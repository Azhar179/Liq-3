# Base Liquibase image
FROM liquibase/liquibase:latest

# Set the Liquibase version
ENV LIQUIBASE_VERSION=4.28.0

# Download and install the MySQL JDBC driver
RUN curl -L -o /liquibase/lib/mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.32/mysql-connector-java-8.0.32.jar

# Set up environment variables for Liquibase
ENV DB_URL=jdbc:mysql://your_db_host:3306/your_db_name \
    DB_USERNAME=your_db_username \
    DB_PASSWORD=your_db_password

# Copy additional files if needed
# COPY /path/to/your/changelog /liquibase/changelog

# Default command to run when container starts (can be overridden in Jenkins pipeline)
CMD ["liquibase", "--version"]
