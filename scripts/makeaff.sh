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

# Assemble affix file.

source $(dirname $0)/common.sh

AFF=$1
adir=../affixes

echo "$LICENSE" >"$AFF"
head -n -1 "$adir/head.aff"  | tail -n +2 >>"$AFF"
head -n -1 "$adir/nouns.aff" | tail -n +2 >>"$AFF"
#cat "$adir/verbs.aff" >>"$AFF"
#...
tail -n +2 "$adir/tail.aff" >>"$AFF"

