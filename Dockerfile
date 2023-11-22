FROM mysql:latest

# Définir l'environnement MySQL
ENV MYSQL_ROOT_PASSWORD=my-secret-pw
ENV MYSQL_DATABASE=my-database
ENV MYSQL_USER=my-user
ENV MYSQL_PASSWORD=my-user-pw

# Exposer le port de MySQL
EXPOSE 3306
