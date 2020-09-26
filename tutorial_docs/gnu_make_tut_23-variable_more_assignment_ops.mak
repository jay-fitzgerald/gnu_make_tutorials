# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Using-Variables.html#Using-Variables
############################ Example Make Code ############################
.PHONY: all
.SILENT:
all: shell_var_demo append_demo

# The shell assignment operator is !=
# https://www.gnu.org/software/make/manual/html_node/Setting.html#Setting
# This is not a negation (not equals) operator.
# It passes the right-hand side to the shell and assigns the output to the variable.
# This happens immediately, during phase one (Read-In).
# Support added in GNU Make 4.0; for earlier versions, use 'var := $(shell ...)' instead
shell_cmd := which python
shell_out != $(shell_cmd)
shell_out_immediate := $(shell_out)# demonstrates that shell_out is assigned a value immediately.
shell_var_demo:
	echo $@
	echo $(shell_cmd): $(shell_out)
	echo Value of previous line\'s RHS at definition: $(shell_out_immediate)
	echo

# The append operator is +=
# https://www.gnu.org/software/make/manual/html_node/Appending.html#Appending
# It takes the value of a variable and adds the new string to it.
# If it already has a value, the string is preceded by a single space.
# For a brand new variable, expansion is deferred.
# For a previously defined variable, the previous expansion behavior is used.
simple_var := string
simple_var += with appended text
append_demo:
	echo $@
	echo $(simple_var)
	echo

############################ Execution Output #############################

# $ make -f gnu_make_tut_23-variable_more_assignment_ops.mak
# shell_var_demo
# which python: /usr/bin/python
# Value of previous line's RHS at definition: /usr/bin/python
#
# append_demo
# string with appended text
#
