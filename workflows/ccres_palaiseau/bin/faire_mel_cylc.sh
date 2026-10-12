#!/bin/bash
#
# SEND OUTPUT AND ERROR JOB Cylc to $USER@$DOMAIN
#
# CONSTANT
DOMAIN='lmd.ipsl.fr'
# LIST OF JOB WE NEED LOG
mel_tasks=( 'verif_scp_climserv_analyse_dd-1' 'faire_colloc_iasi_amsua_l1d_cron_Inddn0' 'faire_colloc_iasi_amsua_l1d_cron_Inddn1'
	    'ajout_drap_nuageux_analyse_Inddn0_Iasic' 'ajout_drap_nuageux_analyse_Inddn1_Iasic'
	    'colloc_pts_clairs_analyse_Inddn0_Indsl0_Iasic' 'colloc_pts_clairs_analyse_Inddn0_Indsl1_Iasic'
	    'colloc_pts_clairs_analyse_Inddn1_Indsl0_Iasic' 'colloc_pts_clairs_analyse_Inddn1_Indsl1_Iasic'
	    'stransac_Inddn0_Indsl0_Iasic' 'stransac_Inddn0_Indsl1_Iasic' 'stransac_Inddn1_Indsl0_Iasic' 'stransac_Inddn1_Indsl1_Iasic'
	    '4AOP_Inddn0_Indsl0_Iasic' '4AOP_Inddn0_Indsl1_Iasic' '4AOP_Inddn1_Indsl0_Iasic' '4AOP_Inddn1_Indsl1_Iasic'
	    'calcul_residus_Inddn0_Indsl0_Iasic' 'calcul_residus_Inddn0_Indsl1_Iasic'
	    'calcul_residus_Inddn1_Indsl0_Iasic' 'calcul_residus_Inddn1_Indsl1_Iasic' 'menage'
	    'echec_tache1' 'echec_tache2' 'echec_tache3' 'echec_tache4' 'echec_tache5' 'echec_tache6' 'echec_tache7' 'echec_tache8' 'influxdb' 'echec_tache9')
#echo "${#mel_tasks[@]}"
max_errors=${#mel_tasks[@]}
let max_errors=max_errors-1
#
if [[ "$#" -lt 1 ]]; then
  echo
  echo "Usage : faire_mel_cylc.sh indice des taches"
  echo "Exemple : faire_mel_cylc.sh 1 2 5 6 8 9"
  echo " 0 =< Indice tache <= $max_errors"
  echo "Wrong nomber of args; FATAL eRROR ! 99"
  echo
  exit 99
fi
listemailsys=lcrepeau@$DOMAIN
# VACANCES listemailsys="lcrepeau@$DOMAIN lmiladi@ipsl.fr"
# END CONSTANTS
# FOR TESTS
# NAME SUIT FOR TEST OR INTERACTIF
#CYLC_SUITE_NAME="Iasic_dd-1"
# NEED A REFERENCE DATE TO USE OF cylc cycle-point FOR TEST
#export CYLC_TASK_CYCLE_POINT=$(date -d "today" +"%Y%m%dT0832+02")
# for arg in "$@"; do
#   echo $arg
# done
#CYLC_SUITE_NAME="chaque_jour/Iasib_dd-2"
#export CYLC_TASK_CYCLE_POINT=$(date -d "today" +"%Y%m%dT0915Z")
# END FOR TESTS
YESTERDAY=$(cylc cycle-point --offset-day=-1 $(date -d "today" +"%Y-%m-%d") --template=CCYY/MM/DD)
#ind=0
#while [ $ind -lt ${#mel_tasks[@]} ]
#set -x
for ind in "$@"
do
  # -1 < INDICE TACHE  A TRAITER < 19
  if [ $ind -lt ${#mel_tasks[@]} ]; then
    if [ -d $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]} ]; then
  # PROD NORMALE autres taches
  #     cat -vte $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]}/NN/job.out | \
  #       mailx -s "TR ${mel_tasks[$ind]} $CYLC_SUITE_NAME step ${mel_tasks[$ind]} : $YESTERDAY SUCCESS" ${listemailsys}
  # PROD ERROR
      if [[ -s $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]}/NN/job.err && $ind != 21 ]]; then
         cat -vte $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]}/NN/job.err | \
           mailx -s "TR ${mel_tasks[$ind]} $CYLC_SUITE_NAME step ${mel_tasks[$ind]} : $YESTERDAY ERROR" ${listemailsys}
         echo "mail ${mel_tasks[$ind]} done"
      fi
    fi
  else
    echo
    echo "NO FATAL eRROR : $ind ! " | \
      mailx -s "TR ${mel_tasks[$ind]} $CYLC_SUITE_NAME step ${mel_tasks[$ind]} : $YESTERDAY END SUCCESS" ${listemailsys}
    echo "mail ${mel_tasks[$ind]} done"
  fi
  let ind=ind+1
done
