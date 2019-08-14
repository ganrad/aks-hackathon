# Login to Az CLI using your credentials
az login

# Configure your subscription where you want to deploy Az resources
az account set --subscription "Sub name"

# Verify you are using the correct subscription
az account show -o table

# Create a basic ACR.  Append your initials as suffix to the ACR name.
# NOTE: Take note of the ACR ID and LoginServer name
az acr create --resource-group csu-dev-grts-rg6 --name akshackacrGR --sku Basic

# Login to ACR.  Remember to substitute the name of the ACR which you created in previous step.
az acr login --name akshackacrGR

# Get the ACR login server fqdn
az acr show --name akshackacrGR --query "{acrLoginServer:loginServer}" --output table

# Tag the "Purchase Order" API container image
docker tag po-service akshackacrgr.azurecr.io/po-service:v1

# List the images
docker images

# Push the "Purchase Order" API container image to ACR instance
docker push akshackacrgr.azurecr.io/po-service:v1

# Remove the "po-service:v1" from your local docker environment (save space ~ 612MB !)
docker rmi akshackacrgr.azurecr.io/po-service:v1

# Optional - Useful commands
# --------------------------

# List repositories in ACR instance
az acr repository list --name akshackacrgr -o table

# List tags in a given repository
az acr repository show-tags --name akshackacrgr --repository po-service -o table
