# Base docker images repo
A full CI/CD solution for working with Docker image hierarchies.

#### What does this CloudFormation stack do?
* Creates a local CodeCommit repo which stores all of the Dockerfiles you will use in your AWS account.
* Creates Several ECR Docker repos which will contain images build from your Dockerfiles.
* Creates a CodePipeline which will CI/CD any changes pushed to master.
* The CI/CD CodePipeline will progressively build Docker images, pushing all
  to ECR only when they can be sucessfully built.

#### Running the stack for the first time
```
Update the params.json file with your project info (replace 'phoenix' with your project name.)

aws cloudformation validate-template --template-body file://base-docker-images.json

aws cloudformation create-stack --stack-name base-docker-images --template-body file://base-docker-images.json --parameters file://params.json --capabilities CAPABILITY_NAMED_IAM

After the stack has been created, add the generated CodeCommit repo as a remote branch and push this repo to it.
$ git remote add codecommit {codecommit URL}
$ git push origin master

Then watch the pipeline build all of your Docker images and push them to ECR using AWS CodePipeline.
```

#### Adding new Dockerfiles, ECR Repos, pipeline stages, or changing a CodeBuild job.
Make any of the following changes in this repo:
* Adding a new Dockerfile and ECR Repo
* Adding/changing the CodePipeline stages
* Adding/changing the buildspec.yml which progressively and sequentially build the docker images and pushes them to your ECR repos.

Then update the stack:
```
aws cloudformation validate-template --template-body file://base-docker-images.json

aws cloudformation create-stack --stack-name base-docker-images --template-body file://base-docker-images.json --parameters file://params.json --capabilities CAPABILITY_NAMED_IAM
```

#### More Information
You can find more info on how the buildspec.yaml file works here:
https://github.com/aws/aws-codebuild-docker-images
