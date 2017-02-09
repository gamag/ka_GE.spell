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
xmunch=../xmunch/xmunch

>adict # make sure it's empty.

wc -l <"$iDIC" >afbase
cat "$iDIC" >>afbase

cat $adir/head.xaff >afxmunch
cat $adir/nouns.xaff >>afxmunch

echo "AC: munch word list"
$xmunch afbase afxmunch - 2>/dev/null > afpX

echo "AC: extract stems"
sed -e "/\//p;d;" afpX >>adict

echo "AC: unmunch results"
wc -l <adict >afdict
cat adict >>afdict
unmunch afdict "$AFF" 2>/dev/null | sort -u >afundict

echo "AC: remove duplicates"
comm -23 "$iDIC" afundict >>adict #>afprest

echo "AC: let munch give its best on what is left"
#wc -l <afprest >afrest
#cat afprest >>afrest
#munch afrest "$AFF" 2> /dev/null | tail -n +2 - >>adict
sort -u adict >"$oDIC"

echo "AC: done"

