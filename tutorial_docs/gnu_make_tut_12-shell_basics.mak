# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Recipe-Syntax.html#Recipe-Syntax
# https://www.gnu.org/software/make/manual/html_node/Echoing.html#Echoing
# https://www.gnu.org/software/make/manual/html_node/Execution.html#Execution
############################ Example Make Code ############################
# Most of the makefile uses make syntax
# The recipes are meant for the shell and written in shell syntax
# Tabbed comments get passed to the shell

all: print_stuff print_pwd print_shell

# Command Echoing/Silencing
# Add an @ before a command to stop it from being printed
# You can also run make with -s; this equates to a @ before every recipe line
print_stuff:
	@echo "This make line will not be printed"
	echo "But this will"
	@echo

# Command Execution
# Each command is run in a new shell (or at least the affect is as such)
print_pwd:
	echo `pwd`
	cd ..
	# The cd above does not affect this line, because each command is effectively run in a new shell
	echo `pwd`

	# This cd command affects the next because they are on the same line
	cd ..;echo `pwd`

	# Same as above
	cd ..; \
	echo `pwd`
	@echo


# Default Shell
# The default shell is /bin/sh.
# You can change this by changing the variable SHELL.
# Unlike most variables, the variable SHELL is never set from the environment (except on Windows).
# https://www.gnu.org/software/make/manual/html_node/Choosing-the-Shell.html#Choosing-the-Shell
SHELL = /bin/bash

# If we set SHELL to a unix shell that can't be found, the value would remain unchanged
# This behavior is specific to MS-DOS/Windows.
print_shell:
# You'll notice that make interprets $(SHELL) before passing the recipe line
	echo "Hello from $(SHELL)"
# If we use $${SHELL}, then ${SHELL} is passed to the shell, which tries to interpret a variable
# The make value for this variable overrides the default environment value (/bin/bash), but only on Windows/MS-DOS
# On other systems, the value of SHELL inherited from the environment, if any, is exported
	echo "Hello from $${SHELL}"

.PHONY: all
############################ Execution Output #############################

# $ make -f gnu_make_tut_12-shell_basics.mak
# This make line will not be printed
# echo "But this will"
# But this will
#
# echo `pwd`
# /cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs
# cd ..
# # The cd above does not affect this line, because each command is effectively run in a new shell
# echo `pwd`
# /cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs
# # This cd command affects the next because they are on the same line
# cd ..;echo `pwd`
# /cygdrive/c/git_roots/programming/gnu_make
# # Same as above
# cd ..; \
# echo `pwd`
# /cygdrive/c/git_roots/programming/gnu_make
#
# echo "Hello from /bin/bash"
# Hello from /bin/bash
# echo "Hello from ${SHELL}"
# Hello from /bin/bash
