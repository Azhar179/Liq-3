FROM liquibase/liquibase:latest

# Copy MySQL JDBC driver
COPY mysql-connector-j-9.0.0.jar /opt/liquibase/lib/
