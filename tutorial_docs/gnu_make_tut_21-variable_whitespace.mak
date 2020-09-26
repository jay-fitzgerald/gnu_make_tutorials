# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Using-Variables.html#Using-Variables
############################ Example Make Code ############################
.PHONY: all
.SILENT:
all: whitespace_demo

# **** Spaces ****
# Spaces at the end of a line are not stripped, ones at the start are
# To make a variable with a single space, have a variable guard
with_spaces := hello         # trailing spaces up to the comment are part of the value
hello_ws_there:= $(with_spaces)there
nullstring :=
space_ex1 := $(nullstring) # nullstring expands to an empty string and the value is a single space
space_ex2 := $(nonexistent) # nonexistent was never defined and expands to an empty string, giving us the same result
whitespace_demo:
	echo $@
	echo "${hello_ws_there}"
	echo start"${space_ex1}"end
	echo start"${space_ex2}"end
	echo

############################ Execution Output #############################

# $ make -f gnu_make_tut_21-variable_whitespace.mak
# whitespace_demo
# hello         there
# start end
# start end
#
