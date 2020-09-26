# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Conditional-Syntax.html#Conditional-Syntax
# https://www.gnu.org/software/make/manual/html_node/Testing-Flags.html#Testing-Flags
############################ Example Make Code ############################
.PHONY: all clean
.SILENT:
all: demo_test_empty_string demo_test_makeflags
clean:
	rm -f demo*
# Often you want to test if a variable has a non-empty value.
# When the value results from complex expansions of variables and functions:
# 1. You can not use ifdef (because it doesn't expand variables)
# 2. The result may contain whitespace characters, making it non-empty
# So how should we do it? Use the strip function.
# https://www.gnu.org/software/make/manual/html_node/Text-Functions.html#Text-Functions
nullstring =
foo = $(nullstring) # end of line; there is a space here
demo_test_empty_string:
	echo $@
ifeq ($(foo),)
	echo "foo is empty"
else ifeq ($(strip $(foo)),)
	echo "foo is empty after being stripped"
endif
	touch $@
	echo

# You can test for makeflags
# The example of why you would want to do this that the reference gives
# is if you wanted to check for -t because touch is not enough to make
# a file appear up-to-date.
demo_test_makeflags:
	echo $@
# The findstring function determines whether one string appears as a substring of another.
ifneq (, $(findstring i,$(MAKEFLAGS)))
	echo You want to ignore errors? Are you nuts?
endif

############################ Execution Output #############################

# $ make -f gnu_make_tut_30-conditionals_with_functions.mak -i
# demo_test_empty_string
# foo is empty after being stripped
#
# demo_test_makeflags
# You want to ignore errors? Are you nuts?

# $ make -f gnu_make_tut_30-conditionals_with_functions.mak
# demo_test_makeflags
