# https://www.gnu.org/software/make/manual/html_node/Canned-Recipes.html#Canned-Recipes
#
# When the same sequence of commands is useful in making various targets,
# you can define it as a canned sequence with the 'define' directive, and refer
# to the canned sequence from the recipes for those targets.
############################ Example Make Code ############################
# The canned sequence is actually a variable, so the name must not conflict with other variable names.
# Variables defined by define are recursively expanded.
define run-canned =
echo Running canned recipe for target "$@".
echo Almost Finished
touch $@
echo Done
echo
endef

OBJECTS = can_one can_two

all: $(OBJECTS)
can_%:
# NOTE: prefix characters on the recipe line that refers to a canned sequence apply to every line in the sequence
	@$(run-canned)


.PHONY: all
clean:
	rm -rf $(OBJECTS)

############################ Execution Output #############################

# $ make -f gnu_make_tut_17-canned_recipes.mak
# Running canned recipe for target can_one.
# Almost Finished
# Done
#
# Running canned recipe for target can_two.
# Almost Finished
# Done
#

# $ make -f gnu_make_tut_17-canned_recipes.mak
# make: Nothing to be done for 'all'.
