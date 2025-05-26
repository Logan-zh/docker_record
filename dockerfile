FROM php:7.3-apache

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    curl \
    gnupg2 \
    unixodbc-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libkrb5-dev

# 加入 Microsoft repo（Debian 11）
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
 && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17

RUN pecl install sqlsrv-5.9.0 pdo_sqlsrv-5.9.0 \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv

RUN a2enmod rewrite
    
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf