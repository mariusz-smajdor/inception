#!/bin/bash

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to start..."
while ! mysqladmin ping -h"$DB_HOST" --silent; do
    sleep 1
done

# Check if wp-config.php already exists
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Setting up WordPress..."

    # Download WordPress core files
    wp core download --allow-root

    # Generate wp-config.php using environment variables
    wp config create \
        --dbname=$WP_NAME \
        --dbuser=$WP_ADMIN_LOGIN \
        --dbpass=$WP_ADMIN_PASSWORD \
        --dbhost=$DB_HOST \
        --allow-root

    # Install WordPress
    wp core install \
        --url=$WP_URL \
        --title="My WordPress Site" \
        --admin_user=$WP_ADMIN_LOGIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    # Create a secondary WordPress user
    wp user create \
        $WP_USER_LOGIN \
        $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASSWORD \
        --allow-root

    # Adjust file permissions
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html

    echo "WordPress setup complete!"
else
    echo "WordPress is already set up."
fi

# Start PHP-FPM in the foreground
php-fpm7.3 -F
