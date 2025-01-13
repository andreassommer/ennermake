# TOP-LEVEL Makefile
$(info ___PROCESSING: $(realpath $(lastword $(MAKEFILE_LIST))))


# ========================
# Setup and load ENNERMAKE

# Set Base Directory and ENNERMAKE directory
BASEDIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

# load ENNERMAKE system
ENNERMAKE_PROJECT_BASEDIR := $(BASEDIR)
include $(BASEDIR)/mk/ennermake_system.mk

# load project package configuration
include $(ENNERMAKE_PACKAGECONFIG)




# ======================
# List of possible flags

FLAGS.shared     := -shared
FLAGS.pic        := -fPIC
FLAGS.debug      := -g -ggdb -O0
FLAGS.cxx11      := -std=c++11 -pedantic 
FLAGS.cxx13      := -std=c++13 -pedantic 
FLAGS.warnings   := -Wall -Wfloat-equal -Wshadow -Wconversion -Wsign-conversion
FLAGS.optimize   := -O3

FLAGS.cxx.default  := $(FLAGS.cxx11) $(FLAGS.warnings) $(FLAGS.optimize)
FLAGS.cxx.debug    := $(FLAGS.cxx11) $(FLAGS.warnings) $(FLAGS.debug)  -Wno-float-equal


# =========
# CONFIG

CFLAGS.all         := 
CXXFLAGS.all       := $(FLAGS.cxx.debug)
LINKFLAGS.all      := 
LINKLIBS.all       :=
ARFLAGS.all        := rcs # DEBUG # TODO



# Dependency generation inspired by: http://make.mad-scientist.net/papers/advanced-auto-dependency-generation
# -MT $@   Specify exact name of the target in the generated dependency file
# -MMD     Dependency generation during (not instead of) compilation, without system headers (use -MD to include system headers)
# -MP      Adds a target for each prerequisite in the list, to avoid errors when deleting files
# -MF x.d  Write the generated dependency file x.d
###DEPDIR := . #UNUSED CURRENTLY
DEPFLAGS = -MT $@ -MMD -MP -MF $*$(EXT.depend)


### Build tools:  (non-immediate variables)
# gcc [options] [source files] [object files] [-Ldir] -llibname [-o outfile]
COMP.cc    = $(CC)  $(DEPFLAGS) $(CFLAGS.all)   $(CFLAGS.local)   -o $@ -c $<
COMP.cxx   = $(CXX) $(DEPFLAGS) $(CXXFLAGS.all) $(CXXFLAGS.local) -o $@ -c $<
LINK.executable = $(CXX) $(CXXFLAGS.all) $(CXXFLAGS.local) $(LINKFLAGS.all) $(LINKFLAGS.local) -o $@ $^ $(LINKLIBS.all) $(LINKLIBS.local)   ## TODO
LINK.dynamic    = $(CXX) $(CXXFLAGS.all) $(CXXFLAGS.local) $(LINKFLAGS.all) $(LINKFLAGS.local) $(FLAGS.shared) -o $@ $^ $(LINKLIBS.all) $(LINKLIBS.local)   ## TODO
LINK.static     = $(CXX) $(CXXFLAGS.all) $(CXXFLAGS.local) $(LINKFLAGS.all) $(LINKFLAGS.local) $(FLAGS.static) -o $@ $^ $(LINKLIBS.all) $(LINKLIBS.local)   ## TODO
LINK.archive    = $(AR) $(ARFLAGS.all) $(ARFLAGS.local) $@ $^   ## TODO




# If a plain "make" is invoked, display the list of targets
.DEFAULT_GOAL := info



# Start the walk through non-recursive make
include $(BASEDIR)/MakeRules.mk



# Display the list of targets
.PHONY: targetlist
targetlist: DISPLAYTARGETS := $(foreach word,$(sort $(TARGETS)),$(word) \| )
targetlist:
	$(ECHO)
	$(ECHO) List of TARGETS
	$(ECHO) '  ' $(DISPLAYTARGETS)
	$(ECHO)


# Display some information
.PHONY:	info
info: DISPLAYMODULES := $(foreach word,$(sort $(MODULES)),$(word) \| )
info: DISPLAYUNITS   := $(foreach word,$(sort $(UNITS)),$(word) \| )
info: DISPLAYPHONYS  := $(foreach word,$(sort $(PHONYS)),$(word) \| )
info:
	$(ECHO)
	$(ECHO) List of MODULES
	$(ECHO) '  ' $(DISPLAYMODULES)
	$(ECHO) Every module can be preponed by \'compile_\' to trigger full compulation of objects.
	$(ECHO) Every module can be preponed by \'clean_\' to clean the module and all submodules.
	$(ECHO)
	$(ECHO) List of UNITS
	$(ECHO) '  ' $(DISPLAYUNITS)
	$(ECHO) Every unit can be preponed by \'clean_\' to clean the module and all submodules.
	$(ECHO)
	$(ECHO) List of PHONY targets
	$(ECHO) '  ' $(DISPLAYPHONYS)
	$(ECHO)
	$(ECHO) Cleaning:
	$(ECHO) "   make clean    :  clean everything."
	$(ECHO) "   make dryclean :  display a list what will be deleted upon cleaning."
	$(ECHO) Every module and every unit can be preponed by \'clean_\' to start specific cleaning.
	$(ECHO)
	$(ECHO) Tab-completion can be used depening on your shell:
	$(ECHO) "   make clean<TAB><TAB> :  gives a list of all cleaning targets."
	$(ECHO) "   make <TAB><TAB>      :  gives a list of all make targets."

# Documentation as recursive make (since doc is completely independent of everything else)
.PHONY: doc
doc:
	$(ECHO) Invoking sub-make for independent doc generation
	$(CD) doc && $(MAKE)
clean_doc:
	$(ECHO) Invoking sub-make for independent doc cleaning
	$(CD) doc && $(MAKE) clean
TARGETS += doc




# End of file
-include $(ENNERMAKE_INC_FILE_EXIT)
