#!/bin/bash

set -e

echo "Installing Cypress dependencies..."
cd plugins/generic/issuePreselection
npm install

echo "Running Cypress tests..."
npx cypress run --headless --browser chrome --config baseUrl=http://localhost --env contextPath=index,adminUsername=admin,adminPassword=admin,editorUsername=dbarnes,editorPassword=dbarnes,authorUsername=ccorino,authorPassword=ccorino,CI=true


