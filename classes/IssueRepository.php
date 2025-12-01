<?php

/**
 * @file plugins/generic/issuePreselection/classes/IssueRepository.php
 *
 * Copyright (c) 2017-2023 Simon Fraser University
 * Copyright (c) 2017-2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class IssueRepository
 * @brief Repository for issue-related queries
 */

namespace APP\plugins\generic\issuePreselection\classes;

use APP\facades\Repo;

class IssueRepository
{
    /**
     * Get open future issues for a context
     *
     * Retrieves all unpublished issues for the given context that are marked
     * as open for submissions (isOpen flag is true).
     *
     * @param int $contextId The journal/press context ID
     *
     * @return array Array of Issue objects that are unpublished and open
     */
    public static function getOpenFutureIssues(int $contextId): array
    {
        $unpublishedIssues = Repo::issue()
            ->getCollector()
            ->filterByContextIds([$contextId])
            ->filterByPublished(false)
            ->getMany();

        return array_filter(
            iterator_to_array($unpublishedIssues),
            fn($issue) => $issue->getData(Constants::ISSUE_IS_OPEN) === true,
        );
    }
}
