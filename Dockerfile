FROM php:7.3-apache

LABEL maintainer="henry.stivens@gmail.com"

RUN apt-get update && apt-get install -y \
        mysql-client \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libaio1 \
        libmcrypt-dev \
        libxml2-dev \
        zlib1g-dev \
    && docker-php-ext-install -j$(nproc) iconv gettext mbstring \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \            
            opcache \
            mysqli pdo pdo_mysql    

#install zip extension
RUN apt-get install -y \
        libzip-dev \
        zip \        
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip                                     

RUN a2enmod rewrite \
 && sed -i 's!/var/www/html!/var/www/default/public!g' /etc/apache2/apache2.conf \
 && sed -i 's!/var/www/html!/var/www/default/public!g' /etc/apache2/sites-available/000-default.conf

 # Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/local/bin \
        --filename=composer

WORKDIR /var/www