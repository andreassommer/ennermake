# Check if module name is available
$(call ennermake_check_module_name_available)


# =============== 
# Local variables
# ===============

# (must be immediate using := )
BASENAMES_$(d)     := $(basename $(SOURCES_$(d)))

OBJECTS_$(d)       := $(addsuffix $(EXT.obj),    $(BASENAMES_$(d)))
OBJECTS_PIC_$(d)   := $(addsuffix $(EXT.objPIC), $(BASENAMES_$(d)))
DEPFILES_$(d)      := $(addsuffix $(EXT.depend), $(BASENAMES_$(d)))
CLEAN_$(d)         := $(OBJECTS_$(d)) $(OBJECTS_PIC_$(d)) $(DEPFILES_$(d))

INCLUDE_FLAGS_$(d) := $(call ennermake_generate_flags_include_dirs,$(INCLUDE_DIRS_$(d)))



# ==================================
# Local rules, targets, dependencies
# ==================================

$(OBJECTS_$(d)):      CXXFLAGS.local := $(CXXFLAGS_$(d)) $(INCLUDE_FLAGS_$(d))
$(OBJECTS_PIC_$(d)):  CXXFLAGS.local := $(CXXFLAGS_$(d)) $(INCLUDE_FLAGS_$(d))

MODULE.COMPILETARGET := compile_$(MODULE_$(d))
.PHONY:	$(MODULE.COMPILETARGET)
compile_$(MODULE_$(d)):	$(OBJECTS_$(d)) $(OBJECTS_PIC_$(d))
	$(ECHO) $@ ready.

