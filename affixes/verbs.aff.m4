dnl This file is part of ge_KA.spell, (c) 2016 Gabriel Margiani

#########
# Verbs #
#########

dnl We use one group per tense, so we generally have different stems
dnl for example in aorist and present tense and don't need to care about
dnl thematic signs. However, we have to create different rules for different
dnl preverbs.
dnl
dnl Preverbs
dnl I მი
dnl o მო
dnl A ა
dnl C ჩა
dnl a ამო
dnl c ჩამო
dnl E შე
dnl G გა
dnl e შემო
dnl g გამო
dnl X გადა
dnl x გადმო 
dnl W წა
dnl w წამო
dnl n და
dnl N 0
dnl
dnl Suffixes:
dnl   Present: PQpq
dnl   Imperfect: IJij
dnl   Subjunctive: KLkl
dnl
dnl   Aorist: ABab
dnl   Optativ: OTot
dnl
dnl   Perfect: EFef
dnl   Pluperfect: UVuv
dnl   Subjunctive perfect: CDcd
dnl
dnl Prefixes:
dnl  0: 0
dnl
dnl  ვ: 1
dnl
dnl  მ: 2
dnl  გ: 3
dnl  ჰ,ს,0: 4 - careful with xmunch!
dnl  გვ: 5
dnl
dnl  მი: 6
dnl  გი: 7
dnl  გვი: 8
dnl  უ: 9
dnl   
dnl "Public" flags are combined from one suffix flag followed by a preverb flag.
dnl prefix flags combined with preverb flags are to be used only as circumfixes.
 

dnl##########################################dnl
dnl  tools, general lists and helper macros  dnl
dnl##########################################dnl

dnl foreach loop from http://mbreen.com/m4.html
dnl look there for usage examples.
define(`FOREACH',`ifelse(eval($#>2),1,
    `pushdef(`$1',`$3')$2`'popdef(`$1')dnl
  `'ifelse(eval($#>3),1,`$0(`$1',`$2',shift(shift(shift($@))))')')')

dnl if $1 is empty, replace expand to 0 else to $1
define(`EMPTY0',`ifelse($1,,0,$1)')

dnl list of preverb markers. See below or above for which one core corresponds to what.
define(`PREVERBMARKS', ``I',`o',`A',`C',`a',`c',`E',`G',`e',`g',`X',`x',`W',`w',`n',`N'')

#############################################
# Verb Prefixes (Preverb + Personal Prefix) #
#############################################

dnl list of preverbs to be used with foreach
define(`PREVERBS', ``I,მი',`o,მო',`A,ა',`C,ჩა',`a,ამო',`c,ჩამო',`E,შე',`G,გა',`e,შემო',`g,გამო',`X,გადა',`x,გადმო',`W,წა',`w,წამო',`n,და',`N,`''')

dnl define all prefixes for verbs. Takes the second letter of the flag 
dnl (preverb mark) in $1 and the preverb in $2 
define(`MAKEPREFIXES',`
PFX 0$1 Y 1
PFX 0$1 0       EMPTY0($2)/&x     .

PFX 1$1 Y 1
PFX 1$1 0       $2ვ/&x     .

PFX 2$1 Y 1
PFX 2$1 0       $2მ/&x     .

PFX 3$1 Y 1
PFX 3$1 0       $2გ/&x     .

PFX 4$1 Y 3
PFX 4$1 0       $2ს/&x        [დტთძწცჯჭჩ]
PFX 4$1 0       $2ჰ/&x        [გკქგყ]
PFX 4$1 0       EMPTY0($2)/&x [^დტთძწცჯჭჩგკქგყ]

PFX 5$1 Y 1
PFX 5$1 0       $2გვ/&x    .

PFX 6$1 Y 1
PFX 6$1 0       $2მი/&x    .

PFX 7$1 Y 1
PFX 7$1 0       $2გი/&x    .

PFX 8$1 Y 1
PFX 8$1 0       $2გვი/&x   .

PFX 9$1 Y 1
PFX 9$1 0       $2უ/&x     .
')

dnl Expand all prefixes. The loop key should not be in the PREVERBS array.
FOREACH(`PV',`MAKEPREFIXES(PV)', PREVERBS)


############################
# Present and Future Tense #
############################

dnl creates present and future for type one verbs without object
define(`PRESENT1',`
SFX P$1 Y 7
SFX P$1 0       0/&x1$1         .
SFX P$1 0       0/&x0$1         .
SFX P$1 0       ს/&x0$1         .
SFX P$1 0       თ/&x1$1         .
SFX P$1 0       თ/&x0$1         .
SFX P$1 0       ენ/&x0$1        [^ი]
SFX P$1 0       ან/&x0$1        ი
')
FOREACH(`PV',`PRESENT1(PV)', PREVERBMARKS)

# vim: set ts=8 et:
