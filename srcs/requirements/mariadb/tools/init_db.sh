#!/bin/bash

# Start MySQL service
service mysql start

# Run SQL commands to create database and user
mysql -e "CREATE DATABASE IF NOT EXISTS ${WP_NAME};"
mysql -e "CREATE USER IF NOT EXISTS '${WP_ADMIN_LOGIN}'@'%' IDENTIFIED BY '${WP_ADMIN_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${WP_NAME}.* TO '${WP_ADMIN_LOGIN}'@'%';"
mysql -u${DB_USER} -p${DB_PASSWORD} -e "ALTER USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Shut down MySQL service cleanly
mysql -u${DB_USER} -p${DB_PASSWORD} -e "SHUTDOWN;"

mysqld