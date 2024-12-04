### TP_owncloud

## Sauvegarde des fichiers :

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




