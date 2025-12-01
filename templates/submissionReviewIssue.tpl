{**
 * templates/submissionReviewIssue.tpl
 *
 * Copyright (c) 2017-2023 Simon Fraser University
 * Copyright (c) 2017-2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Display selected issue in submission wizard review section
 *}
<div class="submissionWizard__reviewPanel__item"
     v-if="submission.preselectedIssueId && submission.preselectedIssueId !== 0">
    <h4 class="submissionWizard__reviewPanel__item__header">
        {translate key="plugins.generic.issuePreselection.issueLabel"}
    </h4>
    <div class="submissionWizard__reviewPanel__item__value">
        {'{{'}
        {foreach from=$issueMap key=id item=title name=issueLoop}
            {if !$smarty.foreach.issueLoop.first} : {/if}submission.preselectedIssueId === {$id} ? {$title|json_encode}
        {/foreach}
        : "" {'}}'}
    </div>
</div>

<div class="submissionWizard__reviewPanel__item"
     v-if="!submission.preselectedIssueId || submission.preselectedIssueId === 0">
    <h4 class="submissionWizard__reviewPanel__item__header">
        {translate key="plugins.generic.issuePreselection.issueLabel"}
    </h4>
    <div class="submissionWizard__reviewPanel__item__value">
        <div class="pkpNotification pkpNotification--warning">
            <span class="inline-block align-middle rtl:scale-x-[-1] text-negative h-5 w-5">
                <svg viewBox="0 0 24 24"
                     xmlns="http://www.w3.org/2000/svg">
                    <path d="M12.8849 3.4905C12.5389 2.8365 11.4629 2.8365 11.1169 3.4905L2.11694 20.4905C2.03592 20.6429 1.99575 20.8136 2.00036 20.9861C2.00496 21.1586 2.05417 21.327 2.14319 21.4749C2.23221 21.6227 2.35801 21.7449 2.50833 21.8297C2.65865 21.9145 2.82837 21.9588 3.00094 21.9585H21.0009C21.1734 21.9589 21.343 21.9145 21.4932 21.8298C21.6434 21.7451 21.7691 21.6229 21.8581 21.4752C21.947 21.3274 21.9961 21.1591 22.0007 20.9867C22.0052 20.8144 21.965 20.6437 21.8839 20.4915L12.8849 3.4905ZM13.0009 18.9585H11.0009V16.9585H13.0009V18.9585ZM11.0009 14.9585V9.9585H13.0009L13.0019 14.9585H11.0009Z"
                          fill="currentColor"></path>
                </svg>
            </span>
            {translate key="plugins.generic.issuePreselection.error.issueRequired"}
        </div>
    </div>
</div>
