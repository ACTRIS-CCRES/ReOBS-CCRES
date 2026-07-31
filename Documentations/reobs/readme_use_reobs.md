# Interface en ligne de commande (CLI)

ReOBS fournit une interface en ligne de commande (`reobs`) permettant d'explorer les configurations existantes, de générer des modèles de configuration et de lancer des chaînes de traitement.

## Syntaxe générale

```bash
reobs <commande> [options]
```

### Commandes disponibles

| Commande | Description |
|----------|-------------|
| `ls` | Explorer une configuration ReOBS. |
| `template` | Générer ou compléter une arborescence de configuration. |
| `run` | Exécuter une chaîne de traitement. |

Afficher l'aide générale :

```bash
reobs --help
```

Afficher l'aide d'une commande spécifique :

```bash
reobs <commande> --help
```

## La commande `ls`

La commande `ls` permet d'explorer une configuration ReOBS sans avoir à parcourir manuellement les fichiers de configuration.

### Syntaxe

```bash
reobs ls <sous-commande> <config_file> [options]
```

### Sous-commandes disponibles

| Sous-commande | Description |
|---------------|-------------|
| `site` | Liste les sites disponibles. |
| `stream` | Liste les chaînes de traitement. |
| `base` | Liste les bases de données. |
| `info` | Affiche les informations d'un site. |
| `input` | Liste les fichiers d'entrée d'une chaîne de traitement. |
| `output` | Liste les fichiers de sortie d'une chaîne de traitement. |

### `site`

Liste les sites disponibles.

#### Syntaxe

```bash
reobs ls site <config_file> [options]
```

#### Arguments

| Argument | Description |
|----------|-------------|
| `<config_file>` | Fichier principal de configuration ReOBS. |

#### Options

| Option | Description |
|---------|-------------|
| `--pretty` | Affiche le résultat sous une forme hiérarchique plus lisible. |

#### Exemple

```bash
reobs ls site superviseur.conf
```

Exemple de sortie :

```text
sirta
ccres
```

### `stream`

Liste les chaînes de traitement disponibles.

#### Syntaxe

```bash
reobs ls stream <config_file> [options]
```

#### Arguments

| Argument | Description |
|----------|-------------|
| `<config_file>` | Fichier principal de configuration ReOBS. |

#### Options

| Option | Description |
|---------|-------------|
| `--site <site>` | Limite l'affichage à un site donné. |
| `--pretty` | Affiche le résultat sous une forme hiérarchique plus lisible. |

#### Exemples

Tous les sites :

```bash
reobs ls stream superviseur.conf
```

Un site spécifique :

```bash
reobs ls stream superviseur.conf --site sirta
```

### `base`

Liste les bases de données disponibles.

#### Syntaxe

```bash
reobs ls base <config_file> [options]
```

#### Arguments

| Argument | Description |
|----------|-------------|
| `<config_file>` | Fichier principal de configuration ReOBS. |

#### Options

| Option | Description |
|---------|-------------|
| `--site <site>` | Limite l'affichage à un site donné. |
| `--pretty` | Affiche le résultat sous une forme hiérarchique plus lisible. |

#### Exemples

```bash
reobs ls base superviseur.conf
```

```bash
reobs ls base superviseur.conf --site sirta
```

### `info`

Affiche les informations d'un site.

#### Syntaxe

```bash
reobs ls info <config_file> <site> [options]
```

#### Arguments

| Argument | Description |
|----------|-------------|
| `<config_file>` | Fichier principal de configuration ReOBS. |
| `<site>` | Nom du site. |

#### Options

| Option | Description |
|---------|-------------|
| `--grep <motif>` | Filtre les clés à l'aide d'un motif de type *glob*. |
| `--pretty` | Affiche le résultat sous une forme hiérarchique plus lisible. |

#### Exemples

Afficher toutes les informations :

```bash
reobs ls info superviseur.conf sirta
```

Filtrer certaines clés :

```bash
reobs ls info superviseur.conf sirta --grep input*
```

Afficher le résultat sous une forme hiérarchique :

```bash
reobs ls info superviseur.conf sirta --pretty
```

### `input`

Liste les fichiers d'entrée d'une chaîne de traitement.

#### Syntaxe

```bash
reobs ls input <config_file> <site> <pipeline> [options]
```

#### Arguments

| Argument | Description |
|----------|-------------|
| `<config_file>` | Fichier principal de configuration ReOBS. |
| `<site>` | Nom du site. |
| `<pipeline>` | Nom de la chaîne de traitement. |

#### Options

| Option | Description |
|---------|-------------|
| `--sort_by {size,m_date,c_date}` | Trie les fichiers par taille, date de modification ou date de création. |
| `--reverse` | Inverse l'ordre du tri. |
| `--pretty` | Affiche le résultat sous une forme hiérarchique (accepté mais sans effet sur une simple liste). |

#### Exemples

Lister les fichiers :

```bash
reobs ls input superviseur.conf sirta gps
```

Trier les fichiers :

```bash
reobs ls input superviseur.conf sirta gps \
    --sort_by m_date \
    --reverse
```

### `output`

Liste les fichiers de sortie d'une chaîne de traitement.

#### Syntaxe

```bash
reobs ls output <config_file> <site> <pipeline> [options]
```

#### Arguments

| Argument | Description |
|----------|-------------|
| `<config_file>` | Fichier principal de configuration ReOBS. |
| `<site>` | Nom du site. |
| `<pipeline>` | Nom de la chaîne de traitement. |

#### Options

| Option | Description |
|---------|-------------|
| `--sort_by {size,m_date,c_date}` | Trie les fichiers par taille, date de modification ou date de création. |
| `--reverse` | Inverse l'ordre du tri. |
| `--pretty` | Affiche le résultat sous une forme hiérarchique (accepté mais sans effet sur une simple liste). |

#### Exemple

```bash
reobs ls output superviseur.conf sirta gps
```

---

## La commande `template`

La commande `template` permet de générer ou de compléter une arborescence de configuration.

### Syntaxe

```bash
reobs template <sous-commande> [options]
```

### Sous-commandes disponibles

| Sous-commande | Description |
|---------------|-------------|
| `create` | Crée une nouvelle arborescence de configuration. |
| `add` | Ajoute un site ou une chaîne de traitement à une configuration existante *(non implémentée)*. |

### `create`

Crée une nouvelle arborescence de configuration.

#### Syntaxe

```bash
reobs template create --site <site> --pipeline <pipeline> [options]
```

#### Options

| Option | Obligatoire | Description |
|---------|:-----------:|-------------|
| `--site <site>` | ✅ | Nom du site à créer. |
| `--pipeline <pipeline>` | ✅ | Nom de la chaîne de traitement à créer. |
| `-o`, `--output <dossier>` | | Répertoire de destination (défaut : `./template`). |
| `--overwrite` | | Écrase les fichiers existants. |

#### Exemples

Créer un modèle :

```bash
reobs template create \
    --site sirta \
    --pipeline gps
```

Spécifier un répertoire de destination :

```bash
reobs template create \
    --site sirta \
    --pipeline gps \
    --output ./configs
```

Écraser les fichiers existants :

```bash
reobs template create \
    --site sirta \
    --pipeline gps \
    --overwrite
```

### `add`

> **⚠️ Cette sous-commande n'est pas encore implémentée.**

#### Syntaxe

```bash
reobs template add --site <site> --pipeline <pipeline> [options]
```

#### Options

| Option | Obligatoire | Description |
|---------|:-----------:|-------------|
| `--site <site>` | ✅ | Nom du site. |
| `--pipeline <pipeline>` | ✅ | Nom de la chaîne de traitement. |
| `-f`, `--folder <dossier>` | | Dossier contenant la configuration existante. |

---

## La commande `run`

La commande `run` lance une chaîne de traitement ReOBS.

### Syntaxe

```bash
reobs run [options]
```

### Options

La commande `run` ne définit aucune option spécifique.

Toutes les options sont directement transmises au script `superviseur.sh`.

Afficher l'aide du superviseur :

```bash
reobs run --help
```
