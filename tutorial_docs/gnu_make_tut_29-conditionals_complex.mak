# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Conditional-Syntax.html#Conditional-Syntax
# Conditionals are used to control what make actually sees in a makefile.
# They can be used to change the values of variables, lines of a recipe,
# inclusion of a rule and more.
#
# Conditional Syntax with an Else
# <conditional-directive>
# <text-if-true>
# else
# <text-if-false>
# endif
#
# Multi-Conditional Syntax
# <conditional-directive-0>
# <text-if-0-is-true>
# else [<conditional-directive-n>]
# <text-if-previous-conditionals-are-false-and-curent-conditional-is-true-or-omitted>
# endif
############################ Example Make Code ############################
.PHONY: all
.SILENT:
all: demo_multiconditional

demo_multiconditional: 
	echo $@
ifeq ($(cli_var), A)
	echo A? This must be your first run of this makefile.
else ifeq ($(cli_var), B)
	echo B? You\'re running this again?
else
	echo I hope this is the last time you run this. You clearly have too much time on your hands.
endif

############################ Execution Output #############################

# $ make -f gnu_make_tut_29-conditionals_complex.mak
# demo_multiconditional
# I hope this is the last time you run this. You clearly have too much time on your hands.

# $ make -f gnu_make_tut_29-conditionals_complex.mak cli_var:=A
# demo_multiconditional
# A? This must be your first run of this makefile.

# $ make -f gnu_make_tut_29-conditionals_complex.mak cli_var:=B
# demo_multiconditional
# B? You're running this again?

# $ make -f gnu_make_tut_29-conditionals_complex.mak cli_var:=C
# demo_multiconditional
# I hope this is the last time you run this. You clearly have too much time on your hands.
