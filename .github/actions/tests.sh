#!/bin/bash

set -e

npx cypress run  --headless --browser chrome  --config '{"specPattern":["plugins/generic/issuePreselection/cypress/tests/functional/*.cy.js"]}'


