# Commandes `reobs` à partir de la v5.0.0

L'aide a été revue par lleberre en appellant directement reobs avec des
    arguments.

La page web complète est [là](https://ipsl.pages.in2p3.fr/espri/espri-obs/reobs/v3/reobs/user_guide/command_line_interface.html)

Voici quelques exemples.

## Voir l'aide de la commande

```bash
$ reobs ls --help

usage: reobs ls [-h] {site,stream,dependencies,base,info,input,output} ...

ReOBS ls subcommand. It is a utility to make discovery of config file easier

optional arguments:
  -h, --help            show this help message and exit

subcommands:
  valid subcommands :

  {site,stream,dependencies,base,info,input,output}
    site                List configured sites
    stream              List configured streams
    dependencies        List dependencies between streams
    base                List configured base sections
    info                Show configuration information for a site
    input               List existing input files for a stream
    output              List existing output files for one or all streams
```

## Voir les dépendances d'une filière

```bash
$ reobs ls dependencies  --site ccres_palaiseau --stream construct_final_2D \
    --format json \
    --config ~/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
{
  "ccres_palaiseau": {
    "cloudnet_categorize": [],
    "cloudnet_classification": [],
    "cloudnet_der": [],
    "cloudnet_disdrometer_raw": [],
    "cloudnet_disdrometer": [],
    "cloudnet_drizzle": [],
    "cloudnet_ier": [],
    "cloudnet_iwc": [],
    "cloudnet_doppler_lidar": [],
    "cloudnet_doppler_lidar_epsilon": [],
    "cloudnet_lwc": [],
    "cloudnet_meteo": [],
    "cloudnet_radar": [],
    "cloudnet_lidar": [],
    "cloudnet_doppler_lidar_wind": [],
    "cloudnet_mwr_multi": [],
    "cloudnet_mwr_single": [],
    "cloudnet_mwr_l1c": [],
    "construct_final_2D": [
      "cloudnet_categorize",
      "cloudnet_classification",
      "cloudnet_der",
      "cloudnet_disdrometer_raw",
      "cloudnet_disdrometer",
      "cloudnet_drizzle",
      "cloudnet_ier",
      "cloudnet_iwc",
      "cloudnet_doppler_lidar",
      "cloudnet_doppler_lidar_epsilon",
      "cloudnet_lwc",
      "cloudnet_meteo",
      "cloudnet_radar",
      "cloudnet_lidar",
      "cloudnet_doppler_lidar_wind",
      "cloudnet_mwr_multi",
      "cloudnet_mwr_single",
      "cloudnet_mwr_l1c"
    ]
  }
}
```

## Voir les fichiers originaux à traiter disponibles pour une filière donnée

```bash
# ICI POUR LA FILIERE cloudnet\_radar
$ reobs ls input --site ccres_galati --stream cloudnet_radar \
    --config ~/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
/scratchx/ccres/cloudnet/galati/2022/12/01/20221201_galati_rpg-fmcw-94.nc
/scratchx/ccres/cloudnet/galati/2022/12/02/20221202_galati_rpg-fmcw-94.nc
/scratchx/ccres/cloudnet/galati/2022/12/03/20221203_galati_rpg-fmcw-94.nc
/scratchx/ccres/cloudnet/galati/2022/12/04/20221204_galati_rpg-fmcw-94.nc
/scratchx/ccres/cloudnet/galati/2022/12/05/20221205_galati_rpg-fmcw-94.nc
/scratchx/ccres/cloudnet/galati/2022/12/06/20221206_galati_rpg-fmcw-94.nc
...
/scratchx/ccres/cloudnet/galati/2023/09/08/20230908_galati_rpg-fmcw-94_71dad3ea.nc
/scratchx/ccres/cloudnet/galati/2023/09/09/20230909_galati_rpg-fmcw-94_71dad3ea.nc
/scratchx/ccres/cloudnet/galati/2023/09/10/20230910_galati_rpg-fmcw-94_71dad3ea.nc
/scratchx/ccres/cloudnet/galati/2023/09/11/20230911_galati_rpg-fmcw-94_71dad3ea.nc
/scratchx/ccres/cloudnet/galati/2023/09/12/20230912_galati_rpg-fmcw-94_71dad3ea.nc
/scratchx/ccres/cloudnet/galati/2023/09/13/20230913_galati_rpg-fmcw-94_71dad3ea.nc
...
```

## Voir tous les fichiers intermédiaires pour la filière construct\_final\_2D

```bash
$ reobs ls input --config ~/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg --site ccres_galati --stream construct_final_2D
/homedata/ccres/ACTRIS/CCRES/pub/reobs/base/ccres_galati/products/monthly_ccres_v2026_09_1/treatments/cloudnet_categorize/cloudnet_categorize_v2026_09_1_20250601_000000_30d.nc
/homedata/ccres/ACTRIS/CCRES/pub/reobs/base/ccres_galati/products/monthly_ccres_v2026_09_1/treatments/cloudnet_categorize/cloudnet_categorize_v2026_09_1_20260801_000000_31d.nc
/homedata/ccres/ACTRIS/CCRES/pub/reobs/base/ccres_galati/products/monthly_ccres_v2026_09_1/treatments/cloudnet_categorize/cloudnet_categorize_v2026_09_1_20260701_000000_31d.nc
/homedata/ccres/ACTRIS/CCRES/pub/reobs/base/ccres_galati/products/monthly_ccres_v2026_09_1/treatments/cloudnet_categorize/cloudnet_categorize_v2026_09_1_20240201_000000_29d.n
...
```

## Voir toutes les bases de filières définies pour une station donnée

```bash
# STATION ccres_galati
$ reobs ls base --site ccres_galati \
    --config ~/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
ccres_galati:
    base_cloudnet_categorize
    base_cloudnet_categorize_reobs
    base_cloudnet_classification
    base_cloudnet_classification_reobs
    base_cloudnet_der
    base_cloudnet_der_reobs
    base_cloudnet_drizzle
    base_cloudnet_drizzle_reobs
    base_cloudnet_ier
    base_cloudnet_ier_reobs
    base_cloudnet_iwc
    base_cloudnet_iwc_reobs
    base_cloudnet_lidar
    base_cloudnet_lidar_079cdfce
    base_cloudnet_lidar_reobs
    base_cloudnet_lwc
    base_cloudnet_lwc_reobs
    base_cloudnet_mwr_multi
    base_cloudnet_mwr_multi_reobs
    base_cloudnet_mwr_l1c
    base_cloudnet_mwr_l1c_reobs
    base_cloudnet_mwr_single
    base_cloudnet_mwr_single_reobs
    base_cloudnet_mwr_single_ah
    base_cloudnet_mwr_single_ah_reobs
    base_cloudnet_radar
    base_cloudnet_radar_71dad3ea
    base_cloudnet_radar_reobs
    base_cloudnet_disdrometer
    base_cloudnet_disdrometer_reobs
    base_cloudnet_disdrometer_raw_reobs
    base_cloudnet_meteo
    base_cloudnet_meteo_reobs
    base_final_2D_reobs
```

## Voir les infos de traitement d'une station

```bash
# FORMAT json
$ reobs ls info --site ccres_mindelo --product-type monthly_ccres \
    --product-version v2026_09_1 --format json \
    --config ~/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
{
  "ccres_mindelo": {
    "site_id": "12",
    "code_dir": "/home/ccres/flux/ReOBS-CCRES/src/reobs/reobs/",
    "first_date": "20241201",
    "liste_filieres": "(cloudnet_categorize cloudnet_classification cloudnet_der cloudnet_drizzle cloudnet_ier cloudnet_iwc cloudnet_lwc cloudnet_lidar cloudnet_doppler_lidar cloudnet_doppler_lidar_wind cloudnet_doppler_lidar_epsilon cloudnet_mwr_multi cloudnet_mwr_l1c cloudnet_mwr_single cloudnet_mwr_single_ah cloudnet_radar cloudnet_disdrometer cloudnet_disdrometer_raw cloudnet_meteo cloudnet_raingauge construct_final_2D)",
    "config_version": "v0_4_0",
    "folder_output": "v0_4_0",
    "conf_site_dir": "/home/ccres/flux/ReOBS-CCRES/configs/treatments/sites/ccres_mindelo/",
    "reobs_dir": "/bdd/ACTRIS/CCRES/pub/reobs/base/ccres_mindelo/products/v0_4_0",
    "reobs_dir_treatments": "/bdd/ACTRIS/CCRES/pub/reobs/base/ccres_mindelo/products/v0_4_0/treatments"
  }
}
# FORMAT text
$ reobs ls info --site ccres_mindelo --product-type monthly_ccres \
   --product-version v2026_09_1 --format text \
   --config ~/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
ccres_mindelo:
    site_id: 12
    code_dir: /home/ccres/flux/ReOBS-CCRES/src/reobs/reobs/
    first_date: 20241201
    liste_filieres: (cloudnet_categorize cloudnet_classification cloudnet_der cloudnet_drizzle cloudnet_ier cloudnet_iwc cloudnet_lwc cloudnet_lidar cloudnet_doppler_lidar cloudnet_doppler_lidar_wind cloudnet_doppler_lidar_epsilon cloudnet_mwr_multi cloudnet_mwr_l1c cloudnet_mwr_single cloudnet_mwr_single_ah cloudnet_radar cloudnet_disdrometer cloudnet_disdrometer_raw cloudnet_meteo cloudnet_raingauge construct_final_2D)
    config_version: v0_4_0
    folder_output: v0_4_0
    conf_site_dir: /home/ccres/flux/ReOBS-CCRES/configs/treatments/sites/ccres_mindelo/
    reobs_dir: /bdd/ACTRIS/CCRES/pub/reobs/base/ccres_mindelo/products/v0_4_0
    reobs_dir_treatments: /bdd/ACTRIS/CCRES/pub/reobs/base/ccres_mindelo/products/v0_4_0/treatments
# SANS ARGUMENTS SUPPLEMENTAIRES
$ reobs ls info --config ~/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg --site ccres_palaiseau
ccres_palaiseau:
    site_id: 14
    code_dir: /home/ccres/flux/ReOBS-CCRES/src/reobs/reobs/
    first_date: 20230101
    liste_filieres: (cloudnet_categorize cloudnet_classification cloudnet_der cloudnet_drizzle cloudnet_ier cloudnet_iwc cloudnet_lwc cloudnet_lidar cloudnet_doppler_lidar cloudnet_doppler_lidar_wind cloudnet_mwr_l1c cloudnet_mwr_multi cloudnet_doppler_lidar_epsilon cloudnet_radar cloudnet_disdrometer cloudnet_disdrometer_raw cloudnet_meteo construct_final_2D)
    config_version: v0_4_0
    folder_output: *_*
    conf_site_dir: /home/ccres/flux/ReOBS-CCRES/configs/treatments/sites/ccres_palaiseau/
    reobs_dir: /bdd/ACTRIS/CCRES/pub/reobs/ccres_palaiseau/*
    reobs_dir_treatments: /homedata/ccres/ACTRIS/CCRES/pub/reobs/base/ccres_palaiseau/products/*_*/treatments
# AVEC ARGUMENTS --product-type monthly_ccres --product-version v2026_09_1
$ reobs ls info --config ~/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg --site ccres_palaiseau --product-type monthly_ccres --product-version v2026_09_1
ccres_palaiseau:
    site_id: 14
    code_dir: /home/ccres/flux/ReOBS-CCRES/src/reobs/reobs/
    first_date: 20230101
    liste_filieres: (cloudnet_categorize cloudnet_classification cloudnet_der cloudnet_drizzle cloudnet_ier cloudnet_iwc cloudnet_lwc cloudnet_lidar cloudnet_doppler_lidar cloudnet_doppler_lidar_wind cloudnet_mwr_l1c cloudnet_mwr_multi cloudnet_doppler_lidar_epsilon cloudnet_radar cloudnet_disdrometer cloudnet_disdrometer_raw cloudnet_meteo construct_final_2D)
    config_version: v0_4_0
    folder_output: monthly_ccres_v2026_09_1
    conf_site_dir: /home/ccres/flux/ReOBS-CCRES/configs/treatments/sites/ccres_palaiseau/
    reobs_dir: /bdd/ACTRIS/CCRES/pub/reobs/ccres_palaiseau/v2026_09_1
    reobs_dir_treatments: /homedata/ccres/ACTRIS/CCRES/pub/reobs/base/ccres_palaiseau/products/monthly_ccres_v2026_09_1/treatments
```

## Voir les fichiers finaux (construct\_final\_2D) d'une station

```bash
# STATION LINDENBERG
$ reobs ls output --site ccres_lindenberg --stream construct_final_2D \
    --format json \
    --config ~/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
[
  "/bdd/ACTRIS/CCRES/pub/reobs/ccres_lindenberg/v2026_09_1/final_2D/lindenberg_reobs_ccres_2D_v2026_09_1_20260901_000000_1M.nc",
  "/bdd/ACTRIS/CCRES/pub/reobs/ccres_lindenberg/v2026_09_1/final_2D/lindenberg_reobs_ccres_2D_v2026_09_1_20260301_000000_1M.nc",
  "/bdd/ACTRIS/CCRES/pub/reobs/ccres_lindenberg/v2026_09_1/final_2D/lindenberg_reobs_ccres_2D_v2026_09_1_20260101_000000_1M.nc",
  "/bdd/ACTRIS/CCRES/pub/reobs/ccres_lindenberg/v2026_09_1/final_2D/lindenberg_reobs_ccres_2D_v2026_09_1_20260601_000000_30d.nc",
  "/bdd/ACTRIS/CCRES/pub/reobs/ccres_lindenberg/v2026_09_1/final_2D/lindenberg_reobs_ccres_2D_v2026_09_1_20260201_000000_0M.nc",
  "/bdd/ACTRIS/CCRES/pub/reobs/ccres_lindenberg/v2026_09_1/final_2D/lindenberg_reobs_ccres_2D_v2026_09_1_20260701_000000_31d.nc",
  "/bdd/ACTRIS/CCRES/pub/reobs/ccres_lindenberg/v2026_09_1/final_2D/lindenberg_reobs_ccres_2D_v2026_09_1_20260401_000000_1M.nc",
  "/bdd/ACTRIS/CCRES/pub/reobs/ccres_lindenberg/v2026_09_1/final_2D/lindenberg_reobs_ccres_2D_v2026_09_1_20260801_000000_31d.nc",
  "/bdd/ACTRIS/CCRES/pub/reobs/ccres_lindenberg/v2026_09_1/final_2D/lindenberg_reobs_ccres_2D_v2026_09_1_20260501_000000_1M.nc"
]
```
