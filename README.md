# Docker Image Pipeline
A full CI/CD solution for continuously building and deploying entire Docker image hierarchies.

#### Overview
Builds infrastructure for managing a hierarchy of docker images required for a Phoenix microservice project.
A default set of base docker images for build nodes and application nodes can be found in this repo, along
with the infrastructure to manage deployment of those images in a safe and predictable way.

#### What does this CloudFormation stack do?
* Creates a GitHub webhook.
* Creates ECR repos for storing families of related docker images.
* Creates a CodeBuild job for building and pushing the docker images.
* Creates a CodePipeline for orchestration.
* Creates IAM roles.

#### Running the stack for the first time
* Clone this repo and give it a name, such as "credit-service-docker", or "point-of-sale-docker".
* The name of this repo must match the project name (see 'your-project-name' below).

```
$ git clone {the URL of this repo}
$ git remote remove origin
$ git remote add origin {your-repo-origin}
$ python search_and_replace.py . 714284646049 {your AWS AccountId}
$ python search_and_replace.py . phoenix {your-project-name} --> where "your-project-name" is name of your git repo.
```

#### Save the token in SSM parameter store

```
./deploy-ssm-github-token.sh {token}
```
Where {token} can be found in LastPass under "mosaic-codebuild personal access token". This token is required mostly to create webhook and make API calls into GitHub.

#### Update parameter file
* Update the params in the 'template-pipeline-params.json' file, using your project role.

```
$ git add -A
$ git diff --> Run this command to view changes
$ git commit -m "Updating repo to use my project name and AWS account ID."
```

#### Create or update the stack
```
$ ./deploy-pipeline.sh create
# ./deploy-pipeline.sh update
```

#### Trigger the pipeline
```
$ git push origin master
```

#### More Information
Inspiration for this project:
https://github.com/aws/aws-codebuild-docker-images
