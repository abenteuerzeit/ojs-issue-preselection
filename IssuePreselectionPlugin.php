<?php

/**
 * @file plugins/generic/issuePreselection/IssuePreselectionPlugin.php
 *
 * @class IssuePreselectionPlugin
 *
 * @brief Allows authors to select issue assignment during submission
 */

namespace APP\plugins\generic\issuePreselection;

use APP\plugins\generic\issuePreselection\classes\IssueManagement;
use APP\plugins\generic\issuePreselection\classes\SubmissionManagement;
use Exception;
use PKP\plugins\GenericPlugin;
use PKP\plugins\Hook;

class IssuePreselectionPlugin extends GenericPlugin
{

    /**
     * @param $category
     * @param $path
     * @param null $mainContextId
     * @return bool
     * @throws Exception
     */
    public function register($category, $path, $mainContextId = null): bool
    {
        $success = parent::register($category, $path, $mainContextId);

        if ($success && $this->getEnabled($mainContextId)) {
            $issueManagement = new IssueManagement($this);
            $submissionManagement = new SubmissionManagement($this);

            Hook::add('Schema::get::issue', [$issueManagement, 'addToIssueSchema']);
            Hook::add('Templates::Editor::Issues::IssueData::AdditionalMetadata', [$issueManagement, 'addIssueFormFields']);
            Hook::add('issueform::readuservars', [$issueManagement, 'readIssueFormData']);
            Hook::add('issueform::execute', [$issueManagement, 'saveIssueFormData']);
            Hook::add('Issue::edit', [$issueManagement, 'beforeIssueEdit']);

            Hook::add('Schema::get::submission', [$submissionManagement, 'addToSubmissionSchema']);
            Hook::add('Form::config::after', [$submissionManagement, 'addToSubmissionForm']);
            Hook::add('Submission::getSubmissionsListProps', [$submissionManagement, 'addSubmissionListProps']);
            Hook::add('Template::SubmissionWizard::Section::Review::Editors', [$submissionManagement, 'addIssueReviewSection']);
            Hook::add('Submission::validateSubmit', [$submissionManagement, 'handleSubmissionValidate']);
        }

        return $success;
    }

    /**
     * @copydoc Plugin::getDisplayName()
     * @noinspection PhpUnused
     */
    public function getDisplayName(): object|array|string|null
    {
        return __('plugins.generic.issuePreselection.displayName');
    }

    /**
     * @copydoc Plugin::getDescription()
     * @noinspection PhpUnused
     */
    public function getDescription(): object|array|string|null
    {
        return __('plugins.generic.issuePreselection.description');
    }

}
