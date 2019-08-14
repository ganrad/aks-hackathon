#  Purchase Order API Microservice
This directory hosts the *Purchase Order* API microservice for a fictitious Coffee Company.  The application exposes REST API's for retrieving and storing purchase orders in a MySQL database.

### Description:

This application expects the following configuration parameters to be supplied at runtime.

### Configuration Parameters
| Name | Description | Type | Location (Mount point in the container) |
|------|-------------|------|----------|
| MYSQL_SVC_NAMESPACE| Parameter used by the application to discover the hostname of the MySQL database server (backend). Points to the Kubernetes MySQL service name within a given K8S namespace.  For instance, a value of `mysql.development` denotes, the `mysql` service is deployed within `development` namespace. | Environment Variable | None |
| MYSQL_SERVICE_PORT | Parameter used by the application to discover the listening port of the MySQL database server (backend). | Environment Variable | None |
| mysql.dbname | Parameter used by the application to connect to a MySQL database.  Specifies the database name. | K8S ConfigMap | `/etc/config/mysqldb.properties` |
| mysql.user | Specifies the MySQL database user name | Azure Key Vault Secret | `/etc/vol-secrets/username.properties` |
| mysql.password | Specifies the MySQL database user password | Azure Key Vault Secret | `/etc/vol-secrets/password.properties` |
