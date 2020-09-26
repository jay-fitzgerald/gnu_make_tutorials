# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Functions.html#Functions
# The result of a function’s processing is substituted into the makefile at
# the point of the call, just as a variable might be substituted.
#
# A function call is used for text processing, can appear anywhere a variable
# reference can appear and **is expanded using the same rules as variable references.**
#
# For recap, this means they are expanded when read, except if they appear
# in a recipe or the definition of a variable assignment with deferred expansion.
#
# **** Syntax ****
# $(<function> <arg1>[,<arg2>[,<arg3>...]])
# You can also use braces {} instead of parentheses.
# Spaces in arg2 or later will be seen as part of the argument.
#
# Use the execution output as quick reference for text functions.
############################ Example Make Code ############################
.PHONY: all
.SILENT:
all: demo_subst demo_strip demo_findstring demo_filter demo_filter_out demo_sort \
     demo_word demo_firstword demo_lastword demo_wordlist demo_words

# **** String Substitution and Analysis Functions ****
# https://www.gnu.org/software/make/manual/html_node/Text-Functions.html#Text-Functions
# $(subst from,to,text)                # substitute <to> for <from> in <text>
# $(patsubst pattern,replacement,text) # same but with patterns; use subst. refs, instead (see tut_22)
# $(strip string)                      # remove surrounding whitespace & condense internal w.s. into single spaces
# $(findstring find,in)                # searches <in> for an occurrence of <find>, returning <find> or empty string
# $(filter pattern…,text)              # returns words in <text> that match any of the <pattern> words; use % in patterns
# $(filter-out pattern…,text)          # returns words that don't match any patterns
# $(sort list)                         # returns lexically-sorted words of <list> w/o duplicates, separated by single spaces
# $(word n,text)                       # returns the nth word of <text> (1-based indexing) or empty string if n is too large
# $(firstword n,text)                  # returns the first word of <text>
# $(lastword n,text)                   # returns the last word of <text>
# $(wordlist s,e,text)                 # returns words s...e of <text> (1-based indexing) or empty string if s is too large or s>e
# $(words text)                        # returns number of words in <text>

# **** Function DON'Ts ****
# 1. Don't put a commented function in a recipe
#    Anything tabbed is expanded and passed to the shell.
#    Make only treats it as a comment if the # appears before the tab.
# 2. Don't try to expand a variable to provide the name of the function
#    fn_name := subst
#    $($(fn_name) A,B,ABC) # Evaluates to empty string
# 3. Don't use a single variable to provide more than one function argument
#    Make identifies func args before any necessary expansion is performed; a ref to a variable with commas or spaces is just one arg
#    args := A,B,ABC
#    $(subst $(args)) # insufficient arguments

str_to_search := Where? Near? There? Everywhere!
subst_fn_call         = $(subst A,B,ABC)
# If we passed an unquoted variable for the next line's arg,
# the spaces would be condensed before getting passed to the shell.
strip_fn_call         = $(strip I  have a    lot of  whitespace    )
findstring_fn_call    = $(findstring here,$(str_to_search))
filter_fn_call        = $(filter %here?,$(str_to_search))
filter_out_fn_call    = $(filter-out %here?,$(str_to_search))
sort_fn_call          = $(sort $(str_to_search))
word_fn_call          = $(word 2,$(str_to_search))
firstword_fn_call     = $(firstword $(str_to_search))
lastword_fn_call      = $(lastword $(str_to_search))
wordlist_fn_call      = $(wordlist 2,3,$(str_to_search))
words_fn_call         = $(words $(str_to_search))
demo_%: start_demo
# **** The Value Function ****
# https://www.gnu.org/software/make/manual/html_node/Value-Function.html#Value-Function
# By using the value function, we are passing the unexpanded value of a variable to the shell.
# By using single quotes, we prevent the shell from trying to expand the value.
	printf "%-45s %-s\n" '$(value $*_fn_call)': '$($*_fn_call)'
start_demo:
	echo demo_text_functions
	echo '$$(str_to_search)': $(str_to_search)
	echo Output is aligned for readability
	echo ----------------------------------

############################ Execution Output #############################

# $ make -f gnu_make_tut_31-function_basics.mak
# demo_text_functions
# $(str_to_search): Where? Near? There? Everywhere!
# Output is aligned for readability
# ----------------------------------
# $(subst A,B,ABC):                             BBC
# $(strip I  have a    lot of  whitespace    ): I have a lot of whitespace
# $(findstring here,$(str_to_search)):          here
# $(filter %here?,$(str_to_search)):            Where? There?
# $(filter-out %here?,$(str_to_search)):        Near? Everywhere!
# $(sort $(str_to_search)):                     Everywhere! Near? There? Where?
# $(word 2,$(str_to_search)):                   Near?
# $(firstword $(str_to_search)):                Where?
# $(lastword $(str_to_search)):                 Everywhere!
# $(wordlist 2,3,$(str_to_search)):             Near? There?
# $(words $(str_to_search)):                    4
