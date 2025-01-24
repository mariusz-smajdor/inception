# Base image: Debian Buster is chosen as the operating system for the container.
FROM debian:buster

# Update package lists and install the MariaDB server package.
RUN apt-get update && apt-get install -y mariadb-server

# Expose port 3306, which is the default port used by MariaDB for connections.
EXPOSE 3306

# Copy the custom MariaDB configuration file into the container's configuration directory.
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# Copy the database initialization script into the container's /tmp directory.
COPY ./tools/init_db.sh /tmp/init_db.sh

# Make the database initialization script executable.
RUN chmod +x /tmp/init_db.sh

# Set the initialization script as the default command for the container.
CMD ["/tmp/init_db.sh"]
