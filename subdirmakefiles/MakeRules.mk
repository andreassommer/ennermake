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


SOURCES_$(d) := $(wildcard $(d)/*.cxx)
INCLUDE_DIRS_$(d) := $(PDO_INC_DIRS) $(SOLVINDSUITE_INC_DIRS)

include $(ENNERMAKE_INC_PROCESS_MODULE)


# ---------------------------- EDIT STOP HERE ----------------------


# =============== 
# STANDARD THINGS   --- DO NOT EDIT ---
# ===============

include $(ENNERMAKE_INC_MODULE_CLEAN)
include $(ENNERMAKE_INC_PROPAGATE)
include $(ENNERMAKE_INC_DIRECTORY_UPDATERS)
-include $(ENNERMAKE_INC_FILE_EXIT)


