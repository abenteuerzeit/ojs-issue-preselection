<?php

/**
 * @file plugins/generic/issuePreselection/classes/SubmissionManagement.php
 * @noinspection PhpUnusedParameterInspection
 *
 * @class SubmissionManagement
 * @brief Handles submission-related functionality for the Issue Preselection plugin
 */

namespace APP\plugins\generic\issuePreselection\classes;

use APP\core\Application;
use APP\core\Request;
use APP\facades\Repo;
use APP\plugins\generic\issuePreselection\IssuePreselectionPlugin;
use APP\submission\Submission;
use Exception;
use PKP\core\Core;
use PKP\security\Role;
use PKP\stageAssignment\StageAssignment;
use PKP\userGroup\UserGroup;

class SubmissionManagement
{
    /** @var IssuePreselectionPlugin */
    public IssuePreselectionPlugin $plugin;

    /** @var IssueManagement */
    private IssueManagement $issueManagement;

    public function __construct(IssuePreselectionPlugin &$plugin)
    {
        $this->plugin = &$plugin;
        $this->issueManagement = new IssueManagement($plugin);
    }

    /**
     * Add preselectedIssueId to submission list props
     *
     * @hook Submission::getSubmissionsListProps
     * @param string $hookName
     * @param array $params
     * @return bool
     */
    public function addSubmissionListProps(string $hookName, array $params): bool
    {
        $props = &$params[0];
        $props[] = Constants::SUBMISSION_PRESELECTED_ISSUE_ID;
        return false;
    }

    /**
     * Add issue preselection field to submission schema
     *
     * @hook Schema::get::submission
     * @param string $hookName
     * @param array $params
     * @return bool
     */
    public function addToSubmissionSchema(string $hookName, array $params): bool
    {
        $schema = &$params[0];

        $schema->properties->{Constants::SUBMISSION_PRESELECTED_ISSUE_ID} = (object)['type' => 'integer', 'apiSummary' => true, 'writeDisabledInApi' => false, 'validation' => ['nullable']];

        return false;
    }

    /**
     * Add issue selector field to submission form
     *
     * @hook Form::config::after
     * @param string $hookName
     * @param array $params
     * @return bool
     */
    public function addToSubmissionForm(string $hookName, array $params): bool
    {
        $config = &$params[0];
        $form = $params[1];

        $formClass = get_class($form);
        if ($formClass !== 'PKP\components\forms\submission\CommentsForTheEditors') {
            return false;
        }

        $request = Application::get()->getRequest();
        $context = $request->getContext();

        if (!$context) {
            return false;
        }

        if (!isset($config['action']) || !preg_match('/submissions\/(\d+)/', $config['action'], $matches)) {
            return false;
        }

        $submissionId = (int)$matches[1];
        $submission = Repo::submission()->get($submissionId);

        if (!$submission) {
            return false;
        }

        $currentValue = $submission->getData(Constants::SUBMISSION_PRESELECTED_ISSUE_ID);

        $issues = $this->issueManagement->getOpenFutureIssues($context->getId());

        if (empty($issues)) {
            return false;
        }

        $issueOptions = [['value' => 0, 'label' => __('plugins.generic.issuePreselection.selectOption')]];

        foreach ($issues as $issue) {
            $issueOptions[] = ['value' => (int)$issue->getId(), 'label' => $issue->getIssueIdentification()];
        }

        $fieldConfig = ['name' => Constants::SUBMISSION_PRESELECTED_ISSUE_ID, 'component' => 'field-select', 'label' => __('plugins.generic.issuePreselection.issueLabel'), 'description' => __('plugins.generic.issuePreselection.description.field'), 'options' => $issueOptions, 'value' => $currentValue ? (int)$currentValue : 0, 'isRequired' => true, 'groupId' => 'default'];

        $config['fields'][] = $fieldConfig;

        if (!isset($config['values'])) {
            $config['values'] = [];
        }
        $config['values'][Constants::SUBMISSION_PRESELECTED_ISSUE_ID] = $currentValue ? (int)$currentValue : 0;

        return false;
    }

    /**
     * Add issue information to the review section
     *
     * @hook Template::SubmissionWizard::Section::Review::Editors
     * @param string $hookName
     * @param array $params
     * @return bool
     */
    public function addIssueReviewSection(string $hookName, array $params): bool
    {
        $smarty = $params[1];
        $output = &$params[2];

        $submission = $smarty->getTemplateVars('submission');

        if (!$submission) {
            return false;
        }

        $localeKey = $smarty->getTemplateVars('localeKey');
        $submissionLocale = $submission->getData('locale');

        if ($localeKey !== $submissionLocale) {
            return false;
        }

        $request = Application::get()->getRequest();
        $context = $request->getContext();

        if (!$context) {
            return false;
        }

        $issues = $this->issueManagement->getOpenFutureIssues($context->getId());

        if (empty($issues)) {
            return false;
        }

        $issueMap = [];
        foreach ($issues as $issue) {
            $issueMap[$issue->getId()] = $issue->getIssueIdentification();
        }

        $smarty->assign('issueMap', $issueMap);
        $output .= $smarty->fetch($this->plugin->getTemplateResource('submissionReviewIssue.tpl'));

        return false;
    }

    /**
     * Handle submission validation - assign issue and editors when submitted
     *
     * @hook Submission::validateSubmit
     * @param string $hookName
     * @param array $params
     * @return bool
     */
    public function handleSubmissionValidate(string $hookName, array $params): bool
    {
        $errors = &$params[0];
        $submission = $params[1];
        $context = $params[2];

        $issueId = $submission->getData(Constants::SUBMISSION_PRESELECTED_ISSUE_ID);

        $openIssues = $this->issueManagement->getOpenFutureIssues($context->getId());

        if (!empty($openIssues) && (!$issueId)) {
            $errors[Constants::SUBMISSION_PRESELECTED_ISSUE_ID] = [__('plugins.generic.issuePreselection.error.issueRequired')];
            return false;
        }

        if (!$issueId) {
            return false;
        }

        $issue = Repo::issue()->get($issueId);

        if (!$issue || !$issue->getData(Constants::ISSUE_IS_OPEN)) {
            return false;
        }

        $publication = $submission->getCurrentPublication();
        if (!$publication) {
            return false;
        }

        try {
            Repo::publication()->edit($publication, ['issueId' => $issueId]);

            $editorIds = $issue->getData(Constants::ISSUE_EDITED_BY);

            if (!empty($editorIds) && is_array($editorIds)) {
                $request = Application::get()->getRequest();
                $this->assignEditorsToSubmission($submission, $editorIds, $request);
            }
        } catch (Exception $e) {
            error_log("[IssuePreselection] ERROR scheduling publication: " . $e->getMessage());
        }

        return false;
    }

    /**
     * Assign editors to submission as Guest Editors
     * @param Submission $submission
     * @param array $editorIds
     * @param Request $request
     */
    private function assignEditorsToSubmission(Submission $submission, array $editorIds, Request $request): void
    {
        $context = $request->getContext();
        if (!$context) {
            return;
        }

        $contextId = $context->getId();
        $submissionId = $submission->getId();

        foreach ($editorIds as $editorId) {
            if (!Repo::user()->get($editorId)) {
                continue;
            }

            $editorGroup = $this->getEditorUserGroup($contextId, $editorId);
            if (!$editorGroup) {
                continue;
            }

            if ($this->isAlreadyAssigned($submissionId, $editorId, $editorGroup->user_group_id)) {
                continue;
            }

            $this->createStageAssignment($submissionId, $editorId, $editorGroup->user_group_id);
        }
    }

    /**
     * Get editor user group for a user
     * @param int $contextId
     * @param int $userId
     * @return object|null
     * @noinspection PhpUndefinedMethodInspection
     */
    private function getEditorUserGroup(int $contextId, int $userId): ?object
    {
        /** @noinspection PhpUndefinedMethodInspection */
        $userGroups = UserGroup::query()->withContextIds([$contextId])->withUserIds([$userId])->withRoleIds([Role::ROLE_ID_SUB_EDITOR])->get();

        if ($userGroups->isEmpty()) {
            /** @noinspection PhpUndefinedMethodInspection */
            $userGroups = UserGroup::query()->withContextIds([$contextId])->withUserIds([$userId])->withRoleIds([Role::ROLE_ID_MANAGER])->get();
        }

        return $userGroups->isEmpty() ? null : $userGroups->first();
    }

    /**
     * Check if editor is already assigned to submission
     * @param int $submissionId
     * @param int $userId
     * @param int $userGroupId
     * @return bool
     * @noinspection PhpUndefinedMethodInspection
     */
    private function isAlreadyAssigned(int $submissionId, int $userId, int $userGroupId): bool
    {
        /** @noinspection PhpUndefinedMethodInspection */
        return StageAssignment::query()->withSubmissionIds([$submissionId])->withUserId($userId)->withUserGroupId($userGroupId)->first() !== null;
    }

    /**
     * Create stage assignment for editor
     * @param int $submissionId
     * @param int $userId
     * @param int $userGroupId
     * @noinspection PhpUndefinedFieldInspection
     */
    private function createStageAssignment(int $submissionId, int $userId, int $userGroupId): void
    {
        /** @noinspection PhpUndefinedFieldInspection */
        $stageAssignment = new StageAssignment();
        $stageAssignment->submissionId = $submissionId;
        $stageAssignment->userGroupId = $userGroupId;
        $stageAssignment->userId = $userId;
        $stageAssignment->dateAssigned = Core::getCurrentDate();
        $stageAssignment->recommendOnly = 0;
        $stageAssignment->canChangeMetadata = 1;
        $stageAssignment->save();
    }
}
