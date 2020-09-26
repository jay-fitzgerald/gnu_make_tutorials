# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Pattern_002dspecific.html#Pattern_002dspecific
# Pattern-specific variables are target-specific variables which apply to targets matching a pattern.
# See the static_pattern_rules tutorial for an intro to target patterns.
############################ Example Make Code ############################
.PHONY: all
.SILENT:
all: demo_ps_var_t1 demo_ps_var_t2 demo_ps_var_t3
demo_ps_var_t1: t1_prereq
demo_ps_var_%:
	echo $@
	echo Question: Which assignment took precedence?
	echo Answer: $(cool_var)
	echo

t1_prereq:
	echo $@
	echo Inherited?
	echo $(cool_var)
	echo

# Syntax - target_patterns … : variable-assignment
# A target-specific variable value is created for each matching member of the target list individually.

# If a target matches more than one pattern, the variables with longer target pattern stems are interpreted first.
# This results in values for more specific patterns taking precedence over the more generic ones.
t1%: cool_var:=No# Takes precedence over an inherited value
%_ps_var_t1: cool_var:=The one with the shortest stem.# A regular ts variable (no stem) would take precedence over this.
demo%: cool_var:=There was only one matching pattern.
%r_t3: cool_var:=Stem lengths were the same, so the last one in the file.

############################ Execution Output #############################

# $ make -f gnu_make_tut_27-variable_pattern_specific.mak
# t1_prereq
# Inherited?
# No
#
# demo_ps_var_t1
# Question: Which assignment took precedence?
# Answer: The one with the shortest stem.
#
# demo_ps_var_t2
# Question: Which assignment took precedence?
# Answer: There was only one matching pattern.
#
# demo_ps_var_t3
# Question: Which assignment took precedence?
# Answer: Stem lengths were the same, so the last one in the file.
#
