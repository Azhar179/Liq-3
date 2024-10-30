docker run -it <your-image-name> liquibase \
  --url="jdbc:mysql://<db-host>:<db-port>/<db-name>" \
  --username=<your-db-username> \
  --password=<your-db-password> \
  --driver=com.mysql.cj.jdbc.Driver \
  status
