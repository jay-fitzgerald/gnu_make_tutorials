# Tutorial Page: https://makefiletutorial.com
# You can consider each of the prerequisites of 'all' as separate examples.
#
# Key takeaway: if a target matches an existing file or directory that target
# will not be rebuilt, unless it has a pre-requisite that must be rebuilt.
#
# We say rebuilt (but we mean running the recipe) because if it exists as a file or folder, we consider it built.
############################ Example Make Code ############################
# The default target is the first target, so it will run if no target is specifed when make is called
# The default target is typically named "all": https://www.gnu.org/software/make/manual/html_node/Standard-Targets.html#Standard-Targets
all: print_target_info some_file1 some_file2 some_file3 some_file4 some_file5 some_file6

print_target_info:
	echo making target "all"
	echo target all has prerequisites: some_file1 some_file2 some_file3 some_file4 some_file5 some_file6

# We never run a command that creates a file named some_file1, so the commands for this target will always run.
some_file1:
	echo making some_file1
	echo "This line will always print"

# touch marks a target up-to-date without actually changing it.
# If that target is a file which does not exist, it will create an empty file. That's how the bash command 'touch' works.
# This will make some_file2 the first time, and the second time notice it’s already made, resulting in make: 'some_file2' is up to date.
some_file2:
	echo making some_file2
	echo "This line will only print once"
	touch some_file2

# The first command line for a target may be attached to the target-and-prerequisites line with a semicolon in between
# This is not true of other command lines.
some_file3: ; touch some_file3
	echo making some_file3
	echo "This line will only print once"

# The backslash (“\”) character gives us the ability to use multiple lines when the commands are too long
some_file4: 
	echo making some_file4
	echo This line is too long, so \
		it is broken up into multiple lines

# Here, the target some_file5 “depends” on other_file1.
# When we run make, the default target (all, since it’s first) will get called and it will eventually call the prereq some_file5.
# some_file5 will first look at its list of dependencies, and if any of them are older, it will first run the targets for those dependencies, and then run itself.
# The second time this is run, neither target will run because both targets exist.
some_file5: other_file1
	echo making some_file5
	echo "This will run after other_file1, because it depends on other_file1"
	touch some_file5

other_file1:
	echo making other_file1
	echo "This will run before some_file5"
	touch other_file1

# This will always make both targets, because some_file6 depends on other_file2, which is never created.
some_file6: other_file2
	echo making some_file6
	touch some_file6

other_file2:
	echo making other_file2
	echo "nothing"


# Prerequisites of .PHONY are considered phony targets
# The commands for those targets are run unconditionally (when considered),
# regardless of whether a file with that name exists or what its last-modification time is.
# https://www.gnu.org/software/make/manual/html_node/Special-Targets.html#Special-Targets
.PHONY: all clean

# “clean” is often used as a target that removes the output of other targets.
# This is a standard target name, like all, not a special target name.
clean:
	echo "making clean (removing files)"
	rm -f some_file*
	rm -f other_file*

# The normal behavior of make is to echo (print to console) each command before running it.
# This can be turned off for a single command by beginning it with @
# The ‘-s’ or ‘--silent’ flag to make prevents all echoing, as if all recipes started with ‘@’.
# A rule in the makefile for the special target .SILENT without prerequisites has the same effect
# If you specify prerequisites, echoing will be turned off just for the those targets
# https://www.gnu.org/software/make/manual/html_node/Echoing.html
.SILENT: 
# The commands for .SILENT are not meaningful.

############################ Execution Output #############################
# Don't forget to run "make -f gnu_make_tut_02-simple_examples.mak clean" afterwards!

# $ make -f gnu_make_tut_02-simple_examples.mak
# making target all
# target all has prerequisites: some_file1 some_file2 some_file3 some_file4 some_file5 some_file6
# making some_file1
# This line will always print
# making some_file2
# This line will only print once
# making some_file3
# This line will only print once
# making some_file4
# This line is too long, so it is broken up into multiple lines
# making other_file1
# This will run before some_file5
# making some_file5
# This will run after other_file1, because it depends on other_file1
# making other_file2
# nothing
# making some_file6

# $ make -f gnu_make_tut_02-simple_examples.mak
# making target all
# target all has prerequisites: some_file1 some_file2 some_file3 some_file4 some_file5 some_file6
# making some_file1
# This line will always print
# making some_file4
# This line is too long, so it is broken up into multiple lines
# making other_file2
# nothing
# making some_file6

# $ make  -f gnu_make_tut_02-simple_examples.mak clean
# making clean (removing files)

# NOTE: The next run of "make" would give us the original output, again.

