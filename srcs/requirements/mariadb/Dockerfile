FROM debian:buster
# Base image: Debian Buster is chosen as the operating system for the container.

RUN apt-get update && apt-get install -y mariadb-server
# Updates the package lists and installs the MariaDB server package.

EXPOSE 3306
# Exposes port 3306, which is the default port for MariaDB, allowing external access to the database.

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
# Copies a custom MariaDB configuration file to the appropriate directory inside the container.
# This file likely customizes the MariaDB server's behavior, such as bind address or performance settings.

COPY ./tools/init_db.sh /tmp/init_db.sh
# Copies the `init_db.sh` script into the `/tmp` directory inside the container.
# This script will be executed to initialize the database (e.g., creating databases, users, and setting permissions).

RUN chmod +x /tmp/init_db.sh
# Makes the `init_db.sh` script executable.

ENTRYPOINT ["bash", "/tmp/init_db.sh"]
# Specifies the script to be executed as the container starts.
# The `init_db.sh` script sets up the database and starts the MariaDB service.

CMD ["mysqld"]
# The default command to run after the entrypoint.
# Runs the MariaDB server (mysqld) process in the foreground, keeping the container alive.
