# Station palaiseau

## Faire mensuelles

Au 20260729 il manque comme filieres :

* cloudnet\_doppler\_lidar\_wind
* cloudnet\_mwr\_multi
* cloudnet\_mwr\_l1c
* cloudnet\_mwr\_single
* cloudnet\_mwr\_single\_ah

Souvent il y a des fichiers à traiter.

Pas réussi à lancer cloudnet_lidar

Des fichiers sont présent :

* /scratchx/ccres/cloudnet/palaiseau/2026/01/15/20260115_palaiseau_chm15k_b14e15ec.nc
* /scratchx/ccres/cloudnet/palaiseau/2026/01/20/20260120_palaiseau_chm15k_b14e15ec.nc
* /scratchx/ccres/cloudnet/palaiseau/2026/01/10/20260110_palaiseau_chm15k_b14e15ec.nc
* /scratchx/ccres/cloudnet/palaiseau/2026/01/09/20260109_palaiseau_chm15k_b14e15ec.nc
* /scratchx/ccres/cloudnet/palaiseau/2026/01/17/20260117_palaiseau_chm15k_b14e15ec.nc
* /scratchx/ccres/cloudnet/palaiseau/2026/01/05/20260105_palaiseau_chm15k_b14e15ec.nc
* /scratchx/ccres/cloudnet/palaiseau/2026/01/29/20260129_palaiseau_chm15k_b14e15ec.nc
* /scratchx/ccres/cloudnet/palaiseau/2026/01/14/20260114_palaiseau_chm15k_b14e15ec.nc
* /scratchx/ccres/cloudnet/palaiseau/2026/01/25/20260125_palaiseau_chm15k_b14e15ec.nc
* /scratchx/ccres/cloudnet/palaiseau/2026/01/07/20260107_palaiseau_chm15k_b14e15ec.nc
* ...

mais :

* $> /home/ccres/flux/ReOBS-CCRES/src/reobs/reobs/cli/superviseur/superviseur.sh  -o init_catalog -d 20260101-20260131 -s ccres_palaiseau -f cloudnet_lidar -c /home/ccres/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
2026-07-29 16:03:46 : Initialisation du catalogue des fichiers d'entree '%Y%m%d_palaiseau_chm15k.nc' du traitement 'Lecture des fichiers cloudnet lidar' de la filiere cloudnet_lidar
2026-07-29 16:03:46 : Mise a jour du catalogue des fichiers d'entree '%Y%m%d_palaiseau_chm15k.nc' du traitement 'Lecture des fichiers cloudnet lidar' de la filiere 'cloudnet_lidar'. Veuillez patienter ...
2026-07-29 16:03:48 : Pas de fichiers '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]_palaiseau_chm15k.nc' trouves dans '/scratchx/ccres/cloudnet/palaiseau/%Y/%m/%d'
(/homedata/ccres/python_envs/reobs) ccres@spiritx2:~/flux/ReOBS-CCRES/workflows/ccres_mensuelle$ 2026-07-29 16:03:48 : Fin de la filiere 'cloudnet_lidar' du site 'ccres_palaiseau'. Execution en 3 secondes.

* $> /home/ccres/flux/ReOBS-CCRES/src/reobs/reobs/cli/superviseur/superviseur.sh  -o init_catalog -d 20260101-20260131 -s ccres_palaiseau -f cloudnet_lidar_b14e15ec -c /home/ccres/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
2026-07-29 16:09:38 : La filiere 'cloudnet_lidar_b14e15ec' n'est pas repertoriee pour le site 'ccres_palaiseau'

Pas réussi à faire cloudnet_doppler_lidar_wind

Il y a des fichiers :

/scratchx/ccres/cloudnet/palaiseau/2026/01/15/20260115_palaiseau_wls400s-wind_455010e1.nc
/scratchx/ccres/cloudnet/palaiseau/2026/01/20/20260120_palaiseau_wls400s-wind_455010e1.nc
/scratchx/ccres/cloudnet/palaiseau/2026/01/10/20260110_palaiseau_wls400s-wind_455010e1.nc
/scratchx/ccres/cloudnet/palaiseau/2026/01/09/20260109_palaiseau_wls400s-wind_455010e1.nc
/scratchx/ccres/cloudnet/palaiseau/2026/01/17/20260117_palaiseau_wls400s-wind_455010e1.nc

mais

* $> /home/ccres/flux/ReOBS-CCRES/src/reobs/reobs/cli/superviseur/superviseur.sh  -o init_catalog -d 20260101-20260131 -s ccres_palaiseau -f cloudnet_doppler_lidar_wind -c /home/ccres/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
2026-07-29 16:26:38 : La filiere 'cloudnet_doppler_lidar_wind' n'est pas repertoriee pour le site 'ccres_palaiseau'
(/homedata/ccres/python_envs/reobs) ccres@spiritx2:~/flux/ReOBS-CCRES/workflows/ccres_mensuelle$ 2026-07-29 16:26:38 : Fin de la filiere 'cloudnet_doppler_lidar_wind' du site 'ccres_palaiseau'. Execution en 0 secondes

pourquoi pour le même job on a autant de différence d'utilisation mémoire

======================================================
Job ID: 8914365
Cluster: spiritx
User/Group: ccres/sirta
Job Name: cloudnet_doppler_lidar_ccres_palaiseau.20260729T1230Z.workflows/ccres_mensuelle
Running partition: zen4 on spiritx64-3
Started : 2026/07/29-14:40:29
State: FAILED (exit code 0)
Cores: 1
CPU Utilized: 00:01:47
CPU Efficiency: 65.24% of 00:02:44 core-walltime
Asked time         : 01:00:00
Job Wall-clock time: 00:02:44
Memory Utilized: 3.60 GB
Memory Efficiency: 105.31% of 3.42 GB

et

======================================================
Job ID: 8915037
Cluster: spiritx
User/Group: ccres/sirta
Job Name: cloudnet_doppler_lidar_ccres_palaiseau.20260729T1433Z.workflows/ccres_mensuelle
Running partition: zen4 on spiritx96-2
Started : 2026/07/29-16:33:27
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:01:26
CPU Efficiency: 70.49% of 00:02:02 core-walltime
Asked time         : 01:00:00
Job Wall-clock time: 00:02:02
Memory Utilized: 1.64 GB
Memory Efficiency: 47.86% of 3.42 G
