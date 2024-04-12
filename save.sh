#!/bin/bash

# La commande grep -v '^#' .env filtre les lignes commentées (commençant par #) du fichier .env. même si ici nous n'en avons pas
# La commande xargs convertit chaque ligne filtrée en une série d'arguments.
# La commande export rend les variables d'environnement disponibles pour le script.

export $(grep -v '^#' /home/tpuser/db/sql/root.env | xargs)

# Répertoire de sauvegarde
backup_dir="/home/tpuser/database_backup"
backup_dir_new="$backup_dir/backup_dir"


# Nom du fichier de sauvegarde
backup_file_new="all-databases-$(date +'%Y-%m-%d_%H-%M-%S').sql"

# Chemin complet du fichier de sauvegarde
backup_path_new="$backup_dir_new/$backup_file_new"

# Mot de passe de l'utilisateur root de MariaDB
mariadb_root_password="$MYSQL_ROOT_PASSWORD"

# Exécute mariadb-dump pour sauvegarder toutes les bases de données
# Utilisez les options -uroot -p pour spécifier l'utilisateur et le mot de passe
docker exec tpuser-mariadb-1 mariadb-dump --all-databases -uroot -p"$mariadb_root_password"  > "$backup_path_new"


# Vérifie si la sauvegarde a réussi
if [ $? -eq 0 ]; then
    echo "Sauvegarde des bases de données terminée avec succès: $backup_path_new"
    echo "-----------------------"
else
    echo "ERREUR: La sauvegarde des bases de données a échoué"
    echo "-----------------------"
    exit 1
fi

# Compression du fichier de sauvegarde
gzip "$backup_path_new"

# Vérifie si la compression a réussi
if [ $? -eq 0 ]; then
    echo "Compression du fichier de sauvegarde terminée avec succès: $backup_path_new.gz"
    echo "-----------------------"
    echo "Effacement de l'ancien fichier de sauvergarde"
    echo "-----------------------"
    # Supprimer tous les fichiers .gz du répertoire database_backup
    nombre_fichiers=$(ls -1 "$backup_dir"/*.gz 2>/dev/null | wc -l)

    # Vérifier si le nombre de fichiers est supérieur à zéro
    if [ "$nombre_fichiers" -gt 0 ]; then
        # S'il y a des fichiers, exécuter la commande rm
        rm "$backup_dir"/*.gz
        echo "Les anciens fichiers .gz ont été supprimés avec succès.."
        echo "-----------------------"
    else
        echo "Aucun fichier .gz à supprimer dans le répertoire."
        echo "-----------------------"
    fi
    mv "$backup_path_new".gz "$backup_dir"
    echo -e "Le fichier : $backup_path_new.gz a été déplacé vers :\n$backup_dir"
    echo "-----------------------"
else
    echo "ERREUR: La compression du fichier de sauvegarde a échoué"
    exit 1
fi
