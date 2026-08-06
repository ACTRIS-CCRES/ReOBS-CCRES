# ACTRIS-ReOBS-CCRES

Faire des fichiers mensuels, puis annuels à partir des données téléchargés par station via cloudnet.

A chaque 5 ième jour du mois organiser le traitement du mois précédent :

* pour toutes les stations
* pour toutes les filiéres

Il faudra :

* générer le fichier mensuel échu
* mettre à jour les visualisations
* concaténer le fichier mensuel dans le fichier annuel correspondant.

Voir le [cahier des charges](../README.md 'là').

## Où

Le travail va se mener sur le compte `ccres` sur spiritx.

## Installation

L'installation va se faire dans le répertoire /home/ccres/flux/ReOBS-CCRES. Au 20260731 `reobs` a besoin d'un environnement python conda spécifique pour travailler. Cet environnement est installé dans le répertoire `/homedata/ccres/python_envs/reobs`. Il est activé par la commande :

```bash
$> conda activate /homedata/ccres/python_envs/reobs
```

### Organisation du répertoire

```bash
$> cd flux/ReOBS-CCRES
~/flux/ReOBS-CCRES $> ls -1
configs
Documentations
README.md
Reobs_ccres_cylc_visualisations
src
workflows
```

Il y a 5 répertoires :

* configs : répertoire contenant les configurations `reobs` pour travailler
* Documentations : pour les notes personnelles de lcrepeau
* Reobs\_ccres\_cylc\_visualisations : environnement python pour faire tourner du `cylc` et générer les visualisations. Il est différent de celui de `reobs` pour pouvoir utiliser des outils récents
* src : contient le code source de `reobs`
* contient les différentes suites `cylc` historiques

et 2 dépôt versionnés par git

* le répertoire src est le dépôt git `reobs` installé en sous-module
* les répertoires configs et workflow font partie de l'autre dépôt git

dont les adresses sont :

* raccourci (origin): adresse (git@github.com:ACTRIS-CCRES/ReOBS-CCRES.git)
* raccourci (origin\_workflow) : adresse (git@github.com:ACTRIS-CCRES/ReOBS-CCRES-workflow.git)

Ils doivent être indépendants pour avoir une installation propre (quelle que soit la version `reobs` utilisée et quelle que soit les configurations du projet) et une gestion séparée.

## Utilisation de `cylc` pour automatiser les tâches récurrentes

Des suites `cylc` vont être mises au point pour faire ce travail récurrent.

## Premiers ajustements après installation de reobs

Ajustements des chemins /scratchx/ccres par rapport au compte `ccres` :

* configs/treatments/bases\_ccres\_lindenberg.cfg
* configs/treatments/bases\_ccres\_palaiseau.cfg
* configs/treatments/superviseur.cfg
* configs/treatments/superviseur.dev.cfg
* workflows/ccres\_palaiseau/flow.cylc
* workflows/run\_cylc.py

## Ticket ReOB-CCRES

Poser les remarques ou les questions pour Lise Le Berre plutôt que des mèls il vaut
    mieux faire des
[tickets](https://gitlab.in2p3.fr/ipsl/espri/espri-obs/reobs/projects/reobs-ccres 'ici').

## Configuration de ReOBS

![graph][internal-source-sui]

[internal-source-sui]: lcrepeau/images/conf_reobs_A.baco.png 'Confs ReOBS'

### Le chapitre 4

Le document A.Baco\_Rapport\_Stage.pdf explique comment configurer les différents
    fichiers pour traiter avec `reobs`.

## Organisation des fichiers pour les stations Palaiseau et Lindenberg

Au 20260731, il y avait 14 stations connues en plus des 2 ci-dessus, et les filières connues à ce jour pour les 2 stations.

```bash
$> cd configs/treatments
$> $ tree -f
.
├── ./bases_ccres_lindenberg.cfg
├── ./bases_ccres_palaiseau.cfg
├── ./filieres_ccres_lindenberg.cfg
├── ./filieres_ccres_palaiseau.cfg
├── ./macro.cfg
├── ./sites
│   ├── ./sites/ccres_lindenberg
│   │   ├── ./sites/ccres_lindenberg/categorize.cfg
│   │   ├── ./sites/ccres_lindenberg/classification.cfg
│   │   ├── ./sites/ccres_lindenberg/construct_final_2D.cfg
│   │   ├── ./sites/ccres_lindenberg/default.cfg
│   │   ├── ./sites/ccres_lindenberg/der.cfg
│   │   ├── ./sites/ccres_lindenberg/disdrometer.cfg
│   │   ├── ./sites/ccres_lindenberg/disdrometer_raw.cfg
│   │   ├── ./sites/ccres_lindenberg/doppler_lidar.cfg
│   │   ├── ./sites/ccres_lindenberg/doppler_lidar_epsilon.cfg
│   │   ├── ./sites/ccres_lindenberg/doppler_lidar_wind.cfg
│   │   ├── ./sites/ccres_lindenberg/drizzle.cfg
│   │   ├── ./sites/ccres_lindenberg/ier.cfg
│   │   ├── ./sites/ccres_lindenberg/iwc.cfg
│   │   ├── ./sites/ccres_lindenberg/lidar.cfg
│   │   ├── ./sites/ccres_lind/home/ccres/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfgenberg/lwc.cfg
│   │   ├── ./sites/ccres_lindenberg/meteo.cfg
│   │   ├── ./sites/ccres_lindenberg/mwr.cfg
│   │   ├── ./sites/ccres_lindenberg/mwr_l1c.cfg
│   │   ├── ./sites/ccres_lindenberg/mwr_multi.cfg
│   │   ├── ./sites/ccres_lindenberg/mwr_single_ah.cfg
│   │   ├── ./sites/ccres_lindenberg/mwr_single.cfg
│   │   ├── ./sites/ccres_lindenberg/radar.cfg
│   │   └── ./sites/ccres_lindenberg/raingauge.cfg
│   ├── ./sites/ccres_palaiseau
│   │   ├── ./sites/ccres_palaiseau/categorize.cfg
│   │   ├── ./sites/ccres_palaiseau/classification.cfg
│   │   ├── ./sites/ccres_palaiseau/construct_final_2D.cfg
│   │   ├── ./sites/ccres_palaiseau/default.cfg
│   │   ├── ./sites/ccres_palaiseau/der.cfg
│   │   ├── ./sites/ccres_palaiseau/disdrometer.cfg
│   │   ├── ./sites/ccres_palaiseau/disdrometer_raw.cfg
│   │   ├── ./sites/ccres_palaiseau/doppler_lidar.cfg
│   │   ├── ./sites/ccres_palaiseau/doppler_lidar_epsilon.cfg
│   │   ├── ./sites/ccres_palaiseau/doppler_lidar_wind.cfg
│   │   ├── ./sites/ccres_palaiseau/drizzle.cfg
│   │   ├── ./sites/ccres_palaiseau/ier.cfg
│   │   ├── ./sites/ccres_palaiseau/iwc.cfg
│   │   ├── ./sites/ccres_palaiseau/lidar.cfg
│   │   ├── ./sites/ccres_palaiseau/lwc.cfg
│   │   ├── ./sites/ccres_palaiseau/meteo.cfg
│   │   ├── ./sites/ccres_palaiseau/mwr.cfg
│   │   ├── ./sites/ccres_palaiseau/mwr_l1c.cfg
│   │   ├── ./sites/ccres_palaiseau/mwr_multi.cfg
│   │   ├── ./sites/ccres_palaiseau/mwr_single_ah.cfg
│   │   ├── ./sites/ccres_palaiseau/mwr_single.cfg
│       └── ./sites/ccres_palaiseau/radar.cfg
├── ./superviseur.cfg
└── ./superviseur.dev.cfg
```

C'est le fichier superviseur.dev.cfg qui est utilisé car c'est celui par défaut qui est utilisé par les suites `cylc`.

## Commande ReOBS type

```bash
$> /home/ccres/flux/ReOBS-CCRES/src/reobs/reobs/cli/superviseur/superviseur.sh \
-o init_catalog -d 20260101-20260131 -s ccres_palaiseau \
-f cloudnet_doppler_lidar_wind \
-c /home/ccres/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
```

C'est ce type de commande qui sera utilisée dans les suites `cylc` dans les fichiers `flow.cylc`.

### Explications de la commande

* On lance le superviseur.sh
* On demande l'initialisation d'un catalogue
* On demande un traitement pour tout le mois de Janvier 2026
* On demande la station `ccres_palaiseau`
* On demande la filière `cloudnet_doppler_lidar_wind`
* On utilise le fichier de config `superviseur.dev.cfg`

### Script `superviseur.sh`

C'est une couche bash qui encapsule le programme python `reobs` et qui permet de lancer tous les traitements :

```bash
$> superviseur.sh -h
DESCRIPTION
    Utilisation de superviseur.sh :

    superviseur.sh [-h|-v] -d dates (aaaammjj|auto[-aaaammjj|auto])
    -s site -f nom_filiere -c fich_config [-g niv_debogage]

OPTIONS
    -d
     Seules les donnees appartenant a cette periode sont traitees

    -c
     Fichier de configuration

    -s/home/ccres/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
     Site d'observation

    -f
     Nom d'une filiere

    -o
     Active une option (init_catalog, debug, log)

    -g
     Activation du debogage (idem a l'option '-o debug')

    -v
     Affiche la version du programme

    -h | --help
     Affiche cette aide

    --ignore-today
     Ignore la date d'aujourd'hui lors de la creation du catalogue

    --ignore-catalog-errors
     Ignore les erreurs lors de la creation du catalogue
```

### `reobs` peut être lancé seul

En utilisant l'interface de commande en ligne directement :

```bash
# EXEMPLE
$> reobs run -d 20260101-20260722 -g -l -s sirta -f angle_solaire \
  -c /home/$USER/ReOBS/configs/treatments/superviseur.cfg
```

## Concaténation des netcdf générés

Pour concaténer des fichiers netCDF sur la variable time, vous pouvez utiliser
    la commande ncrcat qui nécessite que les fichiers aient une dimension de
    temps illimitée ([source](https://donneesclimatiques.ca)).
