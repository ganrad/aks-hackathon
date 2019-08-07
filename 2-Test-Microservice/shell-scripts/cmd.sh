# Pull and run the mysql container
docker run --name mysql101 --rm -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=sampledb -e MYSQL_USER=mysql -e MYSQL_PASSWORD=password mysql/mysql-server:latest

# Find out docker bridge ip address for mysql container 'mysql101'
docker inspect mysql101

# (Optional/Skip) Login to the mysql instance within the container
docker exec -it mysql101 mysql -u mysql -p

# (Optional/Skip) MySQL 8.x
CREATE USER 'mysql'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'mysql'@'localhost';

# (Optional/Skip) Logout and login as user 'mysql'
docker exec -it mysql101 mysql -u mysql -p

# (Optional/Skip) Create a database called 'sampledb'
CREATE DATABASE sampledb;

# Clone the 'aks-hackathon' GitHub project to the Linux VM (local instance)
git clone https://github.com/ganrad/aks-hackathon.git
 
# Update values for the following properties in SpringBoot 'application.properties' file - mysql server hostname (docker bridge IP) , mysql port, db name, user name & user password

# Switch to project directory and run Maven (application) build
mvn package

# Run docker (container) build
docker build -t po-service -f ./src/Dockerfile .

# Run the application (po-service) container
docker run --name potest --rm -p 8080:8080 po-service:latest

# Test the po-service API end-points
# eg., http://localhost:8080/orders
# eg., http://localhost:8080/orders/1
