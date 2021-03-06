#  Azure Kubernetes Service *Hackathon*
This hackathon is for advanced users of Kubernetes.  The goal of this hackathon is to educate attendees on many of the preview features introduced in the latest version of AKS.  This project will be updated frequently to include challenges for newly introduced and upcoming features in AKS.

### Description:

In a nutshell, you will work on the following tasks.
1.  Provision a Linux VM and install pre-requisite CLI tools
2.  Locally build, test and deploy the application containers on the Linux VM.
2.  Deploy an AKS (Azure Kubernetes Service) Kubernetes cluster and manually deploy the containerized microservice application on AKS.
5.  Configure an [Azure API Management Service](https://docs.microsoft.com/en-us/azure/api-management/) to manage the lifecycle of API's exposed by **po-service** Springboot Microservice.

### Prerequisites:
1.  Active **Microsoft Azure Subscription**.  You can obtain a free Azure subscription by accessing the [Microsoft Azure](https://azure.microsoft.com/en-us/?v=18.12) website.  In order to execute all the labs in this project, either your *Azure subscription* or the *Resource Group* **must** have **Owner** Role assigned to it.
2.  **GitHub** Account to fork and clone this GitHub repository.
3.  This project assumes readers/attendees of this AKS Hackathon are well versed in Linux OS and Kubernetes.  Attendees are required to have hands-on experience working with most (if not all) of the following - Linux OS, docker engine, Container Platforms (`eg., Kubernetes`), DevOps tooling (conceptual understanding) and developing/deploying Microservices in one or more programming languages.  If you are new to Linux, Containers, Kubernetes and/or would like to get familiar with container solutions available on Microsoft Azure, please go thru the [k8s-springboot-data-rest](https://github.com/ganrad/k8s-springboot-data-rest) GitHub project first and complete all hands-on labs.
4.  (Optional) Download and install [Postman App](https://www.getpostman.com/apps), a REST API Client used for testing the Web API's.

### Challenges:
Complete the following challenges (labs) in order.  Keep in mind, the challenges get progressively complex (and harder).   Complete all steps in a given challenge and verify all steps (output) before proceeding to the next challenge.

[1. Deploy a Linux CentOS VM on Azure (~ Bastion Host ~ Jump-Box)](https://github.com/ganrad/aks-hackathon/tree/master/1-Deploy-LinuxVM)

[2. Build and test the *Purchase Order* microservice container](https://github.com/ganrad/aks-hackathon/tree/master/2-Test-Microservice)

[3. Deploy ACR instance and push *Purchase order* container image into the registry](https://github.com/ganrad/aks-hackathon/tree/master/3-Deploy-ACR)

[4. Deploy and configure an AKS cluster](https://github.com/ganrad/aks-hackathon/tree/master/4-Deploy-Conf-AKS)

[5. Configure and deploy the *Purchase order* microservice on AKS](https://github.com/ganrad/aks-hackathon/tree/master/5-Conf-Deploy-PO-App)
