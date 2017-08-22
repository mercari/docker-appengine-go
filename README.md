# docker-appengine-go

Docker Image for the [Google App Engine Go environment](https://cloud.google.com/appengine/docs/go/).

## Installation

```sh
docker pull mercari/appengine-go
```

## Base Image

[google/cloud-sdk:slim - Docker Hub](https://hub.docker.com/r/google/cloud-sdk/)

## Usage

To use this image, pull from [Docker Hub](https://hub.docker.com/r/mercari/appengine-go/), run the following command:

```sh
docker pull mercari/appengine-go:latest
```

### CircleCI 2.0

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

Install Circle CI 2.0 Command Line Interface.

https://circleci.com/docs/2.0/local-jobs/

Verify the CI on local:

```sh
cd YOUR_REPO
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
