#!/bin/bash
set -e

# Saves a GitHub access token to SSM parameter store for the docker code pipeline webhook.
# You must generate an access token within GitHub and pass it to this script.
#
# USAGE
#   ./ssm-put-github-token.sh {Github Token}

# Check for valid arguments
if [ $# -ne 1 ]
  then
    echo "Incorrect number of arguments supplied. Pass in a Githab access token"
    exit 1
fi

aws ssm put-parameter \
  --name '/global/github/tokens/docker-pipeline' \
  --description 'GitHub token used by the Docker code pipeline for this account' \
  --type 'String' \
  --overwrite \
  --value $1
