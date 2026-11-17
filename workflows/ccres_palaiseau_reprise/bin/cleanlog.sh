#!/bin/bash

#on efface le rep du jour precedent s'il existe
echo "Test du repertoire : $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=-4)";
if [ -d "$HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=-4)" ];then
  echo "Suppression du repertoire : ";
  echo "rm -rf $HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=-4)"
  /bin/rm -rf "$HOME/cylc-run/$CYLC_SUITE_NAME/log/job/$(cylc cycle-point --offset-days=-4)"
else
  echo "Pas de repertoire a effacer"
fi

if [ -d "$HOME/cylc-run/$CYLC_SUITE_NAME/work/$(cylc cycle-point --offset-days=-4)" ];then
  echo "Suppression du repertoire : ";
  echo "rm -rf $HOME/cylc-run/$CYLC_SUITE_NAME/work/$(cylc cycle-point --offset-days=-4)"
  /bin/rm -rf "$HOME/cylc-run/$CYLC_SUITE_NAME/work/$(cylc cycle-point --offset-days=-4)"
else
  echo "Pas de repertoire a effacer"
fi
