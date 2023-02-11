# Use the official MySQL image as the base image
FROM mysql:8.0

# Set environment variables for the MySQL root user, Laravel user, and database
ENV MYSQL_ROOT_PASSWORD=root_password
ENV LARAVEL_DB=laravel_db
ENV LARAVEL_USER=laravel_user
ENV LARAVEL_PASSWORD=laravel_password

# Copy the script to the container
COPY init-db.sh /docker-entrypoint-initdb.d/init-db.sh

# Create the Laravel database and user, and grant privileges to the Laravel user
RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

# Copy the custom my.cnf file into the Docker image
COPY my.cnf /etc/mysql/my.cnf

# Expose the MySQL port
EXPOSE 3306

