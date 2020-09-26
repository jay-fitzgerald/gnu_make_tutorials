# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Multi_002dLine.html#Multi_002dLine
############################ Example Make Code ############################
.PHONY: all
.SILENT:
all: demo_each_cmd_in_a_separate_shell

# We covered "define" before with canned recipes.
# define creates a multi-line variable which can be used
# for a canned recipe or passed to the eval function.

# We'll cover the eval function in a later tutorial.

# **** "define" syntax ****
# define <variable_name> [<operator>]
# <one or more lines that comprise the value of the variable>
# endef
# NOTE: Support for specifying <operator> added in GNU Make 3.82

# **** "define" Expansion ****
# See the makefile_parsing tutorial for details
# By default, deferred expansion is used.
# If an operator is included, the same expansion
# behavior that we get without the define directive
# is used.

one = export blah="I was set"; echo $${blah}

define two
export blah="I was set"
echo $${blah}
endef

# When used for a canned recipe, each line is executed in a separate shell.
# With this in mind, avoid something like "echo $(defined_variable)".
# Rather than running the canned recipe, you would echo each line of it.

# We'll demonstrate how each line of the canned recipe is executed in a separate
# shell by exporting a variable inside the shell and trying to echo it.
demo_each_cmd_in_a_separate_shell:
	echo $@
	$(one)
	$(two) # prints an empty line

############################ Execution Output #############################

# $ make -f gnu_make_tut_24-variable_define_directive.mak
# demo_each_cmd_in_a_separate_shell
# I was set
#

