#!/bin/bash

set -e

# Determine the plugin directory name (could be issuePreselection or ojs-issue-preselection)
PLUGIN_DIR="plugins/generic/issuePreselection"
if [ ! -d "$PLUGIN_DIR" ]; then
    PLUGIN_DIR="plugins/generic/ojs-issue-preselection"
fi

echo "Installing Cypress dependencies in $PLUGIN_DIR..."
cd "$PLUGIN_DIR"
npm install

echo "Running Cypress tests..."
npx cypress run --headless --browser chrome --config baseUrl=http://localhost --env contextPath=publicknowledge,adminUsername=admin,adminPassword=admin,editorUsername=dbarnes,editorPassword=dbarnes,authorUsername=ccorino,authorPassword=ccorino,CI=true


