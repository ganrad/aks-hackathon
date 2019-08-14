#  Deploy ACR instance and push *Purchase Order* container image into the registry
**Approx. time to complete this section: 10 minutes**

### Description:
In this challenge, you will deploy an Azure Container Registry (ACR) instance. Following that, you will push the *Purchase Order* API microservice container image which you built and tested in the previous challange into the ACR. 

### Prerequisites:

1. You should be logged in to the Linux VM (Bastion Host) via SSH

### Steps:

1. Login to Azure via CLI with your credentials.  You installed Azure CLI on the Linux VM in **Challenge 1**.  Make sure you set the Azure CLI context to point to the correct subscription (as needed).

2. Create an ACR instance (Basic SKU).  Refer to the [ACR documentation](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-azure-cli)

3. Login to the ACR instance.

4. Tag the *Purchase Order* container image (eg., `po-service:v1`).

5. Push the tagged container image into ACR.

You have now completed this challenge.  Return to the parent project and proceed with the next challenge. 
