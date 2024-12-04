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

- Automatisation de la tâche :
Configurer le crontab :

```crontab -e``` 

saisir 1

Pour lancer le script de sauvegarde chaque jour à 23h45 voici ligne à saisir :

```45 23 * * * ~/backup_toip.sh```











