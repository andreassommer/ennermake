# This files walks into the submodules specified in the variable SUBDIRS_$(d)

# use full paths
SUBDIRS_$(d) := $(call ennermake_unwild_absolutize_filespec, $(SUBDIRS_$(d)))

# Descend into subdirectories. Must use variable "dir" to descend.
# Add the submodules' objects to current module's objects lists.
$(foreach m,$(SUBDIRS_$(d)), \
   $(eval ennermake_nextdir := $m) \
   $(eval include $(ennermake_nextdir)/MakeRules.mk) \
   $(eval SUBMODULES_$(d)  += $(MODULE_$(call ennermake_generate_safe_name,$(ennermake_nextdir)))) \
   $(eval OBJECTS_$(d)     += $(OBJECTS_$(call ennermake_generate_safe_name,$(ennermake_nextdir)))) \
   $(eval OBJECTS_PIC_$(d) += $(OBJECTS_PIC_$(call ennermake_generate_safe_name,$(ennermake_nextdir)))) \
   )

# For debugging, insert the following after the foreach line
#    $(info Including submodule $m) \

# Compilation target: Depends on phony compilation targets of submodules
.PHONY: compile_$(MODULE_$(d))
compile_$(MODULE_$(d)): $(foreach mod,$(SUBMODULES_$(d)),compile_$(mod))
	$(ECHO) $@ ready.

