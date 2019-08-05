#  Deploy a Linux VM (Jump-Box / Bastion Host)
**Approx. time to complete this section: 45 minutes**

**Description:**
As a first step, we will deploy a Linux VM (CentOS) on Azure and install prerequisite CLI tools on it.  This VM will serve as a jump box (Bastion host) and allow us to manage PaaS services on Azure using CLI.

The following tools (binaries) will be installed on this VM.
- Azure CLI 2.0 client.  Azure CLI will be used to administer and manage all Azure resources.
- Git client.  We will be cloning this repository to make changes to the source code, scripts and Kubernetes resources.
- OpenJDK and Maven.
- Kubernetes CLI (`kubectl`).  This binary will be used for managing resources on Kubernetes (AKS).
- Helm CLI (`helm`).  Helm is a package manager for Kubernetes and is used for automating the deployment of applications comprised of multiple microservices on Kubernetes.
- [Kubernetes Service Catalog](https://kubernetes.io/docs/concepts/extend-kubernetes/service-catalog/). Service Catalog will be used for dynamically provisioning PaaS services on Azure.
- Docker engine (community edition).  Docker will be used to deploy and test application containers on this host.

**Prerequisites:**
1. An active **Microsoft Azure Subscription**

   You can obtain a free Azure subscription by accessing the [Microsoft Azure](https://azure.microsoft.com/en-us/?v=18.12) website.  In order to execute all the labs in this project, either your *Azure subscription* or the *Resource Group* **must** have **Owner** Role assigned to it.

Follow the steps below to create the Bastion host (Linux VM), install pre-requisite software (CLI) on this VM.

1. Access the Azure Cloud Shell

   Login to the [Azure Portal](https://portal.azure.com) using your credentials and use a **Azure Cloud Shell** session to perform the next steps.  Azure Cloud Shell is an interactive, browser-accessible shell for managing Azure resources.  The first time you access the Cloud Shell, you will be prompted to create a resource group, storage account and file share.  You can use the defaults or click on *Advanced Settings* to customize the defaults.  Accessing the Cloud Shell is described in [Overview of Azure Cloud Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/overview). 

2. Create a resource group

   An Azure resource group is a logical container into which Azure resources are deployed and managed.  From the Cloud Shell, use Azure CLI to create a **Resource Group**.  Azure CLI is already pre-installed and configured to use your Azure account (subscription) in the Cloud Shell.  Alternatively, you can also use Azure Portal to create this resource group.  

   ```bash
   # Create the resource group. Substitute your intials in the command below eg., aks-hack-GR
   $ az group create --name aks-hack-<YOUR_INITIAL> --location westus2
   ```

   **NOTE:** Keep in mind, you will need to substitute the resource group name in multiple CLI commands in the remainder of this project!  For the remainder of this project, the resource group will be referred to as **RG_NAME**.

3. Provision a Linux CentOS VM on Azure

   Use the command below to create a **CentOS 7.4** VM on Azure.  Make sure you specify the correct values for RG_NAME for *password*.  Once the command completes, it will print the VM connection info. in the JSON message (response).  Note down the **Public IP address**, **Login name** and **Password** info. so that we can connect to this VM using SSH (secure shell).

   Alternatively, if you prefer you can use SSH based authentication to connect to the Linux VM.  The steps for creating and using an SSH key pair for Linux VMs in Azure is documented [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/mac-create-ssh-keys).  You can then specify the location of the public key with the `--ssh-key-path` option to the `az vm create ...` command.

   ```bash
   # Remember to specify the password for the 'labuser'.
   $ az vm create --resource-group <RG_NAME> --name aks-hack --image OpenLogic:CentOS:7.4:7.4.20180118 --size Standard_B2s --generate-ssh-keys --admin-username labuser --admin-password <password> --authentication-type password
   # When the above command exits, it will print the public IP address, login name (labuser) and password.  Make a note of these values.
   ```

4. Login into the Linux VM via SSH.

   On a Windows PC, you can use a SSH client such as [Putty](https://putty.org/) or the [Windows Sub-System for Linux (Windows 10)](https://docs.microsoft.com/en-us/windows/wsl/install-win10) to login into the VM.

   **NOTE:** Use of Cloud Shell to SSH into the VM is **NOT** recommended.

   ```bash
   # SSH into the VM.  Substitute the public IP address for the Linux VM in the command below.
   $ ssh labuser@x.x.x.x
   #
   ```

5. Install CLI tools

   Install Azure CLI, Kubernetes CLI, Helm CLI, Service Catalog CLI, Git client, Open JDK and Maven on this VM.

   If you are a Linux power user and would like to save yourself some typing time, use this [shell script](./shell-scripts/setup-bastion.sh) to install all the pre-requisite CLI tools.

   ```bash
   # Install Azure CLI on this VM so that we can to deploy this application to the AKS cluster later in step [D].
   #
   # Import the Microsoft repository key.
   $ sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
   #
   # Create the local azure-cli repository information.
   $ sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
   #
   # Install with the yum install command.
   $ sudo yum install azure-cli
   #
   # Test the install
   $ az -v
   #
   # Login to your Azure account
   $ az login -u <user name> -p <password>
   #
   # View help on az commands, sub-commands
   $ az --help
   #
   # Install Git client
   $ sudo yum install git
   #
   # Check Git version number
   $ git --version
   #
   # Install OpenJDK 8 on the VM.
   $ sudo yum install -y java-1.8.0-openjdk-devel
   #
   # Check JDK version
   $ java -version
   #
   # Switch back to home directory
   $ cd
   #
   # Install Maven 3.5.4
   $ mkdir maven
   $ cd maven
   $ wget http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
   $ tar -xzvf apache-maven-3.5.4-bin.tar.gz
   #
   # Switch back to home directory
   $ cd
   #
   # Install Helm v2.14.3
   # Create a new directory 'Helm' under home directory to store the helm binary
   $ mkdir helm
   $ cd helm
   $ wget https://storage.googleapis.com/kubernetes-helm/helm-v2.14.3-linux-amd64.tar.gz
   $ tar -xzvf helm-v2.14.3-linux-amd64.tar.gz
   #
   # Switch back to home directory
   $ cd
   #
   # Install Kubernetes CLI
   # Create a new directory 'aztools' under home directory to store the kubectl binary
   $ mkdir aztools
   #
   # Install kubectl binary in the new directory
   $ az aks install-cli --install-location=./aztools/kubectl
   #
   # Install Service Catalog 'svcat' binary in 'aztools' directory
   $ cd aztools
   $ curl -sLO https://servicecatalogcli.blob.core.windows.net/cli/latest/$(uname -s)/$(uname -m)/svcat
   $ chmod +x ./svcat
   # Switch back to home directory
   $ cd
   #
   # Finally, update '.bashrc' file and set the path to Maven, Helm and Kubectl binaries
   $ KUBECLI=/home/labuser/aztools
   $ MAVEN=/home/labuser/maven/apache-maven-3.5.4/bin
   $ HELM=/home/labuser/helm/linux-amd64
   $ echo "export PATH=$MAVEN:$KUBECLI:$HELM:${PATH}" >> ~/.bashrc
   #
   ```

6. Install **docker-ce** container runtime

   Refer to the commands below.  You can also refer to the [Docker CE install docs for CentOS](https://docs.docker.com/install/linux/docker-ce/centos/).

   ```bash
   $ sudo yum update
   $ sudo yum install -y yum-utils device-mapper-persistent-data lvm2
   $ sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
   $ sudo yum install docker-ce-18.03.0.ce
   $ sudo systemctl enable docker
   $ sudo groupadd docker
   $ sudo usermod -aG docker labuser
   ```

   **NOTE:** LOGOUT AND RESTART YOUR LINUX VM BEFORE PROCEEDING.  You can restart the VM via Azure Portal.  Once the VM is back up, log back in to the Linux VM via SSH.  Run the command below to verify **docker** engine is running.

   ```bash
   $ docker info
   ```

You have now completed this lab exercise.  Go back to the parent project and proceed with the next challenge. 
