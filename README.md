# docker-appengine-go
[![Docker Build Status](https://img.shields.io/docker/build/mercari/appengine-go.svg?style=flat-square&label=status)](https://hub.docker.com/r/mercari/appengine-go/builds/)
[![Docker Automated build](https://img.shields.io/docker/automated/mercari/appengine-go.svg?style=flat-square&label=build)](https://hub.docker.com/r/mercari/appengine-go/)

Docker Image for the [Google App Engine Go environment](https://cloud.google.com/appengine/docs/go/).

## Installation

```sh
docker pull mercari/appengine-go
```

## Tags

All images installed `go` runtime, `gcloud` SDK and following components with `gcloud` way.

| Tag            | [`latest`](1.9/jessie/Dockerfile), [`1.9`](1.9/jessie/Dockerfile) | [`slim`](1.9/slim/Dockerfile), [`1.9-slim`](1.9/slim/Dockerfile) | [`1.8`](1.8/jessie/Dockerfile)                                    | [`1.8-slim`](1.8/slim/Dockerfile)                                | [`1.6`](1.6/jessie/Dockerfile)                    | [`1.6-slim`](1.6/slim/Dockerfile)                      |
|---------------:|-------------------------------------------------------------------|------------------------------------------------------------------|-------------------------------------------------------------------|------------------------------------------------------------------|---------------------------------------------------|--------------------------------------------------------|
|         **Go** | 1.9.2                                                             | 1.9.2                                                            | 1.8.5                                                             | 1.8.5                                                            | 1.6.4                                             | 1.6.4                                                  |
| **Components** | appengine-go                                                      | appengine-go                                                     | appengine-go                                                      | appengine-go                                                     | appengine-go                                      | appengine-go                                           |
|                | beta                                                              | beta                                                             | beta                                                              | beta                                                             | beta                                              | beta                                                   |
|                | cloud-datastore-emulator                                          |                                                                  | cloud-datastore-emulator                                          |                                                                  | cloud-datastore-emulator                          |                                                        |
|                | emulator-reverse-proxy                                            |                                                                  | emulator-reverse-proxy                                            |                                                                  | emulator-reverse-proxy                            |                                                        |
|                | pubsub-emulator                                                   |                                                                  | pubsub-emulator                                                   |                                                                  | pubsub-emulator                                   |                                                        |
| **Base image** | [debian:jessie](https://hub.docker.com/_/debian/)                 | [debian:jessie-slim](https://hub.docker.com/_/debian/)           | [debian:jessie](https://hub.docker.com/_/debian/)                 | [debian:jessie-slim](https://hub.docker.com/_/debian/)           | [debian:jessie](https://hub.docker.com/_/debian/) | [debian:jessie-slim](https://hub.docker.com/_/debian/) |

## Note

All images are monkey patched to `goapp` for always use `api_version` to self go version.

- [`1.6`](1.6/jessie/Dockerfile), [`1.6-slim`](1.6/slim/Dockerfile)

```sh
sed -i "s|goroots.GOROOTS\['go1'\])|goroots.GOROOTS\['go1.6'\])|g" $(which goapp)
```

- [`1.8`](1.8/jessie/Dockerfile), [`1.8-slim`](1.8/slim/Dockerfile)

```sh
sed -i "s|goroots.GOROOTS\['go1'\])|goroots.GOROOTS\['go1.8'\])|g" $(which goapp)
```

- [`latest`](1.9/jessie/Dockerfile), [`1.9`](1.9/jessie/Dockerfile), [`slim`](1.9/slim/Dockerfile), [`1.9-slim`](1.9/slim/Dockerfile)

```sh
sed -i "s|goroots.GOROOTS\['go1'\])|goroots.GOROOTS\['go1.9'\])|g" $(which goapp)
```

`goapp` respect the `api_version` on the `app.yaml` in current directory at first. If not exist `app.yaml`, `goapp` always use the `1.8` version to compiling and testing after Google Cloud SDK version 191.0.0.  
That's why monkey patched `goapp` file.

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
 * Kensuke Sano ([@sonatard](https://github.com/sonatard))

## Contribution

Please read the CLA below carefully before submitting your contribution.

https://www.mercari.com/cla/

## License

Copyright 2017 Mercari, Inc.

Licensed under the MIT License.
