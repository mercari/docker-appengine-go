FROM debian:jessie-slim
LABEL maintainer "Mercari, Inc"

ARG APT_MIRROR=httpredir.debian.org
ARG GOLANG_VERSION=1.9.2
ARG GOLANG_DOWNLOAD_SHA256=de874549d9a8d8d8062be05808509c09a88a248e77ec14eb77453530829ac02b

ENV GOPATH=/go \
	PATH=/go/bin:/usr/local/go/bin:/usr/lib/google-cloud-sdk/bin:/usr/lib/google-cloud-sdk/platform/google_appengine:$PATH

RUN sed -ri "s/(deb|httpredir).debian.org/${APT_MIRROR}/g" /etc/apt/sources.list && \
	set -eux && \
	apt-get update && \
	apt-get install -yqq --no-install-suggests --no-install-recommends \
		curl \
		gcc \
		git \
		libc6-dev \
		make \
		openssh-client \
		python-dev \
		python-pip \
		unzip && \
	rm -rf /var/lib/apt/lists/* && \
	\
	pip install -U crcmod && \
	rm -rf $HOME/.cache/pip && \
	\
	curl https://sdk.cloud.google.com | bash -s -- --disable-prompts --install-dir=/usr/lib && \
	gcloud config set core/disable_usage_reporting true && \
	gcloud config set component_manager/disable_update_check true && \
	gcloud config set metrics/environment github_docker_image && \
	\
	gcloud components install \
		app-engine-go \
		beta && \
	\
	chmod +x \
		/usr/lib/google-cloud-sdk/platform/google_appengine/goapp \
		/usr/lib/google-cloud-sdk/platform/google_appengine/godoc \
		/usr/lib/google-cloud-sdk/platform/google_appengine/gofmt \
		/usr/lib/google-cloud-sdk/platform/google_appengine/appcfg.py \
		/usr/lib/google-cloud-sdk/platform/google_appengine/backends_conversion.py \
		/usr/lib/google-cloud-sdk/platform/google_appengine/bulkload_client.py \
		/usr/lib/google-cloud-sdk/platform/google_appengine/bulkloader.py \
		/usr/lib/google-cloud-sdk/platform/google_appengine/download_appstats.py \
		/usr/lib/google-cloud-sdk/platform/google_appengine/endpointscfg.py && \
	\
	# patch for always use go1.9 runtime
	sed -i "s|goroots.GOROOTS\['go1'\])|goroots.GOROOTS\['go1.9'\])|g" $(which goapp) && \
	\
	curl -o go.tgz -sSL "https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz" && \
	echo "${GOLANG_DOWNLOAD_SHA256} *go.tgz" | sha256sum -c - && \
	tar -C /usr/local -xzf go.tgz && \
	rm go.tgz

VOLUME ["/root/.config"]
