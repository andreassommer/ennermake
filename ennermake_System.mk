$(info ___LOADING ENNERMAKE in $(realpath $(lastword $(MAKEFILE_LIST))))

# Ensure that project basedir is set
ifeq ("","$(ENNERMAKE_PROJECT_BASEDIR)")
   $(error Please set ENNERMAKE_PROJECT_BASEDIR to the project base directory.)
endif

# Retrieve base directory
ENNERMAKE_FILE := $(realpath $(lastword $(MAKEFILE_LIST)))
ENNERMAKE_DIR :=  $(realpath $(dir $(lastword $(MAKEFILE_LIST))))



# ---------------------------------------------------------------------------------------
# Define symbols

empty :=
ENNERMAKE_SYMBOLS_EMPTY             := $(empty)
ENNERMAKE_SYMBOLS_COMMA             := $(empty),$(empty)
ENNERMAKE_SYMBOLS_COLON             := $(empty):$(empty)
ENNERMAKE_SYMBOLS_SPACE             := $(empty) $(empty)
ENNERMAKE_SYMBOLS_TILDE             := $(empty)~$(empty)
ENNERMAKE_SYMBOLS_ASTERISK          := $(empty)*$(empty)
ENNERMAKE_SYMBOLS_PARENTHESIS_OPEN  := $(empty)($(empty)
ENNERMAKE_SYMBOLS_PARENTHESIS_CLOSE := $(empty))$(empty)
ENNERMAKE_SYMBOLS_UNDERSCORE        := $(empty)_$(empty)
ENNERMAKE_SYMBOLS_SLASH             := $(empty)/$(empty)
ENNERMAKE_SYMBOLS_BACKSLASH         := $(empty)\$(empty)
ENNERMAKE_SYMBOLS_BAD := $(ENNERMAKE_SYMBOLS_COMMA) \
                         $(ENNERMAKE_SYMBOLS_TILDE) \
                         $(ENNERMAKE_SYMBOLS_ASTERISK) \
                         $(ENNERMAKE_SYMBOLS_PARENTHESIS_OPEN) \
                         $(ENNERMAKE_SYMBOLS_PARENTHESIS_CLOSE)
define ENNERMAKE_SYMBOLS_NEWLINE :=

$(ENNERMAKE_SYMBOLS_EMPTY)
endef # NOTE: We must keep the empty line 



# ---------------------------------------------------------------------------------------
# Checks: (1) if path contains invalid characters
#         (2) ennermake can find itself

# Since testing for spaces is painful, we first transform all spaces into commas
ENNERMAKE_CHECK_DIR := $(subst $(ENNERMAKE_SYMBOLS_SPACE),$(ENNERMAKE_SYMBOLS_COMMA),$(ENNERMAKE_DIR))
ENNERMAKE_CHECK_BAD_SYMBOLS_FOUND :=
$(foreach sym,$(ENNERMAKE_SYMBOLS_BAD),\
   $(eval ENNERMAKE_CHECK_BAD_SYMBOLS_FOUND += $(findstring $(sym),$(ENNERMAKE_CHECK_DIR)))\
)
ifneq (,$(strip $(ENNERMAKE_CHECK_BAD_SYMBOLS_FOUND)))
   $(error The current path contains bad symbols or spaces, e.g. $(ENNERMAKE_SYMBOLS_BAD).)
endif

# Ensure we can find ourself
ifeq (,$(wildcard $(ENNERMAKE_FILE)))
   $(error Unable to locate myself at: $(ENNERMAKE_FILE))
endif



# ---------------------------------------------------------------------------------------
# ENNERMAKE FILES

# Setup the ennermake file access variables
ENNERMAKE_DEBUG_HELPERS        := $(ENNERMAKE_DIR)/ennermake_Debug.mk
ENNERMAKE_SETUP_OS_DETECTION   := $(ENNERMAKE_DIR)/ennermake_OSdetection.mk
ENNERMAKE_SETUP_OS_SPECIFICS   := $(ENNERMAKE_DIR)/ennermake_OSspecifics.mk

# Package configuration file in project directory
ENNERMAKE_SETUP_PACKAGECONFIG  := $(ENNERMAKE_PROJECT_BASEDIR)/ennermake_packageconfig.mk
ENNERMAKE_SETUP_CHECKS         := $(ENNERMAKE_DIR)/ennermake_Checks.mk

# Include files for usage in MakeRules.mk
ENNERMAKE_INC_PROPAGATE              := $(ENNERMAKE_DIR)/ennermake_inc_propagate.mk
ENNERMAKE_INC_FILE_ENTRY             := $(ENNERMAKE_DIR)/ennermake_inc_file_entry.mk
ENNERMAKE_INC_FILE_EXIT              := $(ENNERMAKE_DIR)/ennermake_inc_file_exit.mk
ENNERMAKE_INC_DIRECTORY_ACCESSORS    := $(ENNERMAKE_DIR)/ennermake_inc_directory_accessors.mk
ENNERMAKE_INC_DIRECTORY_UPDATERS     := $(ENNERMAKE_DIR)/ennermake_inc_directory_updaters.mk
ENNERMAKE_INC_MODULE_HEAD            := $(ENNERMAKE_DIR)/ennermake_inc_module_head.mk
ENNERMAKE_INC_MODULE_CLEAN           := $(ENNERMAKE_DIR)/ennermake_inc_module_clean.mk
ENNERMAKE_INC_PROCESS_SUBDIRS        := $(ENNERMAKE_DIR)/ennermake_inc_process_subdirs.mk
ENNERMAKE_INC_PROCESS_MODULE         := $(ENNERMAKE_DIR)/ennermake_inc_process_module.mk
ENNERMAKE_INC_PROCESS_UNIT           := $(ENNERMAKE_DIR)/ennermake_inc_process_unit.mk



# ---------------------------------------------------------------------------------------
# Initialize ENNERMAKE system

include $(ENNERMAKE_DEBUG_HELPERS)
include $(ENNERMAKE_SETUP_OS_SPECIFICS)
include $(ENNERMAKE_SETUP_CHECKS)




# ---------------------------------------------------------------------------------------
# Ennermake generator functions

# Function to generate module name:   $(call ennermake_generate_module_name)
# The module name is created from the directory tree below BASEDIR, by removing the base directoy
# and substituting and slash / and backslash \ into _. 
# Example:    directory "$(BASEDIR)/src/utils"  -->  module name "_src_utils"
ennermake_generate_name           = $(strip $(subst \,_,$(subst /,_,$(subst $(ENNERMAKE_PROJECT_BASEDIR),,$(1)))))
ennermake_generate_module_name    = $(call ennermake_generate_name,module_$(ennermake_curdir))
ennermake_generate_unit_name      = $(call ennermake_generate_name,unit_$(1))

# safename generates a safe variable name by substituting :/\ with _ (needed for variables like OBJECTS_$(d))
ennermake_generate_safe_name      = $(strip $(subst \,_,$(subst /,_,$(subst :,_,$(1)))))

# Function to generate library name flags
ennermake_generate_flags_library_names          = $(addprefix -l,$(1))
ennermake_generate_flags_library_dirs           = $(addprefix -L,$(1))
ennermake_generate_flags_library_names_and_dirs = $(addprefix -l,$(1)) $(addprefix -L,$(2))
ennermake_generate_flags_include_dirs           = $(addprefix -I,$(1))
ennermake_generate_flags_rpath                  = $(addprefix -Wl$(ENNERMAKE_SYMBOLS_COMMA)-rpath=,$(1))



# ---------------------------------------------------------------------------------------
# Helper Functions

# Pretty printing something
ennermake_pprint_x = $(foreach word,$(1),$(word)$(2))
ennermake_pprint   = $(call ennermake_pprint_x,$(1),$(ENNERMAKE_SYMBOLS_COMMA))

# Make list having only unique elements
ennermake_remove_duplicates = $(if $(1),$(firstword $(1)) $(call ennermake_remove_duplicates,$(filter-out $(firstword $(1)),$(1))))

# DEBUG: Helper to determine the calling function --- This does not work as intended.
# ennermake_get_secondbutlast_makefile = $(lastword $(filter-out $(realpath $(lastword $(MAKEFILE_LIST))),$(MAKEFILE_LIST)))
# ennermake_get_last_makefile          = $(realpath $(lastword $(MAKEFILE_LIST)))



# ---------------------------------------------------------------------------------------
# Transform file specs:

# check if path is absolute:   either starts with / (LINUX) or contains ":\" (WINDOWS) or ":/" (MinGW)
ennermake_is_absolute_filespec = $(strip \
$(if $(findstring $(ENNERMAKE_SYMBOLS_COLON)$(ENNERMAKE_SYMBOLS_BACKSLASH),$(1)),ABSWINDOWS,\
$(if $(findstring $(ENNERMAKE_SYMBOLS_COLON)$(ENNERMAKE_SYMBOLS_SLASH),$(1)),ABSMINGW,\
$(if $(patsubst $(ENNERMAKE_SYMBOLS_SLASH)%,$(empty),$(dir $(1))),$(empty),ABSLINUX))))


# absolutize: if absolute file is given, return unchanged, otherwise add prefix for current directory
ennermake_absolutize_filespec = $(strip \
$(foreach file,$(1),\
$(if $(call ennermake_is_absolute_filespec,$(file)),$(file),$(abspath $(ennermake_curdir)/$(file)))))


# unwild: apply wildcard function only to those filespecs containing the wildcard character
ennermake_unwild_filespec = $(strip \
$(foreach file,$(1),\
$(if $(findstring $(ENNERMAKE_SYMBOLS_ASTERISK),$(file)),$(wildcard $(file)),$(file))))


# first absolutize, then unwild
ennermake_unwild_absolutize_filespec = $(strip \
$(call ennermake_unwild_filespec,$(call ennermake_absolutize_filespec,$(1))))




# ---------------------------------------------------------------------------------------
# INTENTions for UNIT generation

INTENT.archive    = archive
INTENT.compile    = compile
INTENT.executable = executable
INTENT.libdynamic = libdynamic
INTENT.libstatic  = libstatic
INTENT.object     = object
INTENT.picobject  = picobject
INTENTS = $(INTENT.archive) $(INTENT.compile) $(INTENT.executable)\
          $(INTENT.libdynamic) $(INTENT.libstatic)\
          $(INTENT.object) $(INTENT.picobject) 



# ---------------------------------------------------------------------------------------
# Define variables used for propagation

CLEAN    :=
DEPFILES :=
MODULES  :=
PHONYS   :=
TARGETS  :=
UNITS    :=
