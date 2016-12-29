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

source $(dirname $0)/common.sh

iDIC=$1
oDIC=$2
AFF=$3
adir=../affixes

>"$oDIC" # make sure it's empty.

wc -l <"$iDIC" >afbase
cat "$iDIC" >>afbase

echo "AC: munch word list to find nouns"
munch afbase "$adir/nouns.pre" 2>/dev/null | tail -n +2 - > afpNouns

echo "AC: extract nouns"
sed -n -r -f "$adir/nouns.sed" afpNouns >>"$oDIC"

echo "TODO: Same for others"
#echo "AC: munch word list to find verbs"
#munch "$iDIC" "$adir/verbs.pre" 2>/dev/null | tail -n +2 - > afpverbs

#echo "AC: extract verbs"
#sed -n -r -f "$adir/verbs.sed" afpverbs >>"$oDIC"

# ...

echo "AC: unmunch results"
wc -l <"$oDIC" >afdict
cat "$oDIC" >>afdict
unmunch afdict "$AFF" 2>/dev/null | sort -u >afundict

echo "AC: remove duplicates"
comm -23 "$iDIC" afundict >afprest

echo "AC: let munch give its best on what is left"
wc -l <afprest >afrest
cat afprest >>afrest
munch afrest "$AFF" 2> /dev/null | tail -n +2 - >>"$oDIC"

echo "AC: done"

