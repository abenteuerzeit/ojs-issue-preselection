import { defineConfig } from "cypress";

export default defineConfig({
    defaultCommandTimeout: 10000,
    requestTimeout: 10000,
    responseTimeout: 10000,
    video: false,
    screenshotOnRunFailure: true,
    chromeWebSecurity: false,

    env: {
        pluginName: "issuePreselection",
        contextPath: "publicknowledge"
    },

    e2e: {
        baseUrl: "http://localhost",
        specPattern: "cypress/tests/**/*.cy.{js,jsx,ts,tsx}",
        setupNodeEvents(on, config) {
            // implement node event listeners here
            return config;
        }
    }
});
