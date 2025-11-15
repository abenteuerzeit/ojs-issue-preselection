/**
 * @file cypress/tests/functional/SubmissionWizard.cy.js
 *
 * Cypress tests for Submission Wizard with Issue Preselection
 */

/// <reference types="cypress" />

describe("Submission Wizard - Issue Preselection", function () {
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

  it("Shows issue selector in submission wizard", function () {
    const authorUser = Cypress.env("authorUsername") || "author";
    const authorPass = Cypress.env("authorPassword") || "password";
    login(authorUser, authorPass);

    cy.visit(`/index.php/${context}/submission`);
    cy.wait(3000);

    cy.window().then((win) => {
      const editor = win.tinymce.get("startSubmission-title-control");
      if (editor) {
        editor.setContent("<p>Test Submission for Issue Preselection</p>");
        editor.fire("change");
      }
    });
    cy.wait(1000);

    cy.get('input[type="checkbox"][name="submissionRequirements"]').check();
    cy.get('input[type="checkbox"][name="privacyConsent"]').check();

    cy.get("button")
      .contains(/Begin Submission/i)
      .click();
    cy.wait(3000);

    cy.get("body").then(($body) => {
      if ($body.find('iframe[id*="abstract"]').length > 0) {
        cy.get('iframe[id*="abstract"]').scrollIntoView();
        cy.wait(500);

        cy.window().then((win) => {
          if (win.tinymce && win.tinymce.editors) {
            const abstractEditor = win.tinymce.editors.find(
              (e) => e.id && e.id.includes("abstract"),
            );
            if (abstractEditor) {
              abstractEditor.setContent(
                "<p>This is a test abstract for the submission.</p>",
              );
              abstractEditor.fire("change");
            }
          }
        });
        cy.wait(1000);

        cy.get("button")
          .contains(/Continue/i)
          .click();
        cy.wait(2000);
      }
    });

    cy.get("body").then(($body) => {
      if ($body.find('input[type="file"]').length > 0) {
        cy.fixture("dummy.docx", "base64").then((fileContent) => {
          cy.get('input[type="file"]')
            .first()
            .selectFile(
              {
                contents: Cypress.Buffer.from(fileContent, "base64"),
                fileName: "test-article.docx",
                mimeType:
                  "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
              },
              { force: true },
            );
        });
        cy.wait(3000);

        cy.get("button")
          .contains(/Article Text/i)
          .click();
        cy.wait(1000);

        cy.get(".submissionWizard__footer button")
          .contains("Continue")
          .scrollIntoView()
          .click({ force: true });
        cy.wait(2000);
      }
    });

    cy.get("button")
      .contains(/Add Contributor/i)
      .click();
    cy.wait(2000);

    cy.get('input[name*="givenName"]', { timeout: 10000 })
      .first()
      .scrollIntoView()
      .should("be.visible")
      .type("John");
    cy.get('input[name*="familyName"]').first().type("Doe");
    cy.get('input[name*="email"]').first().type("john.doe@example.com");
    cy.get('select[name*="country"]').first().select("US");

    cy.get('input[type="radio"][name*="userGroupId"]')
      .first()
      .scrollIntoView()
      .check({ force: true });

    cy.get(".pkpFormPage__footer button")
      .contains("Save")
      .scrollIntoView()
      .click({ force: true });
    cy.wait(2000);

    cy.get(".submissionWizard__footer button")
      .contains("Continue")
      .scrollIntoView()
      .should("be.visible")
      .click({ force: true });
    cy.wait(2000);

    cy.get('select[name="preselectedIssueId"]').should("exist");
    cy.get('select[name="preselectedIssueId"] option').should(
      "have.length.gt",
      1,
    );

    cy.get('select[name="preselectedIssueId"]').select(1);
    cy.wait(500);

    cy.get(".submissionWizard__footer button")
      .contains("Continue")
      .scrollIntoView()
      .click({ force: true });
    cy.wait(2000);

    cy.get("button")
      .contains(/Submit/i)
      .should("exist");

    cy.get("button")
      .contains(/Cancel/i)
      .click();
  });
});
