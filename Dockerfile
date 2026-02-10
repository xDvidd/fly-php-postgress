FROM php:8.2-cli

# Instalar drivers de Postgres
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql pgsql

WORKDIR /app
COPY . .

# Obligamos a que el puerto sea el que Railway quiera
EXPOSE 8080

# Comando que no depende de carpetas externas
CMD ["php", "-S", "0.0.0.0:8080"]