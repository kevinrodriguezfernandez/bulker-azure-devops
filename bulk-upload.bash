#!/bin/bash

# Define variables for Azure DevOps organization URL, project name, and personal access token
org_url="your_org"
project_name="project_name"
pat="pat or create on your env"

# Loop through all directories in the current directory
for dir in */; do
  # Get the name of the directory (without trailing slash)
  repo_name=${dir%/}
  : 
  # Create the repository in Azure DevOps using the REST API
  curl -H "Authorization: Basic $(echo -n :$pat | base64)" \
       -H "Content-Type: application/json" \
       -d "{\"name\": \"$repo_name\", \"project\": { \"name\": \"$project_name\" }}" \
       -X POST \
       "$org_url/_apis/git/repositories?api-version=6.0-preview.1"

  # Initialize a new git repository in the directory
  cd "$dir"
  git init

  # Set the remote to the Azure DevOps repository URL
  git remote add origin "https://$org_url/$project_name/_git/$repo_name"

  # Add and commit all files in the directory
  git add .
  git commit -m "Initial commit"

  # Push the repository to Azure DevOps
  git push -u origin master

  # Go back to the parent directory
  cd ..
    
    echo $repo_name
done
