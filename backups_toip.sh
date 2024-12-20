#!/bin/bash
#installation du pacquet zip :
apt install zip

# Variables
SOURCE_CSV="/var/lib/docker/volumes/9e78b14313909f6318898c1c908b7d4faaf5553de74865ea522387cb6e7c5b1d/_data/data/max/files/toip/fichier.csv"
TOIP_DIR="/var/lib/docker/volumes/9e78b14313909f6318898c1c908b7d4faaf5553de74865ea522387cb6e7c5b1d/_data/data/max/files/toip"
BACKUP_DIR="$HOME/backups_ownclouds"
TIMESTAMP=$(date +"%d-%m-%Y_%H:%M:%S")


# Compresser le contenu du répertoire `toip` en un fichier ZIP
BACKUP_ZIP="$BACKUP_DIR/sio2-$TIMESTAMP.zip"
zip -r "$BACKUP_ZIP" "$TOIP_DIR"
echo "Contenu du répertoire toip compressé sous : $BACKUP_ZIP"


