# GeoFencing
Application mobile qui affiche des informations sur les zones géographiques d'une façon automatique selon la position d'utilisateur.

Cette application interagit avec un service API afin de récupérer des données contenues dans une base de données, pour être ensuite affichée sur le téléphone de l’utilisateur.


CCe dépôt contient l'application mobile développée en Flutter ainsi que le fichier docker-compose pour générer l'interface administrateur sur Directus.

## Planning :
- Date de début : **08 Nouvembre 2021**
- Date de fin : **08 Avril 2022**

## Membre de group :
- Youssef Bahi (youssef.bahi1@etu.univ-lorraine.fr)
- Malek Ben Khalifa (malek.ben-khalifa3@etu.univ-lorraine.fr)
- Sebastien Klaus (sebastien.klaus2@etu.univ-lorraine.fr)
- Maxime Piscalgia (maxime.piscaglia1@etu.univ-lorraine.fr)

## Version Flutter :
* Flutter 2.10.3
* Dart 2.16.1
* DevTools 2.9.2

## Lien utiles :
- CMS : https://geofencingiut.netlify.app/
- Interface administrateur : http://docketu.iutnc.univ-lorraine.fr:62007/
- Tableau de bord (Trello) : https://trello.com/b/QgXt2PSV/planning

## Code source :
- Version mobile & docker compose: https://github.com/malekbk98/Geofencing-IUT-2022

# Installation d'application mobile:
## Deux méthodes:
### 1) Exécuter ce code source
-    **Note** : avoir une version de Flutter compatible (Flutter 2.10.3)
-   Créer le fichier de config ```config.json``` (dans assets/config) depuis l'example ```config_example.json```
-   ``` geofencing> flutter run ```


### 2) Par fichier d'installation APK:

-    Installer le fichier Apk `geofencing.apk` sur votre mobile.

## En cas d'erreur lors de l'instatllation:
1) ``` geofencing> flutter clean ```
2) ``` geofencing> flutter pub get ```
3) ``` geofencing> flutter run ```

## Génération du fichier. Apk :
``` geofencing> flutter build apk --split-per-abi  ```


# Installation directus:
1)
2)
## Fonctionnalités :
### Client (version mobile)
- Consulter des informations sur la mine de Neuve-Maison.
- La détection automatique d'entrée/sortir d'une zone géographie (définie par l'administrateur) et afficher des informations reliées.
- Scanner des QR code pour avoir des informations sur les bornes.
- Recevoir des notifications lors d'entrée/sortir d'une zone.
- Consulter la liste de toutes les zones et bornes.
- Activer/déactiver les notifications.
- Vérifier s'il y a des mises à jour.

## Technologies :
- Mobile app : ```Flutter```
- Backoffine : ```Directus 9.5.1```
- Database : ```SqlLite```