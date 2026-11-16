#!/bin/bash

set -e

echo "Iniciando aprovisionamiento automático..."

cd /vagrant/scripts

echo "Instalando la pila LAMP..."
bash install_lamp.sh

echo "Instalando PrestaShop..."
bash deploy_prestashop.sh

echo "¡Aprovisionamiento completado con éxito!"