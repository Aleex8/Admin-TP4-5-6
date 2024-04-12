

CREATE DATABASE IF NOT EXISTS woodytoys;
USE woodytoys;

CREATE USER 'woodytoysuser'@'tpuser-php-1.tpuser_Web_network' IDENTIFIED BY 'woodytoysuserpwd';
GRANT SELECT ON `woodytoys`.* TO 'woodytoysuser'@'tpuser-php-1.tpuser_Web_network';

CREATE TABLE IF NOT EXISTS products (
    id MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(255) DEFAULT NULL,
    product_price VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (id)
) AUTO_INCREMENT=1;

INSERT INTO products (product_name, product_price) VALUES 
    ("Set de 100 cubes multicolores", "50"),
    ("Yoyo", "10"),
    ("Circuit de billes", "75"),
    ("Arc à flèches", "20"),
    ("Maison de poupées", "150");   
