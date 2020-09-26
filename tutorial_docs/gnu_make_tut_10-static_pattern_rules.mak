# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Static-Pattern.html#Static-Pattern
#
# A static pattern allows a rule with multiple targets to generate a different prereq list for each target.
# targets ...: target-pattern: prereq-patterns ...
# 	commands
#
# Each target is matched by the target-pattern (via a % wildcard).
# Whatever was matched is called the *stem*. 
# The stem is then substituted into the % in the prereq-pattern, to generate the target’s prereqs.
# Each pattern normally only has one wildcard. Not all prereq patterns have to have a wildcard.
############################ Example Make Code ############################
# A typical use case is to compile .c files into .o files.
objects = foo.o bar.o
all: $(objects)
.PHONY: all

# Syntax - targets ...: target-pattern: prereq-patterns ...
# In the case of the first target, foo.o, the target-pattern matches foo.o and sets the "stem" to be "foo".
# It then replaces that stem with the wildcard pattern in prereq-patterns
$(objects): %.o: %.c
# The automatic variable $@ matches the target, and $< matches the prerequisite
	echo "Call gcc to generate $@ from $<"

# If we were worried about mixed file types in $(objects), we could use a filter in the target list.
# $(filter %.o,$(objects)): %.o: %.c
# https://www.gnu.org/software/make/manual/html_node/Text-Functions.html#Text-Functions

# Matches all .c files and creates them if they don't exist
%.c:
	touch $@

clean:
	rm -f foo.c bar.c

############################ Execution Output #############################

# $ make -f gnu_make_tut_10-static_pattern_rules.mak
# touch foo.c
# echo "Call gcc to generate foo.o from foo.c"
# Call gcc to generate foo.o from foo.c
# touch bar.c
# echo "Call gcc to generate bar.o from bar.c"
# Call gcc to generate bar.o from bar.c
