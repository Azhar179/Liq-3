LIQUIBASE_VERSION=4.28.0
echo "Attempting to download Liquibase..."
curl -L -O https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz
