FROM debian:buster

# Install necessary packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    php-fpm \
    php-mysql \
    php-zip \
    php-redis \
    curl \
    vim \
    default-mysql-client \
    sendmail && \
    sed -i -e 's/listen =.*/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf && \
    mkdir -p /run/php && \
    apt-get clean

# Set working directory
WORKDIR /var/www/html

# Download WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy the WordPress setup script
COPY ./tools/wordpress_start.sh .

# Make the script executable
RUN chmod +x wordpress_start.sh

# Entry point for the container
ENTRYPOINT ["bash", "wordpress_start.sh"]
