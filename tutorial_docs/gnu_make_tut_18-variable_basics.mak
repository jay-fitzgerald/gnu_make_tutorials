# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Using-Variables.html#Using-Variables
#
# Variables and functions in all parts of a makefile are expanded when read, except
# for in recipes, the right-hand sides of variable definitions using ‘=’, and the
# bodies of variable definitions using the **define** directive.
############################ Example Make Code ############################
.PHONY: all
all: demo_refs

# Basic Referencing
# https://www.gnu.org/software/make/manual/html_node/Reference.html#Reference
# Variables can be referenced in any context: targets, prereqs, recipes, most directives, and new variable values.
# Always reference variables using ${} or $()
# Escape a dollar sign with another: $$
ref = dude
demo_refs:
	@echo $(ref)
	@echo ${ref}
# Next line equates to $(r)ef, so don't forget the braces
	@echo $ref
# $r expands to nothing because an undefined variable is just an empty string.

############################ Execution Output #############################

# $ make -f gnu_make_tut_18-variable_basics.mak
# dude
# dude
# ef
