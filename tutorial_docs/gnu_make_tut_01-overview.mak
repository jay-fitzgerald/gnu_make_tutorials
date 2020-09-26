# Tutorial Page: https://makefiletutorial.com
#
# A Makefile consists of a set of *rules*. A rule generally looks like this:
# targets : prerequisities
#	command
#	command
#	command
#
# * The targets are file names, seperated by spaces. Typically, there is only one per rule.
# * The commands are a series of steps typically used to make the target(s). ** These need to start with a tab character, not spaces. **
# * The prerequisites are also file names, seperated by spaces. These files need to exist before the commands for the target are run.
# * The commands for a rule make what's called a *recipe*.
# * https://www.gnu.org/software/make/manual/html_node/Recipe-Syntax.html#Recipe-Syntax
#
# It's recommended that you display tabs and spaces when viewing makefiles.
############################ Example Make Code ############################
# Makefiles are typically named "makefile", or "Makefile".
# Included makefiles or sub-make files might be given a special name and an extension, such
# as ".mk" or ".mak". If there's a convention for this, I haven't found it in the documentation.

# Since the blah target is first, it is the default target and will be run when we run "make"
blah: blah.o
	gcc blah.o -o blah

# blah.o prereq takes us here
blah.o: blah.c
	gcc -c blah.c -o blah.o

# blah.c prereq takes us here
blah.c:
	echo "int main() { return 0; }" > blah.c

clean:
	rm -f blah.o blah.c blah

############################ Execution Output #############################
# NOTE: to run the example, cd to the directory with cygwin and run the displayed command ($ make ...)

# $ make -f gnu_make_tut_01-overview.mak
# echo "int main() { return 0; }" > blah.c
# gcc -c blah.c -o blah.o
# gcc blah.o -o blah

# NOTE: Some examples, like the above, have a target called "clean". Run it via "make clean" to delete the files that make generated:

# $ make -f gnu_make_tut_01-overview.mak clean
# rm -f blah.o blah.c blah