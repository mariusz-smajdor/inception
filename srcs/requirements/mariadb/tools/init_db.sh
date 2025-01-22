#!/bin/bash

# Start MySQL service
service mysql start

# Run SQL commands to create database and user
mysql -e "CREATE DATABASE IF NOT EXISTS ${WP_NAME};"
mysql -e "CREATE USER IF NOT EXISTS '${WP_ADMIN_LOGIN}'@'%' IDENTIFIED BY '${WP_ADMIN_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${WP_NAME}.* TO '${WP_ADMIN_LOGIN}'@'%';"
mysql -uroot -proot12345 -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root12345';"
mysql -e "FLUSH PRIVILEGES;"

# Shut down MySQL service cleanly
mysql -uroot -proot12345 -e "SHUTDOWN;"

exec "$@"
