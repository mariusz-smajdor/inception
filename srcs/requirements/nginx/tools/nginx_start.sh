#!/bin/bash

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
    echo "Nginx: setting up SSL...";

    # Generate a self-signed SSL certificate
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
        -keyout /etc/ssl/private/nginx.key \
        -out /etc/ssl/certs/nginx.crt \
        -subj "/C=PL/ST=Mazowieckie/L=Warsaw/O=42Warsaw/CN=msmajdor.42.fr";
    
    echo "Nginx: SSL is set up!";
fi

# Start NGINX in the foreground to prevent the container from exiting.
nginx -g "daemon off;"
