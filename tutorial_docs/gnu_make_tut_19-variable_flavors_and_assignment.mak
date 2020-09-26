# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Using-Variables.html#Using-Variables
# https://www.gnu.org/software/make/manual/html_node/Flavors.html#Flavors
#
# Shout-out: the following answer was excellent in giving me an initial understanding
# of deferred and immediate constructs.
# https://stackoverflow.com/a/51313761
#
# The execution output can serve as a quick-reference.
############################ Example Make Code ############################
# There are two basic flavors: "recursive" and "simply expanded"
# There is also a conditionally assigned variable.
.PHONY: all
all: demo_simple demo_recursive demo_conditional

# Simply expanded variables are defined with := or ::=
# Only ::= is described by the POSIX standard (added in 2012)
# Their definition is determined immediately when they are defined.
# However, the value can be overwritten, later.
# NOTE: Support for ::= added in GNU Make 4.0
prev_simple := Success!
simple_one := verbatim string
simple_two := expansion of to-be-defined variable: $(simple_three)
simple_three := expansion of previously-defined variable: $(prev_simple)
prev_simple := String addition through self-reference: $(prev_simple)
demo_simple:
	@echo $@ "(:= or ::=)"
	@echo $(simple_one)
	@echo $(simple_two)
	@echo $(simple_three)
	@echo $(prev_simple)
	@echo The previous line also demonstrates reassignment.
	@echo

# Recursive variables use =
# Their definition is determined anew each time they are referenced.
prev_simple_rec_demo := Success!
reassignment_rec_demo := Reassignment: Failure!
rec_one = verbatim string
rec_two = expansion of to-be-defined variable: $(fut_simple_rec_demo)
rec_three = expansion of previously-defined simple variable: $(prev_simple_rec_demo)
rec_four = expansion of previously-defined recursive variable: $(rec_two)
reassignment_rec_demo = Reassignment: Success!
fut_simple_rec_demo = Success!
# Next 2 lines would cause an infinite loop, so they error
# rec_one = String addition through recursive self-reference of recursive variable: $(rec_one)
# prev_simple_rec_demo = String addition through recursive self-reference of simple variable: $(prev_simple_rec_demo)
demo_recursive:
	@echo $@ "(=)"
	@echo $(rec_one)
	@echo $(rec_two)
	@echo $(rec_three)
	@echo $(rec_four)
	@echo $(reassignment_rec_demo)
	@echo

# Conditionally assigned variables use ?=
# Like recursive variables, their definition is determined when they are referenced.
# However, ?= does not change the value of variables which have already been assigned a value.
reassignment_cond_demo := Reassignment: Failure!
conditional_one ?= verbatim string
conditional_two ?= expansion of to-be-defined variable: $(fut_simple_cond_demo)
conditional_three ?= expansion of previously-defined variable: $(conditional_two)
reassignment_cond_demo ?= Reassignment: Success! 
fut_simple_cond_demo = Success!
demo_conditional:
	@echo $@ "(?=)"
	@echo $(conditional_one)
	@echo $(conditional_two)
	@echo $(conditional_three)
	@echo $(reassignment_cond_demo)
	@echo

# Quick Note
# Although we used different, seemingly-localized, variables in each demo, variables could actually
# be placed anywhere in the makefile (outside of a rule) and be used in any of the rules.
# Likewise, a variable defined at the top of the makefile could be overwritten at the bottom.
# We'll discuss this more, later.

############################ Execution Output #############################

# $ make -f gnu_make_tut_19-variable_flavors_and_assignment.mak
# demo_simple (:= or ::=)
# verbatim string
# expansion of to-be-defined variable:
# expansion of previously-defined variable: Success!
# String addition through self-reference: Success!
# The previous line also demonstrates reassignment.
#
# demo_recursive (=)
# verbatim string
# expansion of to-be-defined variable: Success!
# expansion of previously-defined simple variable: Success!
# expansion of previously-defined recursive variable: expansion of to-be-defined variable: Success!
# Reassignment: Success!
#
# demo_conditional (?=)
# verbatim string
# expansion of to-be-defined variable: Success!
# expansion of previously-defined variable: expansion of to-be-defined variable: Success!
# Reassignment: Failure!
#
