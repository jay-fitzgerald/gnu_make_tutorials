# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Using-Variables.html#Using-Variables
############################ Example Make Code ############################
.PHONY: all
.SILENT:
all: substitution_demo computed_names_demo

# **** Text Replacement ****
# https://www.gnu.org/software/make/manual/html_node/Substitution-Refs.html#Substitution-Refs
# You can text replace at the end of each space seperated word using $(var:a=b)
# Note: don’t put spaces in between anything; it will be seen as a search or replacement term
# Note: This is shorthand for using make’s patsubst expansion function

foo := a.o b.o c.o
# bar becomes a.c b.c c.c
bar := $(foo:.o=.c)
# You can use % as well to grab some text!
baz := $(foo:%.o=%)
substitution_demo:
	echo $@
	echo $(bar)
	echo $(baz)
	echo

# **** Computed Names ****
# https://www.gnu.org/software/make/manual/html_node/Computed-Names.html#Computed-Names
# You can use a variable to store the name of part of another variable
# You might do this when including a makefile from another component that
# multiple components depend on.
var_name_prefixA := prefixA
var_name_prefixB := prefixB
prefixA_value := value_A
prefixB_value := value_B
computed_variable := $($(var_name_prefixA)_value)
computed_names_demo:
	echo $@
	echo $(computed_variable)
	echo $($(var_name_prefixB)_value)
	echo

############################ Execution Output #############################

# $ make -f gnu_make_tut_22-variable_advanced_features.mak
# substitution_demo
# a.c b.c c.c
# a b c
#
# computed_names_demo
# value_A
# value_B
#
