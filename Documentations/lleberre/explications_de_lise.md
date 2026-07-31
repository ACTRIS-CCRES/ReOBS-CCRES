# Notes, remarque de Lise

## Organisation

J'ai créé un dépôt ReOBS-CCRES sur le GitLab.

Ce dépôt GitLab a été créé pour référencer le projet ReOBS-CCRES au sein
    de l'organisation ReOBS. De plus, le projet étant réparti sur
    plusieurs dépôts (cœur de ReOBS sur GitLab, configurations sur GitHub
    et workflows sur GitHub), il fournit un point unique de coordination et de
    suivi des issues.

Le dépôt est disponible ici : https://gitlab.in2p3.fr/ipsl/espri/espri-obs/reobs/projects/reobs-ccres

@Laurent, les issues sont désormais à créer et à suivre dans ce dépôt.

@Jean-François, peux-tu t'abonner aux notifications du projet ? Tu recevras
    ainsi un e-mail à chaque nouvelle issue.

## Nom des fichiers

Voici les réponses à tes questions :

    suffix : 000000_0y.nc en fin de fichier
        le suffixe 000000 est hhmmss associée à la date située avant : dans
        ton exemple 20260101 0y correspond à la durée du fichier en année
        mais comme tu fais tourner tes fichiers par mois effectivement avoir
        l'info en année n'est pas pertinent.
        Pour modifier ce fonctionnement il faut modifier les fichiers
        `base_XXX.cfg` doivent être modifiés. (voir reobs-station#2)
        Remplacer tous les :

            file_length_unit=year

            par :

            file_length_unit=day ou month

* Bizarre les données globales du netcdf pour un fichier mensuel :
    :time_coverage_start = "2026-01-01T00:00:00" ;
    :time_coverage_end = "2026-01-15T23:00:00" ;
    Oui c'est un bug identifié mais pas encore corrigé (voir issue reobs#103)

    choix dans le netcdf de  : netcdf cloudnet_der_v0_4_0_20260101_000000_0y
    { dimensions:  time = UNLIMITED ; // (744 currently)
    Le choix d'une dimension time = UNLIMITED est je pense historiquement.
    Historiquement, il était peut être prévu d'étendre un fichier NetCDF
    existant en ajoutant de nouveaux pas de temps, plutôt que de le réécrire
    entièrement et de retraiter toute les filières. Cependant, dans
    l'utilisation actuelle de ReOBS, les fichiers sont reconstruits puis
    réécrits intégralement à chaque génération. La dimension UNLIMITED ne
    semble donc plus apporter de bénéfice particulier et pourrait être
    remplacée par une dimension de taille fixe. Il reste toutefois à vérifier
    si cette possibilité d'écriture incrémentale est toujours envisagée avant
    de modifier ce comportement. J'ai créé une issur à ce sujet reobs#110

## Questions lcrepeau

* Nouveau fichier mensuel créé au bon endroit désormais
    BDD="/bdd/ACTRIS/CCRES/pub/reobs/base/ccres_palaiseau/products"

    $BBD/v0_4_0/treatments/cloudnet_der/cloudnet_der_v0_4_0_20260101_000000_0y.nc

* Je ne comprend pas le choix dans le netcdf de  :
    netcdf cloudnet_der_v0_4_0_20260101_000000_0y {
    dimensions:
        time = UNLIMITED ; // (744 currently)
    Le time = UNLIMITED a un gros impact sur la taille du fichier (ici 22,5 Mo
    quand même) car le netcdf réserve des places pour pouvoir concaténer
    d'autres données et là nous n'en avons pas besoin.

    Bizarre les données globales du netcdf pour un fichier mensuel :
            :time_coverage_start = "2026-01-01T00:00:00" ;
            :time_coverage_end = "2026-01-15T23:00:00" ;

    Je m'attendais à au moins 2026-01-31 en date de fin. Bizarre. En tous cas le
    superviseur lit en 2 paquets de 15 jours.

* Je ne comprends pas le suffix : 000000\_0y.nc en fin de fichier
    $BBD/v0_4_0/treatments/cloudnet_der/cloudnet_der_v0_4_0_20260101_000000_0y.nc
