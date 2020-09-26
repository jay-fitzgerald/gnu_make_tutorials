# Tutorial Page: https://makefiletutorial.com
############################ Example Make Code ############################
.PHONY: all
.SILENT:
all: demo_ts_var_t1 demo_ts_var_t2 demo_ts_var_t3 demo_ts_var_t4

# Target-specific variables
# https://www.gnu.org/software/make/manual/html_node/Target_002dspecific.html#Target_002dspecific
# Variables are global, except automatic-variables and target-specific variables.
# Target-specific variables allow you to define different values for a variable, based on target.
# They are only defined within the context of a target’s recipe and in other target-specific assignments.

# Syntax - targets … : variable-assignment
# Multiple target values create a target-specific variable value for each member of the target list individually.
demo_ts_var_t2: private cool_var:=Yes!# never inherited by prereqs
demo_ts_var_t1: cool_var:=Yes and I was inherited!# doesn't change demo_ts_var_t2; they have different scopes
demo_ts_var_t3: cool_var:=Yes!
t3_prereq: cool_var:=Yes and I was not inherited!# takes precedence over inherited value
cool_var := Maybe?

# You can apply export, override, or private as part of these assignments, with the target-specific context.
# Target-specific variables are inherited by a target's prereqs (if that target triggers their build).
# They can be passed down to those targets' prereqs the same way.
# NOTE: Starting in GNU Make 3.82, you can use multiple modifiers (export, override, private) in a single line

demo_ts_var_%: %_prereq
	echo $@
	echo Question: Do you exist?
	echo Answer: $(cool_var)
	echo
%_prereq:
	echo $@
	echo Question: Are you an awesome variable?
	echo Answer: $(cool_var)
	echo

# **** private directive ****
# Wait, what's private?!
# "private" prevents a variable from being inherited.
# https://www.gnu.org/software/make/manual/html_node/Suppressing-Inheritance.html#Suppressing-Inheritance
# It makes the most sense to apply this to a target- or pattern-specific variable.
# If applied to a global variable, that variable will not be visible within any target recipe.
# NOTE: Feature added in GNU Make 3.82

############################ Execution Output #############################

# $ make -f gnu_make_tut_26-variable_target_specific_and_private.mak
# t1_prereq
# Question: Are you an awesome variable?
# Answer: Yes and I was inherited!
#
# demo_ts_var_t1
# Question: Do you exist?
# Answer: Yes and I was inherited!
#
# t2_prereq
# Question: Are you an awesome variable?
# Answer: Maybe?
#
# demo_ts_var_t2
# Question: Do you exist?
# Answer: Yes!
#
# t3_prereq
# Question: Are you an awesome variable?
# Answer: Yes and I was not inherited!
#
# demo_ts_var_t3
# Question: Do you exist?
# Answer: Yes!
#
# t4_prereq
# Question: Are you an awesome variable?
# Answer: Maybe?
#
# demo_ts_var_t4
# Question: Do you exist?
# Answer: Maybe?
#

# $ make -f gnu_make_tut_26-variable_target_specific_and_private.mak t1_prereq
# t1_prereq
# Question: Are you an awesome variable?
# Answer: Maybe?
#
