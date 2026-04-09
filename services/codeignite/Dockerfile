FROM php:8.2-apache

# Instalar dependências
RUN apt-get update && apt-get install -y \
    git unzip curl libzip-dev libonig-dev \
    libxml2-dev libpng-dev libjpeg-dev \
    gnupg

# PHP Extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli

# SQL Server Driver
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/12/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev \
    && pecl install sqlsrv pdo_sqlsrv \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv

# MongoDB Driver
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Node (para Vue)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Copiar projeto
WORKDIR /var/www/html
COPY . .

# Instalar Vue
WORKDIR /var/www/html/vue
RUN npm install && npm run build

WORKDIR /var/www/html

# Permissões
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80