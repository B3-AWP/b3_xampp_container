# Verwende das offizielle MariaDB-Image als Basis
FROM mariadb

# Installiere den mysql-client
RUN apt-get update && apt-get install -y mysql-client && rm -rf /var/lib/apt/lists/*