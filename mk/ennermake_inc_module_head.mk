# This function creates the local variables as immediate (simple expanded) variables,
# ensuring that there is no clobbering with existing variables and having them of immediate flavor.

# Directory variables (alphabetically)
BASENAMES_$(d)     :=
CLEAN_$(d)         := 
CXXFLAGS_$(d)      :=
DEPFILES_$(d)      :=
INCLUDE_DIRS_$(d)  :=
OBJECTS_$(d)       := 
OBJECTS_PIC_$(d)   :=
LIBRARY_NAMES_$(d) :=
LIBRARY_DIRS_$(d)  :=
MODULE_$(d)        := $(call ennermake_generate_module_name)
PHONYS_$(d)        :=
SOURCES_$(d)       :=
SUBMODULES_$(d)    :=
SUBDIRS_$(d)       := 
TARGETS_$(d)       :=
UNITS_$(d)         :=

# Reset UNIT user variables
UNIT.INCLUDE_DIRS  :=
UNIT.INTENT        :=
UNIT.LIBRARY_NAMES :=
UNIT.LIBRARY_DIRS  :=
UNIT.NAME          :=
UNIT.PHONY         :=
UNIT.REQUIRES      :=
UNIT.SOURCES       :=
UNIT.TARGET        :=
UNIT.default.INCLUDE_DIRS  := 
UNIT.default.LIBRARY_DIRS  :=
UNIT.default.LIBRARY_NAMES :=
UNIT.default.REQUIRES      :=
