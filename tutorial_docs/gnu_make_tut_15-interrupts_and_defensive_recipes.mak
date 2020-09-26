# https://www.gnu.org/software/make/manual/html_node/Interrupts.html#Interrupts
############################ Details ############################
# No example code this time

# ** Overview **
# If make gets a fatal signal while a shell is executing, it will delete the target
# file that the recipe was supposed to update, if its last-modification time has changed
# since make first checked it.
# This is so we aren't left with a corrupt target.

# ** Cleanup Can Fail **
# Sometimes one of the programs make invokes may be killed or crashed.
# In this case, make may fail to delete the target.
# The same thing may happen if make crashes.

# ** Defensive Recipes **
# Rather than updating a target directly, you can create a temporary file
# and rename it to the target name at the very end. This way,
# the target will either be made or not, never corrupt.
# You may still want to execute cleanup of your temporary files at the
# beginning of the recipe.
