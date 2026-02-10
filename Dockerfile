# Usamos una versión estable de PHP con Apache
FROM php:8.2-apache

# 1. Instalar dependencias del sistema necesarias para PostgreSQL (libpq-dev)
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql pgsql

# 2. SOLUCIÓN AL ERROR MPM (CRÍTICO):
# Desactivamos mpm_event y forzamos mpm_prefork para evitar el conflicto "More than one MPM loaded"
RUN a2dismod mpm_event && a2enmod mpm_prefork

# 3. Habilitar mod_rewrite (opcional pero recomendado para PHP)
RUN a2enmod rewrite

# 4. Copiar los archivos de tu proyecto al directorio público de Apache
COPY . /var/www/html/

# 5. Asegurar que Apache tenga permisos sobre los archivos
RUN chown -R www-data:www-data /var/www/html

# 6. Exponer el puerto 80 (Railway mapeará esto automáticamente)
EXPOSE 80