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

# common functionally for ka_GE.spell scripts

if [[ $1 != "makefile" ]]; then
	echo "This file should only be called by make."
	exit 1
fi
shift;

cd $(dirname $0)/../build

# Remove lines from $1 that are in $2..n too.
# assumes lists to be uniq
function leftxor() {
	sort -m "$1" "$2" | uniq -d >xortmp
	sort -m xortmp "$1" | uniq -u
	rm xortmp
}

LICENSE="
	# This file was generated by ka_GE.spell script by Gabriel Margiani using words from word lists by:
	# - Dato Bumbeishvili (https://github.com/bumbeishvili/GeoWordsDatabase)
	# - Kevin Scannell (http://crubadan.org/) CC-BY 4.0
"
