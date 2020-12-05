_built with
[concourse ci](https://github.com/JeffDeCola/crypto-miner-manager/blob/master/ci-README.md)_

# OVERVIEW

Here is an overview of what we're going to do,

![IMAGE - crypto-miner-manager-overview - IMAGE](pics/crypto-miner-manager-overview.jpg)

## PREREQUISITES

I used the following language,

* [go](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/development/languages/go-cheat-sheet)

You will need the following go packages,

```bash
go get -u -v github.com/sirupsen/logrus
```

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
[run.sh](https://github.com/JeffDeCola/crypto-miner-manager/blob/master/code/run.sh).

To run
[main.go](https://github.com/JeffDeCola/crypto-miner-manager/blob/master/code/main.go)
from the command line,

```bash
cd code
go run main.go
```

As a placeholder, every 2 seconds it will print,

```txt
    INFO[0000] Let's Start this!
    Hello everyone, count is: 1
    Hello everyone, count is: 2
    Hello everyone, count is: 3
    etc...
```

## CREATE BINARY

The following steps are located in
[create-binary.sh](https://github.com/JeffDeCola/crypto-miner-manager/blob/master/code/bin/create-binary.sh).

```bash
cd code
go build -o bin/crypto-miner main.go
cd bin
./crypto-miner
```

This binary will not be used during a docker build
since it creates it's own.

## TEST, BUILD, PUSH & DEPLOY

Refer to
[ci-README.md](https://github.com/JeffDeCola/crypto-miner-manager/blob/master/ci-README.md)
on how I automated this process.

### STEP 1 - TEST

The following steps are located in
[unit-tests.sh](https://github.com/JeffDeCola/crypto-miner-manager/tree/master/code/test/unit-tests.sh).

To unit test the code,

```bash
cd code
go test -cover ./... | tee test/test_coverage.txt
cat test/test_coverage.txt
```

To create `_test` files,

```bash
gotests -w -all main.go
```

### STEP 2 - BUILD (DOCKER IMAGE VIA DOCKERFILE)

The following steps are located in
[build.sh](https://github.com/JeffDeCola/crypto-miner-manager/blob/master/code/build-push/build.sh).

We will be using a multi-stage build using a
[Dockerfile](https://github.com/JeffDeCola/crypto-miner-manager/blob/master/code/build-push/Dockerfile).
The end result will be a very small docker image around 13MB.

```bash
cd code
docker build -f build-push/Dockerfile -t jeffdecola/crypto-miner-manager .
```

You can check and test this docker image,

```bash
docker images jeffdecola/crypto-miner-manager:latest
docker run --name crypto-miner-manager -dit jeffdecola/crypto-miner-manager
docker exec -i -t crypto-miner-manager /bin/bash
docker logs crypto-miner-manager
```

#### Stage 1

In stage 1, rather than copy a binary into a docker image (because
that can cause issue), **the Dockerfile will build the binary in the
docker image.**

If you open the DockerFile you can see it will get the dependencies and
build the binary in go,

```bash
FROM golang:alpine AS builder
RUN go get -d -v
RUN go build -o /go/bin/crypto-miner-manager main.go
```

#### Stage 2

In stage 2, the Dockerfile will copy the binary created in
stage 1 and place into a smaller docker base image based
on `alpine`, which is around 13MB.

### STEP 3 - PUSH (TO DOCKERHUB)

The following steps are located in
[push.sh](https://github.com/JeffDeCola/crypto-miner-manager/blob/master/code/build-push/push.sh).

If you are not logged in, you need to login to dockerhub,

```bash
docker login
```

Once logged in you can push to DockerHub,

```bash
docker push jeffdecola/crypto-miner-manager
```

Check the
[crypto-miner-manager](https://hub.docker.com/r/jeffdecola/crypto-miner-manager)
docker image at DockerHub.

### STEP 4 - DEPLOY (TO MARATHON)

The following steps are located in
[deploy.sh](https://github.com/JeffDeCola/crypto-miner-manager/blob/master/code/deploy-marathon/deploy.sh).

Pull the `crypto-miner-manager` docker image
from DockerHub and deploy to mesos/marathon.

This is actually very simple, you just PUT the
[app.json](https://github.com/JeffDeCola/crypto-miner-manager/blob/master/code/deploy-marathon/app.json)
file to mesos/marathon. This .json file tells marathon what to do.

```bash
cd deploy-marathon
curl -X PUT http://192.168.20.117:8080/v2/apps/crypto-miner-long-running \
-d @app.json \
-H "Content-type: application/json"
```
