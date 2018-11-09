#!/bin/bash
set -e

# Deploys a docker pipeline for making changes to hierarchies of dependent docker images.
#
# USAGE:
#  ./deploy-pipeline.sh [create | update]


# Check for valid arguments
if [ $# -ne 1 ]
  then
    echo "Incorrect number of arguments supplied. Pass in either 'create' or 'update'."
    exit 1
fi

# Extract JSON properties for a file into a local variable
PROJECT_NAME=`jq -r '.Parameters.ProjectName' template-pipeline-params.json`

python parameters_generator.py template-pipeline-params.json > temp1.json

# Validate the CloudFormation template before template execution.
aws cloudformation validate-template --template-body file://template-pipeline.json

aws cloudformation $1-stack \
    --stack-name docker-code-pipeline \
    --template-body file://template-pipeline.json \
    --parameters file://temp1.json \
    --capabilities CAPABILITY_NAMED_IAM

# Cleanup
rm temp1.json
