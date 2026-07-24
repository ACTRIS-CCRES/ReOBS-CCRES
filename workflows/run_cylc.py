import os
import sys
import subprocess
import click

REOBS_DIR = os.path.abspath("/home/ccres/flux/ReOBS-CCRES/src/reobs")


# cd reobs/configs/workflows/sirta_1D
# export REOBS_CONFIG_FILE=/home/reobs/reobs/configs/treatments/superviseur.dev.cfg
# export REOBS_BASE_DIR=/home/reobs/reobs/
# export REOBS_CONDA_ENV=reobs
# export REOBS_PROD=1
# export REOBS_DATE=yyyymmdd-yyyymmdd
# export HDF5_USE_FILE_LOCKING=FALSE (parfois pour les fichiers Heatflux L2A et ne pas bloquer la lecture...)
# cylc install .
# cylc play sirta_1D
# cylc tui sirta_1D

click.command()
click.argument("-superviseur", "--su", default="superviseur.dev.cfg")
click.argument("-site", "--site", required=True)
click.argument("date_start", type=click.DateTime(formats=["%Y%m%d"]))
click.argument("date_end", type=click.DateTime(formats=["%Y%m%d"]))
def run_cylc(superviseur, site, date_start, date_end):
    ""
    
    return 0


if __name__ == "__main__":
    sys.exit(run_cylc())
