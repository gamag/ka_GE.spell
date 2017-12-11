
# ქართული ორთოგრაფიული ლექსიკონი - Georgian Spell Checking Dictionary #

Contains:

- Hunspell dictionary (MIT License) (for OpenOffice.org, Mozilla Firefox, Google Chrome, and may more) in `dictionaries/`
- Script to generate the dictionary from word lists (GPL3)

Note: The used word lists have been automatically created by crawling the
internet using different techniques, so many words may be missing or wrong
(which leads to false positives/negatives)

## Dictionary installation ##

### In Applications ##

- __OpenOffice and LibreOffice__: An extension package it available 
  [here](https://extensions.openoffice.org/en/project/kartuli-ortograpiuli-leksikoni-georgian-spell-checking-dictionary)
  The dictionary extension can be installed from the extension manager:
  From the menu `tools` select `Extension Manager`. In the extension manager
  window click `add` and open `ka_GE.spell_.oxt`
- __Firefox, Thunderbird__: Install the plugin from [AMO](https://addons.mozilla.org/de/firefox/addon/georgian-dictionary/)
- __Other open source applications__: Contact the developers and ask them to include this dictionary (see #3).

### System wide ###

#### Mac OS X (10.6 and later) ####

- Download or clone this repo.
- In `Finder`, select `Go To Folder` from `Go` menu, type in `~/Library`, click
  `Go` (for system wide installation, use `/Library` instead).
- In the `Library` directory, locate the folder `Spelling` or create it, if it is not there.
- Copy `ka_GE.aff` and `ka_GE.dic` from the repository (in `dictionaries/`) to the `Spelling` folder.

#### Linux ####

Copy `dictionaries/ka_GE.dic` and `dictionaries/ka_GE.aff` to `/usr/share/hunspell/`


## Data sources ##

Word lists by the following People / from the following sources are used to generate the dictionary:

- Dato Bumbeishvili (https://github.com/bumbeishvili/GeoWordsDatabase, MIT License)
- Kevin Scannell (http://crubadan.org/languages/ka, CC-BY 4.0) 

Thanks a lot for your awesome work! 


## Update/build dictionary ##

You need a bash compatible shell, gnu tools, hunspell (and
hunspell-tools on some systems) and a c++14 compatible compiler installed.
xmunch (https://github.com/gamag/xmunch) is as submodule, so after cloning
this repository, run `git submodule update --init`, then go to xmunch subdirectory
and run make.

To build the dictionary, run `make all`

To build the packages for firefox and OpenOffice, run `make bundle` later.

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

