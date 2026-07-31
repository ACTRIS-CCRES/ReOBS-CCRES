
# Sur le mésocentre

## Première installation

### Récupération des sources

Deux méthodes sont possibles pour récupérer les sources de ReOBS.

#### Installation classique

Clonez directement le dépôt :

```bash
$> git clone git@gitlab.in2p3.fr:ipsl/espri/espri-obs/reobs/v3/reobs.git
$> cd reobs
```

#### Installation en tant que sous-module Git

Si ReOBS doit être intégré à un autre projet, il peut être ajouté comme sous-module Git :

```bash
$> git submodule add git@gitlab.in2p3.fr:ipsl/espri/espri-obs/reobs/v3/reobs.git src/reobs
```

Si le sous-module est déjà déclaré dans le fichier `.gitmodules`

```bash
# PAR EXEMPLE
$> cat .gitmodules
[submodule "src/reobs"]
    path = src/reobs
    url = git@gitlab.in2p3.fr:ipsl/espri/espri-obs/reobs/v3/reobs.git
```

(par exemple après le clonage d'un projet existant), il suffit de l'initialiser et de le récupérer :

```bash
$> git submodule update --init
```

Pour récupérer également les éventuels sous-modules imbriqués :

```bash
$> git submodule update --init --recursive
```

### Création de l'environnement Conda

Chargez les modules du mésocentre, puis créez et activez l'environnement :

```bash
$> module load pangeo-meso/2024.01.22

$> conda env create --file requirements/environment-prod.yml
$> conda activate reobs
```

## A chaque utilisation

Avant chaque lancement de reobs il faudra faire :

```bash
$> module load anaconda-meso/2023
$> conda activate /homedata/ccres/python_envs/reobs
```

Et pour vérifier que l'environnement est bien activé :

```bash
$> which python
$> python -c "import sys; print(sys.executable)"
```

:::{admonition} Aide
:class: hint
Pour faciliter le lancement sur le mésocentre il est possible d'ajouter un alias dans le `.zshrc` ou le `.bashrc` permettant de l'activer plus rapidement :

```bash
# AJOUTER DANS ~/.zshrc OU ~/.bashrc
alias activ_reobs='module load anaconda-meso/2023 && conda activate reobs'
```

## Commande pour installer reobs

```bash
$> cd ~/flux/ReOBS-CCRES/src/reobs
# INSTALLER LE PROGRAMME reobs
$> pip install .
# VERIFIER
$> reobs -h
usage: reobs [-h] {ls,template,run} ...

ReObs CLI (Command Line Interface)

optional arguments:
  -h, --help         show this help message and exit

subcommands:
  valid subcommands :

  {ls,template,run}
    ls               ls subcommand
    template         template subcommand
    run              run subcommand
```

## Vérifier avant de lancer

Le programme reobs fonctionnent avec des dizaines de fichiers toml où il faut
    vérifier les bons chemins des fichiers de conf ou du programme principal
    dans `configs/treatments/superviseur.dev.cfg` car c'est le fichier qui est
    utilisé dans les fichiers `flow.cylc` de cylc

## Commande pour tester reobs A TRAVERS superviseur.sh

Commande typique lance par cylc

```bash
# COMMANDE superviseur.sh mensuel cylc
$> /home/ccres/flux/ReOBS-CCRES/src/reobs/reobs/cli/superviseur/superviseur.sh  -d 20260101-20260131 -s ccres_palaiseau -f cloudnet_der -c /home/ccres/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
(/homedata/ccres/python_envs/reobs) ccres@spiritx1:~/flux/ReOBS-CCRES$ /home/ccres/flux/ReOBS-CCRES/src/reobs/reobs/cli/superviseur/superviseur.sh  -d 20260101-20260131 -s ccres_palaiseau -f cloudnet_der -c /home/ccres/flux/ReOBS-CCRES/configs/treatments/superviseur.dev.cfg
2026-07-22 18:43:28 : Initialisation du catalogue des fichiers d'entree '%Y%m%d_palaiseau_der.nc' du traitement 'Lecture des fichiers cloudnet der' de la filiere cloudnet_der
2026-07-22 18:43:28 : Mise a jour du catalogue des fichiers d'entree '%Y%m%d_palaiseau_der.nc' du traitement 'Lecture des fichiers cloudnet der' de la filiere 'cloudnet_der'. Veuillez patienter ...
2026-07-22 18:43:34 : Lancement de la filiere 'cloudnet_der' (Lecture des fichiers cloudnet der) du site 'ccres_palaiseau' du 20260101 au 20260115
2026-07-22 18:43:57 : INFO data_stream [pid:304016] Classic data stream
2026-07-22 18:43:57 : INFO data_stream [pid:304016] Parse arguments from command line.
2026-07-22 18:43:57 : INFO data_stream [pid:304016] Parse configuration file
2026-07-22 18:43:57 : INFO data_stream [pid:304016] Validate all configuration attributes
2026-07-22 18:43:57 : INFO data_stream [pid:304016] Run classic data stream from 2026-01-01T00:00:00 to 2026-01-16T00:00:00
2026-07-22 18:43:57 : INFO data_stream [pid:304016] Read files (section : read)
2026-07-22 18:43:57 : INFO reobs.core.read [pid:304016] Using following reader : NetCDFReader
2026-07-22 18:43:57 : INFO reobs.core.readers.netcdf [pid:304016] Reading 16 files ...
2026-07-22 18:43:57 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/01/20260101_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/02/20260102_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/03/20260103_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/04/20260104_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/05/20260105_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/06/20260106_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/07/20260107_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/08/20260108_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/09/20260109_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/10/20260110_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/11/20260111_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/12/20260112_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/13/20260113_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/14/20260114_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/15/20260115_palaiseau_der.nc
2026-07-22 18:43:58 : DEBUG reobs.core.readers.netcdf [pid:304016] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/16/20260116_palaiseau_der.nc
2026-07-22 18:44:01 : INFO data_stream [pid:304016] Check variables (section : check)
2026-07-22 18:44:01 : INFO reobs.core.checkers.checkers [pid:304016] Running check from flags
2026-07-22 18:44:02 : INFO data_stream [pid:304016] Synthetize (section : treat)
2026-07-22 18:44:02 : INFO reobs.core.treaters.treat_ND [pid:304016] Do box computations
2026-07-22 18:44:02 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Dimensions computation :
2026-07-22 18:44:02 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Compute n_scaled (1/6)
2026-07-22 18:44:02 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:44:05 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Compute der (2/6)
2026-07-22 18:44:05 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:44:07 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Compute der_scaled (3/6)
2026-07-22 18:44:07 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:44:10 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Compute der_error (4/6)
2026-07-22 18:44:10 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:44:12 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Compute der_scaled_error (5/6)
2026-07-22 18:44:12 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:44:15 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Compute der_retrieval_status (6/6)
2026-07-22 18:44:15 : DEBUG reobs.core.treaters.treat_ND [pid:304016] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>, <class 'reobs.core.treaters.methods.FirstMostFrequent'>, <class 'reobs.core.treaters.methods.FirstMostFrequentPercent'>, <class 'reobs.core.treaters.methods.SecondMostFrequent'>, <class 'reobs.core.treaters.methods.SecondMostFrequentPercent'>]
2026-07-22 18:44:28 : INFO data_stream [pid:304016] Write file (section : write)
2026-07-22 18:44:28 : INFO reobs.core.writers.writers [pid:304016] Rename variables.
2026-07-22 18:44:30 : DEBUG git.cmd [pid:304016] Popen(['git', 'version'], cwd=/home/ccres/flux/ReOBS-CCRES, stdin=None, shell=False, universal_newlines=False)
2026-07-22 18:44:30 : DEBUG git.cmd [pid:304016] Popen(['git', 'version'], cwd=/home/ccres/flux/ReOBS-CCRES, stdin=None, shell=False, universal_newlines=False)
2026-07-22 18:44:30 : DEBUG git.util [pid:304016] Failed checking if running in CYGWIN due to: FileNotFoundError(2, 'No such file or directory')
2026-07-22 18:44:30 : INFO data_stream [pid:304016] File written in /scratchx/ccres/reobs_prod/superviseur/tmp/cloudnet_der.Wu8Uh/cloudnet_der_v0_4_0_%Y%m%d_%H%M%S_%L.nc.yrcI7)
2026-07-22 18:44:30 : INFO data_stream [pid:304016] Elapsed time : 0 days 00:00:33
2026-07-22 18:44:31 : Lancement de la filiere 'cloudnet_der' (Lecture des fichiers cloudnet der) du site 'ccres_palaiseau' du 20260116 au 20260130
2026-07-22 18:44:32 : INFO data_stream [pid:306462] Classic data stream
2026-07-22 18:44:32 : INFO data_stream [pid:306462] Parse arguments from command line.
2026-07-22 18:44:32 : INFO data_stream [pid:306462] Parse configuration file
2026-07-22 18:44:32 : INFO data_stream [pid:306462] Validate all configuration attributes
2026-07-22 18:44:32 : INFO data_stream [pid:306462] Run classic data stream from 2026-01-16T00:00:00 to 2026-01-31T00:00:00
2026-07-22 18:44:32 : INFO data_stream [pid:306462] Read files (section : read)
2026-07-22 18:44:32 : INFO reobs.core.read [pid:306462] Using following reader : NetCDFReader
2026-07-22 18:44:32 : INFO reobs.core.readers.netcdf [pid:306462] Reading 17 files ...
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/15/20260115_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/16/20260116_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/17/20260117_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/18/20260118_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/19/20260119_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/20/20260120_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/21/20260121_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/22/20260122_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/23/20260123_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/24/20260124_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/25/20260125_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/26/20260126_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/27/20260127_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/28/20260128_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/29/20260129_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/30/20260130_palaiseau_der.nc
2026-07-22 18:44:32 : DEBUG reobs.core.readers.netcdf [pid:306462] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/31/20260131_palaiseau_der.nc
2026-07-22 18:44:35 : INFO data_stream [pid:306462] Check variables (section : check)
2026-07-22 18:44:35 : INFO reobs.core.checkers.checkers [pid:306462] Running check from flags
2026-07-22 18:44:36 : INFO data_stream [pid:306462] Synthetize (section : treat)
2026-07-22 18:44:36 : INFO reobs.core.treaters.treat_ND [pid:306462] Do box computations
2026-07-22 18:44:36 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Dimensions computation :
2026-07-22 18:44:36 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Compute n_scaled (1/6)
2026-07-22 18:44:36 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:44:40 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Compute der (2/6)
2026-07-22 18:44:40 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:44:42 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Compute der_scaled (3/6)
2026-07-22 18:44:42 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:44:45 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Compute der_error (4/6)
2026-07-22 18:44:45 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:44:48 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Compute der_scaled_error (5/6)
2026-07-22 18:44:48 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:44:50 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Compute der_retrieval_status (6/6)
2026-07-22 18:44:50 : DEBUG reobs.core.treaters.treat_ND [pid:306462] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>, <class 'reobs.core.treaters.methods.FirstMostFrequent'>, <class 'reobs.core.treaters.methods.FirstMostFrequentPercent'>, <class 'reobs.core.treaters.methods.SecondMostFrequent'>, <class 'reobs.core.treaters.methods.SecondMostFrequentPercent'>]
2026-07-22 18:45:05 : INFO data_stream [pid:306462] Write file (section : write)
2026-07-22 18:45:05 : INFO reobs.core.writers.writers [pid:306462] Rename variables.
2026-07-22 18:45:05 : DEBUG git.cmd [pid:306462] Popen(['git', 'version'], cwd=/home/ccres/flux/ReOBS-CCRES, stdin=None, shell=False, universal_newlines=False)
2026-07-22 18:45:05 : DEBUG git.cmd [pid:306462] Popen(['git', 'version'], cwd=/home/ccres/flux/ReOBS-CCRES, stdin=None, shell=False, universal_newlines=False)
2026-07-22 18:45:05 : DEBUG git.util [pid:306462] Failed checking if running in CYGWIN due to: FileNotFoundError(2, 'No such file or directory')
2026-07-22 18:45:06 : INFO data_stream [pid:306462] File written in /scratchx/ccres/reobs_prod/superviseur/tmp/cloudnet_der.Wu8Uh/cloudnet_der_v0_4_0_%Y%m%d_%H%M%S_%L.nc.af5VQ)
2026-07-22 18:45:06 : INFO data_stream [pid:306462] Elapsed time : 0 days 00:00:33
2026-07-22 18:45:06 : Lancement de la filiere 'cloudnet_der' (Lecture des fichiers cloudnet der) du site 'ccres_palaiseau' du 20260131 au 20260131
2026-07-22 18:45:07 : INFO data_stream [pid:311129] Classic data stream
2026-07-22 18:45:07 : INFO data_stream [pid:311129] Parse arguments from command line.
2026-07-22 18:45:07 : INFO data_stream [pid:311129] Parse configuration file
2026-07-22 18:45:07 : INFO data_stream [pid:311129] Validate all configuration attributes
2026-07-22 18:45:07 : INFO data_stream [pid:311129] Run classic data stream from 2026-01-31T00:00:00 to 2026-02-01T00:00:00
2026-07-22 18:45:07 : INFO data_stream [pid:311129] Read files (section : read)
2026-07-22 18:45:07 : INFO reobs.core.read [pid:311129] Using following reader : NetCDFReader
2026-07-22 18:45:07 : INFO reobs.core.readers.netcdf [pid:311129] Reading 2 files ...
2026-07-22 18:45:07 : DEBUG reobs.core.readers.netcdf [pid:311129] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/30/20260130_palaiseau_der.nc
2026-07-22 18:45:07 : DEBUG reobs.core.readers.netcdf [pid:311129] Read /scratchx/ccres/cloudnet/palaiseau/2026/01/31/20260131_palaiseau_der.nc
2026-07-22 18:45:07 : INFO data_stream [pid:311129] Check variables (section : check)
2026-07-22 18:45:07 : INFO reobs.core.checkers.checkers [pid:311129] Running check from flags
2026-07-22 18:45:07 : INFO data_stream [pid:311129] Synthetize (section : treat)
2026-07-22 18:45:07 : INFO reobs.core.treaters.treat_ND [pid:311129] Do box computations
2026-07-22 18:45:07 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Dimensions computation :
2026-07-22 18:45:07 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Compute n_scaled (1/6)
2026-07-22 18:45:07 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:45:08 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Compute der (2/6)
2026-07-22 18:45:08 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:45:08 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Compute der_scaled (3/6)
2026-07-22 18:45:08 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:45:09 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Compute der_error (4/6)
2026-07-22 18:45:09 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:45:09 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Compute der_scaled_error (5/6)
2026-07-22 18:45:09 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>]
2026-07-22 18:45:09 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Compute der_retrieval_status (6/6)
2026-07-22 18:45:09 : DEBUG reobs.core.treaters.treat_ND [pid:311129] Compute [<class 'reobs.core.treaters.methods.NanMean'>, <class 'reobs.core.treaters.methods.NanStandardDeviation'>, <class 'reobs.core.treaters.methods.NanMedian'>, <class 'reobs.core.treaters.methods.NanMin'>, <class 'reobs.core.treaters.methods.NanMax'>, <class 'reobs.core.treaters.methods.Number'>, <class 'reobs.core.treaters.methods.NanSum'>, <class 'reobs.core.treaters.methods.NanQuantile25'>, <class 'reobs.core.treaters.methods.NanQuantile75'>, <class 'reobs.core.treaters.methods.FirstMostFrequent'>, <class 'reobs.core.treaters.methods.FirstMostFrequentPercent'>, <class 'reobs.core.treaters.methods.SecondMostFrequent'>, <class 'reobs.core.treaters.methods.SecondMostFrequentPercent'>]
2026-07-22 18:45:11 : INFO data_stream [pid:311129] Write file (section : write)
2026-07-22 18:45:11 : INFO reobs.core.writers.writers [pid:311129] Rename variables.
2026-07-22 18:45:11 : DEBUG git.cmd [pid:311129] Popen(['git', 'version'], cwd=/home/ccres/flux/ReOBS-CCRES, stdin=None, shell=False, universal_newlines=False)
2026-07-22 18:45:11 : DEBUG git.cmd [pid:311129] Popen(['git', 'version'], cwd=/home/ccres/flux/ReOBS-CCRES, stdin=None, shell=False, universal_newlines=False)
2026-07-22 18:45:11 : DEBUG git.util [pid:311129] Failed checking if running in CYGWIN due to: FileNotFoundError(2, 'No such file or directory')
2026-07-22 18:45:11 : INFO data_stream [pid:311129] File written in /scratchx/ccres/reobs_prod/superviseur/tmp/cloudnet_der.Wu8Uh/cloudnet_der_v0_4_0_%Y%m%d_%H%M%S_%L.nc.p5Vho)
2026-07-22 18:45:11 : INFO data_stream [pid:311129] Elapsed time : 0 days 00:00:04
2026-07-22 18:45:12 : Concatenation des donnees de sortie
2026-07-22 18:45:17 : Sauvegarde du fichier '/bdd/REOBS/base/ccres_palaiseau/products/v0_4_0/treatments/cloudnet_der/cloudnet_der_v0_4_0_20260101_000000_0y.nc'
2026-07-22 18:45:17 : mv: cannot create regular file '/bdd/REOBS/base/ccres_palaiseau/products/v0_4_0/treatments/cloudnet_der/cloudnet_der_v0_4_0_20260101_000000_0y.nc': Permission denied
(/homedata/ccres/python_envs/reobs) ccres@spiritx1:~/flux/ReOBS-CCRES$ 2026-07-22 18:45:17 : Fin de la filiere 'cloudnet_der' du site 'ccres_palaiseau'. Execution en 110 secondes.
```

## GRAPH FLUX mensuel

Chaque mois :

* Calculer la date  de fin de début de mois et de fin de mois dans flow.cylc
* Regarder dans les fichiers quotidiens les instruments qu'il y a et rentre la liste dans un fichier params.
* Ce fichier params sera lu par flow.cylc et le graphe des tâches pourra être fait a la volée ?
* Que faire lorsqu'un instrument n'est pas configuré ?
* Si un instrument plante comment prévenir l'administrateur(s) & lancement  Sequentiel et étiquette fail  par instrument ?
* Vérifier si les ressources cylc sont bien calibrées.
* Vérifier que les calculs partent bien sur le cluster.
* Faire un mkdir -p /bdd/ACTRIS/CCRES/pub/reobs/base/ccres_bucharest/products/$version

lancement => telechargement\_cloudnet => instrument1 & instrument2 & instrument3 => contruction\_2d\_nc
