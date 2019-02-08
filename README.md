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
$ python search_and_replace.py . 123456789123 {your AWS AccountId}
$ python search_and_replace.py . phoenix {your-project-name} --> where "your-project-name" is name of your git repo.
$ python search_and_replace.py . PhoenixAdmins {YourProjectRoleName}
```

#### Save the token in SSM parameter store

```
./deploy-ssm-github-token.sh {token}
```
Where {token} is your GitHub access token used to create webhooks.

#### Git commit the changes
```
$ git add -A
$ git diff HEAD --> Run this command to view changes
$ git commit -m "Updating repo to use my project name and AWS account ID."
$ git push origin master
```

#### Create a repo in github
1. Name the docker repo "{your-project}-docker"
2. Make sure to add this repo under the solarmosaic organization
3. Add both the "codebuild-users" and "devops-and-it" groups as admin users.

#### AWS CodeBuild GitHub OAuth authorization
- These steps assume use of OneLogin and LastPass.
* These steps are only required once per AWS account.
* When using AWS CodeBuild with GitHub webhook integrations, there is a one time setup involving Oauth tokens for new AWS accounts.
* We will need to use a shared admin GitHub account to authorize these tokens rather than use user specific GitHub accounts.
1. Sign out of your GitHub account.
2. Sign out of your OneLogin account.
3. Sign back into OneLogin as the github access token user.
4. Once logged in, click on the GitHub app within OneLogin.
5. At the GitHub login screen, use the username and password specified in lastpass.
6. Verify that you are logged into GitHub as the github access token user.
7. In the new AWS account, open the AWS CodeBuild console and a new job called "test".
8. Create a simple CodeBuild job using GitHub as the source, and click on the "Connect to GitHub" button.
9. A dialog box will appear where you can authorize "aws-codesuite" to access the GitHub organization.
10. Now you can allow CloudFormation to automatically create GitHub webhooks associated with this AWS account.
11. Log out of the github token user's GitHub account.
12. Log out of the github token user's OneLogin account.
13. Log back into your OneLogin and GitHub accounts. 

#### Create or update the stack 
Make sure you've followed all other steps above before executing the commands below.
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
