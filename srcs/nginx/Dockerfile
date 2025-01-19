# Use a base image of Debian for simplicity
FROM debian:bullseye

# Install required packages: NGINX and OpenSSL
RUN apt-get update && apt-get install -y \
    nginx \
    openssl && \
    rm -rf /var/lib/apt/lists/*

# Copy the NGINX configuration file from the host to the container
COPY ./conf/nginx.conf /etc/nginx/sites-available/default

# Run NGINX in the foreground (the container will run as long as NGINX is running)
CMD ["nginx", "-g", "daemon off;"]