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
# along with ka_GE.spell.  If not, see <http://www.gnu.org/licenses/>.

# Enhanced affix compression for ka_GE.spell

if [[ $1 != "-t" ]]; then
	echo "This file should only be called from build.sh"
	exit 1
else
	echo "Test mode - be careful not to overwrite files you need!"
fi

iDIC=$2
oDIC=$3
oAFF=$4
adir=../affixes

cd $(dirname $0)/build

# Remove lines from $1 that are in $2..n too.
function leftxor() {
	sort -m "$@" | uniq -d >xortmp
	sort -m xortmp "$1" | uniq -u
	rm xortmp
}

cat "$adir/head.aff" >>"$oAFF"


echo "AC: munch word list to find nouns"
munch "$iDIC" "$adir/nouns.pre" 2>/dev/null | tail -n +2 - > afpNouns

echo "AC: extract nouns"
sed -n -r -f "$adir/nouns.sed" afpNouns >"$oDIC"

cat "$adir/nouns.aff" >"$oAFF"


echo "TODO: Same for others"
#echo "AC: munch word list to find verbs"
#munch "$iDIC" "$adir/verbs.pre" 2>/dev/null | tail -n +2 - > afpverbs

#echo "AC: extract verbs"
#sed -n -r -f "$adir/verbs.sed" afpverbs >>"$oDIC"

#cat "$adir/verbs.aff" >"$oAFF"

# ...

echo "AC: unmunch results"

wc -l <"$oDIC" >afdict
cat "$oDIC" >>afdict
unmunch afdict "$oAFF" 2>/dev/null | sort | uniq >afundict

echo "AC: remove duplicates"
leftxor "$iDIC" afundict >afprest

echo "AC: let munch give its best on what is left"
cat "$adir/tail.aff" >"$oAFF"
wc -l <afprest >afrest
cat afprest >>afrest
munch afrest "$oAFF" 2> /dev/null | tail -n +2 - >>"$oDIC"

echo "AC: done"

