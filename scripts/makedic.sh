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

# Assemble dictionay file.

source $(dirname $0)/common.sh

MUN=$1
LOW=$2
DIC=$3

echo "DIC: Removing rare words and words with low confidence level"
comm -23 "$MUN" "$LOW" >ka_GE.tmp

echo "DIC: Building dictionary"
wc -l <ka_GE.tmp >"$DIC"
echo "$LICENSE" >>"$DIC"
cat ../reviewed >> "$DIC"
cat ka_GE.tmp >>"$DIC"

rm ka_GE.tmp
