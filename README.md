### TP_owncloud

## Préparation de la sauvegarde des fichiers :

- Création d'un fichier.csv dans le repertoire OwnCloud

- Recherche de où sont stocké les fichiers OwnCloud :

```docker inspect "numéro de l'image lancée"```

Vous obtiendrez un long script et trouverez ceci :
```"Mounts": [
            {
                "Type": "volume",
                "Name": "9e78b14313909f6318898c1c908b7d4faaf5553de74865ea522387cb6e7c5b1d",
                "Source": "/var/lib/docker/volumes/9e78b14313909f6318898c1c908b7d4faaf5553de74865ea522387cb6e7c5b1d/_data",
                "Destination": "/var/www/html",
                "Driver": "local",
                "Mode": "",
                "RW": true,
                "Propagation": ""
            }
```
Vous pouvez donc voir dans "source" où sont stockés les fichiers.


## Création de la sauvegarde

- Création du fichier de réception de la sauvegarde :

```mkdir ~/backups_ownclouds```

- Création du script.sh pour la sauvegarde des fichiers :

**Voir le script "backup_toip.sh"**

- Pour tester de ce script nous allons le lancer :

```./backup_toip.sh```

- Pour vérifier rendez vous dans le dossier de backup et dans mon cas nous obtenons un fichier.zip commme ceci :

```sio2-04-12-2024_10:52:39.zip```


## Automatisation de la tâche :

- Configurer le crontab :

```crontab -e``` 

puis saisir 1

- Pour lancer le script de sauvegarde chaque jour à 23h45 voici ligne à saisir :

```45 23 * * * ~/backup_toip.sh```

### Transfert FTP vers un serveur externe :

## Creation d'une autre machine serveur
	- Installation du service proftpd
    
    ```apt install proftpd```

## Création du fichier envoiftp.sh :

Voici le script :

```#!/bin/bash

# Chemins et configurations
SOURCE_DIR="/var/lib/docker/volumes/9e78b14313909f6318898c1c908b7d4faaf5553de74865ea522387cb6e7c5b1d/_data/data/max/files/toip"
BACKUP_DIR="/backup_owncloud"
DATE=$(date +"%d-%m-%Y_%H:%M:%S")
BACKUP_FILE="$BACKUP_DIR/sio2-$DATE.zip"
LOG_FILE="/var/log/backup_toi.log"
FTP_SERVER="192.168.20.153"
FTP_USER="root"
FTP_PASS="root"
FTP_DIR="archives_toip"

#compresser le contenu du répertoire source dans un fichier ZIP
zip -r "$BACKUP_FILE" "$SOURCE_DIR" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Sauvegarde réussie : $BACKUP_FILE" | tee -a "$LOG_FILE"
else
    echo "Erreur : échec de la compression avec zip." | tee -a "$LOG_FILE"
    exit 1
fi

# Transfert FTP
echo "Début du transfert FTP vers le serveur $FTP_SERVER dans le répertoire $FTP_DIR" | tee -a "$LOG_FILE"

# Utilisation de l'outil lftp pour transférer le fichier via FTP
lftp -f "
open ftp://$FTP_USER:$FTP_PASS@$FTP_SERVER
lcd $BACKUP_DIR
cd $FTP_DIR
put $(basename $BACKUP_FILE)
bye
"

# Vérification de l'envoi
if [ $? -eq 0 ]; then
    echo "Transfert réussi : $(basename $BACKUP_FILE) vers $FTP_SERVER/$FTP_DIR" | tee -a "$LOG_FILE"
else
    echo "Erreur lors du transfert FTP." | tee -a "$LOG_FILE"
    exit 1
fi

# Nettoyage des fichiers temporaires
echo "Nettoyage des fichiers temporaires..." | tee -a "$LOG_FILE"
rm -rf "$TEMP_DIR"

# Fin du script
echo "=== Fin de la sauvegarde : $(date) ===" >> "$LOG_FILE"

```

- Pour tester le script nous exécutons cette commande :

```./envoiftp.sh```


