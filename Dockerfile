FROM php:8.2-cli

# Instalar drivers de Postgres
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql pgsql

# Establecemos el directorio de trabajo
WORKDIR /app

# Copiamos todo el contenido del repo a /app
COPY . .

# Railway usa el puerto 8080 por defecto en muchos casos
ENV PORT 8080
EXPOSE 8080

# COMANDO DE ARRANQUE:
# Este comando le dice a PHP: "Sirve lo que haya en la raíz de la carpeta /app"
CMD ["php", "-S", "0.0.0.0:8080", "-t", "."]