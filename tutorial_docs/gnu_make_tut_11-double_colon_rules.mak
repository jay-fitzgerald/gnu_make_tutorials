# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Double_002dColon.html#Double_002dColon
############################ Example Make Code ############################
# Double-Colon Rules are rarely used, but allow the same target to run commands from multiple targets.
# If these were single colons, a warning would be printed and only the second set of commands would run.
# Use Case: They provide a mechanism for cases in which the method used to update a target differs depending on which
#           prerequisite files caused the update, and such cases are rare.

# When a target appears in multiple rules, all the rules must be the same type: all ordinary, or all double-colon.
# Double-Colon rules are treated independently, in the order they appear in the makefile.
all: blah

# A double-colon rule with no prereqs is always executed, (even if the target already exists).
blah::
	echo "hello"

blah::
	echo "hello again"

# Even a double-colon rule WITH prereqs is always executed, if the prereq does not exist.
blah:: bleh
	echo "Gross!"

bleh:
	touch blah
	echo "Yuck!"

# Double colons have a different meaning in a pattern rule, but we won't get in to that, right now.

clean:
	rm -f blah

.PHONY: all

############################ Execution Output #############################

# $ make -f gnu_make_tut_11-double_colon_rules.mak
# echo "hello"
# hello
# echo "hello again"
# hello again
# touch blah
# echo "Yuck!"
# Yuck!
# echo "Gross!"
# Gross!

# $ make -f gnu_make_tut_11-double_colon_rules.mak
# echo "hello"
# hello
# echo "hello again"
# hello again
# touch blah
# echo "Yuck!"
# Yuck!
# echo "Gross!"
# Gross!
