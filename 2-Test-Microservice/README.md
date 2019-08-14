#  Build and test the *Purchase Order* microservice container
**Approx. time to complete this section: 30 minutes**

### Description:
In this challenge, you will deploy a MySQL v8.0.x database server in a container on the Linux VM (CentOS). Next, you will build the *Purchase Order* microservice using *Maven*, build a docker container image and then run an instance of this container image on the local host (Bastion Host).  Finally, you will test the Purchase Order microservice's REST API end-points and verify you are able to successfully retreive (and post) purchase orders from/to the MySQL database server (backend).

### Prerequisites:

1. You should be logged in to the Linux VM (Bastion Host) via SSH

### Steps:

1. Download the latest version of *MySQL* database container from [docker hub](https://hub.docker.com/_/mysql) and deploy an instance of this container.

2. Login to the MySQL container as `root` and create a sample database eg., sampledb.  Also, create an application (test) specific MySQL user (eg., mysql) and grant this user full privileges on the sample database.  Note down the name of the MySQL database, user name and password.

3. Clone this GitHub repository to the Linux VM.

4. Copy `src/main/resources/application.properties` file to parent directory with a different name (eg., Save it as file `application.properties.bkup`)

5. Update SpringBoot configuration file `src/main/resources/application.properties` and specify correct values for MySQL host, port, database name, application user name and password.

6. Build the *Purchase Order* microservice application using *Maven*.

7. Execute a docker *Build* using the provided `Dockerfile`.

8. Run the Purchase Order microservice container built in Step [6].

9. Test the microservice API end-points.  Refer to the table below.

   URI Template | HTTP VERB | DESCRIPTION
   ------------ | --------- | -----------
   orders/ | GET | To list all available purchase orders in the backend database.
   orders/{id} | GET | To get order details by `order id`.
   orders/search/getByItem?{item=value} | GET | To search for a specific order by item name
   orders/ | POST | To create a new purchase order.  The API consumes and produces orders in `JSON` format.
   orders/{id} | PUT | To update a new purchase order. The API consumes and produces orders in `JSON` format.
   orders/{id} | DELETE | To delete a purchase order. 

10. Move the original `application.properties` file (saved in Step 4 above) to `src/main/resources/application.properties`.

11. Build the application and the container image (repeat Steps 6 and 7).

You have now completed this challenge.  Return to the parent project and proceed with the next challenge. 
