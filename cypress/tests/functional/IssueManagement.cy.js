/**
 * @file cypress/tests/functional/IssueManagement.cy.js
 *
 * Cypress tests for Issue Management functionality
 */

/// <reference types="cypress" />

describe("Issue Management", function () {
  const context = Cypress.env("contextPath") || "JOP";

  const login = (username, password) => {
    cy.visit(`/index.php/${context}/login/signOut`, {
      failOnStatusCode: false,
    });
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
    cy.get("body").then(($body) => {
      if (
        $body.find(
          'button:contains("Future Issues"), a:contains("Future Issues")',
        ).length > 0
      ) {
        cy.get('button:contains("Future Issues"), a:contains("Future Issues")')
          .first()
          .click();
        cy.wait(1000);
      }
    });
  };

  const openIssueDataTab = () => {
    cy.get('a:contains("Issue Data")', { timeout: 10000 }).should("be.visible");
    cy.get('a:contains("Issue Data")').click();
    cy.wait(2000);

    cy.get("form#issueForm", { timeout: 10000 }).should("exist");
    cy.wait(1000);
  };

  it("Plugin is installed and can be enabled", function () {
    const adminUser = Cypress.env("adminUsername") || "admin";
    const adminPass = Cypress.env("adminPassword") || "password";
    login(adminUser, adminPass);

    cy.visit(`/index.php/${context}/management/settings/website`);
    cy.wait(2000);

    cy.get('button#plugins-button[role="tab"]').click();
    cy.wait(1000);

    cy.get('button#installedPlugins-button[role="tab"]').click();
    cy.wait(1000);

    cy.get('input[id^="select-cell-issuepreselectionplugin"]').check();
    cy.get('input[id^="select-cell-issuepreselectionplugin"]').should(
      "be.checked",
    );
  });

  it("Adds custom fields to issue form", function () {
    const editorUser = Cypress.env("editorUsername") || "editor.section";
    const editorPass = Cypress.env("editorPassword") || "password";
    login(editorUser, editorPass);

    visitManageIssues();

    navigateToFutureIssues();

    cy.get('a:contains("Create Issue"), button:contains("Create Issue")')
      .first()
      .click();

    cy.get("form#issueForm", { timeout: 10000 }).should("exist");
    cy.wait(2000);

    cy.get('input[name="volume"]').should("be.visible");

    cy.get('input[name="volume"]').clear();
    cy.get('input[name="volume"]').type("99");
    cy.get('input[name="number"]').clear();
    cy.get('input[name="number"]').type("1");
    cy.get('input[name="year"]').clear();
    cy.get('input[name="year"]').type("2025");

    cy.get('input[name="isOpen"]').should("exist");
    cy.get('select[name="editedBy[]"]').should("exist");

    cy.get('input[name="isOpen"]').check();

    cy.get('button:contains("Save")').click();
    cy.wait(2000);

    cy.get("body").should("contain", "Vol");
  });

  it("Preserves issue settings on edit", function () {
    const editorUser = Cypress.env("editorUsername") || "editor.section";
    const editorPass = Cypress.env("editorPassword") || "password";
    login(editorUser, editorPass);

    visitManageIssues();

    navigateToFutureIssues();

    cy.get('a[id*="edit-button"], a:contains("Vol")').first().click();
    cy.wait(2000);

    openIssueDataTab();

    cy.get('input[name="isOpen"]').scrollIntoView();
    cy.get('input[name="isOpen"]').should("be.visible");
    cy.get('input[name="isOpen"]').check();

    cy.get('button:contains("Save")').click();
    cy.wait(5000);

    visitManageIssues();

    navigateToFutureIssues();

    cy.get('a[id*="edit-button"], a:contains("Vol")', { timeout: 15000 })
      .first()
      .click();
    cy.wait(2000);

    openIssueDataTab();

    cy.get('input[name="isOpen"]').scrollIntoView();
    cy.get('input[name="isOpen"]').should("be.visible");

    cy.get('input[name="isOpen"]').should("be.checked");
  });
});
