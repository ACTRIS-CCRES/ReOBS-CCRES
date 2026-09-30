# Commandes cylc pour la gestion de la suite

## Voir la version de cylc qui est chargée

```bash
$> cylc --version
8.6.3
# VOIR LES VERSIONS DISPONIBLES + tabulation
$> module load cylc/
cylc/6.11.4  cylc/7.9.5   cylc/8.0.1   cylc/8.0rc1  cylc/8.1.2
cylc/8.2.2   cylc/8.3.6   cylc/8.4.2
```

## Voir ce qui tourne

```bash
$> cylc scan --state=all ; cylc scan --state=running | wc -l
ccres-disdro/reprocessing
chaque_mois/ccres_granada_test
chaque_mois/ccres_granada spiritx2.ipsl.fr:43048 1087897
chaque_mois/ccres_lampedusa
ccres-disdro/nrt spiritx1.ipsl.fr:43056 2945682
ccres-basta/nrt spiritx1.ipsl.fr:43011 3382139
3
```

## Stopper une suite

```bash
$> cylc stop -n chaque_mois/ccres_lampedusa
```

## Nettoyer une suite de la bdd de cylc

```bash
$> cylc clean chaque_mois/ccres_lampedusa
```

## Installer une suite dans la bdd de cylc avec son fichier de paramètres

```bash
$> cylc vip --workflow-name=chaque_mois --run-name=ccres_lampedusa \
    ~/flux/ReOBS-CCRES/workflows/ccres_lampedusa_reprise \
    --set-file=~/flux/ReOBS-CCRES/workflows/ccres_lampedusa_reprise/params
```

# Lancer une suite avec son fichier de paramètres

```bash
$> cylc play chaque_mois/ccres_lampedusa \
    --set-file=~/flux/ReOBS-CCRES/workflows/ccres_lampedusa_reprise/params
```

# Suivre le déroulement d'une suite en interactif

```bash
$> cylc tui chaque_mois/ccres_lampedusa
```
