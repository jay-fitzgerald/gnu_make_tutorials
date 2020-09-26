# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Variables-Simplify.html#Variables-Simplify
############################ Example Make Code ############################
# Variables can only be strings. Here’s an example of using them:

files = file1 file2
some_file: $(files)
	echo "Look at this variable: " $(files)
	touch some_file

file1:
	touch file1
file2:
	touch file2

# It is standard practice for every makefile to have a variable named objects, OBJECTS, objs, OBJS,
# obj, or OBJ which is a list of all object file names. We won't demonstrate that here, though.
    
clean:
	rm -f file1 file2 some_file

############################ Execution Output #############################

# $ make -f gnu_make_tut_03-variables.mak
# touch file1
# touch file2
# echo "Look at this variable: " file1 file2
# Look at this variable:  file1 file2
# touch some_file

# $ make -f gnu_make_tut_03-variables.mak
# make: 'some_file' is up to date.
