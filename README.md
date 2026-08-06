# [CCRES] ReOBS-CCRES-workflow mise en production ReObs (mise à jour)

## Liens:

- slides Jean-François : https://cloud.ipsl.fr/index.php/f/2633073
- Dépôt github reobs : https://github.com/ACTRIS-CCRES/ReOBS-CCRES/
- environnement python sur le compte ccres : stockés dans `/homedata/ccres/python_envs/`

## Résumé de notre discussion/actions

### @jean-françois

- [ ] Fournir les codes des graphiques à mettre à jour par la production `cylc`

### @lise/@christophe

- [x] Intégrer au ReObs "général" le code pour gérer le cas où des données sont manquantes

### @marc-Antoine

- [x] coder l'outil de téléchargement des données
- [x] Mettre à jour le dépôt ReObs-CCRES sur le compte ccres :
    git@github.com:ACTRIS-CCRES/ReOBS-CCRES.git
- [x] Mettre les données 2026/01 Lindenberg, Laquila et Palaiseau dans le
    dossier /scratchx/ccres

  - lindenberg: /scratchx/ccres/cloudnet/lindenberg/2026/01
  - palaiseau: /scratchx/ccres/cloudnet/palaiseau/2026/01
  - laquila: on a jamais téléchargé les données donc @jean-françois tu auras
      peut-être une configuration à faire ? moi ça me fera une station à
      tester pour le code de téléchargement

### @laurent

- [x] Voir le code Reobs et les chemins à changer dans les fichiers de configurations
- [x] Voir comment utiliser le code Reobs et les chemins à changer dans les
    fichiers de configurations
- [x] Voir les améliorations possibles de la production `cylc`
- [ ] Mettre la mise a jour des visualisations dans la production `cylc`
- [x] Voir avec Lise pour la recette pour mettre en place un env python pour Reobs
