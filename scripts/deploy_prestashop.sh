#!/bin/bash

# Cargar las variables del archivo .env
set -e
source "$(dirname "$0")/.env"
set +a

# Directorio web de Apache
WEB_DIR="/var/www/html"

echo "Descargando la última versión de PrestaShop..."

cd /tmp

# Descargar el archivo zip oficial de PrestaShop 
wget -O prestashop.zip \
https://github.com/PrestaShop/PrestaShop/releases/download/8.1.0/prestashop_8.1.0.zip

# Comprobar que el archivo descargado es un ZIP válido
unzip -tq prestashop.zip

echo "Descomprimiendo PrestaShop en el directorio web..."

rm -rf "${WEB_DIR:?}"/*
unzip -q prestashop.zip -d "$WEB_DIR"

# Ajustar permisos para Apache
chown -R www-data:www-data "$WEB_DIR"
find "$WEB_DIR" -type d -exec chmod 755 {} \;
find "$WEB_DIR" -type f -exec chmod 644 {} \;

echo "¡PrestaShop descargado y desplegado correctamente en ${WEB_DIR}!"