# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Recursion.html#Recursion
############################ Example Make Code ############################
# When you want separate makefiles for various subsystems that compose a larger system,
# you can use make as a command in a makefile.

OBJECTS = hello varExport1 varExport2 varExport3 varExport4 varExport5 shellVarExport
all: $(OBJECTS)
	@echo MAKELEVEL is $(MAKELEVEL)

# *** Basic Sub-make Call ***
# Use the special $(MAKE) instead of “make” for this call.
# This will allow us to use the exact same version of make for the recursive invocation.
# It will also pass the make flags for you, but the line invoking make won’t, itself, be affected by
# the -n -t and -q options (which prevent other recipe lines from running unless they begin with '+').
hello_make_contents = "hello:\n\ttouch inside_file"
hello:
	mkdir -p $@
	echo -e $($@_make_contents) | sed -e 's/^ //' > $@/makefile
	cd $@ && $(MAKE)
	@echo

# *** Variables and Sub-Make ***
# Except by explicit request, make exports a variable only if it is either defined in the environment
# initially or set on the command line, and if its name consists only of letters, numbers, and underscores.
#
# The export directive takes a variable and makes it accessible to sub-make commands.
# You can define/update a variable and export it in the same line.
# Note: export has the same syntax as sh, but they aren’t related (although similar in function)
cool = "The subdirectory can't see me, because I'm not exported!"
export cooly = "The subdirectory can see me!"
# unexport can be used to prevent a variable from being passed on, e.g.:
# unexport cooly
#
# Using export or unexport by itself (no variable passed) causes all variables to be exported/unexported.
# export or unexport by itself will not override an export/unexport that explicitly mentions a variable.
# You cannot use export and unexport to have variables exported for some recipes and not for others.
# The last export or unexport directive determines the behavior for the entire run of make.
varExport1_make_contents = "hello:\n\\techo \$$(cool)"
varExport2_make_contents = "hello:\n\\techo \$$(cooly)"
varExport3_make_contents = "cooly=\"This definition overrides the exported variable that was passed!\"\nhello:\n\\techo \$$(cooly)"
varExport4_make_contents = "cooly=\"This definition is overridden by the exported variable because of the flag!\"\nhello:\n\\techo \$$(cooly)"
varExport4_make_flags = "-e"
varExport5_make_contents = "hello:\n\\t@echo \"MAKELEVEL was automatically set!\"\n\\t@echo MAKELEVEL is \$$(MAKELEVEL)"
# MAKEFLAGS is exported by default.
# MAKEFILES is exported if set.
# MAKEFILES serves as a list of extra makefiles for the sub-make to read before the ones specified with "include <other_makefile>".
# .EXPORT_ALL_VARIABLES: has the same effect as export by itself, but is compatible with older versions of make.
varExport%:
	mkdir -p $@
	echo -e $($@_make_contents) | sed -e 's/^ //' > $@/makefile
	@echo "---MAKEFILE CONTENTS---"
	@cd $@ && cat makefile
	@echo "---END MAKEFILE CONTENTS---"
	cd $@ && $(MAKE) $($@_make_flags)
	@echo

# *** Variables and Shell ***
# You need to export variables for the shell to be able to see them
one=this unexported variable is only seen by make
export two=the shell sees this exported variable
shellVarExport:
	@echo Make Expansion: $(one)
	@echo Shell Expansion: $$one
	@echo Make Expansion: $(two)
	@echo Shell Expansion: $$two
	echo

# Variables defined on the command line are passed down to Sub-Make
# through MAKEOVERRIDES via a reference to MAKEOVERRIDES in MAKEFLAGS

.DELETE_ON_ERROR:
.PHONY: all
clean:
	rm -rf $(OBJECTS)

############################ Execution Output #############################
# With all these targets, we may as well run jobs in parallel.

# $ make -f gnu_make_tut_16-recursive_use_of_make.mak -j4 --output-sync=recurse
# mkdir -p hello
# echo -e "hello:\n\ttouch inside_file" | sed -e 's/^ //' > hello/makefile
# cd hello && make
# make[1]: Entering directory '/cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/hello'
# touch inside_file
# make[1]: Leaving directory '/cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/hello'
#
# mkdir -p varExport2
# echo -e "hello:\n\\techo \$(cooly)" | sed -e 's/^ //' > varExport2/makefile
# ---MAKEFILE CONTENTS---
# hello:
#         echo $(cooly)
# ---END MAKEFILE CONTENTS---
# cd varExport2 && make
# make[1]: Entering directory '/cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/varExport2'
# echo "The subdirectory can see me!"
# The subdirectory can see me!
# make[1]: Leaving directory '/cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/varExport2'
#
# mkdir -p varExport1
# echo -e "hello:\n\\techo \$(cool)" | sed -e 's/^ //' > varExport1/makefile
# ---MAKEFILE CONTENTS---
# hello:
#         echo $(cool)
# ---END MAKEFILE CONTENTS---
# cd varExport1 && make
# make[1]: Entering directory '/cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/varExport1'
# echo
#
# make[1]: Leaving directory '/cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/varExport1'
#
# mkdir -p varExport3
# echo -e "cooly=\"This definition overrides the exported variable that was passed!\"\nhello:\n\\techo \$(cooly)" | sed -e 's/^ //' > varExport3/makefile
# ---MAKEFILE CONTENTS---
# cooly="This definition overrides the exported variable that was passed!"
# hello:
#         echo $(cooly)
# ---END MAKEFILE CONTENTS---
# cd varExport3 && make
# make[1]: Entering directory '/cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/varExport3'
# echo "This definition overrides the exported variable that was passed!"
# This definition overrides the exported variable that was passed!
# make[1]: Leaving directory '/cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/varExport3'
#
# Make Expansion: this unexported variable is only seen by make
# Shell Expansion:
# Make Expansion: the shell sees this exported variable
# Shell Expansion: the shell sees this exported variable
# echo
#
# mkdir -p varExport4
# echo -e "cooly=\"This definition is overridden by the exported variable because of the flag!\"\nhello:\n\\techo \$(cooly)" | sed -e 's/^ //' > varExport4/makefile
# ---MAKEFILE CONTENTS---
# cooly="This definition is overridden by the exported variable because of the flag!"
# hello:
#         echo $(cooly)
# ---END MAKEFILE CONTENTS---
# cd varExport4 && make "-e"
# make[1]: Entering directory '/cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/varExport4'
# echo "The subdirectory can see me!"
# The subdirectory can see me!
# make[1]: Leaving directory '/cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/varExport4'
#
# mkdir -p varExport5
# echo -e "hello:\n\\t@echo \"MAKELEVEL was automatically set!\"\n\\t@echo MAKELEVEL is \$(MAKELEVEL)" | sed -e 's/^ //' > varExport5/makefile
# ---MAKEFILE CONTENTS---
# hello:
#         @echo "MAKELEVEL was automatically set!"
#         @echo MAKELEVEL is $(MAKELEVEL)
# ---END MAKEFILE CONTENTS---
# cd varExport5 && make
# make[1]: Entering directory '/cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/varExport5'
# MAKELEVEL was automatically set!
# MAKELEVEL is 1
# make[1]: Leaving directory '/cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/varExport5'
#
# MAKELEVEL is 0
