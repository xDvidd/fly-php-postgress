FROM php:8.2-apache

# 1. Instalar dependencias y limpiar
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. SOLUCIÓN MPM (Evita el crash inicial)
RUN rm -f /etc/apache2/mods-enabled/mpm_event.load \
    && rm -f /etc/apache2/mods-enabled/mpm_event.conf \
    && rm -f /etc/apache2/mods-enabled/mpm_worker.load \
    && rm -f /etc/apache2/mods-enabled/mpm_worker.conf \
    && a2enmod mpm_prefork rewrite

# 3. CONFIGURACIÓN DE RUTAS (Aquí está la magia para el 404)
# Definimos que la raíz de la web sea la carpeta /public
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Modificamos la configuración de Apache para usar esa ruta
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# 4. Copiar TODO el código
COPY . /var/www/html/

# 5. Dar permisos (Crucial para que Apache pueda leer los archivos)
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80