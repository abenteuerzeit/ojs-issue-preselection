{**
 * templates/issueFormFields.tpl
 *
 * Copyright (c) 2017-2023 Simon Fraser University
 * Copyright (c) 2017-2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Additional fields for issue form
 *}
<div class="section">
    <ul class="checkbox_and_radiobutton">
        <li>
            <label>
                <input type="checkbox"
                       id="isOpen"
                       name="isOpen"
                       value="1"
                       {if $issuePreselectionIsOpen}checked="checked"{/if}
                       class="field checkbox">
                {translate key="plugins.generic.issuePreselection.settings.isOpenLabel"}
            </label>
        </li>
    </ul>
    <span>
        <label class="sub_label" for="isOpen">
            {translate key="plugins.generic.issuePreselection.settings.isOpenDescription"}
        </label>
    </span>
</div>

<div class="section">
    <label>{translate key="plugins.generic.issuePreselection.settings.editedBy"}</label>

    <div>
        <select name="editedBy[]"
                id="editedBy"
                multiple="multiple"
                size="10"
                class="field select">
            {foreach from=$issuePreselectionEditorOptions key=editorId item=editorName}
                <option value="{$editorId}"
                        {if in_array($editorId, $issuePreselectionEditors)}selected="selected"{/if}>
                    {$editorName|escape}
                </option>
            {/foreach}
        </select>

        <span>
            <label class="sub_label" for="editedBy">
                {translate key="plugins.generic.issuePreselection.settings.editedByDescription"} {translate key="plugins.generic.issuePreselection.settings.editedByHelp"}
            </label>
        </span>
    </div>
</div>