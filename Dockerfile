FROM php:7.4-fpm

WORKDIR /app

# Arguments defined in docker-compose.yml
ARG user
ARG uid

ENV ACCEPT_EULA=Y


# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    gnupg \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip


ARG DB_NAME

ENV APP_ENV=production \
    DB_DATABASE=${DB_NAME}

COPY . .

#instalando dependencias do projeto
COPY composer.json composer.lock artisan ./
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.2.6
RUN composer install

RUN mv .env.example .env

EXPOSE 5000

CMD [ "bash", "entrypoint.sh" ]


