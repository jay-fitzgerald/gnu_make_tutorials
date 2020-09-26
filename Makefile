tut_%:
	$(eval submake_stem:=$(shell export string=$@; echo $${string:0:6}))
	$(eval submake_target:=$(shell export string=$@; echo $${string:7}))
	cd tutorial_docs && $(MAKE) -f gnu_make_$(submake_stem)-*.mak $(submake_target)