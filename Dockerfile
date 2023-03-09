FROM php:7.4-apache-bullseye
MAINTAINER María Jesús Alloza Rodríguez "mariajesus.allozarodriguez@gmail.com"
RUN apt-get update && apt-get upgrade -y && docker-php-ext-install mysqli pdo pdo_mysql && apt-get install mariadb-client -y && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY src /var/www/html
COPY script.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/script.sh
ENV DB_HOST=localhost
ENV DB_NAME=crudphp
ENV DB_USER=crudphp
ENV DB_PASSWORD=crudphp
ENTRYPOINT ["/usr/local/bin/script.sh"]
