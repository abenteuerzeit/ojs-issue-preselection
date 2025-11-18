/**
 * @file cypress/support/commands.js
 *
 * Custom Cypress commands for Issue Preselection plugin tests
 */
/// <reference types="cypress" />

// Shared helper functions
Cypress.Commands.add("getContext", () => {
    return Cypress.env("contextPath") || "JOP";
});

Cypress.Commands.add("loginOJS", (username, password) => {
    cy.getContext().then((context) => {
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
    });
});

Cypress.Commands.add("loginAsEditor", () => {
    const editorUser = Cypress.env("editorUsername") || "editor.section";
    const editorPass = Cypress.env("editorPassword") || "password";
    cy.loginOJS(editorUser, editorPass);
});

Cypress.Commands.add("loginAsAdmin", () => {
    const adminUser = Cypress.env("adminUsername") || "admin";
    const adminPass = Cypress.env("adminPassword") || "password";
    cy.loginOJS(adminUser, adminPass);
});

Cypress.Commands.add("loginAsAuthor", () => {
    const authorUser = Cypress.env("authorUsername") || "author";
    const authorPass = Cypress.env("authorPassword") || "password";
    cy.loginOJS(authorUser, authorPass);
});

Cypress.Commands.add("visitManageIssues", () => {
    cy.getContext().then((context) => {
        cy.visit(`/index.php/${context}/manageIssues`);
        cy.wait(2000);
    });
});

Cypress.Commands.add("navigateToFutureIssues", () => {
    cy.get("body").then(($body) => {
        if ($body.find('button:contains("Future Issues"), a:contains("Future Issues")').length > 0) {
            cy.get('button:contains("Future Issues"), a:contains("Future Issues")').first().click();
            cy.wait(1000);
        }
    });
});

Cypress.Commands.add("openIssueDataTab", () => {
    cy.get('a:contains("Issue Data")', { timeout: 10000 }).should("be.visible");
    cy.get('a:contains("Issue Data")').click();
    cy.wait(2000);
    cy.get("form#issueForm", { timeout: 10000 }).should("exist");
    cy.wait(1000);
});

Cypress.Commands.add("openFirstIssue", () => {
    cy.get('a[id*="edit-button"], a:contains("Vol")').first().scrollIntoView();
    cy.get('a[id*="edit-button"], a:contains("Vol")').first().click({ force: true });
    cy.wait(2000);
    cy.openIssueDataTab();
});

Cypress.Commands.add("saveIssue", () => {
    cy.get('button:contains("Save")').click();
    cy.wait(2000);
});
