##
# This file is part of ka_GE.spell
# Copyright (C) 2017 Gabriel Margiani
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
##

# xmunch affix definitions for verbs.
 

dnl##########################################dnl
dnl  tools, general lists and helper macros  dnl
dnl##########################################dnl

dnl foreach loop from http://mbreen.com/m4.html
dnl look there for usage examples.
define(`FOREACH',`ifelse(eval($#>2),1,
    `pushdef(`$1',`$3')$2`'popdef(`$1')dnl
  `'ifelse(eval($#>3),1,`$0(`$1',`$2',shift(shift(shift($@))))')')')

dnl Expand $2 if $1 is not empty
define(`NE',`ifelse($1,,,$2)')

dnl Expand to o if $1 is not empty, else c
define(`OC',`ifelse($1,,c,o)')

dnl list of preverb markers. See below or above for which one core corresponds to what.
define(`PREVERBMARKS', ``I',`o',`A',`C',`a',`c',`E',`G',`e',`g',`X',`x',`W',`w',`n',`N'')

dnl list of preverbs to be used with foreach
define(`PREVERBS', ``I,მი',`o,მო',`A,ა',`C,ჩა',`a,ამო',`c,ჩამო',`E,შე',`G,გა',`e,შემო',`g,გამო',`X,გადა',`x,გადმო',`W,წა',`w,წამო',`n,და',`N,`''')

#########################
# Imperfect/Conditional #
#########################

dnl takes $1 = preverb flag, $2 = preverb
define(`IMPERFECT2', `
J$1 (1m 1y 2h o) {
.:.		$2ვ-ოდი		(1m)
.:.		$2-ოდი		(1y)
.:.		$2-ოდა		(1h)
.:.		$2ვ-ოდით	(1m)
.:.		$2-ოდით		(1y)
.:.		$2-ოდნენ	(1h)
.:.		$2ვ-ოდე		(1m)
.:.		$2-ოდე		(1y)
.:.		$2-ოდეს		(1h)
.:.		$2ვ-ოდეთ	(1m)
.:.		$2-ოდეთ		(1y)
}
')
FOREACH(`PV',`IMPERFECT2(PV)', PREVERBS)

define(`IMPERFECT1', `
I$1 (1m 1y 2h o) {
.:.		$2ვ-დი		(1m)
.:.		$2-დი		(1y)
.:.		$2-და		(1h)
.:.		$2ვ-დით		(1m)
.:.		$2-დით		(1y)
.:.		$2-დნენ		(1h)
.:.		$2ვ-დე		(1m)
.:.		$2-დე		(1y)
.:.		$2-დეს		(1h)
.:.		$2ვ-დეთ		(1m)
.:.		$2-დეთ		(1y)
}
')
FOREACH(`PV',`IMPERFECT1(PV)', PREVERBS)

##################
# Present/Future #
##################

dnl takes $1 = preverb flag, $2 = preverb
dnl OC($2): in case of no preverb, we must not forbid the 2. person singular
dnl form, but if we have a preverb, we might not create it for the preverbless.
dnl verb.
define(`PRESENT1', `
P$1 (1m 0y 2h 0x OC($2)) {
.		$2ვ-	(1m)
NE($2,`.	$2-		(1y)')
.:.		$2-ს	(1h)
.:.		$2ვ-თ	(1m)
.:.		$2-თ	(1y)
.:.		$2-ენ	(1h)
.:ი		$2-იან	(1h)
.:ი		$2-იენ	(-1x) # our aff file would turn this into იან!
}
')
FOREACH(`PV',`PRESENT1(PV)', PREVERBS)

define(`PRESENT2', `
Q$1 (1m 0y 2h v) {
.:.		$2ვ-ი	(1m)
.:.		$2-ი	(1y)
.:.		$2-ა	(1h)
.:.		$2ვ-ით	(1m)
.:.		$2-ით	(1y)
.:.		$2-იან	(1h)
}
')
FOREACH(`PV',`PRESENT2(PV)', PREVERBS)
