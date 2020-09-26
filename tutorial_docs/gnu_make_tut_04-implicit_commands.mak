# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/make-Deduces.html#make-Deduces
############################ Example Make Code ############################
# Probably one of the most confusing parts about Make is the hidden coupling between Make and GCC.
# Make was largely made for GCC, and so makes compiling C/C++ programs “easy”.

# This variable will cause make to use gcc, instead of cc.
# https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html#Implicit-Variables
CC = gcc

# Implicit command of: "cc blah.o -o blah"
# Note: Do not put a comment inside of the blah.o rule; the implicit rule will not run!
blah:

# Implicit command of: "cc -c blah.c -o blah.o"
blah.o:

# no implicit command used for blah.c
# these comments are not part of the blah.o recipe, because they are not tabbed.
blah.c:
	echo "int main() { return 0; }" > blah.c

clean:
	rm -f blah.o blah blah.c

############################ Execution Output #############################

# $ make -f gnu_make_tut_04-implicit_commands.mak
# echo "int main() { return 0; }" > blah.c
# gcc    -c blah.c -o blah.o
# gcc   blah.o   -o blah
