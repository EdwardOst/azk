# Azure CLI & Kubernetes & Docker Client Container

This image creates a container with the Azure CLI, Kuberenetes, and Docker Client pre-installed.  It can be
used instead of installing the client apps ont the host system.  This avoids environment clutter and other
dependencies such as python libraries and makes it simple to upgrade.

You will need to supply Azure and Kubernetes credentials.  Since the Docker image will be transitory,  you
may wish to keep Azure or Kubernetes credentials on the host laptop.  In order to provide access to these
credentials within the container, you can map a host directory to a Docker volume.

The Azure configuration settings are stored in /root/.azure.  Kubernetes settings are in kubernetes.
In addition, Kubernetes uses the Docker client, so the container include the Docker cliient.  You can use the
Docker daemon on the host OS by mapping the docker server socket as a volume.

    docker run -v /home/eost/azure/cli_host:/root \
               -v /home/eost/kubernetes_host:/kubernetes \
               -v /var/run/docker.sock:/var/run/docker.sock \
               -it \
               azuresdk/azurep-cli-python:latest

If you are running Windows, then you are probably using Boot2Docker on windows.  In that case your windows
directories are already mapped.

    docker run -v ${HOME}/Documents/se/azure/cli_host:/root \
               -v ${HOME}/Documents/se/azure/kubernetes_host:/kubernetes \
               -v /var/run/docker.sock:/var/run/docker.sock \
               -it azuresdk/azure-cli-python:latest

TODO: need to address using host docker serfvice on windows, it may not be possible.

