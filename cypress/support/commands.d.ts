// noinspection JSUnusedGlobalSymbols

/**
 * @file cypress/support/commands.d.ts
 *
 * TypeScript declarations for custom Cypress commands
 */
/// <reference types="cypress" />

declare global {
    interface Window {
        tinymce?: {
            get(id: string): {
                setContent(content: string): void;
                fire(event: string): void;
            } | null;
        };
    }

    namespace Cypress {
        interface Chainable {
            /**
             * Get the current context path (e.g., "JOP")
             * @example cy.getContext().then((context) => { ... })
             */
            getContext(): Chainable<string>;

            /**
             * Login to OJS with username and password
             * @param username - The username to login with
             * @param password - The password to login with
             * @example cy.loginOJS('admin', 'password')
             */
            loginOJS(username: string, password: string): Chainable<void>;

            /**
             * Login as an editor user
             * @example cy.loginAsEditor()
             */
            loginAsEditor(): Chainable<void>;

            /**
             * Login as an admin user
             * @example cy.loginAsAdmin()
             */
            loginAsAdmin(): Chainable<void>;

            /**
             * Login as an author user
             * @example cy.loginAsAuthor()
             */
            loginAsAuthor(): Chainable<void>;

            /**
             * Visit the manage issues page
             * @example cy.visitManageIssues()
             */
            visitManageIssues(): Chainable<void>;

            /**
             * Navigate to the Future Issues tab
             * @example cy.navigateToFutureIssues()
             */
            navigateToFutureIssues(): Chainable<void>;

            /**
             * Open the Issue Data tab in the issue form
             * @example cy.openIssueDataTab()
             */
            openIssueDataTab(): Chainable<void>;

            /**
             * Open the first issue in the list
             * @example cy.openFirstIssue()
             */
            openFirstIssue(): Chainable<void>;

            /**
             * Save the current issue form
             * @example cy.saveIssue()
             */
            saveIssue(): Chainable<void>;

            /**
             * Upload a plugin archive file
             * @param pluginPath - Path to the plugin .tar.gz file
             * @example cy.uploadPlugin('/path/to/plugin.tar.gz')
             */
            uploadPlugin(pluginPath: string): Chainable<void>;

            /**
             * Enable a plugin by name
             * @param pluginName - The plugin name/identifier
             * @example cy.enablePlugin('issuePreselection')
             */
            enablePlugin(pluginName: string): Chainable<void>;
        }
    }
}

export {};
