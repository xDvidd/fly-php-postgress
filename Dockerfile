# Usamos la versión CLI de PHP, que es más ligera y no trae Apache
FROM php:8.2-cli

# 1. Instalar dependencias para PostgreSQL
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Copiar todo el proyecto al contenedor
WORKDIR /app
COPY . .

# 3. Informar a Railway qué puerto usar (por defecto 8080 si no hay variable)
ENV PORT=8080
EXPOSE ${PORT}

# 4. Comando de inicio: 
# Usamos el servidor integrado de PHP apuntando a la carpeta /public
# Si tu index.php está en la raíz, quita "/public" del final del comando
CMD php -S 0.0.0.0:${PORT} -t public/