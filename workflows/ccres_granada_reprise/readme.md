# Utilisation de cylc

## Pour avoir l'environnement python du reobs sur le compte ccres

Il existe un alias dans le ~/.bashrc pour charger l'environnment :

```bash
$> alias
alias activate_reobs='conda activate /homedata/ccres/python_envs/reobs'
...
# Il faut lancer la commande activate_reobs est c'est tout
$> activate_reobs
(/homedata/ccres/python_envs/reobs) $>
```

## Traitement de séries temporelles avec cylc

Aller dans le répertoire
  /home/ccres/flux/ReOBS-CCRES/workflows/ccres\_granada\_reprise et mettre
  les dates de traitement dans le fichier params :

```bash
# EXMPLE DE FICHIER params
$> cat params
BASE_DIR = "/home/ccres/flux/basta-ccres"
EMAIL_FROM = "ccres-grafana@lmd.polytechnique.fr"
EMAIL_TO = "laurent.crepeau@lmd.ipsl.fr,jean-francois.ribaud@ipsl.fr"
LISTEFILIERES = [ "radar_nephele_rpg94","radar_nebula_rpg94","concat_radar_rpg94","categorize","classification","der","drizzle","ier","iwc","lidar","lwc","mwr_l1c","mwr_single","mwr_single_ah","radar","disdrometer","disdrometer_raw","meteo","mwr_multi" ]
START = 20230401
END = 20260831
PRODUCTION_VERSION = "v2026.09.1"
PRODUCTION_TYPE = "monthly_ccres"
```

**ATTENTION: La date END ci-dessus est exclue du traitement.**
**ATTENTION: Les répertoires workflows/ccres_granada_reprise
   et workflows/ccres_granada sont différents.**

## Lancer l'installation sous cylc

```bash
$> cylc vip --workflow-name=chaque_mois --run-name=ccres_granada_reprise_test3 \
   ~/flux/ReOBS-CCRES/workflows/ccres_granada_reprise \
   --set-file=~/flux/ReOBS-CCRES/workflows/ccres_granada_reprise/params
```

Attention à l'argument --run-name= qui doit être unique sinon les logs sont
  écrasées ou insulte.

## Lancer la suite si besoin

```bash
$> cylc play chaque_mois/ccres_granada_reprise_test3 \
  --set-file=~/flux/ReOBS-CCRES/workflows/ccres_granada/params
```

## Suivre la suite en interactif

```bash
$> cylc tui chaque_mois/ccres_granada_reprise_test3
```

## Arrêter la suite en production

```bash
$> cylc stop -n chaque_mois/ccres_granada_reprise_test3
```

## Supprimer la suite (et les logs)

```bash
$> cylc clean chaque_mois/ccres_granada_reprise_test3
```

## Valider une suite après modif :

Ca fait gagner beaucoup de temps et d'arrachage de cheveux inutiles.

```bash
$> cylc validate . --set-file=~/flux/ReOBS-CCRES/workflows/ccres_granada/params
```
