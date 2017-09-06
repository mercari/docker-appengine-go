# docker-appengine-go
[![Docker Build Status](https://img.shields.io/docker/build/mercari/appengine-go.svg?style=flat-square&label=status)](https://hub.docker.com/r/mercari/appengine-go/builds/)
[![Docker Automated build](https://img.shields.io/docker/automated/mercari/appengine-go.svg?style=flat-square&label=build)](https://hub.docker.com/r/mercari/appengine-go/)

Docker Image for the [Google App Engine Go environment](https://cloud.google.com/appengine/docs/go/).

## Installation

```sh
docker pull mercari/appengine-go
```

## Tags

### `latest`
[![](https://images.microbadger.com/badges/image/mercari/appengine-go.svg)](https://microbadger.com/images/mercari/appengine-go "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/mercari/appengine-go.svg)](https://microbadger.com/images/mercari/appengine-go "Get your own version badge on microbadger.com")

[`latest`](Dockerfile) tag image installed `gcloud` SDK and installed following components with `gcloud` way.  
base image uses `debian:jessie`.

- appengine-go
- beta
- cloud-datastore-emulator
- emulator-reverse-proxy
- pubsub-emulator

### `slim`
[![](https://images.microbadger.com/badges/image/mercari/appengine-go:slim.svg)](https://microbadger.com/images/mercari/appengine-go:slim "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/mercari/appengine-go:slim.svg)](https://microbadger.com/images/mercari/appengine-go:slim "Get your own version badge on microbadger.com")

[`slim`](slim/Dockerfile) tag image installed `gcloud` SDK and installed following components with `gcloud` way.  
base image uses `debian:jessie-slim`.

- appengine-go
- beta

## Base image

| latest                                                    | slim                                                           |
|-----------------------------------------------------------|----------------------------------------------------------------|
| [library/debian:jessie](https://hub.docker.com/_/debian/) | [library/debian:jessie-slim](https://hub.docker.com/_/debian/) |

## Usage
 
To use this image, pull from [Docker Hub](https://hub.docker.com/r/mercari/appengine-go/). See [Installation](#installation) section.

Verify the `go`, `gcloud` and `goapp` commands:

```console
$ docker run --rm -it mercari/appengine-go:latest gcloud version
Google Cloud SDK 167.0.0
alpha 2017.08.11
beta 2017.08.11
bq 2.0.25
core 2017.08.11
gcloud
gsutil 4.27

$ docker run --rm -it mercari/appengine-go:latest go version
go version go1.6.4 linux/amd64

$ docker run --rm -it mercari/appengine-go:latest goapp version
go version 1.6.4 (appengine-1.9.57) linux/amd64
```

### Use on Circle CI 2.0

Create `.circleci/config.yml` to your repository.  

```yaml
version: 2
jobs:
  build:
    working_directory: /go/src/github.com/YOUR/REPO
    docker:
      - image: mercari/appengine-go
    steps:
      - checkout
      - run:
          command: YOUR_TEST_COMMAND
```

If you want to test the CI works, Install Circle CI 2.0 Command Line Interface:

https://circleci.com/docs/2.0/local-jobs/

Verify on local (required Docker environment on host OS):

```sh
cd /path/to/your_repository
circleci build
```

## Committers

 * Koichi Shiraishi ([@zchee](https://github.com/zchee))

## Contribution

Please read the CLA below carefully before submitting your contribution.

https://www.mercari.com/cla/

## License

Copyright 2017 Mercari, Inc.

Licensed under the MIT License.
