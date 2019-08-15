### Configure ACR authentication
# Get the ACR resouce ID
az acr show --resource-group csu-dev-grts-rg6 --name akshackacrgr --query "id" --output tsv

# Grant access to AKS SP ID to push and pull images from the ACR
az role assignment create --assignee 8e5f9843-592c-4106-bbd5-5580d48ebbea --scope /subscriptions/f99e3e10-4fe2-476a-bf9c-e2e1be9e7a53/resourceGroups/csu-dev-grts-rg6/providers/Microsoft.ContainerRegistry/registries/akshackacrGR --role acrpush
