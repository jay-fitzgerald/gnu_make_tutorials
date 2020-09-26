# https://www.gnu.org/software/make/manual/html_node/Parallel.html#Parallel
#
# ** Overview **
# Normally, make executes just one recipe at a time.
# By passing -j or --jobs (optionally with a number N), you can tell make to
# run up to N or infinity recipes in parallel. This even works on Windows (with Cygwin).
#
# ** Output **
# When running parallel jobs, output from multiple recipes can be interspersed.
# By passing --output-sync or -O (optionally with an argument) you can group output by
# the target or recursive invocation that it comes from.
# NOTE: --output-sync support added in GNU Make 4.0
#
# ** Input **
# make will invalidate the standard input streams of all but one running recipe.
# If another recipe attempts to read from standard input it will usually incur a
# fatal error (a ‘Broken pipe’ signal).
# Just don't use standard input in your recipes!
#
# ** Execution Order **
# Sometimes, when executing jobs in parallel, you want to enforce build order
# between certain jobs. This can be tricky, but it is possible.
############################ Example Make Code ############################
all: target_A target_B target_C
A_prereqs = prereq_D prereq_E prereq_F
B_prereqs = prereq_G
C_prereqs = target_A prereq_D

target_%:
	@echo $@
	@echo 
prereq_%:
	@echo $@

target_A: $(A_prereqs)
target_B: $(B_prereqs)
target_C: $(C_prereqs)
$(B_prereqs): target_A # A must execute before B_prereqs
# Enforced Order (Last: .... :First)
# target_B target_C:$(B_prereqs) $(C_prereqs): target_A: $(A_prereqs)
############################ Execution Output #############################

# make -f gnu_make_tut_13-parallel_execution.mak -j8 --output-sync=target
# prereq_D
# prereq_E
# prereq_F
# target_A
#
# prereq_G
# target_C
#
# target_B
#

# There is no enforcement of order between B and C, but since
# C_prereqs are already complete after A is built and B still has prereqs
# we're seeing the target_C complete before B.
# For another example of enforcing order with parallel execution, see tutorial 32.