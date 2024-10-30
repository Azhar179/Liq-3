docker run -it --entrypoint /liquibase/liquibase <your_dockerhub_username>/my-liquibase-image-driver \
    --url=jdbc:mysql://localhost:3306/twenty_eight \
    --username=root \
    --password=root update
