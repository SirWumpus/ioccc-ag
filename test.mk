#
#	Test Driver for Anthony's Grep
#
#	Public Domain 1992, 1993 by Anthony Howe.  No warranty.
#

all :	char word anchor literal wild closure option branch sub class

#
# Test simple text patterns without the use of meta characters.
#

empty: 
	$(PRG) '' test.mk

char:
	$(PRG) 'q' test.mk

word:
	$(PRG) 'simple' test.mk

#
# Test meta characters.
#

anchor: anchor1 anchor2 anchor3 anchor4 anchor5

anchor1:
	$(PRG) '^anchor1' test.mk

anchor2:
	$(PRG) 'Grep$' test.mk

#
# Find all empty lines.
#
anchor3:
	$(PRG) '^$' test.mk

#
# This is valid but will never match.
#
anchor4:
	-$(PRG) 'x^a' test.mk

#
# This is valid but will never match.
#
anchor5:
	-$(PRG) 'mk$x' test.mk

literal: literal1 literal2

#
# Every line with a dollar-sign.	
#
literal1:
	$(PRG) '\$' test.mk

#
# Every line with a backslash.	
#
literal2:
	$(PRG) '\\' test.mk

#
#	wild #1#
#	wild #a#
#	wild #%#
#
wild:
	$(PRG) '#.#' test.mk

#
#  	closure !!
#  	closure !x!
#	closure !xxxxxx!
#
closure:
	$(PRG) 'closure !x*!' test.mk

#
#	option ++
#	option +a+
#	option +b+
#	option +c+
#	option +abc+
#
option: option1 option2

option1:
	$(PRG) '+b?+' test.mk

option2:
	$(PRG) '+.?+' test.mk

branch: branch1 branch2 branch3 branch4 branch5 branch6

branch1:
	$(PRG) 'q|simple' test.mk

#
# This pattern should be the same as '(^all)|(Public)|(Grep$)'.
#
branch2:
	$(PRG) '^all|Public|Grep$' test.mk

#
# This pattern should generate the same results as branch2.
#
branch3:
	$(PRG) 'Grep$|^all|Public' test.mk

#
# Null expression between start of pattern and vertical-line.
#
branch4:
	$(PRG) '|Grep' test.mk

#
# Null expression between vertical-line and end of pattern.
#
branch5:
	$(PRG) 'Grep|' test.mk

#
# Null expression between vertical-line and vertical-line.
#
branch6:
	$(PRG) 'all||Grep' test.mk

#
#	sub aabcbcbcxx
#	sub aagxx
#	sub aaggxx
#	sub aadddxx
#	sub aaxx
#
sub: sub0 sub1 sub2 sub3 sub4 sub5 lparen1 lparen2 rparen1 rparen2

#
# Null sub-expressions.
#
sub0:
	$(PRG) 's()u()b()' test.mk

sub1:
	$(PRG) '#(1|%)#' test.mk

sub2:
	$(PRG) 'aa((bc)*|g)xx' test.mk

#
# Null expression between the left-parenthesis and the vertical-line.
#
sub3:
	$(PRG) '#(|1)#' test.mk

#
# Null expression between the vertical-line and the right-parenthesis.
#
sub4:
	$(PRG) '#(1|)#' test.mk

#
# Null expression between the vertical-line and the right-parenthesis.
#
sub5:
	$(PRG) '#(%||1)#' test.mk

#
# Missing left-parenthesis generates an error.
#
lparen1:
	-$(PRG) 'left ( only' test.mk

lparen2:
	$(PRG) 'left \( only' test.mk

#
# Right-parenthesis without preceding left parenthesis should be a literal.
#
rparen1:
	-$(PRG) 'right ) only' test.mk

rparen2:
	$(PRG) 'right \) only' test.mk

#
#		12345678
#	-----------------
#	=0=	1  45
#	=1=	 2 45 78
#	=2=	 2 45
#	=3=	 2 45 78
#	=4=	 2 45
#	=5=	 2 45
#	=6=	 2 45
#	=7=	 2 45
#	=8=	 2 45
#	=9=	1  45
#	=]=	 23  6
#	=-=	 2 4 678
#	= =	 2 4 6
#
class:	class1 class2 class3 class4 class5 class6 class7 class8

class1:
	$(PRG) '=[09]=' test.mk

class2:
	$(PRG) '=[^09]=' test.mk

class3:
	$(PRG) '=[]]=' test.mk

class4:
	$(PRG) '=[^]]=' test.mk

class5:
	$(PRG) '=[0-9]=' test.mk

class6:
	$(PRG) '=[^0-9]=' test.mk

class7:
	-$(PRG) '=[3-1]=' test.mk

class8:
	$(PRG) '=[-13]=' test.mk

