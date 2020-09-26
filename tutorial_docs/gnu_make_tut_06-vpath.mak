# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/General-Search.html#General-Search
# https://www.gnu.org/software/make/manual/html_node/Selective-Search.html#Selective-Search
#
# Use vpath to specify search directories for target or prerequisite files not found in the current directory.
# Usage:
# vpath <pattern> <directories> # Specify the search path directories for file names that match pattern.
# vpath pattern                 # Clear out the search path associated with pattern.
# vpath                         # Clear all search paths previously specified with vpath directives.
# directories are separated by spaces (preferable) or colons (semicolons, instead on DOS or Windows)
# <pattern> can have a %, which matches any zero or more characters.
# There is also the VPATH variable:
# VPATH = <directories>
#
# Target, Prerequisite directory search order:
# 1. Current directory
# 2. All directories (in order listed) for each directive (in the order listed) with a matching pattern
#    Multiple directives with the same pattern are treated independently, when processing directives.
# 3. VPATH directories
############################ Example Make Code ############################
vpath %.h ../headers ../other-directory

some_binary: ../headers blah.h blah2.h blah3.h
	touch some_binary
# https://www.gnu.org/software/make/manual/html_node/Search-Algorithm.html#Search-Algorithm
# For prerequisites found through directory search the path used in the prerequisite list varies.
# If the prereq does not need to be rebuilt, the path found through directory search is used.
# If the prereq needs to be rebuilt, the filename specified in the prerequsite list is used.
# You can make it always use the path found through directory search if you use GPATH, rather than vpath or VPATH.
# https://www.gnu.org/software/make/manual/html_node/Recipes_002fSearch.html#Recipes_002fSearch
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables
# Since recipes execute as written, if you need the recipe to access the path found in directory search
# you have to use an automatic variable, such as $^.
#
# On the 1st execution, this next line will print the prereqs as listed.
# On the 2nd execution, this next line will print the prereqs as listed, except blah.h,
# because it is the only prereq found (with a different path) through directory search that is not rebuilt.
	echo $^

../headers:
	mkdir ../headers

blah.h:
	touch ../headers/blah.h
blah2.h:
	echo blah2.h
blah3.h: blah2.h
# This will be rebuilt because of blah2.h
	touch ../headers/blah3.h

clean:
	rm -rf ../headers
	rm -f some_binary

############################ Execution Output #############################

# $ make -f gnu_make_tut_06-vpath.mak
# mkdir ../headers
# touch ../headers/blah.h
# echo blah2.h
# blah2.h
# touch ../headers/blah3.h
# touch some_binary
# echo ../headers blah.h blah2.h blah3.h
# ../headers blah.h blah2.h blah3.h

# $ make -f gnu_make_tut_06-vpath.mak
# echo blah2.h
# blah2.h
# touch ../headers/blah3.h
# touch some_binary
# echo ../headers ../headers/blah.h blah2.h blah3.h
# ../headers ../headers/blah.h blah2.h blah3.h
