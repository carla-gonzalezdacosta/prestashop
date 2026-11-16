#!/bin/bash

# Cargar las variables del archivo .env
set -a
source "$(dirname "$0")/.env"
set +a

export DEBIAN_FRONTEND=noninteractive

# Esperar únicamente si el bloqueo de dpkg está siendo utilizado
while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 || fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    echo "Esperando a que se libere el gestor de paquetes..."
    sleep 5
done

# Actualizar repositorios e instalar Apache y dependencias básicas
apt-get update
apt-get install -y apache2 curl unzip libapache2-mod-php

# Instalar PHP y todas las extensiones requeridas por PrestaShop
apt-get install -y php php-cli php-mysql php-curl php-gd php-intl php-mbstring php-xml php-zip php-soap php-imagick

# Instalar y configurar MySQL/MariaDB
apt-get install -y mariadb-server mariadb-client

systemctl start mysql
systemctl enable mysql

# Crear la base de datos y el usuario con las variables del .env
mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Ajustar configuraciones básicas de PHP en php.ini si es necesario (memory_limit, upload_max_filesize, etc.)
# ...

systemctl restart apache2
echo "¡Pila LAMP instalada correctamente!"