-include $(ENNERMAKE_INC_FILE_ENTRY)

# =============== 
# STANDARD THINGS   --- DO NOT EDIT ---
# ===============

include $(ENNERMAKE_INC_DIRECTORY_ACCESSORS)
include $(ENNERMAKE_INC_MODULE_HEAD)


# ---------------------------- EDIT START HERE ---------------------


# =============
# MODULE config
# =============

SOURCES_$(d) := $(wildcard $(ennermake_curdir)/*.cpp)
INCLUDE_DIRS_$(d) := $(PROJECT_INC_DIRS)

include $(ENNERMAKE_INC_PROCESS_MODULE)


# SUBDIRS_$(d) := arg_list discretization function function_interface mapper model 
# include $(ENNERMAKE_INC_PROCESS_SUBDIRS)

# Target for PROJECT LIBRARY FOLDER
#$(PROJECT_LIB_DIR):
#	$(MKDIR) $(PROJECT_LIB_DIR)
#
#
## Library names for LIBRARY (without extension)
#PROJECT_LIB_DYNAMIC := $(PROJECT_LIB_DIR)/$(PREFIX.libstatic)$(PROJECT_LIB_NAME)$(EXT.libdynamic)
#PROJECT_LIB_STATIC  := $(PROJECT_LIB_DIR)/$(PREFIX.libstatic)$(PROJECT_LIB_NAME)$(EXT.libstatic)
#
#
#UNIT.NAME     := $(PROJECT_LIB_NAME)
#UNIT.DEPENDS  := $(OBJECTS_PIC_$(d))
#UNIT.REQUIRES := $(PROJECT_LIB_DIR)
#UNIT.TARGET   := $(PROJECT_LIB_DYNAMIC)
#UNIT.INTENT   := $(INTENT.libdynamic)
#UNIT.LIBRARY_NAMES := 
#UNIT.LIBRARY_DIRS  := 
#include $(ENNERMAKE_INC_PROCESS_UNIT)



# ---------------------------- EDIT STOP HERE ----------------------


# =============== 
# STANDARD THINGS   --- DO NOT EDIT ---
# ===============

include $(ENNERMAKE_INC_MODULE_CLEAN)
include $(ENNERMAKE_INC_PROPAGATE)
include $(ENNERMAKE_INC_DIRECTORY_UPDATERS)
-include $(ENNERMAKE_INC_FILE_EXIT)


