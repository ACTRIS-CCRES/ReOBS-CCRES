# Lancement cylc mensuelle reobs

## Commandes `cylc`

La suite prend un fichier `params` en argument

Exemple de fichier `params` pour traiter uniquement la station palaiseau pour les filières indiquées.

**Attention la syntaxe du fichier est très importante sinon `cylc` ne fonctionnera pas.**

```bash
BASE_DIR = "/home/ccres/flux/basta-ccres"
LISTESITES = ["ccres_palaiseau"]
LISTEFILIERES = ["categorize","classification","der","drizzle","ier","iwc","lidar","doppler_lidar","doppler_lidar_wind","doppler_lidar_epsilon","lwc","mwr_multi","mwr_l1c","mwr_single","mwr_single_ah","radar","disdrometer","disdrometer_raw","meteo"]
```

```bash
" ALLER DANS LE REPERTOIRE DE TRAVAIL
$> cd ~/flux/ReOBS-CCRES/workflows/ccres_mensuelle
# VALIDER LA SUITE
$> cylc validate --set-file ~/flux/ReOBS-CCRES/workflows/ccres_mensuelle/params .
# INSTALLER LA SUITE
$> cylc install --workflow-name=workflows --run-name=ccres_mensuelle ~/flux/ReOBS-CCRES/workflows/ccres_mensuelle
# VERIFIER l'INSTALLATION
$> cylc scan --state=all ; cylc scan --state=running | wc -l
# LANCER LA SUITE
$> cylc play --set-file ~/flux/ReOBS-CCRES/workflows/ccres_mensuelle/params workflows/ccres_mensuelle
# SUIVRE LA SUITE
$> cylc tui workflows/ccres_mensuelle
# ARRETER LA SUITE
$> cylc stop -n workflows/ccres_mensuelle
# NETTOYER LA SUITE
$> cylc clean workflows/ccres_mensuelle
```
