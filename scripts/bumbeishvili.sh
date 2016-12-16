#!/bin/bash

# This file is part of ka_GE.spell
# Copyright (C) 2016 Gabriel Margiani
#
# ka_GE.spell is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ka_GE.spell is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with ka_GE.spell  If not, see <http://www.gnu.org/licenses/>.

source $(dirname $0)/common.sh

wdir=../words
trustlevel=2

pwd

if [[ ! -f ../dbaccess ]]; then
	echo "DB: Create a file called 'dbaccess' containing"
	echo "DBUSER=..."
	echo "DBNAME=..."
	echo "DBPASS=..."
	echo "so I access the database."
	exit 1;
fi

source ../dbaccess

echo "DB: pulling database dump from https://github.com/bumbeishvili/GeoWordsDatabase"
if [[ -d GeoWordsDatabase ]]; then
	cd GeoWordsDatabase;
	git pull;
	cd ..
else
	git clone https://github.com/bumbeishvili/GeoWordsDatabase.git GeoWordsDatabase;
fi

REF=$(cd GeoWordsDatabase; git rev-parse HEAD)
touch dbref

if [[ "$(cat dbref)" != "$REF" ]]; then
	echo "DB: Updating database"
	mysql -NL "-u$DBUSER" "-p$DBPASS" "$DBNAME" <GeoWordsDatabase/geowords*.sql
	echo "$REF" >dbref
fi

echo "DB: Reading word list from db"
mysql -NL "-u$DBUSER" "-p$DBPASS" "$DBNAME" -e  \
	"SELECT word_geo from words inner join (
				SELECT SUM(repeat_quantity) AS qt, word_id FROM words_history GROUP BY word_id
			)q ON word_id=words.id WHERE qt > $trustlevel ORDER BY word_geo;" \
	| uniq >"$wdir/bumbeishvili.txt"

mysql -NL "-u$DBUSER" "-p$DBPASS" "$DBNAME" -e  \
	"SELECT word_geo from words inner join (
				SELECT SUM(repeat_quantity) AS qt, word_id FROM words_history GROUP BY word_id
			)q ON word_id=words.id WHERE qt <= $trustlevel ORDER BY word_geo;" \
	| uniq >"$wdir/bumbeishvili.low"

