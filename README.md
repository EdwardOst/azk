# Azure CLI & Kubernetes & Docker Client Container

This image creates a container with the Azure CLI, Kuberenetes, and Docker Client pre-installed.  It can be
used instead of installing the client apps ont the host system.  This avoids environment clutter and other
dependencies such as python libraries and makes it simple to upgrade.

A variety of credentials and infrastructure are used by azure cli and kubernetes.  In order to persist this
data across multiple sessions you can use docker volumes.

* Azure configuration settings are stored in the `~/.azure` directory.
* ssh keys in the `~/.ssh` directory.
* Kubernetes configuration in `~/.kube`
* Docker client on `/var/run/docker.sock`

You can retrieve the kubernetes credentials from ACS using the `get-credentials` command.  The results will be
saved to ~/.kube in the container, so you may wish to map this to a host volume.

    # az acs kubernetes get-credentials --resource-group=acs_test1 --name=eost_acs_cluster
    Merged "eostacsclu-acstest1-736734mgmt" as current context in /root/.kube/config

A sample docker run script is included in the `azk` script shown below

    docker run -v /home/eost/azk:/root \
               -v /var/run/docker.sock:/var/run/docker.sock \
               --rm \
               -it \
               azk:latest

The Docker run command above maps the `azk` directory to the container `/root` directory.  `/root` is the default
home for the alpine image, so the .ssh, .kube, and .azure files will all be mounted under this volume. 

If you are running Windows, then you are probably using Boot2Docker on windows.  In that case your windows
directories are already mapped.

    docker run -v ${HOME}/Documents/se/azk:/root \
               -v /var/run/docker.sock:/var/run/docker.sock \
               --rm \
               -it \
               azk:latest

TODO: need to address using host docker serfvice on windows, it may not be possible.

### Sample Session

```

bash-4.3# az login
To sign in, use a web browser to open the page https://aka.ms/devicelogin and enter the code xxxxxx to 
authenticate.
[
  {
    "cloudName": "AzureCloud",
    "id": "736734f7-655c-4c6e-bdcd-945cc1d13eb4",
    "isDefault": true,
    "name": "Microsoft Azure Enterprise",
    "state": "Enabled",
    "tenantId": "0333ca35-3f21-4f69-abef-c46d541d019d",
    "user": {
      "name": "eost@talend.com",
      "type": "user"
    }
  }
]

bash-4.3# az group create --name eost-acs --location eastus2
{
  "id": "/subscriptions/736734f7-655c-4c6e-bdcd-945cc1d13eb4/resourceGroups/eost-acs",
  "location": "eastus2",
  "managedBy": null,
  "name": "eost-acs",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null
}

bash-4.3# az acs create --orchestrator-type kubernetes --resource-group eost-acs --name eost-k8 --generate-ssh-keys
SSH key files '/root/.ssh/id_rsa' and '/root/.ssh/id_rsa.pub' have been generated under ~/.ssh to allow SSH
access to the VM. If using machines without permanent storage like Azure Cloud Shell without an attached file
share, back up your keys to a safe location.



```
