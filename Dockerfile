FROM google/cloud-sdk:slim

ARG GOLANG_VERSION=1.6.4
ARG GOLANG_DOWNLOAD_SHA256=b58bf5cede40b21812dfa031258db18fc39746cc0972bc26dae0393acc377aaf
ARG APPENGINE_GO_VERSION=1.9.57
ARG APPENGINE_GO_DOWNLOAD_SHA256=bd4136de7ef8a5001ca1050238999e9ff45d696ffcb60c4f5e851687dd8deee7
ENV GOPATH=/go \
	PATH=/go/bin:/usr/local/go/bin:/google-cloud-sdk/platform/go_appengine:$PATH

RUN set -ex && \
	apt-get update && \
	apt-get install -yqq --no-install-suggests --no-install-recommends \
		make \
		unzip && \
	rm -rf /var/lib/apt/lists/* && \
	\
	curl -o go.tgz -sSL "https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz" && \
	echo "${GOLANG_DOWNLOAD_SHA256} *go.tgz" | sha256sum -c - && \
	tar -C /usr/local -xzf go.tgz && \
	rm go.tgz && \
	\
	mkdir -p /google-cloud-sdk/platform && \
	curl -o gae.zip -sSL "https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_amd64-${APPENGINE_GO_VERSION}.zip" && \
	echo "${APPENGINE_GO_DOWNLOAD_SHA256} *gae.zip" | sha256sum -c - && \
	unzip -q gae.zip -d /google-cloud-sdk/platform/ && \
	rm gae.zip
