# This files walks into the submodules specified in the variable SUBDIRS_$(d)


# use full paths
SUBDIRS_$(d) := $(call ennermake_unwild_absolutize_filespec, $(SUBDIRS_$(d)))


# Descend into subdirectories. Must use variable "dir" to descend.
# Add the submodules' objects to current module's objects lists.
$(foreach m,$(SUBDIRS_$(d)), \
   $(eval dir := $m) \
   $(eval include $(dir)/MakeRules.mk) \
   $(eval SUBMODULES_$(d)  += $(MODULE_$(dir))) \
   $(eval OBJECTS_$(d)     += $(OBJECTS_$(dir))) \
   $(eval OBJECTS_PIC_$(d) += $(OBJECTS_PIC_$(dir))) \
   )


# For debugging, insert the following after the foreach line
#    $(info Including submodule $m) \


# Compilation target: Depends on phony compilation targets of submodules
.PHONY: compile_$(MODULE_$(d))
compile_$(MODULE_$(d)): $(foreach mod,$(SUBMODULES_$(d)),compile_$(mod))
	$(ECHO) $@ ready.

