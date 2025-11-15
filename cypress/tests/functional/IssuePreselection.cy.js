/**
 * @file cypress/tests/functional/IssuePreselection.cy.js
 *
 * Cypress tests for Issue Preselection Plugin
 */

/// <reference types="cypress" />

describe('Issue Preselection Plugin', function () {
    const context = Cypress.env('contextPath') || 'PJA';

    const login = (username, password) => {
        cy.visit(`/index.php/${context}/login/signOut`, { failOnStatusCode: false });
        cy.wait(1000);

        cy.visit(`/index.php/${context}/login`, { failOnStatusCode: false });
        cy.wait(2000);

        cy.get('input[name="username"]').clear();
        cy.get('input[name="username"]').type(username);
        cy.get('input[name="password"]').clear();
        cy.get('input[name="password"]').type(password);
        cy.get('button[type="submit"]').click();
        cy.wait(3000);
    };

    const visitManageIssues = () => {
        cy.visit(`/index.php/${context}/manageIssues`);
        cy.wait(2000);
    };

    const navigateToFutureIssues = () => {
        cy.get('body').then($body => {
            if ($body.find('button:contains("Future Issues"), a:contains("Future Issues")').length > 0) {
                cy.get('button:contains("Future Issues"), a:contains("Future Issues")').first().click();
                cy.wait(1000);
            }
        });
    };

    const openIssueDataTab = () => {
        cy.get('a:contains("Issue Data")', { timeout: 10000 }).should('be.visible');
        cy.get('a:contains("Issue Data")').click();
        cy.wait(2000);

        cy.get('form#issueForm', { timeout: 10000 }).should('exist');
        cy.wait(1000);
    };

    it('Plugin is installed and can be enabled', function () {
        const adminUser = Cypress.env('adminUsername') || 'admin';
        const adminPass = Cypress.env('adminPassword') || 'admin';
        login(adminUser, adminPass);

        cy.visit(`/index.php/${context}/management/settings/website`);
        cy.wait(2000);

        cy.get('button#plugins-button[role="tab"]').click();
        cy.wait(1000);

        cy.get('button#installedPlugins-button[role="tab"]').click();
        cy.wait(1000);

        cy.get('input[id^="select-cell-issuepreselectionplugin"]').check();
        cy.get('input[id^="select-cell-issuepreselectionplugin"]').should('be.checked');
    });

    it('Adds custom fields to issue form', function () {
        const editorUser = Cypress.env('editorUsername') || 'dbarnes';
        const editorPass = Cypress.env('editorPassword') || 'dbarnes';
        login(editorUser, editorPass);

        visitManageIssues();

        navigateToFutureIssues();

        cy.get('a:contains("Create Issue"), button:contains("Create Issue")').first().click();

        cy.get('form#issueForm', { timeout: 10000 }).should('exist');
        cy.wait(2000);

        cy.get('input[name="volume"]').should('be.visible');

        cy.get('input[name="volume"]').clear();
        cy.get('input[name="volume"]').type('99');
        cy.get('input[name="number"]').clear();
        cy.get('input[name="number"]').type('1');
        cy.get('input[name="year"]').clear();
        cy.get('input[name="year"]').type('2025');

        cy.get('input[name="isOpen"]').should('exist');
        cy.get('select[name="editedBy[]"]').should('exist');

        cy.get('input[name="isOpen"]').check();

        cy.get('button:contains("Save")').click();
        cy.wait(2000);

        cy.get('body').should('contain', 'Vol');
    });

    it('Shows issue selector in submission wizard', function () {
        const authorUser = Cypress.env('authorUsername') || 'ccorino';
        const authorPass = Cypress.env('authorPassword') || 'ccorino';
        login(authorUser, authorPass);

        cy.visit(`/index.php/${context}/submission`);
        cy.wait(3000);

        cy.get('input[name="sectionId"]').first().check();
        cy.wait(500);

        cy.get('input[name="submissionRequirements"]').check();
        cy.get('input[name="privacyConsent"]').check();

        cy.get('button').contains(/Begin Submission|Continue/i).click();
        cy.wait(3000);

        cy.get('body').then($body => {
            if ($body.find('input[type="file"]').length > 0) {
                cy.fixture('dummy.pdf', 'base64').then(fileContent => {
                    cy.get('input[type="file"]').first().selectFile({
                        contents: Cypress.Buffer.from(fileContent, 'base64'),
                        fileName: 'test.pdf',
                        mimeType: 'application/pdf'
                    }, { force: true });
                });
                cy.wait(3000);

                cy.get('body').then($body2 => {
                    if ($body2.find('button:contains("Continue"), button:contains("Save")').length > 0) {
                        cy.get('button').contains(/Continue|Save/i).click();
                        cy.wait(2000);
                    }
                });
            }
        });

        cy.get('body').then($body => {
            if ($body.find('iframe[id*="title"]').length > 0) {
                cy.get('iframe[id*="title"]').then($iframe => {
                    const body = $iframe.contents().find('body');
                    body.text('Test Submission for Issue Preselection');
                });
            } else if ($body.find('input[name="title"]').length > 0) {
                cy.get('input[name="title"]').type('Test Submission for Issue Preselection');
            }
        });

        cy.get('body').then($body => {
            if ($body.find('button').filter((_i, el) => /Continue|Save/i.test(el.textContent)).length > 0) {
                cy.get('button').contains(/Continue|Save/i).click();
                cy.wait(2000);
            }
        });

        cy.get('body').then($body => {
            if ($body.find('select[name="preselectedIssueId"]').length > 0) {
                cy.get('select[name="preselectedIssueId"]').should('exist');
                cy.get('select[name="preselectedIssueId"] option').should('have.length.gt', 1);
            } else {
                if ($body.find('button').filter((_i, el) => /Continue|Save/i.test(el.textContent)).length > 0) {
                    cy.get('button').contains(/Continue|Save/i).click();
                    cy.wait(2000);
                    cy.get('select[name="preselectedIssueId"]').should('exist');
                }
            }
        });
    });

    it('Preserves issue settings on edit', function () {
        const editorUser = Cypress.env('editorUsername') || 'dbarnes';
        const editorPass = Cypress.env('editorPassword') || 'dbarnes';
        login(editorUser, editorPass);

        visitManageIssues();

        navigateToFutureIssues();

        cy.get('a[id*="edit-button"], a:contains("Vol")').first().click();
        cy.wait(2000);

        openIssueDataTab();

        cy.get('input[name="isOpen"]').scrollIntoView();
        cy.get('input[name="isOpen"]').should('be.visible');
        cy.get('input[name="isOpen"]').check();

        cy.get('button:contains("Save")').click();
        cy.wait(5000);

        visitManageIssues();

        navigateToFutureIssues();

        cy.get('a[id*="edit-button"], a:contains("Vol")', { timeout: 15000 }).first().click();
        cy.wait(2000);

        openIssueDataTab();

        cy.get('input[name="isOpen"]').scrollIntoView();
        cy.get('input[name="isOpen"]').should('be.visible');

        cy.get('input[name="isOpen"]').should('be.checked');
    });
});