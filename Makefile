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

AUTH="makefile"

AFF:=$(abspath dictionaries/ka_GE.aff)
DIC:=$(abspath dictionaries/ka_GE.dic)
WRD:=$(abspath build/ka_GE.wrd)
LOW:=$(abspath build/ka_GE.low)
MUN:=$(abspath build/ka_GE.mun)

scripts/%: scripts/common.sh

# Word list passed around must be sorted and 'uniq'

words/bumbeishvili.%: scripts/bumbeishvili.sh
	@echo updating word list
	@./scripts/bumbeishvili.sh $(AUTH)

$(AFF): scripts/makeaff.sh affixes/*.aff
	@echo building affix file
	@./scripts/makeaff.sh $(AUTH) $(AFF)

$(WRD): scripts/wordlist.sh words/*.txt words/*.low blacklist
	@echo compiling word lists
	@./scripts/wordlist.sh $(AUTH) words $(WRD)

$(LOW): scripts/wordlist.sh words/*.txt words/*.low
	@echo compiling low-trust word lists
	@./scripts/wordlist.sh $(AUTH) lows $(LOW)

$(MUN): scripts/affixcompress.sh affixes/*.sed affixes/*.pre affixes/*.aff $(AFF) $(WRD)
	@echo automatic affix compression
	@./scripts/affixcompress.sh $(AUTH) $(WRD) $(MUN) $(AFF)

$(DIC): scripts/makedic.sh $(MUN) $(LOW)
	@echo compiling dictionay
	@./scripts/makedic.sh $(AUTH) $(MUN) $(LOW) $(DIC)

all: $(AFF) $(DIC)
	@echo done

affix: $(AFF)
	@echo $(AFF) build

words: $(WRD) $(LOW)
	@echo word lists prepared

compress: $(MUN)
	@echo dictionay compressed

dic: $(DIC)
	@echo dictionary build

db:
	@./scripts/bumbeishvili.sh $(AUTH)

