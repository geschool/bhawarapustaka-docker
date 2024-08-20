## RDM Docker 

Docker container running Bhawara Pustaka 

## Prerequistes

* MySQL (mysql_old_password MUST be enabled for MySQL 8+)


## Enviroment Variables

Configuration is done via the following Environment Variables. 

``DB_HOST`` : MySQL server address 

``DB_PORT`` : MySQL server port

``DB_USERNAME``: MySQL username

``DB_PASSWORD``: MySQL password

``DB_DATABASE``: MySQL Database Name

## How to use

``` docker run --name bwp --rm -p 8000:80 -e DB_HOST="host:docker:internal" DB_PORT=3306 -e DB_USERNAME=root -e DB_PASSWORD=pwd -e DB_DATABASE=bwp  geschool/bhawarapustaka ```

Open Browser to http://localhost:8000 to view

**Note:**

Remove `/var/www/html/config/sysconfig.local.inc.php` if database is not yet created 

``docker exec -t bwp rm /var/www/html/config/sysconfig.local.inc.php``



### Sample docker-compose
```version: '3.1'

services:

  rdm:
    image: geschool/bhawarapustaka
    restart: always
    environment:
      DB_HOST: host:docker:internal
      DB_PORT: 3306
      DB_USERNAME: root 
      DB_PASSWORD: pwd 
      DB_DATABASE: rdm  
```      
      
   
### Sample k8s yaml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  labels:
    tier: web
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web
      tier: web
  template:
    metadata:
      labels:
        app: web
        tier: web
    spec:
      containers:
      - name: rdm
        image: geschool/rdm
        env:
        - name: DB_SERVER
          value: "host:docker:internal"
        - name: DB_HOST
          value: 3306
        - name: DB_USER
          value: "user"
        - name: DB_PWD
          value: "pwd"
        - name: DB_DATABASE
          value: "bwp"
        resources:
          requests:
            cpu: "10m"

```
