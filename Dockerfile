FROM php:7.4-apache



# extension
RUN apt-get update 

RUN apt-get install -y zlib1g-dev zip 
RUN  docker-php-ext-install pdo_mysql 
RUN  docker-php-ext-install mysqli 
RUN  docker-php-ext-enable mysqli 
 
RUN apt-get install -y libpng-dev libfreetype6-dev libjpeg-dev 
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg=/usr/local/lib  &&  docker-php-ext-install gd

RUN apt-get install -y libcurl4-openssl-dev libbz2-dev libsqlite3-dev

RUN docker-php-ext-install curl &&  docker-php-ext-enable curl
RUN docker-php-ext-install gettext
RUN apt-get install -y  libonig-dev
RUN docker-php-ext-install mbstring

RUN apt install -y yaz libyaz-dev
RUN pecl install yaz
RUN docker-php-ext-enable yaz
# # ioncube loader
# RUN curl -fSL 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz' -o ioncube.tar.gz \
#     && mkdir -p ioncube \
#     && tar -xf ioncube.tar.gz -C ioncube --strip-components=1 \
#     && rm ioncube.tar.gz \
#     && mv ioncube/ioncube_loader_lin_7.2.so /var/www/ioncube_loader_lin_7.2.so \
#     && rm -r ioncube
# # php.ini
# COPY conf/php.ini /usr/local/etc/php/
COPY conf/env.conf /etc/apache2/conf-enabled/environment.conf

#bwp
ADD bhawarapustaka.zip /var/www/html/

RUN cd /var/www/html/ && unzip /var/www/html/bhawarapustaka.zip 
RUN rm /var/www/html/bhawarapustaka.zip 


#slims
# ADD slims9_bulian-9.6.1.zip /tmp/ 

# RUN cd /tmp/ && unzip /tmp/slims9_bulian-9.6.1.zip
# RUN rm /tmp/slims9_bulian-9.6.1.zip
# RUN rm -rf /var/www/html && mv /tmp/slims9_bulian-9.6.1 /var/www/html 

#config
COPY conf/config.php /var/www/html/config/sysconfig.local.inc.php

RUN a2enmod rewrite
RUN a2enmod ssl

# apache user
RUN usermod -u 1000 www-data \
    && groupmod -g 1000 www-data


RUN chown -R 1000:1000 /var/www/html

