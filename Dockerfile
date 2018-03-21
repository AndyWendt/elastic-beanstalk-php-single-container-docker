FROM php:7.1-apache-jessie
MAINTAINER Andy Wendt <andy@awendt.com>

COPY . /var/www/html

ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

#RUN mkdir /common  \
#    && mkdir /common/web \
#    && chmod 777 /common/web

RUN apt-get update \
    && apt-get install -y libxml2-dev
#    && apt-get install -y libapache2-modsecurity \
#    && a2enmod rewrite \
#    && a2enmod headers

RUN docker-php-ext-install mysqli pdo_mysql soap

WORKDIR /var/www/html

EXPOSE 80 443
