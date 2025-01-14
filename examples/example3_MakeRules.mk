-include $(ENNERMAKE_INC_FILE_ENTRY)

# =============== 
# STANDARD THINGS   --- DO NOT EDIT ---
# ===============

include $(ENNERMAKE_INC_DIRECTORY_ACCESSORS)
include $(ENNERMAKE_INC_MODULE_HEAD)

# -------------------------------------------------- EDIT START HERE ---------------------

SUBDIRS_$(d) := utils  solver  model  nlp_solver  nlp
include $(ENNERMAKE_INC_PROCESS_SUBDIRS)



# Target for PDO LIBRARY FOLDER
$(PDO_LIB_DIR):
	$(MKDIR) $(PDO_LIB_DIR)


# Library names for LIBRARY (without extension)
PDO_LIB_DYNAMIC := $(PDO_LIB_DIR)/$(PREFIX.libstatic)$(PDO_LIB_NAME)$(EXT.libdynamic)
PDO_LIB_STATIC  := $(PDO_LIB_DIR)/$(PREFIX.libstatic)$(PDO_LIB_NAME)$(EXT.libstatic)

# UNIT for STATIC LIBRARY
UNIT.NAME     := pdo_lib_static
UNIT.DEPENDS  := $(OBJECTS_$(d))
UNIT.REQUIRES := $(PDO_LIB_DIR)
UNIT.TARGET   := $(PDO_LIB_STATIC)
UNIT.INTENT   := $(INTENT.archive)
#UNIT.LIBRARY_NAMES := $(PDO_EXTLIBS_NAMES)
#UNIT.LIBRARY_DIRS  := $(PDO_EXTLIBS_DIRS)
#UNIT.INTENT   := $(INTENT.libstatic) # currently fails as there is no main()
include $(ENNERMAKE_INC_PROCESS_UNIT)

# UNIT for DYNAMIC LIBRARY
UNIT.NAME     := pdo_lib_dynamic
UNIT.DEPENDS  := $(OBJECTS_PIC_$(d))
UNIT.REQUIRES := $(PDO_LIB_DIR)
UNIT.TARGET   := $(PDO_LIB_DYNAMIC)
UNIT.INTENT   := $(INTENT.libdynamic)
UNIT.LIBRARY_NAMES := $(PDO_EXTLIBS_NAMES)
UNIT.LIBRARY_DIRS  := $(PDO_EXTLIBS_DIRS)
include $(ENNERMAKE_INC_PROCESS_UNIT)



# -------------------------------------------------- EDIT STOP HERE ----------------------


# =============== 
# STANDARD THINGS   --- DO NOT EDIT ---
# ===============

include $(ENNERMAKE_INC_MODULE_CLEAN)
include $(ENNERMAKE_INC_PROPAGATE)
include $(ENNERMAKE_INC_DIRECTORY_UPDATERS)
-include $(ENNERMAKE_INC_FILE_EXIT)
