# Base image with PHP 8.2 CLI
FROM php:8.2-cli

# Set working directory inside container
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    sqlite3 \
    libsqlite3-dev \
    && docker-php-ext-install pdo_sqlite \
    && rm -rf /var/lib/apt/lists/*

# Copy composer from official image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy project files into container
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Copy .env.example to .env if .env does not exist
RUN if [ ! -f .env ]; then cp .env.example .env; fi

# Generate Laravel key
RUN php artisan key:generate

# Ensure SQLite database file exists
RUN touch database/database.sqlite

# Run migrations and seeders
RUN php artisan migrate --seed --force

# Expose port 8000
EXPOSE 8000

# Start Laravel development server
CMD php artisan serve --host=0.0.0.0 --port=8000
