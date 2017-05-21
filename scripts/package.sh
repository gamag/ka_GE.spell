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

source $(dirname $0)/common.sh

DIC=$2
AFF=$3
RES=$4

function version() {
	if [[ $1 == num ]]; then
		v=$(git describe --long | sed "s/v//;s/-/./;s/-.*//;")
		ref=$(( 16#$(git rev-parse --short=4 HEAD) ))
		echo $v.$ref
	else
		git describe --long --abbrev=4 | sed "s/v//;s/-/./;s/-/.r/;"
	fi
}

function mozilla() {
	mkdir -p mozilla/dictionaries
	ln -f $AFF mozilla/dictionaries/ka-GE.aff
	ln -f $DIC mozilla/dictionaries/ka-GE.dic
	sed -e "s/{{VERSION}}/$(version)/" ../pkgdata/Mozilla/install.rdf >mozilla/install.rdf
	cd mozilla
	zip $RES *.* dictionaries/*.*
	cd ..
}

function ooo() {
	mkdir -p ooo
	cp -rt ooo ../pkgdata/OOO/*
	sed -e "s/{{VERSION}}/$(version num)/" ../pkgdata/OOO/description.xml >ooo/description.xml
	ln -f $AFF ooo/ka-GE.aff
	ln -f $DIC ooo/ka-GE.dic
	cd ooo
	zip -r $RES *
	cd ..
}

if [[ $1 == 'ooo' ]]; then
	ooo;
else
	mozilla;
fi

