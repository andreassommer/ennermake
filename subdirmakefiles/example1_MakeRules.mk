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

SOURCES_$(d)      := nlp_solver.cxx
INCLUDE_DIRS_$(d) := $(PDO_INC_DIRS)

ifeq ($(PDO_WITH_IPOPT), 1)
   SOURCES_$(d)      += nlp_solver_ipopt.cxx
   INCLUDE_DIRS_$(d) += $(IPOPT_INC_DIRS)
endif

ifeq ($(PDO_WITH_SNOPT), 1)
   SOURCES_$(d)      += nlp_solver_snopt.cxx
   INCLUDE_DIRS_$(d) += $(SNOPT_INC_DIRS)
endif

ifeq ($(PDO_WITH_FILTERSQP), 1)
   SOURCES_$(d)      += nlp_solver_filter.cxx  nlp_solver_filter_functions.cxx
   INCLUDE_DIRS_$(d) += $(FILTERSQP_INC_DIRS)
endif

SOURCES_$(d) := $(addprefix $(d)/,$(SOURCES_$(d)))


include $(ENNERMAKE_INC_PROCESS_MODULE)

# ---------------------------- EDIT STOP HERE ----------------------


# =============== 
# STANDARD THINGS   --- DO NOT EDIT ---
# ===============

include $(ENNERMAKE_INC_MODULE_CLEAN)
include $(ENNERMAKE_INC_PROPAGATE)
include $(ENNERMAKE_INC_DIRECTORY_UPDATERS)
-include $(ENNERMAKE_INC_FILE_EXIT)


