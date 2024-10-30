# Use the official Liquibase image as the base
FROM liquibase/liquibase:latest

# Install necessary tools
RUN apt-get update && apt-get install -y curl

# Download and add the MySQL JDBC driver
ENV MYSQL_DRIVER_VERSION=8.0.32
RUN curl -L -o /liquibase/lib/mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar

# Verify installation
RUN ls -l /liquibase/lib/mysql-connector-java.jar

# Optional: set environment variables for database connection
ENV DB_URL=jdbc:mysql://your_db_host:3306/your_db_name
ENV DB_USERNAME=your_db_username
ENV DB_PASSWORD=your_db_password

# Set the default command to start Liquibase
CMD ["liquibase"]
