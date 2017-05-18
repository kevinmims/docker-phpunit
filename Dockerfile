FROM php:5.6-cli

RUN apt-get update \ 
 && apt-get install -y git zlib1g-dev \
 && docker-php-ext-install zip \
 && curl -sS https://getcomposer.org/installer \ | php -- --install-dir=/usr/local/bin --filename=composer \
 && composer global require phpunit/phpunit \
 && composer global require phpunit/dbunit \
 && composer global require phing/phing \
 && composer global require sebastian/phpcpd \
 && composer global require phploc/phploc \
 && composer global require phpmd/phpmd \
 && composer global require squizlabs/php_codesniffer 
 
ENV PATH="/root/.composer/vendor/bin:${PATH}"