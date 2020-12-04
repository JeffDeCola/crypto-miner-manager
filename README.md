# hello-go-deploy-marathon

[![Go Report Card](https://goreportcard.com/badge/github.com/JeffDeCola/hello-go-deploy-marathon)](https://goreportcard.com/report/github.com/JeffDeCola/hello-go-deploy-marathon)
[![GoDoc](https://godoc.org/github.com/JeffDeCola/hello-go-deploy-marathon?status.svg)](https://godoc.org/github.com/JeffDeCola/hello-go-deploy-marathon)
[![Maintainability](https://api.codeclimate.com/v1/badges/24c711ac3a1ec5155969/maintainability)](https://codeclimate.com/github/JeffDeCola/hello-go-deploy-marathon/maintainability)
[![Issue Count](https://codeclimate.com/github/JeffDeCola/hello-go-deploy-marathon/badges/issue_count.svg)](https://codeclimate.com/github/JeffDeCola/hello-go-deploy-marathon/issues)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)

_Test, build, push (to DockerHub) and deploy
a long running "hello-world" Docker Image to Mesos/Marathon._

I also have other repos showing different deployments,

* PaaS
  * [hello-go-deploy-aws-elastic-beanstalk](https://github.com/JeffDeCola/hello-go-deploy-aws-elastic-beanstalk)
  * [hello-go-deploy-azure-app-service](https://github.com/JeffDeCola/hello-go-deploy-azure-app-service)
  * [hello-go-deploy-gae](https://github.com/JeffDeCola/hello-go-deploy-gae)
  * [hello-go-deploy-marathon](https://github.com/JeffDeCola/hello-go-deploy-marathon)
    **(You are here)**
* CaaS
  * [hello-go-deploy-amazon-ecs](https://github.com/JeffDeCola/hello-go-deploy-amazon-ecs)
  * [hello-go-deploy-amazon-eks](https://github.com/JeffDeCola/hello-go-deploy-amazon-eks)
  * [hello-go-deploy-aks](https://github.com/JeffDeCola/hello-go-deploy-aks)
  * [hello-go-deploy-gke](https://github.com/JeffDeCola/hello-go-deploy-gke)
* IaaS
  * [hello-go-deploy-amazon-ec2](https://github.com/JeffDeCola/hello-go-deploy-amazon-ec2)
  * [hello-go-deploy-azure-vm](https://github.com/JeffDeCola/hello-go-deploy-azure-vm)
  * [hello-go-deploy-gce](https://github.com/JeffDeCola/hello-go-deploy-gce)

Table of Contents,

* [PREREQUISITES](https://github.com/JeffDeCola/hello-go-deploy-marathon#prerequisites)
* [RUN](https://github.com/JeffDeCola/hello-go-deploy-marathon#run)
* [CREATE BINARY](https://github.com/JeffDeCola/hello-go-deploy-marathon#create-binary)
* [STEP 1 - TEST](https://github.com/JeffDeCola/hello-go-deploy-marathon#step-1---test)
* [STEP 2 - BUILD (DOCKER IMAGE VIA DOCKERFILE)](https://github.com/JeffDeCola/hello-go-deploy-marathon#step-2---build-docker-image-via-dockerfile)
* [STEP 3 - PUSH (TO DOCKERHUB)](https://github.com/JeffDeCola/hello-go-deploy-marathon#step-3---push-to-dockerhub)
* [STEP 4 - DEPLOY (TO MARATHON)](https://github.com/JeffDeCola/hello-go-deploy-marathon#step-4---deploy-to-marathon)
* [CONTINUOUS INTEGRATION & DEPLOYMENT](https://github.com/JeffDeCola/hello-go-deploy-marathon#continuous-integration--deployment)

Documentation and references,

* The `hello-go-deploy-marathon`
  [Docker Image](https://hub.docker.com/r/jeffdecola/hello-go-deploy-marathon)
  on DockerHub

[GitHub Webpage](https://jeffdecola.github.io/hello-go-deploy-marathon/)
_built with
[concourse ci](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/ci-README.md)_

## PREREQUISITES

I used the following language,

* [go](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/development/languages/go-cheat-sheet)

To build a docker image you will need docker on your machine,

* [docker](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/orchestration/builds-deployment-containers/docker-cheat-sheet)

To push a docker image you will need,

* [DockerHub account](https://hub.docker.com/)

To deploy to `mesos/marathon` you will need,

* [marathon](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/orchestration/cluster-managers-resource-management-scheduling/marathon-cheat-sheet)
* [mesos](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/orchestration/cluster-managers-resource-management-scheduling/mesos-cheat-sheet)

As a bonus, you can use Concourse CI,

* [concourse](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/continuous-integration-continuous-deployment/concourse-cheat-sheet)

## RUN

The following steps are located in
[run.sh](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/example-01/run.sh).

To run
[main.go](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/example-01/main.go)
from the command line,

```bash
cd example-01
go run main.go
```

Every 2 seconds it will print,

```bash
Hello everyone, count is: 1
Hello everyone, count is: 2
Hello everyone, count is: 3
etc...
```

## CREATE BINARY

If you want, you can create a binary, but this will not be used since
it is created during the docker image build.

The following steps are located in
[create-binary.sh](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/example-01/bin/create-binary.sh).

```bash
cd example-01
go build -o bin/hello-go main.go
cd bin
./hello-go
```

## STEP 1 - TEST

The following steps are located in
[unit-tests.sh](https://github.com/JeffDeCola/hello-go-deploy-marathon/tree/master/example-01/test/unit-tests.sh).

To unit test the code,

```bash
cd example-01
go test -cover ./... | tee test/test_coverage.txt
cat test/test_coverage.txt
```

To create `_test` files,

```bash
gotests -w -all main.go
```

## STEP 2 - BUILD (DOCKER IMAGE VIA DOCKERFILE)

The following steps are located in
[build.sh](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/example-01/build-push/build.sh).

We will be using a multi-stage build using a
[Dockerfile](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/example-01/build-push/Dockerfile).
The end result will be a very small docker image around 13MB.

```bash
cd example-01
docker build -f build-push/Dockerfile -t jeffdecola/hello-go-deploy-marathon .
```

You can check and test this docker image,

```bash
docker images jeffdecola/hello-go-deploy-marathon:latest
docker run --name hello-go-deploy-marathon -dit jeffdecola/hello-go-deploy-marathon
docker exec -i -t hello-go-deploy-marathon /bin/bash
docker logs hello-go-deploy-marathon
```

### Stage 1

In stage 1, rather than copy a binary into a docker image (because
that can cause issue), **the Dockerfile will build the binary in the
docker image.**

If you open the DockerFile you can see it will get the dependencies and
build the binary in go,

```bash
FROM golang:alpine AS builder
RUN go get -d -v
RUN go build -o /go/bin/hello-go-deploy-marathon main.go
```

### Stage 2

In stage 2, the Dockerfile will copy the binary created in
stage 1 and place into a smaller docker base image based
on `alpine`, which is around 13MB.

## STEP 3 - PUSH (TO DOCKERHUB)

The following steps are located in
[push.sh](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/example-01/build-push/push.sh).

If you are not logged in, you need to login to dockerhub,

```bash
docker login
```

Once logged in you can push to DockerHub,

```bash
docker push jeffdecola/hello-go-deploy-marathon
```

Check the
[hello-go-deploy-marathon](https://hub.docker.com/r/jeffdecola/hello-go-deploy-marathon)
docker image at DockerHub.

## STEP 4 - DEPLOY (TO MARATHON)

The following steps are located in
[deploy.sh](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/example-01/deploy-marathon/deploy.sh).

Pull the `hello-go-deploy-marathon` docker image
from DockerHub and deploy to mesos/marathon.

This is actually very simple, you just PUT the
[app.json](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/example-01/deploy-marathon/app.json)
file to mesos/marathon. This .json file tells marathon what to do.

```bash
cd deploy-marathon
curl -X PUT http://192.168.20.117:8080/v2/apps/hello-go-long-running \
-d @app.json \
-H "Content-type: application/json"
```

## CONTINUOUS INTEGRATION & DEPLOYMENT

Refer to
[ci-README.md](https://github.com/JeffDeCola/hello-go-deploy-marathon/blob/master/ci-README.md)
for how I automated the above process.
