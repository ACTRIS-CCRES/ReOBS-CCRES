#!/bin/bash

# CONSTANTS
DOMAIN='lmd.ipsl.fr'
# LIST OF JOB WE NEED LOG
mel_tasks=( $1 )
listemail=lcrepeau@$DOMAIN
listemailsys=lcrepeau@$DOMAIN
ind=0
#
while [ $ind -lt ${#mel_tasks[@]} ]
do
  echo
  echo "FATAL eRROR ${mel_tasks[$ind]}"
  echo
  if [ -s $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]}/NN/job.err ]; then
    tail -n 10 $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]}/NN/job.err | \
      mailx -s "TR ${mel_tasks[$ind]} $CYLC_SUITE_NAME : $YESTERDAY ERROR" ${listemailsys} $listemail
  else
    echo
    echo "Bizarre pas de fichier d'erreur $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=0)/${mel_tasks[$ind]}/NN/job.err "
    echo
  fi
  let ind=ind+1
done
