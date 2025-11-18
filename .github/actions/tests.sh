#!/bin/bash

set -e

PLUGIN_DIR="plugins/generic/issuePreselection"

echo "Installing Cypress dependencies in $PLUGIN_DIR..."
cd "$PLUGIN_DIR"
npm install

echo "Running Cypress tests..."
npx cypress run --headless --browser chrome --config baseUrl=http://localhost


