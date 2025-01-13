# Sort and remove duplicates from list
CLEAN_$(d) := $(call sort, $(CLEAN_$(d)))


# Target for module clean (including calls to clean of submodules)
.PHONY:	clean_$(MODULE_$(d))
clean_$(MODULE_$(d)):  CLEANlocalfiles  := $(CLEAN_$(d))
clean_$(MODULE_$(d)):  CLEANlocalmodule := $(MODULE_$(d))
clean_$(MODULE_$(d)):  $(foreach mod,$(SUBMODULES_$(d)),clean_$(mod))
clean_$(MODULE_$(d)):
			$(ECHO) Cleaning $(CLEANlocalmodule) ...
			$(RM) $(CLEANlocalfiles)
			$(ECHO) $(CLEANlocalmodule) cleaned.

#$(info clean target created: clean_$(MODULE_$(d)))
