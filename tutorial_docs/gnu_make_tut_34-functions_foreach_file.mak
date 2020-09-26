# Tutorial Page: https://makefiletutorial.com
# https://www.gnu.org/software/make/manual/html_node/Foreach-Function.html#Foreach-Function
# Foreach substitutes different values for a variable into a piece of text repeatedly.
#
# https://www.gnu.org/software/make/manual/html_node/File-Function.html#File-Function
# The file function can read from or write to a file.
############################ Example Make Code ############################
.PHONY: all clean
.SILENT:
foreach_demos := demo_foreach1 demo_foreach2
file_demos := demo_file_read1 demo_file_write demo_file_read2 demo_file_append demo_file_read3
all: $(foreach_demos) $(file_demos)

# $(foreach var,list,text)
# 1. <var> and <list> are expanded immediately
# 2. <text> is expanded using word n of <list> as expansion of <var>
# 3. Output is the concatenation of step 2 performed for each word in <list> with a space between
var          := description
superlatives := Hottest Longest Worst
describe_day  = $(description) day ever!
$(foreach_demos): start_foreach_demo
# Calls that will be demonstrated
foreach1_fn_call = $(foreach value,Al Bob Clarice,Hello $(value)!)
foreach2_fn_call = $(foreach $(var),$(superlatives),$(describe_day))
start_foreach_demo:
	echo demo_foreach_func
	echo '$$(var)': '$(value var)'
	echo '$$(superlatives)': '$(value superlatives)'
	echo '$$(describe_day)': '$(value describe_day)'
	echo Output is aligned for readability
	echo ----------------------------------

# $(file op filename[,text]) # op: < for read, > for write, >> for append
# NOTE: Feature added in GNU Make 4.0
filename := new_file.txt
$(file_demos): start_file_demo
# Calls that will be demonstrated
file_read1_fn_call  = $(file < $(filename))
file_read2_fn_call  = $(file < $(filename))
# trying to printf/echo a multiline file will error; use shell cat so that newlines become spaces
file_read3_fn_call  = $(shell cat $(filename))
file_write_fn_call  = $(file > $(filename),1st line)
file_append_fn_call = $(file >> $(filename),2nd line)
start_file_demo:
	echo
	echo demo_file_func
	echo '$$(filename)': '$(value filename)'
	echo Output is aligned for readability
	echo ----------------------------------

# Pattern rule for each of the calls that we demonstrate
demo_%:
	printf "%-55s %-s\n" '$(value $*_fn_call)': '$($*_fn_call)'
clean:
	-rm $(filename)
############################ Execution Output #############################

# $ make -f gnu_make_tut_34-functions_foreach_file.mak
# demo_foreach_func
# $(var): description
# $(superlatives): Hottest Longest Worst
# $(describe_day): $(description) day ever!
# Output is aligned for readability
# ----------------------------------
# $(foreach value,Al Bob Clarice,Hello $(value)!):        Hello Al! Hello Bob! Hello Clarice!
# $(foreach $(var),$(superlatives),$(describe_day)):      Hottest day ever! Longest day ever! Worst day ever!
#
# demo_file_func
# $(filename): new_file.txt
# Output is aligned for readability
# ----------------------------------
# $(file < $(filename)):
# $(file > $(filename),1st line):
# $(file < $(filename)):                                  1st line
# $(file >> $(filename),2nd line) :
# $(shell cat $(filename)):                               1st line 2nd line
