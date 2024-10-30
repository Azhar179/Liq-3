# Stage 1: Build the application
FROM maven:3.8.6-jdk-11-slim AS build-stage
COPY src /src
WORKDIR /src
RUN mvn clean package

# Stage 2: Create the final image
FROM liquibase/liquibase:latest
COPY --from=build-stage target/*.jar /app.jar
COPY mysql-connector-java-*.jar /opt/liquibase/lib/

# Set environment variables (optional)
ENV DB_URL=jdbc:mysql://your_db_host:3306/your_db_name
ENV DB_USERNAME=your_db_username
ENV DB_PASSWORD=your_db_password

# Command to run when the container starts
CMD ["java", "-jar", "/app.jar"]
