#! /bin/bash

docker compose up -d 
wait_for_mariadb() {
    until nc -z -v -w30 mariadb 3306; do
        echo 'En attente du démarrage de MariaDB...'
        sleep 1
    done
}

# Attendre que le serveur MariaDB soit prêt
wait_for_mariadb

mysql -h mariadb -u root -pmypass < /database/woodytoys.sql
