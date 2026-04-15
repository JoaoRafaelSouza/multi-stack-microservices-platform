FROM php:8.2-apache

# ===============================
# DEPENDÊNCIAS BÁSICAS
# ===============================
RUN apt-get update && apt-get install -y \
    git unzip curl gnupg ca-certificates apt-transport-https \
    libzip-dev libonig-dev libxml2-dev libpng-dev libjpeg-dev \
    unixodbc-dev \
    build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ===============================
# PHP EXTENSIONS
# ===============================
RUN docker-php-ext-install pdo pdo_mysql mysqli

# ===============================
# SQL SERVER DRIVER
# ===============================
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" \
    > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18

# ===============================
# LOCALE
# ===============================
RUN apt-get update && apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# ===============================
# DEPENDÊNCIAS DE BUILD
# ===============================
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    autoconf \
    libc-dev \
    pkg-config

# ===============================
# SQLSRV
# ===============================
RUN pecl install sqlsrv-5.12.0 pdo_sqlsrv-5.12.0 \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv

# ===============================
# MONGODB DRIVER
# ===============================
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

# ===============================
# COMPOSER
# ===============================
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# ===============================
# NODE
# ===============================
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# ===============================
# PROJETO
# ===============================
WORKDIR /var/www/html
COPY . .

# ===============================
# BUILD FRONTEND (VUE)
# ===============================
WORKDIR /var/www/html/vue
RUN npm install --legacy-peer-deps && npm run build

WORKDIR /var/www/html

# ===============================
# PERMISSÕES
# ===============================
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80