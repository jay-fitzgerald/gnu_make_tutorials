# Tutorial Page: https://makefiletutorial.com
############################ Example Make Code ############################
# Making multiple targets and you want all of them to run? Make a 'all' target and designate it as .PHONY
# 'all' is the standard default target, by convention.
# https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html#Phony-Targets
# https://www.gnu.org/software/make/manual/html_node/Standard-Targets.html#Standard-Targets
all: one two three

# Prerequisites of .PHONY are considered phony targets
# The commands for those targets are run unconditionally (when considered),
# regardless of whether a file with that name exists or what its last-modification time is.
# https://www.gnu.org/software/make/manual/html_node/Special-Targets.html#Special-Targets
.PHONY: all

one: print
	touch one
two:
	touch two
three: FORCE
	touch three

# A rule without prereqs or recipe for which the target does not exist will always run.
# This can be used to always rebuild targets that list such a target as a prereq.
# .PHONY is the better way to do this, but some versions of make do not support .PHONY.
# https://www.gnu.org/software/make/manual/html_node/Force-Targets.html#Force-Targets
FORCE:

# The empty target is a variant of the phony target, used to hold recipes for an action
# that you request explicitly from time to time. The file exists, but the contents don't
# matter and are usually empty.
# We have more or less been using these throughout our tutorials, but in reality
# an empty target should list prerequisites that control when it gets rerun.
# https://www.gnu.org/software/make/manual/html_node/Empty-Targets.html#Empty-Targets
print: two
	echo $?
	touch print

clean:
	rm -f one two three print
############################ Execution Output #############################

# $ make -f gnu_make_tut_07-all_and_phony_targets.mak
# touch two
# echo two
# two
# touch print
# touch one
# touch three

# $ make -f gnu_make_tut_07-all_and_phony_targets.mak
# touch three
