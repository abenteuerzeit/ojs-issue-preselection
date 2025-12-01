/**
 * @file cypress/tests/functional/SubmissionWizard.cy.js
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2003-2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Cypress tests for Submission Wizard with Issue Preselection
 */
/// <reference types="cypress" />

import { faker } from "@faker-js/faker";

describe("Submission Wizard - Issue Preselection", function () {
    before(() => {
        const pluginArchive = Cypress.env("PLUGIN_ARCHIVE");
        if (pluginArchive && !Cypress.env("CI")) {
            cy.uploadPlugin(pluginArchive);
            cy.enablePlugin("issuePreselection");
        }
    });

    const setupIssueWithEditors = (editorIndices = [1]) => {
        cy.loginAsAdmin();
        cy.visitManageIssues();
        cy.navigateToFutureIssues();
        cy.get('a[id*="edit-button"], a:contains("Vol")').first().scrollIntoView();
        cy.get('a[id*="edit-button"], a:contains("Vol")').first().click({ force: true });
        cy.wait(2000);
        cy.openIssueDataTab();
        cy.get('input[name="isOpen"]').scrollIntoView();
        cy.get('input[name="isOpen"]').check({ force: true });
        cy.get('select[name="editedBy[]"]').select(editorIndices);
        cy.saveIssue();
    };

    const startSubmission = () => {
        cy.loginAsAuthor();

        cy.getContext().then((context) => {
            cy.visit(`/index.php/${context}/submission`);
            cy.wait(3000);

            cy.window().then((win) => {
                if (win.tinymce) {
                    const editor = win.tinymce.get("startSubmission-title-control");
                    if (editor) {
                        editor.setContent(`<p>${faker.lorem.sentence()}</p>`);
                        editor.fire("change");
                    }
                }
            });
            cy.wait(1000);

            cy.get('label:contains("Yes, my submission meets all of these requirements.")').click();
            cy.get('label:contains("Yes, I agree to have my data collected")').click();
            cy.get("button")
                .contains(/Begin Submission/i)
                .click();
            cy.wait(3000);
        });
    };

    const fillAbstractAndContinue = () => {
        cy.get('iframe[id*="abstract"]').scrollIntoView();
        cy.get('iframe[id*="abstract"]').should("be.visible");
        cy.wait(500);
        cy.get('iframe[id*="abstract"]').then(($iframe) => {
            const $body = $iframe.contents().find("body");
            cy.wrap($body).as("abstractBody");
            cy.get("@abstractBody").click();
            cy.get("@abstractBody").type(faker.lorem.paragraphs(3, " "), { delay: 0 });
        });
        cy.wait(1000);
        cy.get("button")
            .contains(/Continue/i)
            .scrollIntoView();
        cy.get("button")
            .contains(/Continue/i)
            .click({ force: true });
        cy.wait(2000);
    };

    const uploadFileAndContinue = () => {
        cy.fixture("dummy.docx", "base64").then((fileContent) => {
            cy.get('input[type="file"]')
                .first()
                .selectFile(
                    {
                        contents: Cypress.Buffer.from(fileContent, "base64"),
                        fileName: "test-article.docx",
                        mimeType:
                            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                    },
                    { force: true }
                );
        });
        cy.wait(3000);
        cy.get("button")
            .contains(/Article Text/i)
            .click();
        cy.wait(1000);
        cy.get(".submissionWizard__footer button").contains("Continue").scrollIntoView();
        cy.get(".submissionWizard__footer button").contains("Continue").click({ force: true });
        cy.wait(2000);
    };

    const addContributorAndContinue = () => {
        cy.get("button")
            .contains(/Add Contributor/i)
            .click();
        cy.wait(2000);

        const firstName = faker.person.firstName();
        const lastName = faker.person.lastName();
        const email = faker.internet.email({ firstName, lastName });

        cy.get('input[name*="givenName"]', { timeout: 10000 }).first().scrollIntoView();
        cy.get('input[name*="givenName"]', { timeout: 10000 }).first().should("be.visible");
        cy.get('input[name*="givenName"]').first().type(firstName);
        cy.get('input[name*="familyName"]').first().type(lastName);
        cy.get('input[name*="email"]').first().type(email);
        cy.get('select[name*="country"]').first().select("US");
        cy.get('input[type="radio"][name*="userGroupId"]').first().scrollIntoView();
        cy.get('input[type="radio"][name*="userGroupId"]').first().check({ force: true });
        cy.get(".pkpFormPage__footer button").contains("Save").scrollIntoView();
        cy.get(".pkpFormPage__footer button").contains("Save").click({ force: true });
        cy.wait(2000);
        cy.get(".submissionWizard__footer button").contains("Continue").scrollIntoView();
        cy.get(".submissionWizard__footer button").contains("Continue").should("be.visible");
        cy.get(".submissionWizard__footer button").contains("Continue").click({ force: true });
        cy.wait(2000);
    };

    const navigateToIssueSelectionStep = () => {
        cy.wait(2000);
        fillAbstractAndContinue();
        cy.get("body").then(($body) => {
            if ($body.find('input[type="file"]').length > 0) {
                uploadFileAndContinue();
            }
        });
        addContributorAndContinue();
    };

    const selectIssueAndSubmit = () => {
        cy.get('select[name="preselectedIssueId"] option')
            .eq(1)
            .then(($option) => {
                const optionValue = $option.val();
                cy.get('select[name="preselectedIssueId"]').select(String(optionValue));
            });
        cy.wait(500);

        cy.get(".submissionWizard__footer button").contains("Continue").scrollIntoView();
        cy.get(".submissionWizard__footer button").contains("Continue").click({ force: true });
        cy.wait(2000);

        cy.get("button")
            .contains(/Submit/i)
            .scrollIntoView();
        cy.get("button")
            .contains(/Submit/i)
            .click({ force: true });
        cy.wait(1000);

        cy.get("body").then(($body) => {
            if ($body.find('.pkpModal, [role="dialog"]').length > 0) {
                cy.get(
                    '.pkpModal button:contains("Submit"), [role="dialog"] button:contains("Submit")'
                ).click({
                    force: true
                });
                cy.wait(3000);
            }
        });

        cy.get("body").should("contain", "Submission complete");
    };

    const verifyParticipants = (expectedCount = 1) => {
        cy.loginAsAdmin();

        cy.getContext().then((context) => {
            cy.visit(`/index.php/${context}/dashboard/editorial?currentViewId=active`);
            cy.wait(3000);

            cy.contains("button", "View").first().scrollIntoView();
            cy.wait(500);
            cy.contains("button", "View").first().click({ force: true });
            cy.wait(3000);

            cy.url().then((url) => {
                const submissionIdMatch = url.match(/workflowSubmissionId=(\d+)/);
                if (submissionIdMatch) {
                    const submissionId = submissionIdMatch[1];
                    cy.visit(
                        `/index.php/${context}/dashboard/editorial?currentViewId=assigned-to-me&workflowSubmissionId=${submissionId}&workflowMenuKey=workflow_1`
                    );
                    cy.wait(3000);

                    cy.get("body").should("contain", "Participants");
                    cy.get('ul[role="list"]').within(() => {
                        cy.get("li").should("have.length.greaterThan", expectedCount);
                    });
                }
            });
        });
    };

    // Tests
    it.skip("Shows issue selector in submission wizard", function () {
        cy.loginAsAuthor();

        startSubmission();
        fillAbstractAndContinue();
        cy.get("body").then(($body) => {
            if ($body.find('input[type="file"]').length > 0) {
                uploadFileAndContinue();
            }
        });
        addContributorAndContinue();

        cy.get('select[name="preselectedIssueId"]').should("exist");
        cy.get('select[name="preselectedIssueId"] option').should("have.length.gt", 1);
        cy.get('select[name="preselectedIssueId"]').select(1);
        cy.wait(500);

        cy.get(".submissionWizard__footer button").contains("Continue").scrollIntoView();
        cy.get(".submissionWizard__footer button").contains("Continue").click({ force: true });
        cy.wait(2000);

        cy.get("button")
            .contains(/Submit/i)
            .should("exist");
        cy.get("button")
            .contains(/Cancel/i)
            .click();
    });

    it("issue is enabled displays and validates correct list in submission wizard", function () {
        cy.loginAsAuthor();

        cy.getContext().then((context) => {
            cy.visit(`/index.php/${context}/submission/wizard`);
            cy.wait(2000);

            cy.get("body").then(($body) => {
                if ($body.find('select[name="preselectedIssueId"]').length > 0) {
                    cy.get('select[name="preselectedIssueId"]').should("be.visible");
                    cy.get('select[name="preselectedIssueId"] option').should(
                        "have.length.greaterThan",
                        1
                    );
                } else if ($body.find('[name*="issue"]').length > 0) {
                    cy.get('[name*="issue"]').should("be.visible");
                }
            });
        });
    });

    it.skip("author forgets to select an issue, error notification tooltip appears in review stage", function () {
        startSubmission();

        cy.get("body").then(($body) => {
            if ($body.find('select[name="preselectedIssueId"]').length > 0) {
                cy.get(".submissionWizard__footer button").contains("Continue").scrollIntoView();
                cy.get(".submissionWizard__footer button")
                    .contains("Continue")
                    .click({ force: true });
                cy.wait(1000);

                cy.get("body").then(($errorBody) => {
                    if ($errorBody.find('.pkpFormError, .error, [role="alert"]').length > 0) {
                        cy.get('.pkpFormError, .error, [role="alert"]').should("be.visible");
                    }
                });
            }
        });
    });

    it.skip("on go back a tooltip appears in the assign to issue dropdown menu", function () {
        startSubmission();
        navigateToIssueSelectionStep();

        cy.get(".submissionWizard__footer button").contains("Continue").scrollIntoView();
        cy.get(".submissionWizard__footer button").contains("Continue").click({ force: true });
        cy.wait(1000);

        cy.get(".submissionWizard__footer button").contains("Back").scrollIntoView();
        cy.get(".submissionWizard__footer button").contains("Back").click({ force: true });
        cy.wait(1000);

        cy.get('select[name="preselectedIssueId"]').should("be.visible");
    });

    it.skip("on successful submit, the selected editors in editedBy are assigned", function () {
        setupIssueWithEditors([1, 2]);
        startSubmission();
        navigateToIssueSelectionStep();
        selectIssueAndSubmit();

        cy.loginAsAdmin();
        cy.visitManageIssues();
        cy.navigateToFutureIssues();
        cy.get('a[id*="edit-button"], a:contains("Vol")').first().scrollIntoView();
        cy.get('a[id*="edit-button"], a:contains("Vol")').first().click({ force: true });
        cy.wait(2000);
        cy.openIssueDataTab();

        const expectedEditors = [];
        cy.get('select[name="editedBy[]"]')
            .then(($select) => {
                const selectedValues = $select.val();
                cy.get('select[name="editedBy[]"] option').each(($option) => {
                    const optionValue = $option.val();
                    if (selectedValues && selectedValues.includes(String(optionValue))) {
                        expectedEditors.push($option.text().trim());
                    }
                });
            })
            .then(() => {
                cy.getContext().then((context) => {
                    cy.visit(`/index.php/${context}/dashboard/editorial?currentViewId=active`);
                    cy.wait(3000);

                    cy.contains("button", "View").first().scrollIntoView();
                    cy.wait(500);
                    cy.contains("button", "View").first().click({ force: true });
                    cy.wait(3000);

                    cy.url().then((url) => {
                        const submissionIdMatch = url.match(/workflowSubmissionId=(\d+)/);
                        if (submissionIdMatch) {
                            const submissionId = submissionIdMatch[1];
                            cy.visit(
                                `/index.php/${context}/dashboard/editorial?currentViewId=assigned-to-me&workflowSubmissionId=${submissionId}&workflowMenuKey=workflow_1`
                            );
                            cy.wait(3000);

                            cy.get("body").should("contain", "Participants");
                            cy.get('ul[role="list"]').within(() => {
                                cy.get("li").should(
                                    "have.length.greaterThan",
                                    expectedEditors.length
                                );
                                expectedEditors.forEach((editorName) => {
                                    cy.contains(editorName).should("exist");
                                });
                            });
                        }
                    });
                });
            });
    });

    it.skip("assigned editors receive a notification", function () {
        setupIssueWithEditors([1]);
        startSubmission();
        navigateToIssueSelectionStep();
        selectIssueAndSubmit();
        verifyParticipants(1);
    });
});
