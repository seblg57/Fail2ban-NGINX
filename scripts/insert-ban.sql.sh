#!/bin/bash

DB_NAME="fail2ban_db"
DB_USER="fail2ban_user"
DB_PASSWORD="********"
DB_HOST="localhost"

# Collecte des informations via whois (comme avant)
WHOIS_OUTPUT=$(whois $1)
COUNTRY=$(echo "$WHOIS_OUTPUT" | grep -i "country:" | head -n 1 | awk '{print $NF}')
CITY=$(echo "$WHOIS_OUTPUT" | grep -i "city:" | head -n 1 | awk '{print $NF}')
COUNTRY=${COUNTRY:-Unknown}
CITY=${CITY:-Unknown}

# Ajout du type de connexion comme argument $3
CONNECTION_TYPE=$3

# Commande SQL ajustée pour inclure le type de connexion
SQL_COMMAND="INSERT INTO ip_bans (ip_address, country, city, ban_time, jail, connection_type) VALUES ('$1', '$COUNTRY', '$CITY', now(), '$2', '$CONNECTION_TYPE');"

# Exécute la commande SQL via psql
PGPASSWORD=$DB_PASSWORD psql -U $DB_USER -d $DB_NAME -c "$SQL_COMMAND"
