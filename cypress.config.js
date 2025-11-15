import {defineConfig} from "cypress";

export default defineConfig({
    defaultCommandTimeout: 10000,
    requestTimeout: 10000,
    responseTimeout: 10000,
    video: false,
    screenshotOnRunFailure: true,
    chromeWebSecurity: false,

    env: {
        pluginName: "issuePreselection", contextPath: "PJA", defaultCommandTimeout: 10000,
    },

    e2e: {
        baseUrl: "https://localhost:8443",
        specPattern: "cypress/tests/**/*.cy.{js,jsx,ts,tsx}",
        setupNodeEvents(on, config) {
            // implement node event listeners here
            return config;
        },
    },
});
