FROM docker:18.06 as stage-static-docker

FROM debian:stretch
LABEL maintainer "Mercari, Inc"

ARG GOLANG_VERSION=1.11.1
ARG GOLANG_DOWNLOAD_SHA256=2871270d8ff0c8c69f161aaae42f9f28739855ff5c5204752a8d92a1c9f63993
ARG CLOUD_SDK_VERSION=223.0.0
ENV GOPATH=/go \
	PATH=/go/bin:/usr/local/go/bin:/usr/lib/google-cloud-sdk/bin:$PATH \
	GOLANG_VERSION="$GOLANG_VERSION" \
	GOLANG_DOWNLOAD_SHA256="$GOLANG_DOWNLOAD_SHA256" \
	CLOUD_SDK_VERSION="$CLOUD_SDK_VERSION"

COPY --from=stage-static-docker /usr/local/bin/docker /usr/local/bin/docker
RUN set -eux && \
	apt-get update && \
	apt-get install -yqq --no-install-suggests --no-install-recommends \
		curl \
		gcc \
		git \
		libc6-dev \
		make \
		openjdk-8-jdk-headless \
		openssh-client \
		python-dev \
		python-pip \
		python-setuptools \
		unzip && \
	rm -rf /var/lib/apt/lists/* && \
	\
	pip install -U crcmod && \
	rm -rf $HOME/.cache/pip && \
	\
	curl -sSL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-"$CLOUD_SDK_VERSION"-"$(uname | tr '[:upper:]' '[:lower:]')"-"$(uname -m)".tar.gz | tar -C /usr/lib -xzf - && \
	/usr/lib/google-cloud-sdk/install.sh --usage-reporting=false --command-completion=false --path-update=false --quiet --additional-components \
		app-engine-go \
		bq \
		cbt \
		bigtable \
		cloud-datastore-emulator \
		pubsub-emulator \
		core \
		cloud_sql_proxy \
		emulator-reverse-proxy \
		cloud-build-local \
		docker-credential-gcr \
		beta && \
	gcloud config set core/disable_usage_reporting true && \
	gcloud config set component_manager/disable_update_check true && \
	gcloud config set metrics/environment github_docker_image && \
	\
	curl -o go.tgz -sSL "https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz" && \
	echo "${GOLANG_DOWNLOAD_SHA256} *go.tgz" | sha256sum -c - && \
	tar -C /usr/local -xzf go.tgz && \
	rm go.tgz && \
	mkdir -p ${GOPATH}

VOLUME ["/root/.config"]
