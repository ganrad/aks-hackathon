# Create namespace 'po-api-dev'
kubectl create namespace po-api-dev

# Create namespace 'po-api-db'
kubectl create namespace po-api-db

# Switch to the 'po-api-app' directory

# Deploy MySQL container in 'po-api-db' namespace
kubectl apply -f ./k8s-scripts/mysql-deploy.yaml -n po-api-db

# Make sure MySQL DB Pod is running
kubectl get pods -n po-api-db

# Deploy AAD Pod Identity components - MIC and NMI Daemon Sets
kubectl apply -f https://raw.githubusercontent.com/Azure/aad-pod-identity/master/deploy/infra/deployment.yaml

# Deploy Azure Key Vault FlexVolume Driver (Daemon Set)
kubectl create -f https://raw.githubusercontent.com/Azure/kubernetes-keyvault-flexvol/master/deployment/kv-flexvol-installer.yaml

# Create an Azure Identity
az identity create -g csu-dev-grts-rg3 -n po-api-identity -o json

# (Optional) Assign AKS SP the appropriate role (Managed Identity Provider) to work with user-assigned MSI.  This step is only needed if you have created the identity in a RG other than the AKS node RG 'MC_xyz...'
az role assignment create --role "Managed Identity Operator" --assignee <AKS SP App ID> --scope <Azure Pod MSI ID created in previous step>

az role assignment create --role "Managed Identity Operator" --assignee "8e5f9843-592c-4106-bbd5-5580d48ebbea" --scope "/subscriptions/f99e3e10-4fe2-476a-bf9c-e2e1be9e7a53/resourcegroups/csu-dev-grts-rg3/providers/Microsoft.ManagedIdentity/userAssignedIdentities/po-api-identity"

# Create an Azure Key Vault and then create secrets for MySQL username and password.  Use the Azure Portal.
# Secret name: mysqluser, Value: mysql.user=mysql
# Secret name: mysqlpassword, Value: mysql.password=password

# Assign Azure Identity the necessary role permissions (Reader) to access the Key Vault
az role assignment create --role Reader --assignee <PrincipalID of Managed Identity> --scope <ResourceID of Key Vault>

az role assignment create --role Reader --assignee "a502514f-1131-4787-996c-3a4a37c30262" --scope /subscriptions/f99e3e10-4fe2-476a-bf9c-e2e1be9e7a53/resourcegroups/csu-dev-grts-rg3/providers/Microsoft.KeyVault/vaults/po-api-kv

# Set policy to access secrets from Key Vault
az keyvault set-policy -n <KV name> --secret-permissions get --spn <Azure Identity Client ID>

az keyvault set-policy -n po-api-kv --secret-permissions get --spn "d7a0dfa8-49ca-430e-8329-4cdfba1bf9ce"

# Update file './k8s-scripts/aadpodidentity.yaml' with the correct values as specified below
# ResourceID: ID of the managed identity
# ClientID: Client ID of the managed identity

# Install Azure Pod Identity object in 'po-api-dev' namespace on AKS
kubectl apply -f ./k8s-scripts/aadpodidentity.yaml -n po-api-dev

# Check to see if the Azure Pod Identity object got created
kubectl get azureidentity -n po-api-dev

# Install Azure Pod Identity Binding object in 'po-api-dev' namespace on AKS
kubectl apply -f ./k8s-scripts/aadpodidentitybinding.yaml -n po-api-dev

# Check to see if the Azure Pod Idenity Binding object got created
kubectl get azureidentitybinding -n po-api-dev

# Update Helm chart template files

# Review and update values for the following parameters in './po-api-helm-deploy/values.yaml' file
# - ACR name
# - MySQL Service name
# - MySQL Port
# - Azure Key Vault name
# - Azure Subscription ID
# - Azure AD Tenant ID
# - Azure Key Vault Resource Group

# Deploy the 'Purchase Order' API microservice in 'po-api-dev' namespace
helm install ./po-api-helm-deploy/ --namespace po-api-dev

# Test the 'Purchase Order' API microservice
kubectl port-forward pod/wrinkled-eel-nginx-ingress-controller-58f6d4f58c-29r5z -n ingress-alb-std 8080:80
curl http://localhost:8080/po/api/v1/orders

# Optional: Delete the Purchase Order API application
helm list
helm delete <name of application> --purge
