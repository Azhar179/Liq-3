# Base Liquibase image
FROM liquibase/liquibase:latest

# Download and install the Microsoft SQL Server JDBC driver
RUN curl -L -o /liquibase/lib/mssql-jdbc.jar https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/11.2.1.jre8/mssql-jdbc-11.2.1.jre8.jar

# Default command to run when container starts (can be overridden in Jenkins pipeline)
CMD ["liquibase", "--version"]
