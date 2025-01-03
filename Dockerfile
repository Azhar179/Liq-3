FROM liquibase/liquibase:latest

# Download and install the Microsoft SQL Server JDBC driver
RUN curl -L -o /liquibase/lib/mssql-jdbc-11.2.1.jre8.jar \
    https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/11.2.1.jre8/mssql-jdbc-11.2.1.jre8.jar

# Download and install the MySQL JDBC driver
RUN curl -L -o /liquibase/lib/mysql-connector-j-9.0.0.jar \
    https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.0.0/mysql-connector-j-9.0.0.jar

# Set the classpath for the JDBC drivers
ENV CLASSPATH=/liquibase/lib/mysql-connector-j-9.0.0.jar:/liquibase/lib/mssql-jdbc-11.2.1.jre8.jar

# Default command to run when container starts (can be overridden in Jenkins pipeline)
CMD ["liquibase", "--version"]
