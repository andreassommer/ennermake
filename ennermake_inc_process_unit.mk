$(call ennermake_debug, Processing UNIT: "$(UNIT.NAME)" with INTENT "$(UNIT.INTENT)" )

# Error check: valid INTENT?
UNIT.INTENT := $(strip $(UNIT.INTENT))
$(call ennermake_check_intent, $(UNIT.INTENT))


# Always include defaults
UNIT.INCLUDE_DIRS  += $(UNIT.default.INCLUDE_DIRS)  #DEBUG: make these variables immediate!
UNIT.LIBRARY_DIRS  += $(UNIT.default.LIBRARY_DIRS)
UNIT.LIBRARY_NAMES += $(UNIT.default.LIBRARY_NAMES)
UNIT.REQUIRES      += $(UNIT.default.REQUIRES)
UNIT.DEPENDS       += $(UNIT.default.DEPENDS)


# Transform to absolute path names
UNIT.SOURCES := $(call ennermake_unwild_absolutize_filespec,$(UNIT.SOURCES))
UNIT.TARGET  := $(call ennermake_absolutize_filespec,$(UNIT.TARGET))


# ----------------------------------------------------------------------------------
# UNIT.TARGET

# If no target is given, generate target from first source name
# The target name depents on the INTENT:  eg. libdynamic becomes libUNITNAME.so
ifeq ($(strip $(UNIT.TARGET)),)
   tmp := $(basename $(firstword $(UNIT.SOURCES)))
   ifeq ($(UNIT.INTENT),$(INTENT.executable))
      UNIT.TARGET := $(tmp)$(EXT.executable)
   else ifeq ($(UNIT.INTENT),$(INTENT.libdynamic))
      UNIT.TARGET := $(dir $(tmp))$(PREFIX.libdynamic)$(notdir $(tmp))$(EXT.libdynamic)
   else ifeq ($(UNIT.INTENT),$(INTENT.libstatic))
      UNIT.TARGET := $(dir $(tmp))$(PREFIX.libstatic)$(notdir $(tmp))$(EXT.libstatic)
   else ifeq ($(UNIT.INTENT),$(INTENT.archive))
      UNIT.TARGET := $(tmp)$(EXT.archive)
   else ifeq ($(UNIT.INTENT),$(INTENT.compile))
      UNIT.TARGET := 
      $(error Compile intent NOT NET IMPLEMENTED) # DEBUG: Todo?
   else
      $(error Don't know how to build target name for intent $(UNIT.INTENT) from source files $(UNIT.SOURCES))
   endif
   $(call ennermake_debug, No target given - using $(UNIT.TARGET))
endif


# ----------------------------------------------------------------------------------
# UNIT.NAME

# If no UNIT.NAME is given, generate it from target
ifeq ($(strip $(UNIT.NAME)),)
   UNIT.NAME := $(call ennermake_generate_unit_name,$(UNIT.TARGET))
   $(call ennermake_debug, Generated unit name: $(UNIT.NAME))
else
   # If a UNIT.NAME is given, ensure UNIT.PHONY is also created (if not otherwise specified)
   ifeq ($(strip $(UNIT.PHONY)),)
      UNIT.PHONY := $(UNIT.NAME)
   endif
   $(call ennermake_debug, Generated phony name: $(UNIT.PHONY))
endif


# Ensure there are no spaces around 
UNIT.NAME  := $(strip $(UNIT.NAME))
UNIT.PHONY := $(strip $(UNIT.PHONY))


# Check if UNIT.NAME is unique, warn if not
$(call ennermake_check_unitname_is_unique,$(UNIT.NAME))


# ----------------------------------------------------------------------------------
# Local Variables

# Set local variables
UNIT.BASENAMES     := $(basename $(UNIT.SOURCES))

UNIT.OBJECTS       := $(addsuffix $(EXT.obj),    $(UNIT.BASENAMES))
UNIT.OBJECTS_PIC   := $(addsuffix $(EXT.objPIC), $(UNIT.BASENAMES))
UNIT.DEPFILES      := $(addsuffix $(EXT.depend), $(UNIT.BASENAMES))
UNIT.CLEAN         := $(UNIT.OBJECTS) $(UNIT.OBJECTS_PIC) $(UNIT.DEPFILES) $(UNIT.TARGET)

UNIT.INCLUDE_FLAGS := $(call ennermake_generate_flags_include_dirs,$(UNIT.INCLUDE_DIRS))# DEBUG make this with ?= (i.e. allow user to override?)




# ----------------------------------------------------------------------------------
# Recipes for INTENTS


# INTENT: compile -- always created
$(UNIT.OBJECTS):      CXXFLAGS.local := $(UNIT.CXXFLAGS) $(UNIT.INCLUDE_FLAGS)
$(UNIT.OBJECTS_PIC):  CXXFLAGS.local := $(UNIT.CXXFLAGS) $(UNIT.INCLUDE_FLAGS)
UNIT.COMPILETARGET = compile_$(UNIT.NAME)
.PHONY:	$(UNIT.COMPILETARGET)
$(UNIT.COMPILETARGET):	$(UNIT.OBJECTS) $(UNIT.OBJECTS_PIC)
	$(ECHO) Prerequisites: $^
	$(ECHO) $@ compiled.

$(call ennermake_debug, Target created in UNIT.OBJECTS    : "$(UNIT.OBJECTS)")
$(call ennermake_debug, Target created in UNIT_OBJECTS_PIC: "$(UNIT.OBJECTS_PIC)")

# INTENT: all --- Target-specific variables
ifneq ($(UNIT.TARGET),)
$(UNIT.TARGET): LINKLIBS.local  := $(call ennermake_generate_flags_library_names,$(UNIT.LIBRARY_NAMES))
$(UNIT.TARGET): LINKFLAGS.local := $(call ennermake_generate_flags_library_dirs,$(UNIT.LIBRARY_DIRS)) \
                                   $(call ennermake_generate_flags_rpath,$(UNIT.LIBRARY_DIRS)) #DEBUG remove rpath
endif

# Set variables to be used inside UNIT.TARGET recipes
$(call ennermake_debug, making target for intent "$(UNIT.INTENT)" in unit "$(UNIT.NAME)")
$(UNIT.TARGET):   unitname := $(UNIT.NAME)
$(UNIT.TARGET):   unitintent := $(UNIT.INTENT)

# Helper for debugging
PROCESSED_INTENTS :=

# INTENT: executable
ifeq ($(UNIT.INTENT),$(INTENT.executable))
$(UNIT.TARGET): $(UNIT.OBJECTS_PIC) $(UNIT.DEPENDS) $(UNIT.REQUIRES)
	$(ECHO) Linking executable $@ --- in unit $(unitname) with intent $(unitintent)
	$(LINK.executable)
	$(ECHO) $(unitname) ready.
PROCESSED_INTENTS += executable
endif

# INTENT: libdynamic
ifeq ($(UNIT.INTENT),$(INTENT.libdynamic))
   $(UNIT.TARGET): $(UNIT.OBJECTS_PIC) $(UNIT.DEPENDS) | $(UNIT.REQUIRES)
	$(ECHO) Linking dynamic library $@ --- in unit $(unitname) with intent $(unitintent)
	$(LINK.dynamic)
	$(ECHO) $(unitname) ready.
PROCESSED_INTENTS += libdynamic
endif

# INTENT: libstatic    # DEBUG: todo / check
ifeq ($(UNIT.INTENT),$(INTENT.libstatic))
   $(UNIT.TARGET): $(UNIT.OBJECTS) $(UNIT.DEPENDS) | $(UNIT.REQUIRES)
	$(ECHO) Linking static library $@ --- in unit $(unitname) with intent $(unitintent)
	$(LINK.static)
	$(ECHO) $(unitname) ready.
PROCESSED_INTENTS += libstatic
endif

# INTENT: Archive  # DEBUG: todo / check
ifeq ($(UNIT.INTENT),$(INTENT.archive))
   $(UNIT.TARGET): $(UNIT.OBJECTS) $(UNIT.DEPENDS) | $(UNIT.REQUIRES)
	$(ECHO) Archiving in library $@ --- in unit $(unitname) with intent $(unitintent)
	$(LINK.archive)
	$(ECHO) $(unitname) ready.
PROCESSED_INTENTS += archive
endif

# Check if INTENT has been processed
ifeq ($(strip $(PROCESSED_INTENTS)),)
   $(error No intent was processed. Last intent was: $(UNIT.INTENT))
endif






# Create a phony name for target only if requested
ifneq ($(UNIT.PHONY),)
   .PHONY: $(UNIT.PHONY)
   $(UNIT.PHONY): $(UNIT.TARGET)
endif


# Clean target
UNIT.CLEANTARGET := clean_$(UNIT.NAME)
.PHONY: $(UNIT.CLEANTARGET)
$(UNIT.CLEANTARGET): unitcleanfiles := $(UNIT.CLEAN)
$(UNIT.CLEANTARGET):
	$(RM) $(unitcleanfiles)


# Propagate unit to locals
CLEAN_$(d)       += $(UNIT.CLEAN)
DEPFILES_$(d)    += $(UNIT.DEPFILES)
OBJECTS_$(d)     += $(UNIT.OBJECTS)
OBJECTS_PIC_$(d) += $(UNIT.OBJECTS_PIC)
SOURCES_$(d)     += $(UNIT.SOURCES)
TARGETS_$(d)     += $(UNIT.TARGET)
PHONYS_$(d)      += $(UNIT.PHONY)
UNITS_$(d)       += $(UNIT.NAME)


# On exit, undefine UNIT variables (alphabetically ordered, only user variables)
undefine UNIT.DEPENDS
undefine UNIT.INCLUDE_DIRS
undefine UNIT.INTENT
undefine UNIT.LIBRARY_NAMES
undefine UNIT.LIBRARY_DIRS
undefine UNIT.NAME
undefine UNIT.PHONY
undefine UNIT.REQUIRES
undefine UNIT.SOURCES
undefine UNIT.TARGET

