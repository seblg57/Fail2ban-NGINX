#!/bin/bash

# Variables de connexion à la base de données
DB_NAME="ip_database"
DB_USER="fail2ban_user"
DB_PASSWORD="yourpassword"
DB_HOST="localhost"

# Adresse IP à débannir
IP=$1

# Retire l'adresse IP de la zone blockzone dans Firewalld
firewall-cmd --permanent --zone=blockzoneSSH --remove-source=$IP
firewall-cmd --reload

# Supprime l'entrée de l'adresse IP de la base de données
SQL_COMMAND="DELETE FROM ip_bans WHERE ip_address = '$IP';"

# Exécute la commande SQL via psql
PGPASSWORD=$DB_PASSWORD psql -U $DB_USER -d $DB_NAME -h $DB_HOST -c "$SQL_COMMAND"
