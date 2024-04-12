#!/bin/bash

# Répertoire de sauvegarde
backup_dir="/home/tpuser/database_backup"

# Nom du fichier de sauvegarde
backup_file="all-databases-$(date +'%Y-%m-%d_%H-%M-%S').sql"

# Chemin complet du fichier de sauvegarde
backup_path="$backup_dir/$backup_file"

# Mot de passe de l'utilisateur root de MariaDB
mariadb_root_password="rootPSWDa@"

# Exécute mysqldump pour sauvegarder toutes les bases de données
# Utilisez les options -uroot -p pour spécifier l'utilisateur et le mot de passe
docker exec tpuser-mariadb-1 mariadb-dump --all-databases -uroot -p"$mariadb_root_password"  > "$backup_path"


# Vérifie si la sauvegarde a réussi
if [ $? -eq 0 ]; then
    echo "Sauvegarde des bases de données terminée avec succès: $backup_path"
else
    echo "ERREUR: La sauvegarde des bases de données a échoué"
    exit 1
fi

# Compression du fichier de sauvegarde
gzip "$backup_path"

# Vérifie si la compression a réussi
if [ $? -eq 0 ]; then
    echo "Compression du fichier de sauvegarde terminée avec succès: $backup_path.gz"
else
    echo "ERREUR: La compression du fichier de sauvegarde a échoué"
    exit 1
fi
