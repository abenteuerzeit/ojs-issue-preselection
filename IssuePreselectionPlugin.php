<?php

/**
 * @file plugins/generic/issuePreselection/IssuePreselectionPlugin.php
 *
 * Copyright (c) 2017-2023 Simon Fraser University
 * Copyright (c) 2017-2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class IssuePreselectionPlugin
 * @brief Allows authors to select issue assignment during submission
 */

namespace APP\plugins\generic\issuePreselection;

use APP\core\Application;
use APP\plugins\generic\issuePreselection\classes\IssueManagement;
use APP\plugins\generic\issuePreselection\classes\SubmissionManagement;
use PKP\plugins\GenericPlugin;
use PKP\plugins\Hook;

class IssuePreselectionPlugin extends GenericPlugin
{
    /**
     * @copydoc GenericPlugin::register()
     */
    public function register($category, $path, $mainContextId = null): bool
    {
        $success = parent::register($category, $path, $mainContextId);

        if (Application::isUnderMaintenance()) {
            return $success;
        }

        if ($success && $this->getEnabled($mainContextId)) {
            $this->_init();
        }

        return $success;
    }

    /**
     * @copydoc Plugin::getDisplayName()
     * @noinspection PhpUnused
     */
    public function getDisplayName(): object|array|string|null
    {
        return __("plugins.generic.issuePreselection.displayName");
    }

    /**
     * @copydoc Plugin::getDescription()
     * @noinspection PhpUnused
     */
    public function getDescription(): object|array|string|null
    {
        return __("plugins.generic.issuePreselection.description");
    }

    /**
     * Rgister hooks used in normal plugin setup and in CLI tools.
     */
    private function _init() : void
    {
        $issueManagement = new IssueManagement($this);
        $submissionManagement = new SubmissionManagement($this);

        Hook::add("Schema::get::issue", [$issueManagement, "addToIssueSchema"]);
        Hook::add("Templates::Editor::Issues::IssueData::AdditionalMetadata", [$issueManagement, "addIssueFormFields"]);
        Hook::add("issueform::readuservars", [$issueManagement, "readIssueFormData"]);
        Hook::add("issueform::execute", [$issueManagement, "saveIssueFormData"]);
        Hook::add("Issue::edit", [$issueManagement, "beforeIssueEdit"]);

        Hook::add("Schema::get::submission", [$submissionManagement, "addToSubmissionSchema"]);
        Hook::add("Form::config::after", [$submissionManagement, "addToSubmissionForm"]);
        Hook::add("Submission::getSubmissionsListProps", [$submissionManagement, "addSubmissionListProps"]);
        Hook::add("Template::SubmissionWizard::Section::Review::Editors", [
            $submissionManagement,
            "addIssueReviewSection",
        ]);
        Hook::add("Submission::validateSubmit", [$submissionManagement, "handleSubmissionValidate"]);
    }
}

// For backwards compatibility -- expect this to be removed approx. OJS/OMP/OPS 3.6
if (!PKP_STRICT_MODE) {
    class_alias("\APP\plugins\generic\issuePreselection\IssuePreselectionPlugin", "\IssuePreselectionPlugin");
}
