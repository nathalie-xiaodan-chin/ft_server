**Launch ft_server :**
```
service nginx stop
sudo docker build -t myimage .
sudo docker run -d -p 80:80 -p 443:443 --name=mycontainer myimage
```

**Stop ft_server (the hard way):**
```
sudo docker stop mycontainer
sudo docker rm mycontainer
sudo docker rmi myimage
```

**"You will also need to make sure your server is running with an autoindex that must be able to be disabled"**
```
docker exec -ti mycontainer bash
bash disable_autoindex.sh
```
**"You will have to make sure that, depending on the url, your server redirects to the
correct website."**
```
localhost
localhost/wordpress
localhost/phpMyAdmin
```
**" You will need to make
sure your SQL database works with the WordPress and phpMyAdmin."**
- Go to `localhost/wordpress`
- Fill information (don't forget your username and password)
- Go to `Posts` on the left column, then add a new post
- Go to `localhost/phpMyAdmin/` (user is nath and password is toto)
- Go to `nath_db` on the left column, and click on `wp_posts`. *The new post is in the database hooray!*

---
# **I. Prerequisite for ft_server**

## **A. To know what Docker is**
Docker allows you to launch applications in **containers**.

*[Open a parenthesis]*
*What the hell is a containers ?*
Historically, in order to run websites, you need physical servers.
However, to have physical servers was annoying when you needed extra power for periods of high load (eg. New Years Eve).
Hence, virtual machines (VM) were invented. 
VM are heavy virtualization. Indeed, it's recreating an entire system in the host system.
It allows a good solution from the host system but it's also allocating quite a lot of resources (CPU/RAM) from the host system.
This is why containers were invented. Containers are light virtualization. In a container, there is all the necessary executables, binary code, libraries, and configuration files. **It is different from the VM because it does not contain an operating system**. This is why a container is very portable and lightweight compared to the VM.
*[Closed the parenthesis]*

Docker is a platform to allows you to run your code inside a container.
With Docker, you can run your code and deploy your project on every computer and on every environment !
Docker is composed of two elements :
- the daemon runs in the background and takes care of managing your containers
- the client will allow you to interact with the daemon via a command line tool


**Ressources :**

[https://putaindecode.io/articles/introduction-a-docker/](https://putaindecode.io/articles/introduction-a-docker/) **(FR)**

[https://openclassrooms.com/fr/courses/2035766-optimisez-votre-deploiement-en-creant-des-conteneurs-avec-docker/6211306-decouvrez-les-conteneurs](https://openclassrooms.com/fr/courses/2035766-optimisez-votre-deploiement-en-creant-des-conteneurs-avec-docker/6211306-decouvrez-les-conteneurs) **(FR)**

## **B. To know what Debian Buster is**
Debian is part of the Linux distribution family. It is developed by the Debian Project which a community and a democratic organization dedicated to the development of operating systems based exclusively on free software.

The first version of Debian was released in 1993 and it is one of the oldest operating systems based on the Linux Kernel.

The latest released is from July 2019 and is called Debian Buster. Fun fact, the name of the versions are based on Toy Story characters.

## **C. To know what Wordpress is**
It's a content management system (CMS), i.e. a software that will help you to create, manage and modify content on a website without too much technical knowledge.

Wordpress is a free and open-source CMS and it's written in PHP and come with a MySQL or MariaDB database.

## **D. To know what Phpmyadmin is**
PHPMyAdmin is a web interface and is used in order to manipulate MySQL and MariaDB. It's free and open source.

**[Open a parenthesis]**
*What the hell is MySQL and MariaDB ?*

Ok, so first we need to know what is a DBMS ou Database Management System.

It is a software for storing and manipulating users' data while considering security measures. DBMS is divided into two big families :
- RDBMS : a **Relationnal** Database Management System. Example : MySQL, Maria DB, PostgreSQL, SQLite etc.

    ⇒ RDBMS use SQL
- NoSQL : a **non-SQL** Database Management System : MongoDB, Redis, Cassandra, CouchDB etc.

    ⇒ NoSQL doesn't use SQL (*duh*)

*Also, what the hell is SQL ?*
It's a "Structured Query Language". It's a language used to communicate with a database.
**[Closed the parenthesis]**

# **II. How I did ft_server**

According to the subject, *"you will discover the "docker" technology and use it to install a complete web server. This server will run multiples services: Wordpress, phpMyAdmin, and a SQL database."*

So here, we have to install :
- **Docker to deploy and run our needded applications** ;
- **Nginx to serve our content** ;
- **MySQL to store and manage our data** ;
- **phpMyAdmin to handle the administration of MySQL over the web** ;
- **Wordpress to publish and manage our content** with a beautiful interface;

So let the fun begin.

According to the subject :
<i>
- You must set up a web server with Nginx, in only one docker container. The
container OS must be debian buster.
- Your web server must be able to run several services at the same time. The services will be a WordPress website, phpMyAdmin and MySQL. You will need to make
sure your SQL database works with the WordPress and phpMyAdmin.
</i>

### 1. Using Docker

We are going to use a dockerfile. The dockerfile is a text file that will contains all the commands we could like to call on the command line to assemble an image.

The dockerfile will build an image. And then, the image will run a container.

Useful docker commands :
- Build a container (test_container) and run an image (test_image) from this container :

`docker build -t testimage .`

`docker run -d -p 80:80 --name=test_container testimage`

- Stopping a running container (test_container) and erasing this container and its image (test_image)*

`docker stop testcontainer`

`docker rm testcontainer`

`docker rmi testimage`
- List containers
`docker ps`
- List images
`docker images`
- Run a command in a running container
`docker exec` (e.g. docker exec -ti test_container ls)

### 2. Installing LEMP

a. Follow this nice tutorial : https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mariadb-php-lemp-stack-on-debian-10#step-3-—-installing-php-for-processing/

b. And adapt the tutorial to ft_server :

So in the dockerfile, we're going to :
- install nginx, the web server (`apt-get -y install nginx`)
Test to do : http://localhost should welcome you with Nginx’s default landing page.
- install MariaDB,the database system to be able to store and manage data for our website (`apt-get -y install mariadb-server`)
Test to do : logging in to the MariaDB console (cf. tutorial)
- install PHP components to process code :
	- php-fpm : Nginx need a program to handle PHP processing. It's like a bridge between the PHP interpreter itself and the web server.
	- php-mysql : a PHP module that allows PHP to communicate with MySQL-based databases.

Then we need to do some configuration on Nginx :

Nginx has one server block enabled by default (/var/www/html) but we are not going to use it. Since we are cleaned and organized (*lol*), we are going to create our own directory (/var/www/localhost).
Now, we need to tell Nginx to use our new directory.
Hence, we need to modify Nginx’s `sites-available` directory.

(Note : `sites-available` folder stores ALL the configuration whether or not they're currently enabled.
`site-enables` folder contains symlinks to files in the sites-available folder that are served by Nginx).

So, we are going to :
- create our own configuration file (`own_config` in my project) and put inside the name of our domain (`localhost`), and;
- copy/paste into our docker container (using `COPY` in our dockerfile), and then ;
- once it's in our container, copy/paste into the right folder (`cp own_config /etc/nginx/sites-available/localhost` in start.sh)
- activate this configuration by linking to the config file from Nginx’s sites-enabled directory (`ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/` in start.sh)

### 3. Dealing with Wordpress

I'm tired of writing, please follow this very good tutorial : https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-nginx-mariadb-and-php-on-debian-10

### 4. Dealing with phpMyAdmin

I'm tired of writing, please follow this very good tutorial : https://www.itzgeek.com/how-tos/linux/debian/how-to-install-phpmyadmin-with-nginx-on-debian-10.html

### 5. Dealing with SSL protocol

According to the subject, "*Your server should be able to use the SSL protocol*".

https://letsencrypt.org/fr/docs/certificates-for-localhost/
https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-debian-10

### 6. Dealing with autoindex

According to the subject, "*You will also need to make sure your server is running with an autoindex that must be able to be disabled*".

So, with an autoindex on, your `localhost` will list your folders and files.

In order to do that, modify your configuration file (mine is `own_config`) and add a `autoindex on;` in your location block :

```
location / {
    try_files $uri $uri/ =404;
    autoindex on;
}
```

So now, the autoindex is on. In order to turn it off while the container is still running, I've created :
- a new configuration file called `config_autoindex_off`, and ;
- a shell script called `disable_autoindex.sh` that I'll run when I want to disable the autoindex (*duh again*).

In `config_autoindex_off`, I'm going to :
- change the root directive. I'll have `root /var/www/home_without_autoindex;` (instead of `root /var/www/localhost;`). Hush, do not worry my dear friend, my url `localhost` will not change. The root directive sets the base path for the requests only. So, once Nginx catch the request, it will just send it to `root /var/www/home_without_autoindex;` now and my url `localhost` will still be the same.
- set the autoindex to off in my location block (`autoindex off;`).

In `disable_autoindex.sh`, I'm going to :
- remove my actual nginx configuration from `sites-enabled ` (`cd  /etc/nginx/sites-enabled && rm -rf localhost`) ;
- copy into `/var/www/home_without_autoindex` (remember, the new root directive)the things I need for Wordpress and phpMyAdmin ;
- linking my new configuration files in Nginx’s sites-enabled directory (`ln -s /etc/nginx/sites-available/localhost_autoindex_off /etc/nginx/sites-enabled/localhost`) ;
- reload the server (`service nginx reload`).

# **III. Run ft_server in 42 VM**

- Free your 80 port on the VM : `service nginx stop`
- Check if everything is ok with docker : `sudo docker run hello-world`
- If this bastard `localhost` welcome you with Nginx’s default landing page and NOT your index : delete the file `index.nginx-debian.html` (in my project `rm -rf var/www/html/index.nginx-debian.html` in start.sh)

# **IV. Brace yourself for the correction**

Your *caring, kind, gracious, understanding, considerate, benevolent* peer will probably try the following :
- launch your file and check that everything is working ;
- go to your localhost/wordpress and check that you don't have any error messages
 and that your database is properly taken into account ;
- do the same on phpmyadmin ;
- modify your wordpress page and see if the changes are taken into account on phpmyadmin ;
- look carefully at the bottom of phpmyadmin that you have no error message ;
- try to deactivate and reactivate the index of your localhost.
- check that you can connect in http and https and that you have a certificate.



