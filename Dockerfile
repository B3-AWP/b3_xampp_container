# Verwende das offizielle MariaDB-Image als Basis
FROM mariadb:latest
RUN apt-get update && \
    apt-get install -y mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# FROM debian:latest
# RUN apt-get update && \
#     apt-get install mysql-client -y && \
#     rm -rf /var/lib/apt/lists/*