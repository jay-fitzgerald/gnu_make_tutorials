# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Errors.html#Errors
############################ Example Make Code ############################
# The make tool will normally stop running a rule if a command returns a nonzero exit status.
# Any dependent targets will also stop trying to build.
# You can be left with a corrupt target.

# This special target causes all targets with a recipe that returns a nonzero
# exit status to be deleted. You should always use this.
.DELETE_ON_ERROR:

all: one two three

one:
	touch one
	false

# ** Flags for Continuing in the Face of Errors **
# The -k or --keep-going flag
# Pass this flag to continue considering the prereqs of other targets after an error occurs.
# Any target for which an error occurs will still abort.
# The -i or --ignore-errors flag
# Pass this flag to ignore all errors. Recipes with errors will just keep executing.
# DON'T DO THIS!


# Any prereqs for this special target will ignore all errors in their recipes.
# If no prereqs are listed, this has the same effect as the -i flag.
# This target is only supported for historical purposes and should generally not be used.
.IGNORE: two

# The error for this target will be printed but ignored (because of .IGNORE), and make will continue to run
two:
	touch two
	false


# Add a “-“ before a command to suppress the error (if it returns one).
three:
# This error will be printed but ignored, and make will continue to run
	-false
	touch three

.PHONY: all clean
clean:
	rm -f one two three

############################ Execution Output #############################

# $ make -f gnu_make_tut_14-errors_in_recipes.mak -k
# touch one
# false
# make: *** [makefile:17: one] Error 1
# make: *** Deleting file 'one'
# touch two
# false
# make: [makefile:36: two] Error 1 (ignored)
# false
# make: [makefile:42: three] Error 1 (ignored)
# touch three
# make: Target 'all' not remade because of errors.
