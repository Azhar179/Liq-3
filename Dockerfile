# Base Liquibase image for SQL Server
FROM liquibase/liquibase:latest

# Download and install the Microsoft SQL Server JDBC driver
RUN curl -L -o /liquibase/lib/mssql-jdbc-11.2.1.jre8.jar \
    https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/11.2.1.jre8/mssql-jdbc-11.2.1.jre8.jar

# Set Liquibase as the ENTRYPOINT
ENTRYPOINT ["liquibase"]
