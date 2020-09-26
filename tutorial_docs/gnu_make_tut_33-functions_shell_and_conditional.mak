# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Conditional-Functions.html#Conditional-Functions
# Conditonal Functions provide conditional expansion for constructs (variables, functions, etc.).
# Any non-empty string is considered True, for the purpose of evaluating a condition.
#
# https://www.gnu.org/software/make/manual/html_node/Shell-Function.html#Shell-Function
# The shell funcion spawns a shell, runs the argument and returns the result.
# Newlines are converted to single spaces and any trailing newline is removed.
############################ Example Make Code ############################
.PHONY: all clean
.SILENT:
shell_demos := demo_shell1 demo_shell2 demo_shell3 demo_shell4
if_demos := demo_if1 demo_if2 demo_if3 demo_wildcard_if
or_demos := demo_or1 demo_or2 demo_wildcard_or
and_demos := demo_and1 demo_and2 demo_and3 demo_wildcard_and
all: $(shell_demos) $(if_demos) $(or_demos) $(and_demos)
clean:
	-rm demo_*

# **** Shell Function DON'Ts ****
# 1. Avoid using in a variable with deferred expansion.
#    Though you can, it will spawn a shell and evaluate the function each time
#    the variable is expanded, hurting performance.
# 2. Don't create or update files or directories during read-in.
#    $(shell touch new_file)           # evaluated immediately during read-in
#    var_a := $(shell touch new_file)  # evaluated immediately during read-in
# 3. Don't use outside of a recipe or a variable assignment.
#    We can't see or use the result, so it's pointless.

$(shell_demos): start_shell_demo
# Calls that will be demonstrated
# Deferred Expansion of $(shell ...) is only used here for demo purposes. Don't do it!
shell1_fn_call = $(shell echo I am using the shell function!)
# We redirect stderr to stdout; stderr would be printed at expansion time, before the recipe runs.
# Stdout gets returned as the result, instead of being printed.
shell2_fn_call = $(shell ls demo_* 2>&1)
shell3_fn_call = $(shell touch demo_shell)
shell4_fn_call = $(shell ls demo_* 2>&1)
# $(wildcard ...) is probably faster than $(shell ls...), but we're demoing shell.
# The shell function has other uses, such as reading the input of a file into a variable.

# **** Conditional Functions ****
# $(if condition,then-part[,else-part])          # result is expansion of <then-part> or <else-part> based on a condition
# $(or condition1[,condition2[,condition3…]])    # result of the last expansion is returned; short-circuits on a True condition
# $(and condition1[,condition2[,condition3…]])   # result of the last expansion is returned; short-circuits on a False condition
undefine e_str
space := $(e_str) #
$(if_demos): start_if_demo
# Calls that will be demonstrated
if1_fn_call         = $(if $(e_str),True,False)
if2_fn_call         = $(if $(space),True,False)
if3_fn_call         = $(if A,$(shell touch demo_if_true),False)
wildcard_if_fn_call = $(wildcard demo_if_true)

$(or_demos): start_or_demo
# Calls that will be demonstrated
or1_fn_call         = $(or $(e_str),$(space),True)
or2_fn_call         = $(or $(shell touch demo_or_1st),$(shell touch demo_or_2nd),Done)
# Can't use $(wildcard demo_or*) because make's cache does not know about the new files
# If we ran touch without the shell function, we would get different output.
wildcard_or_fn_call = $(wildcard demo_or_1st demo_or_2nd)

$(and_demos): start_and_demo
# Calls that will be demonstrated
and1_fn_call         = $(and 1st, 2nd, last)
and2_fn_call         = $(and True,$(e_str),False)
and3_fn_call         = $(and $(shell touch demo_and_1st),$(shell touch demo_and_2nd),last)
wildcard_and_fn_call = $(wildcard demo_and_1st demo_and_2nd)

start_%_demo:
	echo
	echo demo_$*_func
# Pattern rule for each of the calls that we demonstrate
demo_%:
	printf "%-68s %-s\n" '$(value $*_fn_call)': '$($*_fn_call)'

############################ Execution Output #############################

# $ make -f gnu_make_tut_33-functions_shell_and_conditional.mak
#
# demo_shell_func
# $(shell echo I am using the shell function!):                        I am using the shell function!
# $(shell ls demo_* 2>&1):                                             ls: cannot access demo_*: No such file or directory
# $(shell touch demo_shell):
# $(shell ls demo_* 2>&1):                                             demo_shell
#
# demo_if_func
# $(if $(e_str),True,False):                                           False
# $(if $(space),True,False):                                           True
# $(if A,$(shell touch demo_if_true),False):
# $(wildcard demo_if_true):                                            demo_if_true
#
# demo_or_func
# $(or $(e_str),$(space),True):
# $(or $(shell touch demo_or_1st),$(shell touch demo_or_2nd),Done):    Done
# $(wildcard demo_or_1st demo_or_2nd):                                 demo_or_1st demo_or_2nd
#
# demo_and_func
# $(and 1st, 2nd, last):                                               last
# $(and True,$(e_str),False):
# $(and $(shell touch demo_and_1st),$(shell touch demo_and_2nd),last):
# $(wildcard demo_and_1st demo_and_2nd):                               demo_and_1st
