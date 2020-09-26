# https://www.gnu.org/software/make/manual/html_node/Functions.html#Functions
############################ Example Make Code ############################
.PHONY: all
.SILENT:
file_demos := demo_dir demo_notdir demo_suffix demo_basename \
              demo_addsuffix demo_addprefix demo_join1 demo_join2 demo_abspath
file_existence_demos := demo_wildcard1 demo_wildcard2 \
                        demo_realpath1 demo_realpath2 demo_realpath3
all: $(file_demos) $(file_existence_demos)

# **** File Name Functions ****
# https://www.gnu.org/software/make/manual/html_node/File-Name-Functions.html#File-Name-Functions
# $(dir names…)                 # extract the directory-part of each file name in names; does not check existence
# $(notdir names…)              # remove the directory-part of each file name; "./A/B/C/" --> empty string
# $(suffix names…)              # extract the suffix (extension) from each file name
# $(basename names…)            # remove the suffix from each file name
# $(addsuffix suffix,names…)    # append the suffix to each file name
# $(addprefix prefix,names…)    # prepend the prefix to each file name
# $(join list1,list2)           # concatenate the two arguments word by word; whitespace is condensed to single spaces
# $(wildcard pattern)           # return a list of existing files that match; patterns may use the shell wildcard *
# $(realpath names…)            # return the canonical absolute name for each file
# $(abspath names…)             # like realpath, but does not resolve symlinks or require that files exist

# Using $(wildcard pattern) in a rule is not recommended
# https://www.cmcrossroads.com/article/trouble-wildcard
# $(wildcard pattern) relies on make's cache, which can be out-of-date if file changes
# occur after make starts running. You could delete a wildcard that existed when you
# launched make and still get a wildcard match. $(wildcard verbatim-path) does not rely on the cache.

# Since names is list of files separated by whitespace, you can put them all in one variable
fpaths_1 := /home/A/B/f1.cpp /temp/C/D/f2.c f_cwd.o /var/E/F/no_file/
fpaths_2 := //home///A/B/G/../f1.cpp /temp//C/./D/f2.c /no_file/// f_cwd.o
$(file_demos): start_file_demo # enforce order with prereq
# Calls that will be demonstrated
dir_fn_call       = $(dir $(fpaths_1))
notdir_fn_call    = $(notdir $(fpaths_1))
suffix_fn_call    = $(suffix $(fpaths_1))
basename_fn_call  = $(basename $(fpaths_1))
addsuffix_fn_call = $(addsuffix .h,$(fpaths_1))
addprefix_fn_call = $(addprefix /Made/up/path/,$(notdir $(fpaths_1)))
join1_fn_call     = $(join $(dir $(fpaths_1)),$(notdir $(fpaths_1)))
join2_fn_call     = $(join $(basename $(fpaths_1)),$(suffix $(fpaths_1)))
abspath_fn_call   = $(abspath $(fpaths_2))
start_file_demo:
	echo demo_file_functions
	echo '$$(fpaths_1)': $(fpaths_1)
	echo '$$(fpaths_2)': $(fpaths_2)
	echo Output is aligned for readability
	echo ----------------------------------

pat1 := abc*.o
pat2 := gnu_make_tut_3*.*
rpath1 := /a/b/fake_file.cpp
rpath2 := ./A/../B/../C/../$(notdir $(MAKEFILE_LIST))
$(file_existence_demos): start_file_existence_demo
# Calls that will be demonstrated
wildcard1_fn_call = $(wildcard $(pat1))
wildcard2_fn_call = $(wildcard $(pat2))
realpath1_fn_call = $(realpath $(rpath1))
realpath2_fn_call = $(realpath $(rpath2))
realpath3_fn_call = $(realpath $(MAKEFILE_LIST))
start_file_existence_demo: $(file_demos) # enforce order with prereq
	echo
	echo demo_file_existence_functions
	echo -e '$$(pat1)': $(pat1), \\t\\t'$$(pat2)': $(pat2)
	echo -e '$$(rpath1)': $(rpath1)\\t'$$(rpath2)': $(rpath2)
	echo ----------------------------------

# Pattern rule for each of the calls that we demonstrate
demo_%:
	printf "%-55s %-s\n" '$(value $*_fn_call)': '$($*_fn_call)'
# Writing it this way makes the file very easy to read but has a performance cost.
# To offset that, we run jobs in parallel. To keep the output the same, we have to
# carefully choose target prereqs.
# Next line isn't valid but shows target-prereq relationships
# $(file_existence_demos): start_file_existence_demo: $(file_demos): start_file_demo
############################ Execution Output #############################

# $ make -f gnu_make_tut_32-functions_filename.mak -j8 --output-sync=target
# demo_file_functions
# $(fpaths_1): /home/A/B/f1.cpp /temp/C/D/f2.c f_cwd.o /var/E/F/no_file/
# $(fpaths_2): //home///A/B/G/../f1.cpp /temp//C/./D/f2.c /no_file/// f_cwd.o
# Output is aligned for readability
# ----------------------------------
# $(dir $(fpaths_1)):                                     /home/A/B/ /temp/C/D/ ./ /var/E/F/no_file/
# $(notdir $(fpaths_1)):                                  f1.cpp f2.c f_cwd.o
# $(basename $(fpaths_1)):                                /home/A/B/f1 /temp/C/D/f2 f_cwd /var/E/F/no_file/
# $(suffix $(fpaths_1)):                                  .cpp .c .o
# $(addsuffix .h,$(fpaths_1)):                            /home/A/B/f1.cpp.h /temp/C/D/f2.c.h f_cwd.o.h /var/E/F/no_file/.h
# $(addprefix /Made/up/path/,$(notdir $(fpaths_1))):      /Made/up/path/f1.cpp /Made/up/path/f2.c /Made/up/path/f_cwd.o
# $(join $(dir $(fpaths_1)),$(notdir $(fpaths_1))):       /home/A/B/f1.cpp /temp/C/D/f2.c ./f_cwd.o /var/E/F/no_file/
# $(join $(basename $(fpaths_1)),$(suffix $(fpaths_1))):  /home/A/B/f1.cpp /temp/C/D/f2.c f_cwd.o /var/E/F/no_file/
# $(abspath $(fpaths_2)):                                 /home/A/B/f1.cpp /temp/C/D/f2.c /no_file /cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/f_cwd.o
#
# demo_file_existence_functions
# $(pat1): abc*.o,                $(pat2): gnu_make_tut_30-conditionals_with_functions.mak gnu_make_tut_31-function_basics.mak gnu_make_tut_32-functions_filename.mak
# ----------------------------------
# $(wildcard $(pat1)):
# $(wildcard $(pat2)):                                    gnu_make_tut_30-conditionals_with_functions.mak gnu_make_tut_31-function_basics.mak gnu_make_tut_32-functions_filename.mak
# $(realpath $(rpath1)):
# $(realpath $(rpath2)):
# $(realpath $(MAKEFILE_LIST)):                           /cygdrive/c/git_roots/programming/gnu_make_tutorials/tutorial_docs/gnu_make_tut_32-functions_filename.mak
