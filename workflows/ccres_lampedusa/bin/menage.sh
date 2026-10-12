#!/bin/bash
# Standard error & standard output are merged in example.out
#PBS -j oe

# --product-version v2026.09.1  --product-type monthly_ccres
declare -a ccres_stations=( "bucharest" "cabauw" "cluj" "galati" "granada" "hyytiala" "juelich" "kenttarova" "lampedusa" "laquila" "limassol" "lindenberg" "maido" "marambio" "melpitz" "milesovka" "mindelo" "moufia" "munich" "palaiseau" "payerne" "potenza" "rzecin" "sonnblick" "uto" "villum" "warsaw" )

help()
{
    echo
    echo "Usage: $0 station YYYYMM product_type product_version flag_nettoyage"
    echo "station in ccres station knows"
    echo "yyyymm"
    echo
    echo "product_type de traitement (ex: monthly_ccres,...)"
    echo "product_version de traitement (ex: v2026_09_1,...)"
    echo "flag_nettoyage in y ou n"
    echo
    exit 129
}
set | grep "ENVIRONMENT=" >/dev/null
rc=$?
if [ $rc -eq 1 ]; then
# INTERACTIVE MODE
# VERIFY NUMBERS OF ARGUMENTS
  if [ $# -lt 5 ]; then
   help
  fi
# INTERACTIF
  station=$1
# TEST SI STATION CCRES CONNUE
  echo ${ccres_stations[@]} | grep -q ${station}
  rc=$?
  if [ $rc -eq 1 ]; then
    echo
    echo "Station inconnue '${station}' du script $0. ERROR fATAL ! 146"
    echo
    echo "Stations connues :"
    echo
    echo "${ccres_stations[@]} "
    echo
    exit 146
  fi
  YYYYMM=$2
# CALCUL DE YYYY
  date -d "${YYYYMM}01 2 month ago" +"%Y" >/dev/null
  rc=$?
# MAUVAIS YYYMM
  if [ $rc -ne 0 ]; then
    echo
    echo "MAUVAIS YYYYMM: $YYYYMM. ERROR fATAL ! 130"
    echo
    help
  else
    YYYY=$(date -d "${YYYYMM}01" +"%Y")
  fi
  product_type=$3
  product_version=$4
  nettoyage="$5"
else
# SPECIAL CYLC
    YYYYMM=$(date -d "today 2 month ago" +"%Y%m")
# CALCUL DE YYYY
    date -d "${YYYYMM}01 2 month ago" +"%Y" >/dev/null
    rc=$?
# MAUVAIS YYYMM
    if [ $rc -ne 0 ]; then
      echo
      echo "MAUVAIS YYYYMM: $YYYYMM. ERROR fATAL ! 131"
      echo
      help
    else
      YYYY=$(date -d "today 2 month ago" +"%Y")
    fi
fi # if [ $rc -eq 1 ]; then

#set -x
# FICHIER ORIGINAUX
#/scratchx/ccres/cloudnet/lampedusa/2025/01/17/20250117_lampedusa_classification.nc
# FICHIERS INTERMEDIAIRES
#/homedata/ccres/ACTRIS/CCRES/pub/reobs/base/ccres_lampedusa/products/monthly_ccres_v2026_09_1/treatments/cloudnet_meteo/cloudnet_meteo_v2026_09_1_20250101_000000_0y.nc
# CHANGER POUR S'ALIGNER SUR LE NOM DU REPERTOIRE CREE PAR LE SUPERVISEUR
product_version_net=$(echo $product_version | sed -e 's/\./_/g')
echo
echo "Faire ${YYYYMM} $product_type $product_version_net $nettoyage"
echo
# NETTOYAGE DES FICHIERS ORIGINAUX
find /scratchx/$USER/cloudnet/$station/$YYYY -type f -name "${YYYYMM}??_*.nc"  -exec echo /bin/rm {} \;
if [ $nettoyage = 'y' ]; then
  find /scratchx/$USER/cloudnet/$station/$YYYY -type f -name "${YYYYMM}??_*.nc"  -exec /bin/rm {} \;
fi
# NETTOYAGE DES FICHIERS FILIERES INTERMEDIAIRES
find /homedata/$USER/ACTRIS/CCRES/pub/reobs/base/ccres_${station}/products/${product_type}_${product_version_net}/treatments \
  -type f -name "*${product_version_net}_${YYYYMM}??_*.nc"  -exec echo /bin/rm {} \;
if [ $nettoyage = 'y' ]; then
  find /homedata/$USER/ACTRIS/CCRES/pub/reobs/base/ccres_${station}/products/${product_type}_${product_version_net}/treatments \
    -type f -name "*${product_version_net}_${YYYYMM}??_*.nc"  -exec /bin/rm {} \;
fi
