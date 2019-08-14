#  Purchase Order API Microservice
This project is a container for the *Purchase Order* API microservice.  The application exposes RESTAPI's for retrieving and storing purchase orders for a fictitious Coffee Company.

### Description:

This application expects the following configuration parameters to be supplied at runtime.

### Configuration Parameters
| Name | Description | Type | Location (Mount point in the container) |
|------|-------------|------|----------|
| MYSQL_SVC_NAMESPACE| Parameter used by the application to discover the hostname of the MySQL database server (backend). Should point to the Kubernetes MySQL service name. | Environment Variable | None |
| MYSQL_SERVICE_PORT | Parameter used by the application to discover the listening port of the MySQL database server (backend). Defaults to 3306. | Environment Variable | None |
| mysql.dbname | Parameter used by the application to connect to a MySQL database.  Should specify the database name. | K8S ConfigMap | `/etc/config/mysqldb.properties` |
| mysql.user | Specifies the MySQL database user name | Azure Key Vault Secret | `/etc/vol-secrets/username.properties` |
| mysql.password | Specifies the MySQL database user password | Azure Key Vault Secret | `/etc/vol-secrets/password.properties` |
