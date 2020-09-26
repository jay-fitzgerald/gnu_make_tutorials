# Tutorial Page: https://makefiletutorial.com
############################ Example Make Code ############################
.PHONY: all
.SILENT:
all: demo_override demo_undefine

# Variables can get their value from the environment, command line or makefile.
# https://www.gnu.org/software/make/manual/html_node/Environment.html#Environment
# Natural Order of Precedence for variable values:
# 1. Command Line
# 2. makefile
# 3. environment

# Environment Override
# Pass the -e flag and a value from the environment will override a value in the makefile.
# This is not recommended, though.

# makefile override
# https://www.gnu.org/software/make/manual/html_node/Override-Directive.html#Override-Directive
# With the "override" directive, a value in the makefile
# can override or append to a value from the command line.
# This was not invented for escalation in the war between makefiles and command arguments.
override option_one := did override
option_two := did override?
override option_three = the command line did not specify a value
option_three = did override the original value # won't work; must use override to update an override value
demo_override:
	echo $@
	echo $(option_one)
	echo $(option_two)
	echo $(option_three)
	echo

# **** Undefine directive ****
# https://www.gnu.org/software/make/manual/html_node/Undefine-Directive.html#Undefine-Directive
# You can use "undefine" to pretend a variable was never defined.
# While setting an empty value is usually good enough, this is useful in certain situations.
# The most obvious situations are when checking the origin or flavor of a variable
# NOTE: Feature added in GNU Make 3.82
defined_variable := foo
undefined_variable := bar
defined_variable :=
undefine undefined_variable
demo_undefine:
	echo $@
	echo defined_variable origin: $(origin defined_variable)
	echo undefined_variable origin: $(origin undefined_variable)
	echo defined_variable flavor: $(flavor defined_variable)
	echo undefined_variable flavor: $(flavor undefined_variable)
	echo

############################ Execution Output #############################

# $ make -f gnu_make_tut_25-variable_override_and_undefine.mak option_one="did not override" option_two="did not override"
# demo_override
# did override
# did not override
# the command line did not specify a value
#
# demo_undefine
# defined_variable origin: file
# undefined_variable origin: undefined
# defined_variable flavor: simple
# undefined_variable flavor: undefined
#
