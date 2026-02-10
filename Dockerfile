FROM php:8.2-cli

# 1. Instalar drivers de Postgres
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql pgsql

# 2. Directorio de trabajo
WORKDIR /app

# 3. Copiamos todos los archivos del repo al contenedor
COPY . .

# 4. Exponemos el puerto 8080
EXPOSE 8080

# 5. COMANDO CLAVE:
# Le decimos a PHP que su "Document Root" es la carpeta src/
CMD ["php", "-S", "0.0.0.0:8080", "-t", "src/"]