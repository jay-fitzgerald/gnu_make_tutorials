# https://www.gnu.org/software/make/manual/html_node/Reading-Makefiles.html#Reading-Makefiles
############################ Details ############################
# No example code this time
# NOTE: '!=', '::=' added in GNU Make 4.0
# NOTE: 'define <var_name> <op>' added in GNU Make 3.82.

# **** Make Phases ****
# Make works in two phases.
# 1. Read-In
#    It reads all the makefiles, included makefiles, etc. and internalizes all the
#    variables and their values and implicit and explicit rules, and builds a
#    dependency graph of all the targets and their prerequisites.
# 2. Target-Update
#    It determines which targets need to be updated and runs the recipes necessary to update them.

# **** Expansion of constructs (variable, function, etc) ****
# Immediate: happens in phase one
# Deferred: happens when referenced in an immediate context or in phase two

#  **** Variable Parsing ****
# Automatic variables: deferred (created when a recipe is invoked)
# immediate = deferred
# immediate ?= deferred
# immediate := immediate
# immediate ::= immediate
# immediate += deferred or immediate (see RHS for however it was last set)
# immediate != immediate

# define immediate
  # deferred
# endef

# define immediate =
  # deferred
# endef

# define immediate ?=
  # deferred
# endef

# define immediate :=
  # immediate
# endef

# define immediate ::=
  # immediate
# endef

# define immediate +=
  # deferred or immediate (see RHS for however it was last set)
# endef

# define immediate !=
  # immediate
# endef

# **** Conditional Directives ****
# Immediate.
# If you need to use an automatic variable (deferred), move the condition into the recipe
# and pass it to the shell.

# **** Rule Definition ****
# immediate : immediate ; deferred
#        deferred

# **** Phase Two and Recipe Expansion ****
# As we just stated a few lines above, recipe expansion is deferred.
# Let's dig into how it actually works, though.
# 1. Make determines which target should build/update next.
#    This means it has already gone through the chain of prerequisites.
# 2. Make expands every line of the recipe for that target.
# 3. Make runs the recipe.
#
# This is critical to understand and the guide isn't very clear about it.
# All function and variable references that appear in a rule are expanded
# before the rule runs.
#
# If you have a reference in a recipe that you need to expand after
# a shell command (not a shell function) in that recipe is run, you should
# split the recipe into separate rules, with target-prereq relationships.