# Ruby (Sinatra-based) dummy application

This application was writen to test the inner workings of Gitlab CI. The main reason of embracing Gitlab CI in our workflow is that we would like to deploy an application using a simple Git commit (and maybe adding a specify tag to the commit).

Workflow: 

1. Run all tests inside a disposable docker container. The command `bundle exec rake test` shoud be successfull.
2. Build a container based of the current codebase and push the container to a private registry
3. Notify a 'continuous deployment engine' that a new Docker container is ready to be deployed to the live environement

## Install Gitlab-CI

This application uses `gitlab-ci-multi-runner` on a seperate Ubuntu 14.04.3 LTS server with Docker version 1.8.3, build f4bf5c7 installed.

1. Add GitLab's official repository via apt-get:
```
$ curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash
Install gitlab-ci-multi-runner
```
2. Install `gitlab-ci-multi-runner`
```
$ apt-get install gitlab-ci-multi-runner
```

## Register runners

Register two runners, the first one is used to run your tests, the second runner is used to create a docker image and publish it to a (private) registry. 

Navigate to the your projects CI page in Gitlab to get the gitlab-ci token (e.g.: https://gitlab.adcombi.com/ci/projects/2/runners). Now register the two workers:

```
$ sudo gitlab-ci-multi-runner register

gitlab-ci-multi-runner register
Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/ci):
https://gitlab.example.com/ci
Please enter the gitlab-ci token for this runner:
1a6246xxxxxxxxxxxxxxxxxxxxxxxx
Please enter the gitlab-ci description for this runner:
[ci-runner01]: CI runner 01
Please enter the gitlab-ci tags for this runner (comma separated):
ruby,ruby2.2.3
INFO[0033] 1a624630 Registering runner... succeeded     
Please enter the executor: docker-ssh, ssh, shell, parallels, docker:
docker
Please enter the Docker image (eg. ruby:2.1):
ruby:2.2.3
If you want to enable mysql please enter version (X.Y) or enter latest?

If you want to enable postgres please enter version (X.Y) or enter latest?

If you want to enable redis please enter version (X.Y) or enter latest?

If you want to enable mongo please enter version (X.Y) or enter latest?

INFO[0045] Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded! 
```

### Register the Continuous Deployment runner
```
$ sudo gitlab-ci-multi-runner register

Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/ci):
https://gitlab.example.com/ci
Please enter the gitlab-ci token for this runner:
1a6246xxxxxxxxxxxxxxxxxxxxxxxx
Please enter the gitlab-ci description for this runner:
[ci-runner01]: CD runner 01
Please enter the gitlab-ci tags for this runner (comma separated):
privileged,shell
INFO[0051] 1a624630 Registering runner... succeeded     
Please enter the executor: docker, docker-ssh, ssh, shell, parallels:
shell
INFO[0053] Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded! 
```

### Restart gitlab-ci-multi-runner:
```
$ gitlab-ci-multi-runner restart
```

## Edit `.gitlab-ci.yml`

Now edit the `.gitlab-ci.yml` file. It should contain two sections `test` and `deploy`. Using the `tags`, you can choose the runner that should be used. 

### Edit `Dockerfile`

Dependig on your project, you might want to change the Dockerfile. The Dockerfile is used to build the container