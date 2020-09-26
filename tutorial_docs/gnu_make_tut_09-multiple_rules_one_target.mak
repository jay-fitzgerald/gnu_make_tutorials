# https://www.gnu.org/software/make/manual/html_node/Multiple-Rules.html#Multiple-Rules
############################ Example Make Code ############################
# You can list the same target in multiple rules.
# The prereqs for that target will be merged into one list and any rebuilt prereq will
# cause the target to be rebuilt.

all: multi_rule_target

# A target appearing in multiple rules can only have one recipe.
multi_rule_target: mrt_prereq1 mrt_prereq2
	echo This recipe is overriden by a later recipe, \
		so it will never execute.
multi_rule_target: mrt_prereq3
	echo This recipe overrode the other $@ recipe.
multi%:
# This is a type of implicit rule called a static pattern rule.
# Make only searches for implicit rules to provide a target recipe if no explicit rule provides one.
# Therefore, an implicit rule cannot override an explicit rule.
	echo This pattern rule recipe overrode the other $@ recipe. # No it didn't!

mrt_prereq1 mrt_prereq2:
	echo $@
mrt_prereq3:
	touch $@

.PHONY: all
clean:
	rm -f mrt_prereq3

############################ Execution Output #############################

# $ make -f gnu_make_tut_09-multiple_rules_one_target.mak
# makefile:16: warning: overriding commands for target `multi_rule_target'
# makefile:13: warning: ignoring old commands for target `multi_rule_target'
# touch mrt_prereq3
# echo mrt_prereq1
# mrt_prereq1
# echo mrt_prereq2
# mrt_prereq2
# echo This recipe overrode the other multi_rule_target recipe.
# This recipe overrode the other multi_rule_target recipe.

# $ make -f gnu_make_tut_09-multiple_rules_one_target.mak
# makefile:16: warning: overriding commands for target `multi_rule_target'
# makefile:13: warning: ignoring old commands for target `multi_rule_target'
# echo mrt_prereq1
# mrt_prereq1
# echo mrt_prereq2
# mrt_prereq2
# echo This recipe overrode the other multi_rule_target recipe.
# This recipe overrode the other multi_rule_target recipe.
