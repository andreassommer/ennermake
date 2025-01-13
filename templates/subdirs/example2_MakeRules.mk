-include $(ENNERMAKE_INC_FILE_ENTRY)

# =============== 
# STANDARD THINGS   --- DO NOT EDIT ---
# ===============

include $(ENNERMAKE_INC_DIRECTORY_ACCESSORS)
include $(ENNERMAKE_INC_MODULE_HEAD)


# -------------------------------------------------- EDIT START HERE ---------------------

SUBDIRS_$(d) := arg_list discretization function function_interface mapper model model_description nlp_solver nlp_translator node node_evaluator problem problem_description stage utils working_set
include $(ENNERMAKE_INC_PROCESS_SUBDIRS)


LIBRARY_NAMES_$(d) := $(PDO_EXTLIBS_NAMES)
LIBRARY_DIRS_$(d)  := $(PDO_EXTLIBS_DIRS)



# Target for PDO LIBRARY FOLDER
$(PDO_LIB_DIR):
	$(MKDIR) $(PDO_LIB_DIR)


# Target and rules for STATIC LIBRARY
PDO_LIB_STATIC := $(PDO_LIB_DIR)/$(PREFIX.libstatic)$(PDO_LIB_NAME)$(EXT.libstatic)
$(PDO_LIB_STATIC): $(OBJECTS_$(d)) | $(PDO_LIB_DIR)
	$(LINK.archive)
	$(ECHO)  "Static PDO library built: $@"
.PHONY: pdo_lib_static clean_pdo_lib_static
pdo_lib_static:  $(PDO_LIB_STATIC)
clean_pdo_lib_static:
	$(RM) $(PDO_LIB_STATIC)
CLEAN_$(d) += $(PDO_LIB_STATIC)
TARGETS_$(d) += pdo_lib_static

# Target and rules for DYNAMIC LIBRARY
PDO_LIB_DYNAMIC := $(PDO_LIB_DIR)/$(PREFIX.libdynamic)$(PDO_LIB_NAME)$(EXT.libdynamic)
.PHONY: pdo_lib_dynamic clean_pdo_lib_dynamic
pdo_lib_dynamic: $(PDO_LIB_DYNAMIC)
clean_pdo_lib_dynamic:
	$(RM) $(PDO_LIB_DYNAMIC)
$(PDO_LIB_DYNAMIC): LINKFLAGS.local:=$(call ennermake_generate_flags_library_dirs,$(LIBRARY_DIRS_$(d))) \
                                     $(call ennermake_generate_flags_rpath,$(LIBRARY_DIRS_$(d))) #DEBUG remove rpath
$(PDO_LIB_DYNAMIC): LINKLIBS.local:=$(call ennermake_generate_flags_library_names,$(LIBRARY_NAMES_$(d)))
$(PDO_LIB_DYNAMIC): $(OBJECTS_PIC_$(d)) | $(PDO_LIB_DIR)
	$(LINK.dynamic)
	$(ECHO)  "Dynamic PDO library built: $@"
CLEAN_$(d) += $(PDO_LIB_DYNAMIC)
TARGETS_$(d) += pdo_lib_dynamic


# -------------------------------------------------- EDIT STOP HERE ----------------------


# =============== 
# STANDARD THINGS   --- DO NOT EDIT ---
# ===============

include $(ENNERMAKE_INC_MODULE_CLEAN)
include $(ENNERMAKE_INC_PROPAGATE)
include $(ENNERMAKE_INC_DIRECTORY_UPDATERS)
-include $(ENNERMAKE_INC_FILE_EXIT)
