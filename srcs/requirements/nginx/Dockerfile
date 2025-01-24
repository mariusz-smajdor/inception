FROM debian:buster

# Install NGINX and OpenSSL
RUN apt-get update && apt-get install -y nginx openssl

# Expose port 443 for HTTPS
EXPOSE 443

# Copy the NGINX configuration and SSL setup script
COPY ./conf/default /etc/nginx/sites-enabled/default
COPY ./tools/nginx_start.sh /var/www

# Make the startup script executable
RUN chmod +x /var/www/nginx_start.sh

# Set the startup script as the default command
CMD ["/var/www/nginx_start.sh"]
