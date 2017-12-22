ARG AZURE_CLI_PYTHON_VERSION=latest
FROM azuresdk/azure-cli-python:${AZURE_CLI_PYTHON_VERSION}

ARG DOCKER_CLIENT_VERSION=17.09.1-ce

RUN apk update \
 && apk upgrade \
 && apk add curl \
 && curl -fsSL  --output docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_CLIENT_VERSION}.tgz \
 && rm -rf /var/cache/apk/* \
 && tar xzvf docker.tgz \
 && mv docker/docker /usr/local/bin \
 && mkdir -p kubernetes \
 && az acs kubernetes install-cli --install-location=/kubernetes/kubectl \
 && ln -s /kubernetes/kubectl /usr/local/bin/kubectl
