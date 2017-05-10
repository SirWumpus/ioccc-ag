0. NAME

	ag		Anthony's Grep


1. SYNOPSIS

	ag <pattern> [file...]


2. DESCRIPTION

The AG utility shall search input files, selecting lines matching a
pattern.  An input line shall be selected if the pattern, treated as a
subset of Extended Regular Expressions as described by POSIX.2
Standard section 2.8.4, matches any part of the line; a null pattern
shall match every line.  Each selected input line shall be written to
the standard output.

Regular expression matching shall be based on text lines, which are
separated by a <newline> character.  A regular expression cannot
contain a <newline> and there is no way for a pattern to match a
<newline> found in the input.


3. OPTIONS

None.


4. OPERANDS

pattern         Specify one pattern to be used during the search for
		input.  See Extended Regular Exprssions below on what
		constitutes a valid pattern.

file            A pathname of a file to be searched for the pattern.
		If no file operands are specified or the file operand
		is dash (-), the standard input shall be used.


5. EXTERNINAL INFLUENCES

5.1. STANDARD INPUT

The standard input shall be used only if no file operands are
specifed.  See Input Files.


5.2. INPUT FILES

The input files shall be text files.


5.3. ENVIRONMENT VARIABLES

No environment variables are used.


5.4. ASYNCHRONOUS EVENTS

Default.


6. EXTERNAL EFFECTS

6.1. STANDARD OUTPUT

For each selected input line from a file, a single output line shall
be written:

	"%s:%s\n", file, line

Standard input will have the filename dash (-).


6.2. STANDARD ERROR

Standard error is used for diagnostic messages only.


6.3. OUTPUT FILES

None.


7. EXTENDED DESCRIPTION

7.1. EXTENDED REGULAR EXPRESSIONS

7.1.1. MATCHING A SINGLE CHARACTER

An ERE ordinary character, a special character preceded by a
backslash, or a period shall match a single character.  A bracket
expression shall match a single character.  An ERE matching a single
character enclosed in parentheses shall match the same as the ERE
without parentheses would have matched.


7.1.1.1. ERE ORDINARY CHARACTERS

An oridinary character is an ERE that matches itself.  An ordinary
character is any character in the supported character set, except for
the ERE special characters listed in 7.1.1.2.  The interpretation of
an ordinary character preceded by a backslash (\) is the ordinary
character.


7.1.1.2. ERE SPECIAL CHARACTERS

An ERE special character has special properties in certain contexts.
Outside of those contexts, or when preceded by a backslash, such a
character shall be an ERE that matches the special character itself.
The extended regular expression special characters and the contexts in
which they have their special meaning are:

	. [ \ (         The period, left-bracket, backslash, and left-
			parenthesis are special except when used in a
			bracket expression.  Outside a bracket
			expression, a left-parenthesis immediately
			followed by a right-parenthesis will be
			treated as a null expression.

	)               The right-parenthesis is special when matched
			with a preceding left-parenthesis, both
			outside of a bracket expression.

	* ?             The asterisk and question-mark are special
			except when used in a bracket expression.
			Results are undefined if this character
			appears first in an ERE, or immediately
			following a vertial-line, circumflex, or
			left-parenthesis.

	|               The vertical-line is special except when used
			in a bracket expression.  A vertical-line
			appearing first or last in an ERE or
			immediately following a vertical-line or
			left-parenthesis, or preceding a
			right-parenthesis, produces a null expression.

	^               The circumflex shall be special when used as
			an anchor or, as the first character of a
			bracket expression.

	$               The dollar-sign shall be special when used as
			an anchor.


7.1.1.3 PERIODS IN ERE

A period (.), when used outside of a bracket expression, is an ERE
that shall match any character in the supported character set except
NUL.

7.1.2. ERE BRACKET EXPRESSION

A bracket expression (an expression enclosed in square brackets, []),
is an ERE that matches a single character contained in the nonempty
set of characters represented by the bracket expression.

The following rules and definitions apply to bracket expressions:

   1)   A bracket expression is either a matching list expression
	or a nonmatching list expression.  It consists of one or more
	characters and/or range expressions.  The right-bracket (])
	shall lose its special meaning and represent itself in a
	bracket expression if it occurs first in the list [after an
	initial circumflex (^), if any].  Otherwise, it shall
	terminate the bracket expression.  The special characters
	period (.), asterisk (*), left-bracket ([), and backslash (\)
	shall lose their special meaning within a bracket expression.

   2)   A matching list expression specifies a list that shall match
	any one of the expressions represented in the list.  The first
	character of the list shall not be the circumflex.  For
	example,  [abc]  is an ERE that matches any of a, b, or c.

   3)   A nonmatching list expression begins with a circumflex (^),
	and specifies a list that shall match any character except for
	the expressions represented in the list after the leading
	circumflex.  For example,  [^abc]  is an ERE that matches any
	character except a, b, or c.  The circumflex shall have this
	special meaning only when it occurs first in the list,
	immediately following the left-bracket.

   4)   A range expression represents the set of characters that
	fall between two elements in the current collation sequence,
	inclusive.  It shall be expressed as the starting point and
	the ending point separated by a hyphen (-).

	In the following, all examples assume the collation sequence
	specified for the POSIX Locale (a.k.a ASCII Character Set),
	unless another collation sequence is sepecifically defined
	by the hardware.

	The starting range point and the ending range point shall be a
	collating element (character).  The ending range point shall
	collate higher than the starting range point; otherwise the
	expression shall be treated as invalid.

	The interpretation of a range expression where the ending
	range point is the starting range point of a subsequent range
	expression is undefined.

	The hyphen character shall be treated as itself if it occurs
	first (after an initial ^, if any) or last in the list, or as
	an ending range point in a range expression.  As examples, the
	expressions  [-ac]  and  [ac-] are equivalent and match any of
	the characters a, c, or -; the expressions  [^-ac]  and [^ac-]
	are equivalent and match ant character except a, c, -; the
	expression  [%--]  matches any of the characters between % and
	- inclusive;  the expression  [--@]  matches any of the
	characters between - and @ inclusive; and the expression
	[a--@] is invalid, because the letter a follows the symbol -
	in the POSIX Locale.


7.1.3. ERE MATCHING MULTIPLE CHARACTERS

The following rules shall be used to construct EREs matching multiple
characters from EREs matching a single character:

   1)   A concatenation of EREs shall match the concatenation of the
	character sequences matched by each component of the ERE.  A
	concatenation of EREs enclosed in parentheses shall match
	whatever the concatenation without parentheses matches.  For
	example, both the ERE cd and the ERE (cd) are matched by the
	third and forth character of the string abcdefabcdef.

   2)   When an ERE matching a single character, or a concatention of
	EREs enclosed in parentheses is followed by the special
	character asterisk (*), together with that asterisk it shall
	match what zero or more consecutive occurences of the ERE
	would match.  For example, the ERE b*c matches the first
	character in the string cabbbcde, and the ERE b*cd matches the
	third through seventh characters in the string
	cabbbcdebbbbbbcdbc.  And, [ab]* and [ab][ab] are equivalent
	when matching the string ab.

    3)  When an ERE matching a single character or an ERE enclosed in
	parentheses is followed by the special character question-mark
	(?), together with that question mark it shall match what zero
	or one consecutive occurences of the ERE would match.  For
	example, the ERE b?c matches the second character in the
	string acabbbcde.

The behaviour of multiple adjacent duplication symbols (*, ?) produces
undefined results.


7.1.4. ERE ALTERATION

Two EREs separated by the special character vertical-line (|) shall
match a string that is matched by either.  For example, the ERE
a((bc)|d) matches the string abc and the string ad.  Single
characters, or expressions matching single characters, separated by
the vertical-line and enclosed in parentheses, shall be treated as an
ERE matching a single character.


7.1.5. ERE PRECEDENCE

The order of precedence shall be as shown in the table below, from 
high to low:

	escaped characters			\<special character>
	bracket expression			[ ]
	grouping				( )
	single-character-ERE duplication	* ?
	concatenation
	anchoring				^ $
	alteration				|

For example, the ERE abba|cde matches either the string abba or the
string cde (because concatenation has a higher order of precedence
than alteration).


7.1.6. ERE EXPRESSION ANCHORING

An ERE can be limited to matching strings that begin or end a line;
this is called anchoring.  The circumflex and dollar-sign special
characters shall be considered ERE anchors in the following contexts:

   1)   A circumflex (^) outside a bracket expression shall anchor
	the (sub)expression it begins to the beginning of a string;
	such a (sub)expression can match only a sequence starting at
	the first character of a string.  For example, the EREs ^ab
	and (^ab) match ab in the string abcdef, but fail to match in
	the string cdefab, and the ERE a^b is valid, but can never
	match because the character a prevents the expression ^b from
	matching the first character of a string.

   2)   A dollar-sign ($) outside a bracket expression shall anchor
	the (sub)expression it ends to the end of a string; such a
	(sub)expression can match only a sequence ending at the last
	character of a string.  For example, the EREs ef$ and (ef$)
	match ef in the string abcdef, but fail to match in the string
	cdefab, and the ERE e$f is valid, but can never match because
	the character f prevents the expression e$ from matching the
	last character of a string.


8. EXIT STATUS

The following exit codes will be returned:
 
	0	Successful match.
	1	No match.
	2	Usage error.
	3	General error.


9. INSTALLATION

AG can be built on any system providing at least K&R C.  It has been 
tested on 

	o  SunOS with GCC
	o  ATARI Mega ST with Sozobon C
	o  PC clone with Turbo C and WatCom C
	o  Interactive UNIX System V/386 release 3.2

For most machines, the compile command line should be

	cc -O -o ag ag.c

PC class machines may require that medium or large memory model be used
and that ARRAY be set to 256.  For Watcom C the command line would be

	wcl -ml -DARRAY=256 ag.c

The value ARRAY represents the size of the compiled pattern array and
the size of the array used to record matched states.  The default
value choosen should handle most patterns.  ARRAY can be overridden on
the command line with -DARRAY=nn, where 255 < nn < INT_MAX.


10. REFERENCES

[Aho86]	Aho, Sethi, and Ullman, "Compilers - Principles, Techniques,
	and Tools", Addison-Wesley, 86, ISBN 0-201-10088-6, chapter 3

[K&P81] Kernighan and Plauger, "Software Tools in Pascal".
	Addison-Wesley, 81, ISBN 0-201-10342-7, chapter 5

[Mil87]	Webb Miller, "A Software Tools Sampler", 
	Prentice Hall, 87, ISBN 0-13-822305-X, chaper 4

[POSIX]	POSIX.2 Standard, 2.8.4 Extended Regular Expressions, 4.28 Grep


11. FILES

ag.c		Obfuscated source
ag.doc		Manual for AG
agag.c		Unobfuscated source
test.mk		Makefile test driver for AG.


12. BUGS

The expression (a*)* compiles but loops forever.

There is no check for trailing backslash (\) in the pattern.

There is no check for unbalanced brackets.  Omitting a closing bracket
will generate a "Patern too long" error, which is not the real error.


13. NOTICES

Public Domain 1992, 1993 by Anthony Howe.  No warranty.


