# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Multiple-Targets.html#Multiple-Targets
############################ Example Make Code ############################
# When there are multiple targets for a rule, the commands will be run for each target

all: f1.a f2.a f3.b f4.b foo bar

# An explicit rule with independent targets.
# This is equivalent to writing the same rule once for each target, with duplicated prerequisites and recipes.
# This type of rule does not have to have a recipe.
# $@ is a automatic variable that contains the target name.
f1.a f2.a:
	echo $@

# We can use the wildcard % in targets, that captures zero or more of any character.
# Unlike with *, it will expand to match a target/prerequisite/goal even if no file with that name exists.
%.b:
	echo $@

# An explicit rule with grouped targets, indicated by the "&:".
# This is intended for use with a recipe that generates multiple files.
# NOTE: Feature added in GNU Make 4.3; pattern rules already supported this
foo bar baz &:
	touch foo
	touch bar
	touch baz

.PHONY: all
clean:
	rm -f *.a *.b foo bar baz

############################ Execution Output #############################

# $ make -f gnu_make_tut_08-multiple_targets.mak
# echo f1.a
# f1.a
# echo f2.a
# f2.a
# echo f3.b
# f3.b
# echo f4.b
# f4.b
# touch foo
# touch bar
# touch baz
