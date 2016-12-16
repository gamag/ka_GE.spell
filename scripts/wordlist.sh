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

RES=$2
wdir=../words

function wordlist() {
	echo "WRD: Checking sorting of word lists"
	unsorted=""
	for f in $wdir/*.txt $wdir/*.low; do
		sort -c "$f"
		if [[ $? -ne 0 ]]; then
			unsorted="$unsorted, $f"
		fi
	done
	if [[ -n $unsorted ]]; then
		echo "Error: some word lists appear to be unsorted:"
		echo "$unsorted"
		echo "You may need to set an unicode Locale (if not already set)"
		echo "and sort the word lists in words/*.txt."
		echo "If that doesn't help, make sure mysql is using utf-8 collation."
		exit 1
	fi
		
	echo "WRD: Merging word lists"
	sort -m $wdir/*.txt $wdir/*.low | uniq >txttmp
	echo "WRD: Removing blacklisted words"
	leftxor txttmp ../blacklist >"$RES"
	rm txttmp
}

function lowlist() {
	echo "LOW: Merging word lists"
	sort -m $wdir/*.txt | uniq >txttmp
	echo "LOW: Merging word lists"
	sort -m $wdir/*.low | uniq -u >lowtmp
	echo "LOW: Removing upgraded words"
	leftxor lowtmp txttmp >"$RES"
	rm lowtmp txttmp
}

if [[ $1 == 'words' ]]; then
	wordlist;
else 
	lowlist
fi
