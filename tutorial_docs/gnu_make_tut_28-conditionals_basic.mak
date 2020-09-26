# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Conditional-Syntax.html#Conditional-Syntax
# Conditionals are used to control what make actually sees in a makefile.
# They can be used to change the values of variables, lines of a recipe,
# inclusion of a rule and more.
#
# Be aware that conditionals are evaluated during read-in.
# Be mindful of whether variables are defined, when you stick them in a conditional.
# If this is a problem, rearrange variables and condtionals or use a shell conditional
# (evaluated when building a target) instead.
#
# **** Basic Conditional Syntax ****
# <conditional-directive>
# <text-if-true>
# endif
#
# <text-if-true> can be multiple lines
############################ Example Make Code ############################
.PHONY: all clean
.SILENT:
all: demo_conditional_var demo_ifdef demo_conditional_rule
demo_conditional_rule:
clean:
	rm -f demo_ifdef

# **** Conditional Directives ****
# ifeq <Equality-Args> # True if equal
# ifneq <Equality-Args>
# ifdef <variable-name> # True if defined
# ifndef <variable-name>

# <Equality-Args> can take any of the following forms:
# (arg1, arg2)
# 'arg1' 'arg2'
# "arg1" "arg2"
# "arg1" 'arg2'
# 'arg1' "arg2"

ifeq (some_value, $(cli_var))
  cond_var := Equality!
endif
demo_conditional_var:
	echo $@
	echo Conditional Variable Value: $(cond_var)
	echo

ifndef cond_var
demo_conditional_rule:
	echo $@
	echo We ran the conditional rule!
endif
	echo # We ended the conditional midrule; this will be part of a different rule, depending on the condition

# bar :=    # We could uncomment this line and it would not change the output
foo = $(bar)
baz := $(foo)
# ifdef only checks if a value is defined/non-empty
# it does not expand references
demo_ifdef:
	echo $@
ifdef foo
	echo "foo is defined"
endif
ifdef bar
	echo "but bar is not"
endif
ifndef baz
	echo "and baz is not"
endif
	touch $@
	echo

############################ Execution Output #############################

# $ make -f gnu_make_tut_28-conditionals_basic.mak cli_var:=some_value
# demo_conditional_var
# Conditional Variable Value: Equality!
#
#
# demo_ifdef
# foo is defined
# and baz is not
#

# $ make -f gnu_make_tut_28-conditionals_basic.mak cli_var:=no_value
# demo_conditional_var
# Conditional Variable Value:
#
# demo_conditional_rule
# We ran the conditional rule!
#
