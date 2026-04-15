FROM wordpress:latest

# Instalar extensões PHP extras
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    unzip

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Copiar plugins
# COPY ./plugins /var/www/html/wp-content/plugins

# Permissões
RUN chown -R www-data:www-data /var/www/html