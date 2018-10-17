# Docker Image Fanout Pipeline
A full CI/CD solution for continuously building and deploying entire Docker image hierarchies.

#### Overview
Having a hierarchy of docker images for your Phoenix project is useful for ensuring all images
have a common set of libraries, utilities, and dependencies. For example, you may use different
docker images for different types of build jobs,

#### What does this CloudFormation stack do?
* Creates a local CodeCommit repo which stores all of the Dockerfiles you will use in your AWS account.
* Creates Several ECR Docker repos which will contain images build from your Dockerfiles.
* Creates a CodePipeline which will CI/CD any changes pushed to master.
* The CI/CD CodePipeline will progressively build Docker images, pushing all
  to ECR only when they can be successfully built.

#### Running the stack for the first time
* Create a git repo cloned from this repo. Take note of the name of the git repo as it must be the same as the project name.
* After cloning this repo, run the commands below:

```
$ git clone {the URL of this repo}
$ python search_and_replace.py . 714284646049 {your AWS AccountId}
$ python search_and_replace.py . phoenix {your-project-name} --> where "your-project-name" is name of your git repo.
$ git add -A
$ git diff --> Run this command to view changes
$ git commit -m "Updating repo to use my project name and AWS account ID."

 Launch the stacks

$ ./deploy-gitlab-pipeline.sh create
$ ./deploy-docker-code-pipeline.sh create

 Create a GitLab webhook using the generated API endpoint, secret token, and SSH public key from the gitlab stack.
 Push to gitlab. Watch the pipeline build all of your Docker images and push them to ECR automatically.

$ git push origin master
```

#### Adding new Dockerfiles, ECR Repos, pipeline stages, or changing a CodeBuild job.
Make any of the following changes in this repo:
* Adding a new Dockerfile and ECR Repo
* Adding/changing the CodePipeline stages
* Adding/changing the buildspec.yml which progressively and sequentially build the docker images and pushes them to your ECR repos.
* Then update the stack:

```
./deploy-docker-code-pipeline.sh update
```

#### More Information
You can find more info on how the buildspec.yaml file works here:
https://github.com/aws/aws-codebuild-docker-images
