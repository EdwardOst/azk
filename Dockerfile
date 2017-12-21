FROM azuresdk/azure-cli-python:latest


curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz \
&& tar xzvf docker-17.09.0-ce.tgz \
&& mv docker/docker /usr/local/bin \
&& rm -r docker docker-17.09.0-ce.tgz
