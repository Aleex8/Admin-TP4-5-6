#!/bin/bash

# Attendre que le service MySQL soit démarré
until mysqladmin ping -h mariadb --silent; do
    echo 'Attente du démarrage du service MySQL...'
    sleep 1
done

# Exécuter la commande MySQL pour créer la base de données "woodytoys"
mysql -h mariadb -u root -pmypass -e "CREATE DATABASE IF NOT EXISTS woodytoys;"

# Utiliser la base de données "woodytoys"
mysql -h mariadb -u root -pmypass -e "USE woodytoys;"

# Créer la table "products"
mysql -h mariadb -u root -pmypass -e "CREATE TABLE IF NOT EXISTS products (id mediumint(8) unsigned NOT NULL AUTO_INCREMENT, product_name varchar(255) DEFAULT NULL, product_price varchar(255) DEFAULT NULL, PRIMARY KEY (id));"

# Insérer des données dans la table "products"
mysql -h mariadb -u root -pmypass -e "INSERT INTO products (product_name, product_price) VALUES ('Set de 100 cubes multicolores', '50'), ('Yoyo', '10'), ('Circuit de billes', '75'), ('Arc à flèches', '20'), ('Maison de poupées', '150');"



