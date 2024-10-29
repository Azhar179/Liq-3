=> => sha256:a9cb59f4a42da4a8268428aed089add0c9a0767be0d6130693477cb748f67a3a 10.36kB / 10.36kB                                         0.0s
 => ERROR [build-stage 2/4] COPY src /src                                                                                                0.0s
------
 > [build-stage 2/4] COPY src /src:
------

 1 warning found (use docker --debug to expand):
 - SecretsUsedInArgOrEnv: Do not use ARG or ENV instructions for sensitive data (ENV "DB_PASSWORD") (line 15)
Dockerfile:3
--------------------
   1 |     # Stage 1: Build the application
   2 |     FROM maven:3.8.6-jdk-11-slim AS build-stage
   3 | >>> COPY src /src
   4 |     WORKDIR /src
   5 |     RUN mvn clean package
--------------------
ERROR: failed to solve: failed to compute cache key: failed to calculate checksum of ref a3b9c9ca-b38a-4f5b-84c3-b94c1b3dec03::qqzrjblyvv5x1vip30g5pju6d: "/src": not found
