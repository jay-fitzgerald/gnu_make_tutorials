# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Call-Function.html#Call-Function
# You can assign a complex expression to a variable and use the call function
# to expand it with different values.
############################ Example Make Code ############################
.PHONY: all
.SILENT:
call_demos := demo_call_basic demo_call_builtin demo_call_concat demo_call_nested \
              demo_foreach demo_call_foreach
all: $(call_demos)

# **** Using the Call Function ****
# variable = ....                 # where $(0) = variable, $(1) ... $(n) = params
# $(call variable,param,param,…)
# Notes
# 1. If variable is the name of a builtin function, that function will always be used.
#    It doesn't matter if a variable with that name exists. Extra args are ignored.
#    This means you CAN expand a variable to provide a function name IF you use $(call ...)
# 2. There is no maximum number of params
# 3. param args are expanded before assigning them to temporary variables $(1) ... $(n)
# 4. Functions with special expansion rules may not work like you expect. See note 3.
# 5. Nested invocations of call are permitted.
sweet_new_fn   = Variable Name: $(0), 1st: $(1), 2nd: $(2), Empty Variable: $(3)
sort = $(1) # just expand the arg as is
concat_string  = $(1)$(2)
concat_3string = $(call concat_string,$(call concat_string,$(1),$(2)),$(3))
$(call_demos): start_call_demo
# Calls that will be demonstrated
call_basic_fn_call   = $(call sweet_new_fn,A,B)
call_builtin_fn_call = $(call sort,D Z B C E G T P V)
call_concat_fn_call  = $(call concat_string,Hello,World!)
call_nested_fn_call  = $(call concat_3string,Three,Blind,Mice)
foreach_fn_call      = $(foreach value,Al Bob Clarice,Hello $(value)!)
# Next call demonstrates why note 4 applies; a var with param refs behaves the same
call_foreach_fn_call = $(call foreach,value,Al Bob Clarice,Hello $(value)!)
start_call_demo:
	echo demo_call_func
	echo Output is aligned for readability
	echo ----------------------------------
	printf "%-20s %-s\n" '$$(sweet_new_fn)': '$(value sweet_new_fn)'
	printf "%-20s %-s\n" '$$(sort)': '$(value sort)'
	printf "%-20s %-s\n" '$$(concat_string)': '$(value concat_string)'
	printf "%-20s %-s\n" '$$(concat_3string)': '$(value concat_3string)'
	echo ----------------------------------
# Pattern rule for each of the calls that we demonstrate
demo_%:
	printf "%-60s %-s\n" '$(value $*_fn_call)': '$($*_fn_call)'
############################ Execution Output #############################

# $ make -f gnu_make_tut_35-functions_call.mak
# demo_call_func
# Output is aligned for readability
# ----------------------------------
# $(sweet_new_fn):     Variable Name: $(0), 1st: $(1), 2nd: $(2), Empty Variable: $(3)
# $(sort):             $(1)
# $(concat_string):    $(1)$(2)
# $(concat_3string):   $(call concat_string,$(call concat_string,$(1),$(2)),$(3))
# ----------------------------------
# $(call sweet_new_fn,A,B):                                    Variable Name: sweet_new_fn, 1st: A, 2nd: B, Empty Variable:
# $(call sort,D Z B C E G T P V):                              B C D E G P T V Z
# $(call concat_string,Hello,World!):                          HelloWorld!
# $(call concat_3string,Three,Blind,Mice):                     ThreeBlindMice
# $(foreach value,Al Bob Clarice,Hello $(value)!):             Hello Al! Hello Bob! Hello Clarice!
# $(call foreach,value,Al Bob Clarice,Hello $(value)!):        Hello ! Hello ! Hello !
