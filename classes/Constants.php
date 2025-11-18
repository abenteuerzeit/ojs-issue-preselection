<?php
/**
 * @file plugins/generic/issuePreselection/classes/Constants.php
 *
 * Copyright (c) 2017-2023 Simon Fraser University
 * Copyright (c) 2017-2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class Constants
 * @brief Constants used throughout the Issue Preselection plugin
 */
namespace APP\plugins\generic\issuePreselection\classes;

/**
 * Class Constants
 *
 * Defines all constants used by the Issue Preselection plugin.
 * These constants are used for data field names and configuration values.
 *
 * @package APP\plugins\generic\issuePreselection\classes
 */
class Constants
{
    /**
     * Issue metadata field: Boolean flag indicating if issue is open for submissions
     * @var string
     */
    public const ISSUE_IS_OPEN = "isOpen";

    /**
     * Issue metadata field: Array of editor user IDs assigned to this issue
     * This is the single source of truth for editor assignments
     * @var string
     */
    public const ISSUE_EDITED_BY = "editedBy";

    /**
     * Submission metadata field: ID of the preselected issue
     * @var string
     */
    public const SUBMISSION_PRESELECTED_ISSUE_ID = "preselectedIssueId";

    /**
     * Stage assignment flag: Editor can only recommend (not make decisions)
     * @var int
     */
    public const RECOMMEND_ONLY = 0;

    /**
     * Stage assignment flag: Editor can change submission metadata
     * @var int
     */
    public const CAN_CHANGE_METADATA = 1;
}
