# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Wildcards.html#Wildcards
############################ Example Make Code ############################
# We can use wildcards in the target, prerequisites, or commands.
# Valid wildcards are *, ?, [...]
# * matches any string of 0 or more characters
# ? matches any one character
# [...] matches a single character from a set given in the brackets (like in a RegEx)

# To understand what actually happens here, see
# https://www.gnu.org/software/make/manual/html_node/Reading-Makefiles.html#Reading-Makefiles
# https://www.gnu.org/software/make/manual/html_node/Wildcard-Pitfall.html#Wildcard-Pitfall
# https://www.cmcrossroads.com/article/trouble-wildcard
# The wildcards in target and prerequisite sections are expanded by make (not the shell) immediately, before any recipe runs.
# Since no file match exists for *.c or *.d, the wildcard will be left unexpanded as if it were \*.c and \*.d
# If we run make twice, this will yield different behavior, because the wildcards will find matches the 2nd time.
# In short, be careful with wildcard expansion.
some_file: *.c *.d 

*.c:
	touch f1.c
	touch f2.c
*.d:
# The shell expands this next line when it runs.
	echo *.d

# We CANNOT use wildcards in other places, like variable declarations or function arguments
# Use the wildcard function instead: $(wildcard pattern…)
# Note 1: like with targets and prerequisites, the variable definition gets expanded immediately,
# leading to different behavior on a subsequent run.
# Note 2: Wilcard function behavior is different from other wildcard usage in that if no file name matches a pattern,
# that pattern is omitted from the output of the function (rather than being used verbatim).
wrong = *.o # Wrong
objects := $(wildcard *.e) # Right
other_file: 
	touch f1.e
	touch f2.e
	echo $(wrong)
	echo $(objects)

clean:
	rm -f *.c *.d *.e

############################ Execution Output #############################

# $ make -f gnu_make_tut_05-wildcards.mak some_file
# touch f1.c
# touch f2.c
# echo *.d
# *.d

# $ make -f gnu_make_tut_05-wildcards.mak some_file
# echo *.d
# *.d

# $ make -f gnu_make_tut_05-wildcards.mak other_file
# touch f1.e
# touch f2.e
# echo *.o
# *.o
# echo
#

# $ make -f gnu_make_tut_05-wildcards.mak other_file
# touch f1.e
# touch f2.e
# echo *.o
# *.o
# echo f1.e f2.e
# f1.e f2.e
