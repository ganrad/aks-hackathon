#!/bin/bash
# Author: Ganesh Radhakrishnan, garadha@microsoft.com
# Dated: 08-04-2019
# Notes:
# 1. Updated script to install latest versions of CLI tools (except JDK!)
# 2. This script will switch to the User's home directory to install some of the CLI tools
# 

set -e

if [ $# -ge 1 ]; then
	echo -e "\nUsage: setup-bastion.sh"
	exit 1
fi

# Set the user name variable
USER=`whoami`

# Install Azure CLI on this VM
#
# Import the Microsoft repository key.
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
#
# Create the local azure-cli repository information.
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
#
# Install with the yum install command.
echo "Installing Azure CLI"
sudo yum -y install azure-cli
#
# Test the install
echo "Printing Azure CLI version"
az -v
#
# View help on az commands, sub-commands
echo "Listing Azure CLI commands"
az --help
#
# Install Git client
echo "Installing GIT client"
sudo yum -y install git
#
# Check Git version number
echo "Printing GIT version"
git --version
#
# Install OpenJDK 8 on the VM.
echo "Installing OpenJDK v1.8.0"
sudo yum install -y java-1.8.0-openjdk-devel
#
# Check JDK version
echo "Printing OpenJDK version"
java -version
#
# Switch back to home directory
cd
#
# Install Maven 3.5.4
echo "Installing Maven v3.5.4"
mkdir maven
cd maven
wget http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
tar -xzvf apache-maven-3.5.4-bin.tar.gz
#
# Switch back to home directory
cd
#
# Install Helm v2.14.3
# Create a new directory 'Helm' under home directory to store the helm binary
echo "Installing Helm v2.14.3"
mkdir helm
cd helm
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.14.3-linux-amd64.tar.gz
tar -xzvf helm-v2.14.3-linux-amd64.tar.gz
#
# Switch back to home directory
cd
#
# Install Kubernetes CLI
# Create a new directory 'aztools' under home directory to store the kubectl binary
mkdir aztools
#
# Install kubectl binary in the new directory
echo "Installing Kubectl"
az aks install-cli --install-location=./aztools/kubectl
#
# Install Kubernetes Service Catalog 'svcat' binary in 'aztools' directory
echo "Installing Kubernetes Service Catalog"
cd aztools
curl -sLO https://servicecatalogcli.blob.core.windows.net/cli/latest/$(uname -s)/$(uname -m)/svcat
chmod +x ./svcat
# Switch back to home directory
cd
# Finally, update '.bashrc' file and set the path to Maven, Helm and Kubectl binaries
echo "Configuring PATH ..."
cd
KUBECLI=/home/${USER}/aztools
MAVEN=/home/${USER}/maven/apache-maven-3.5.4/bin
HELM=/home/${USER}/helm/linux-amd64
echo "export PATH=$MAVEN:$KUBECLI:$HELM:${PATH}" >> ~/.bashrc
echo "Configuration of jump-host environment completed!"
# End
