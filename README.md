
# Spell checking for Georgian - ქართული ენა #

Contains:

- Hunspell dictionary (for OpenOffice.org, Mozilla Firefox, Google Chrome, ...)
- Script to update the dictionary from https://github.com/bumbeishvili/GeoWordsDatabase

## Installation ##

TODO: How to install on other systems
TODO: Automatically build OpenOffice/Firefox/... package.

### Mac OS X (10.6 and later) ###

- Download or clone this repo.
- In `Finder`, select `Go To Folder` from `Go` menu, type in `~/Library`, click
  `Go` (for system wide installation, use `/Library` instead).
- In the `Library` directory, locate the folder `Spelling` or create it, if it is not there.
- Copy `ka_GE.aff` and `ka_GE.dic` from the repository (in `build/`) to the `Spelling` folder.

### Linux ###

copy `build/ka_GE.dic` and `build/ka_GE.aff` to `/usr/share/hunspell/`


## Update/build dictionary ##

You need a bash compatible shell, a running mysql server, git and hunspell (and
hunspell-tools on some systems) installed.

### Prepare database ###

Clone ka_GE.spell repository.

Log into mysql and add a user and a database for the word list:

```bash
$ mysql -uroot -p
mysql > CREATE DATABASE geoword;
mysql > CREATE USER 'geowords'@'localhost' IDENTIFIED BY 'password';
mysql > CREATE USER 'geowords'@'localhost' IDENTIFIED BY 'password';
mysql > GRANT ALL PRIVILEGES ON geowords.\* TO 'geowords'@'localhost'; 
mysql > FLUSH PRIVILEGES;
```

Create a file called dbaccess in the ka\_GE.spell root.
containing:

```bash
DBNAME=geowords
DBUSER=geowords
DBPASS=password
```

Now you are ready to run the `build.sh` script. It will checkout the word list,
push it to the database and build a hunspell dictionary from it.

## Remarks ##

The automatically created dictionary is not very accurate, some words may be wrong,
many missing. Also, the affix file is optimized for automatic handling using
`munch` from hunspell and describes the Georgian language in a very suboptimal
way. More work needs to be done to clean that, which implies a move from
automatic to manual affix compression (or implement something to do it
semiautomatic, so the wordlist can be updated from database without loosing
manual corrections).

TODO: translate to Georgian.
