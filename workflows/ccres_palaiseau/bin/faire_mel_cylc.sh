#!/bin/bash
if [[ "$#" -lt 1 ]]; then
  echo
  echo "Usage : faire_mel_cylc.sh indice des taches"
  echo "Exemple : faire_mel_cylc.sh  1 2 5 6 8 9"
  echo " 0 =< Indice tache <= 18"
  echo "Wrong nomber of args; FATAL eRROR ! 99"
  echo
  exit 99
fi
#
# SEND OUTPUT AND ERROR JOB Cylc to $USER@$DOMAIN
#
# CONSTANT
DOMAIN='lmd.ipsl.fr'
# LIST OF JOB WE NEED LOG
mel_tasks=( 'nrt_ch4' 'nrt_co2' 'faire_l1d_correc_antenna_cron'
	    'obr_Inddn0_m565' 'obr_Inddn0_m8461' 'obr_Inddn1_m565' 'obr_Inddn1_m8461'
	    'faire_colloc_iasi_amsua_l1d_cron_Inddn0_m565' 'faire_colloc_iasi_amsua_l1d_cron_Inddn0_m8461'
	    'faire_colloc_iasi_amsua_l1d_cron_Inddn1_m565' 'faire_colloc_iasi_amsua_l1d_cron_Inddn1_m8461'
	    'faire_add_ts_iasi_amsua_l1d_cron_Inddn0' 'faire_add_ts_iasi_amsua_l1d_cron_Inddn1'
	    'echec_tache1' 'echec_tache2' 'echec_tache3' 'echec_tache4' 'echec_tache5' 'echec_tache6' 'influxdb' 'echec_tache7' )
#echo "${#mel_tasks[@]}"
version=( '10.1' '10.1' )
listemail="cyril.crevoisier@lmd.ipsl.fr,nicolas.meilhac@lmd.ipsl.fr"
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
#CYLC_SUITE_NAME="chaque_jour/Iasib_dd-1_suicides"
#export CYLC_TASK_CYCLE_POINT=$(date -d "today" +"%Y%m%dT0732Z")
# END FOR TESTS
YESTERDAY=$(cylc cycle-point --offset-day=-1 $(date -d "today" +"%Y-%m-%d") --template=CCYY/MM/DD)
#ind=0
#while [ $ind -lt ${#mel_tasks[@]} ]
for ind in "$@"
do
  # -1 < INDICE TACHE  A TRAITER < 19
  if [ $ind -lt ${#mel_tasks[@]} ]; then
    if [ -d $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]} ]; then
  # PROD NORMALE 'nrt_ch4' 'nrt_co2'
      if [[ $ind -eq 0 || $ind -eq 1 ]]; then
        cat -vte $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]}/NN/job.out | \
          mailx -s "TR ${mel_tasks[$ind]} ${version[$ind]} $CYLC_SUITE_NAME ${mel_tasks[$ind]} : $YESTERDAY SUCCESS" ${listemailsys},$listemail
  # PROD ERROR
        if [ -s $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]}/NN/job.err ]; then
          cat -vte $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]}/NN/job.err | \
            mailx -s "TR ${mel_tasks[$ind]} ${version[$ind]} $CYLC_SUITE_NAME ${mel_tasks[$ind]} : $YESTERDAY ERROR" ${listemailsys},$listemail
          echo "mail ${mel_tasks[$ind]} done"
        fi
      else
  # PROD NORMALE autres taches
  #     cat -vte $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]}/NN/job.out | \
  #       mailx -s "TR ${mel_tasks[$ind]} $CYLC_SUITE_NAME step ${mel_tasks[$ind]} : $YESTERDAY SUCCESS" ${listemailsys}
  # PROD ERROR
        if [ -s $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]}/NN/job.err ]; then
          cat -vte $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]}/NN/job.err | \
            mailx -s "TR ${mel_tasks[$ind]} $CYLC_SUITE_NAME step ${mel_tasks[$ind]} : $YESTERDAY ERROR" ${listemailsys}
          echo "mail ${mel_tasks[$ind]} done"
        fi
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
