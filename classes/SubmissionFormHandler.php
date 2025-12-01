<?php

/**
 * @file plugins/generic/issuePreselection/classes/SubmissionFormHandler.php
 *
 * Copyright (c) 2017-2023 Simon Fraser University
 * Copyright (c) 2017-2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class SubmissionFormHandler
 * @brief Handles submission form modifications for issue selection
 */

namespace APP\plugins\generic\issuePreselection\classes;

use APP\facades\Repo;
use APP\submission\Submission;
use PKP\components\forms\submission\CommentsForTheEditors;

class SubmissionFormHandler
{
    /**
     * Check if form is the comments for editors form
     *
     * Determines if the provided form object is an instance of the
     * CommentsForTheEditors form where we inject the issue selector.
     *
     * @param object $form The form object to check
     *
     * @return bool True if this is the CommentsForTheEditors form, false otherwise
     */
    public function isCommentsForEditorsForm(object $form): bool
    {
        return $form instanceof CommentsForTheEditors;
    }

    /**
     * Extract submission from form config
     *
     * Parses the form's action URL to extract the submission ID and retrieves
     * the corresponding Submission object.
     *
     * @param array $config The form configuration array
     *
     * @return Submission|null The Submission object or null if not found or invalid
     */
    public function extractSubmissionFromConfig(array $config): ?Submission
    {
        if (!isset($config["action"])) {
            return null;
        }

        if (!preg_match("/submissions\/(\d+)/", $config["action"], $matches)) {
            return null;
        }

        $submissionId = (int) $matches[1];

        if ($submissionId <= 0) {
            error_log("[IssuePreselection] Invalid submission ID: $submissionId");
            return null;
        }

        return Repo::submission()->get($submissionId);
    }

    /**
     * Add issue field to form configuration
     *
     * Injects the issue selection field into the form configuration, including
     * the field definition and current value.
     *
     * @param array &$config The form configuration array (passed by reference)
     * @param Submission $submission The submission being edited
     * @param array $issues Array of available Issue objects
     *
     * @return void
     */
    public function addIssueFieldToForm(array &$config, Submission $submission, array $issues): void
    {
        $value = $this->getSubmissionIssueValue($submission);
        $options = $this->buildIssueOptions($issues);

        $config["fields"][] = $this->createIssueFieldConfig($options, $value);
        $config["values"] ??= [];
        $config["values"][Constants::SUBMISSION_PRESELECTED_ISSUE_ID] = $value;
    }

    /**
     * Get submission's preselected issue value
     *
     * Retrieves the preselected issue ID from the submission data, defaulting to 0.
     *
     * @param Submission $submission The submission object
     *
     * @return int The preselected issue ID, or 0 if not set
     */
    private function getSubmissionIssueValue(Submission $submission): int
    {
        $value = $submission->getData(Constants::SUBMISSION_PRESELECTED_ISSUE_ID);
        return $value ? (int) $value : 0;
    }

    /**
     * Build issue options for dropdown
     *
     * Constructs an array of options for the issue selection dropdown, including
     * a default "select" option and all available issues.
     *
     * @param array $issues Array of Issue objects
     *
     * @return array Array of option arrays with 'value' and 'label' keys
     */
    private function buildIssueOptions(array $issues): array
    {
        $options = [["value" => 0, "label" => __("plugins.generic.issuePreselection.selectOption")]];

        foreach ($issues as $issue) {
            $options[] = [
                "value" => (int) $issue->getId(),
                "label" => $issue->getIssueIdentification(),
            ];
        }

        return $options;
    }

    /**
     * Create issue field configuration
     *
     * Builds the complete field configuration object for the issue selector,
     * including all necessary properties for the UI component.
     *
     * @param array $options Array of dropdown options
     * @param int $value The currently selected issue ID
     *
     * @return array Field configuration array
     */
    private function createIssueFieldConfig(array $options, int $value): array
    {
        return [
            "name" => Constants::SUBMISSION_PRESELECTED_ISSUE_ID,
            "component" => "field-select",
            "label" => __("plugins.generic.issuePreselection.issueLabel"),
            "description" => __("plugins.generic.issuePreselection.description.field"),
            "options" => $options,
            "value" => $value,
            "isRequired" => true,
            "groupId" => "default",
        ];
    }

    /**
     * Build issue map for template
     *
     * Creates a simple mapping of issue IDs to their display identifications
     * for use in templates.
     *
     * @param array $issues Array of Issue objects
     *
     * @return array Associative array mapping issue ID to issue identification string
     */
    public function buildIssueMap(array $issues): array
    {
        $issueMap = [];
        foreach ($issues as $issue) {
            $issueMap[$issue->getId()] = $issue->getIssueIdentification();
        }
        return $issueMap;
    }
}
