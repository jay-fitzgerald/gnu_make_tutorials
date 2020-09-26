# https://www.gnu.org/software/make/manual/html_node/Eval-Function.html#Eval-Function
# Eval allows you to define new constructs that are the result of evaluating other variables and functions.
#
# https://www.gnu.org/software/make/manual/html_node/Make-Control-Functions.html#Make-Control-Functions
# $(info ...) prints its argument to stdout. It won't choke on muli-line input (like expanded define variables).
# The info function is a great way to see what $(eval ...) is actually adding to the makefile.
# Be mindful, though, of the fact that all lines of a recipe are expanded before running the recipe.
############################ Example Make Code ############################
.PHONY: all
.SILENT:
eval_var_demos  := demo_eval_var1 demo_eval_var2
eval_rule_demos := demo_eval_target_prereq demo_eval_rule
all: $(eval_var_demos) $(eval_rule_demos)

# **** Using the Eval Function ****
# $(eval expression) # Expands any references in <expression>, then adds it to the makefile and reads it
# Returns: empty string
# Notes
# 1. Eval lets you stick a rule template in a multi-line variable.
#    Don't try it without eval; you'll get an error when building the target.
# 2. Escape any references in <expression> that you want expanded during or after eval.
# 3. You can call eval pretty much anywhere, even in a recipe.
#    Because it returns an empty string, $(eval ...) passes nothing to the shell.

# **** Eval DON'Ts ****
# 1. Don't eval a rule while running a recipe.
#    Not supported.
# 2. Don't $(eval $(eval ...)).
#    The outer eval accomplishes nothing.

var_A     = var_C
eval_var1 = var_B := ABC
eval_var2 = $(var_A) := DEF
var_D     = $(eval var_E = XYZ)# you can even stick eval in a variable def; use cases discussed in tut_37
$(eval_var_demos): start_eval_var_demo
# Evals that will be demonstrated
$(eval $(eval_var1))
$(eval $(eval_var2))
#$(eval $(var_D)) # don't bother; expanding $(var_D) returns an empty string
start_eval_var_demo:
	echo demo_eval_for_variable_definitions
	echo '**********' 'Variable Defs and Eval Calls' '**********'
	printf "%-30s %-s\n" '$$(var_A)': '$(value var_A)'
	printf "%-30s %-s\n" '$$(eval $(value eval_var1))'
	printf "%-30s %-s\n" '$$(eval $(value eval_var2))'
	printf "%-30s %-s\n" '$$(var_D)': '$(value var_D)'
	printf "%-30s %-s\n" '$$(var_E)': '$(value var_E)' # Not defined yet
	echo '  **** Expanding var_D ****' $(var_D)
	printf "%-30s %-s\n" '$$(var_E)': '$(value var_E)' # Now it's defined
	echo '**********' 'Eval Results' '**********'

# **** Using Eval to read in a function ****
# I can't really come up with any reason to do this, other than to overwrite
# an already defined function definition while building a target.
# Really, though, any user-defined function is actually a variable.
# We won't demo this; it's straightforward.

# Note: We could make the recipe longer, but we won't
define eval_rule_template =
$(1): $(2)
	echo $$@
	$(3)
endef
eval_target_prereq = $(eval_rule_demos): continue_eval_rule_demo
eval_rule = $(call eval_rule_template,continue_eval_rule_demo,,printf "%s %s %s\n" '**********' 'Eval Results' '**********')
$(eval_rule_demos): start_eval_rule_demo
# Evals that will be demonstrated
$(eval $(eval_target_prereq))
$(eval $(eval_rule))
start_eval_rule_demo:
	echo
	echo demo_eval_for_rules
	echo '**********' 'Variable Defs and Eval Calls' '**********'
	printf "%-s\n" '$$(eval $(value eval_target_prereq))'
	echo Rule Template
	printf "%-s\n\t %-s\n\t %-s\n" '$$(1): $$(2)' 'echo $$@' '$$(3)'
	printf "%-s" '$$(eval $(value eval_rule))'
	printf "\n\n"
#	$(eval $(eval_rule_demos): print_another_line) # errors
#	$(eval $(call eval_rule_template,print_another_line,,$$(info Another line.))) # errors

# Pattern rule to display what each eval call adds to the makefile
demo_%:
	$(info $($*))

############################ Execution Output #############################

# $ make -f gnu_make_tut_36-functions_eval_info.mak
# demo_eval_for_variable_definitions
# ********** Variable Defs and Eval Calls **********
# $(var_A):                      var_C
# $(eval var_B := ABC)
# $(eval $(var_A) := DEF)
# $(var_D):                      $(eval var_E = XYZ)
# $(var_E):
#   **** Expanding var_D ****
# $(var_E):                      XYZ
# ********** Eval Results **********
# var_B := ABC
# var_C := DEF
#
# demo_eval_for_rules
# ********** Variable Defs and Eval Calls **********
# $(eval $(eval_rule_demos): continue_eval_rule_demo)
# Rule Template
# $(1): $(2)
#          echo $@
#          $(3)
# $(eval $(call eval_rule_template,continue_eval_rule_demo,,printf "%s %s %s\n" ********** EvalResults **********))
#
# continue_eval_rule_demo
# ********** Eval Results **********
# demo_eval_target_prereq demo_eval_rule: continue_eval_rule_demo
# continue_eval_rule_demo:
#         echo $@
#         printf "%s %s %s\n" '**********' 'Eval Results' '**********'
