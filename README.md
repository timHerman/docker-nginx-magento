#docker-nginx-magento
Docker NGINX + Magento continer
 
## About

This container is optimized for running Magento using NGINX

This container requires a seperate dedicated mysql container (timherman/mysql) to run.
You can find timherman/mysql either at docker (https://registry.hub.docker.com/u/timherman/mysql/) or github (https://github.com/timHerman/docker-mysql)

## Usage by example

### The mysql container

#### Running the container

```shell
docker run -d --name="be.punk.www.mysql" -e "MYSQL_LOCAL_USER=[username]" -e "MYSQL_LOCAL_DATABASE=[database]" -e "MYSQL_LOCAL_PASSWORD=[password]" -v /location/of/mysqldata/at/host/:/var/lib/mysql/  timherman/mysql
```

#### How it works

* -d : Run daemonized
* --Name : The name of the container
* -e : Environmental parameters
  * MYSQL_ROOT_PASSWORD : When no root password of the database is set there will be one generated for you
  * MYSQL_LOCAL_USER : The mysql username for your application
  * MYSQL_LOCAL_DATABASE : The mysql database name for your application
  * MYSQL_LOCAL_PASSWORD : The mysql database password
* -v : Linking a directory on your host with the mysql data of the container
* timherman/mysql : The name of the repository	


### The magento container

#### Running the container

```shell
docker run -d --name="be.punk.www.magento" -p 80:80 -v /location/of/magentodata/at/host/:/var/www/ --link be.punk.www.mysql:db timherman/nginx-magento
```

#### How it works

* -d : Run daemonized
* -p : Map the 80 port the container to the 80 port of the host ( Not required when using a reverse proxy )
* -e : Environmental parameters
  * MAILSERVER : External smtp server (smart host, default value mailserver)
* -v : Linking a directory on your host with the magento data of the container
* --link : linking this container be.punk.www.mysql and set it up with the hostname 'db'
* timherman/nginx-magento : The name of the repositor


## Comments

In our example the magento container is linked to the mysql container under the alias db.
This means that you'll have to edit your config file in such a way that the mysql host is no longer localhost but db.

For more information leave a message or visit http://www.punk.be

Regards,
Tim
