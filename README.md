
# Spell checking for Georgian - ქართული ენა #

Contains:

- Hunspell dictionary (for OpenOffice.org, Mozilla Firefox, Google Chrome, ...)
- Script to generate the dictionary from wordlists

## Dictionary installation ##

TODO: How to install on other systems
TODO: Automatically build OpenOffice/Firefox/... package.

### Mac OS X (10.6 and later) ###

- Download or clone this repo.
- In `Finder`, select `Go To Folder` from `Go` menu, type in `~/Library`, click
  `Go` (for system wide installation, use `/Library` instead).
- In the `Library` directory, locate the folder `Spelling` or create it, if it is not there.
- Copy `ka_GE.aff` and `ka_GE.dic` from the repository (in `dictionaries/`) to the `Spelling` folder.

### Linux ###

copy `dictionaries/ka_GE.dic` and `dictionaries/ka_GE.aff` to `/usr/share/hunspell/`


## Data sources ##

Word lists by the following People / from the following sources are used to generate the dictionary:

- Dato Bumbeishvili (https://github.com/bumbeishvili/GeoWordsDatabase)
- Kevin Scannell (http://crubadan.org/languages/ka, CC-BY 4.0) 

Thanks a lot for your awesome work! 


## Update/build dictionary ##

You need a bash compatible shell, gnu tools and  hunspell (and
hunspell-tools on some systems) installed.

To build the dictionary run `make all`

### Updating Bumbeishvilis word list ###

NOTE: the word list is included in `words/`, you don't need this steps to work
on the dictionary.

You need a running mysql server and git.

Clone this repository

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

call `make db`


## Remarks ##

The automatically created dictionary is not very accurate, some words may be wrong,
many missing. To improve that, words from the dictionary can be reviewed and
correct words added to the `reviewed` dictionary in their final,
affix-compressed form. Wrong words can be added to `blacklist`.

## Contributing ##

Any help is very welcome, especially reviewing the dictionary and improving the affix files.


TODO: translate README to Georgian.

