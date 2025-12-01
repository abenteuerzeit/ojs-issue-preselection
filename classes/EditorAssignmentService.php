<?php

/**
 * @file plugins/generic/issuePreselection/classes/EditorAssignmentService.php
 *
 * Copyright (c) 2017-2023 Simon Fraser University
 * Copyright (c) 2017-2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class EditorAssignmentService
 * @brief Service for assigning editors to submissions
 */

namespace APP\plugins\generic\issuePreselection\classes;

use APP\core\Request;
use APP\facades\Repo;
use APP\submission\Submission;
use Exception;
use Illuminate\Database\Eloquent\Builder;
use PKP\core\Core;
use PKP\stageAssignment\StageAssignment;

class EditorAssignmentService
{
    /**
     * Reference to the base management instance for accessing shared utilities
     *
     * @var BaseManagement
     */
    private BaseManagement $baseManagement;

    /**
     * Constructor
     *
     * @param BaseManagement $baseManagement The base management instance
     */
    public function __construct(BaseManagement $baseManagement)
    {
        $this->baseManagement = $baseManagement;
    }

    /**
     * Sync editors to submission - removes old and adds new
     *
     * The issue's editedBy field is the single source of truth for editor assignments.
     * This method compares current editor assignments with the new list and performs
     * the necessary additions and removals to synchronize them.
     *
     * @param Submission $submission The submission to sync editors for
     * @param array $newEditorIds Array of editor user IDs to assign
     * @param Request $request The current request object
     *
     * @return void
     */
    public function syncEditorsToSubmission(Submission $submission, array $newEditorIds, Request $request): void
    {
        $context = $request->getContext();
        if (!$context) {
            error_log("[IssuePreselection] Cannot sync editors - no context available");
            return;
        }

        $currentAssignments = $this->getCurrentEditorAssignments($submission, $context->getId());
        $currentEditorIds = array_keys($currentAssignments);

        $editorsToRemove = array_diff($currentEditorIds, $newEditorIds);
        foreach ($editorsToRemove as $editorId) {
            $this->removeEditorAssignment($submission, (int) $editorId, $context->getId());
        }

        $editorsToAdd = array_diff($newEditorIds, $currentEditorIds);
        if (!empty($editorsToAdd)) {
            $users = $this->fetchEditorUsers($editorsToAdd);

            foreach ($editorsToAdd as $editorId) {
                if (!isset($users[$editorId])) {
                    error_log("[IssuePreselection] User $editorId not found, skipping assignment");
                    continue;
                }

                $this->assignSingleEditor($submission, $editorId, $context->getId());
            }
        }
    }

    /**
     * Get current editor assignments for a submission
     *
     * Retrieves all stage assignments for the submission and filters them to only
     * include editors (managers and sub-editors) based on their user group.
     *
     * @param Submission $submission The submission to get assignments for
     * @param int $contextId The journal/press context ID
     *
     * @return array Associative array mapping editor user ID to StageAssignment object
     */
    private function getCurrentEditorAssignments(Submission $submission, int $contextId): array
    {
        $assignments = [];

        $query = StageAssignment::query();
        $stageAssignments = $query->withSubmissionIds([$submission->getId()])->get();

        foreach ($stageAssignments as $assignment) {
            $userGroup = $this->baseManagement->getEditorUserGroup($contextId, $assignment->userId);
            if ($userGroup && $userGroup->user_group_id == $assignment->userGroupId) {
                $assignments[$assignment->userId] = $assignment;
            }
        }

        return $assignments;
    }

    /**
     * Remove editor assignment from submission
     *
     * Removes all stage assignments for the specified editor from the submission.
     * Validates that the editor has an appropriate user group before removal.
     *
     * @param Submission $submission The submission to remove the editor from
     * @param int $editorId The user ID of the editor to remove
     * @param int $contextId The journal/press context ID
     *
     * @return void
     */
    private function removeEditorAssignment(Submission $submission, int $editorId, int $contextId): void
    {
        $userGroup = $this->baseManagement->getEditorUserGroup($contextId, $editorId);
        if (!$userGroup) {
            return;
        }

        $query = StageAssignment::query();
        $assignments = $query
            ->withSubmissionIds([$submission->getId()])
            ->withUserId($editorId)
            ->withUserGroupId($userGroup->user_group_id)
            ->get();

        foreach ($assignments as $assignment) {
            $assignment->delete();
        }
    }

    /**
     * Batch fetch and validate editor users
     *
     * Retrieves user objects for the given editor IDs, validating that each ID
     * is numeric and positive, and that the user exists in the system.
     *
     * @param array $editorIds Array of editor user IDs to fetch
     *
     * @return array Associative array mapping user ID to User object
     */
    private function fetchEditorUsers(array $editorIds): array
    {
        $users = [];

        foreach ($editorIds as $editorId) {
            if (!is_numeric($editorId) || $editorId <= 0) {
                error_log("[IssuePreselection] Invalid editor ID: $editorId");
                continue;
            }

            $user = Repo::user()->get((int) $editorId);
            if ($user) {
                $users[$editorId] = $user;
            }
        }

        return $users;
    }

    /**
     * Assign a single editor to submission
     *
     * Creates a stage assignment for the editor if they are not already assigned.
     * Validates that the editor has an appropriate user group before assignment.
     *
     * @param Submission $submission The submission to assign the editor to
     * @param int $editorId The user ID of the editor to assign
     * @param int $contextId The journal/press context ID
     *
     * @return void
     */
    private function assignSingleEditor(Submission $submission, int $editorId, int $contextId): void
    {
        $userGroup = $this->baseManagement->getEditorUserGroup($contextId, $editorId);
        if (!$userGroup) {
            error_log("[IssuePreselection] No editor user group found for user $editorId in context $contextId");
            return;
        }

        if ($this->isEditorAlreadyAssigned($submission->getId(), $editorId, $userGroup->user_group_id)) {
            return;
        }

        try {
            $this->createEditorAssignment($submission->getId(), $editorId, $userGroup->user_group_id);
        } catch (Exception $e) {
            error_log(
                "[IssuePreselection] Failed to assign editor $editorId to submission {$submission->getId()}: {$e->getMessage()}",
            );
        }
    }

    /**
     * Check if editor is already assigned
     *
     * Queries the stage assignments to determine if the specified editor is already
     * assigned to the submission with the given user group.
     *
     * @param int $submissionId The submission ID
     * @param int $editorId The editor user ID
     * @param int $userGroupId The user group ID
     *
     * @return bool True if the editor is already assigned, false otherwise
     */
    private function isEditorAlreadyAssigned(int $submissionId, int $editorId, int $userGroupId): bool
    {
        $query = StageAssignment::query();
        return $query
            ->withSubmissionIds([$submissionId])
            ->withUserId($editorId)
            ->withUserGroupId($userGroupId)
            ->exists();
    }

    /**
     * Create editor stage assignment
     *
     * Creates a new StageAssignment record for the editor with appropriate permissions.
     * Sets recommendOnly and canChangeMetadata flags according to plugin constants.
     *
     * @param int $submissionId The submission ID
     * @param int $editorId The editor user ID
     * @param int $userGroupId The user group ID
     *
     * @return void
     */
    private function createEditorAssignment(int $submissionId, int $editorId, int $userGroupId): void
    {
        $assignment = new StageAssignment();
        $assignment->submissionId = $submissionId;
        $assignment->userGroupId = $userGroupId;
        $assignment->userId = $editorId;
        $assignment->dateAssigned = Core::getCurrentDate();
        $assignment->recommendOnly = Constants::RECOMMEND_ONLY;
        $assignment->canChangeMetadata = Constants::CAN_CHANGE_METADATA;
        $assignment->save();
    }
}
