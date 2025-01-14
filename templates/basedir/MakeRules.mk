-include $(ENNERMAKE_INC_FILE_ENTRY)

# TOP-LEVEL makerules.mk

# Save directory list (call stack, so to say)
sp              := 
dirstack_$(sp)  := 
d               := $(BASEDIR)

# sp             : stack pointer
# dirstack_$(sp) : directory stack
# d              : current directory
# dir            : directory to descend next


# this is the base module
MODULE_$(d)  := base


# include submodules, random order
SUBDIRS_$(d) := src  tests
include $(ENNERMAKE_INC_PROCESS_SUBDIRS)


# Include all generated dependency files
-include   $(DEPFILES)


# General directory independent rules

%$(EXT.obj):  %.c
	$(ECHO) Compiling $@
	$(ECHO) Prerequisites are $^ 
	$(DEBUG) NOT YET $(COMP.cc)

%$(EXT.obj):  %.cpp
	$(ECHO) Compiling $@
	$(ECHO) Prerequisites are $^ 
	$(COMP.cxx)

%$(EXT.objPIC): CXXFLAGS.all+=$(FLAGS.pic)
%$(EXT.objPIC): %.cpp
	$(ECHO) PIC-Compiling $@ 
	$(ECHO) Prerequisites are $^ 
	$(COMP.cxx)


# Define the "all" target
.PHONY: all
all:		phonies
	$(ECHO) all done.

# Shortcut to make all phony targets (this is what you usually want with 'make all')
.PHONY:		phonies
phonies:	$(PHONYS)
	$(ECHO) All phony targets built: $^

# Shortcut to make all targets
.PHONY:		targets
targets:	$(TARGETS) 

# Shortcut to clean everything
.PHONY:		clean
clean:
		$(ECHO) Cleaning...
		$(RM) $(CLEAN)

# Shortcut to simulate cleaning    #DEBUG: make that working on windows, macos, etc, i.e. substitute "ls" call
.PHONY:		dryclean
dryclean:
		$(ECHO) Cleaning would remove following...
		@$(LS) -1 $(CLEAN) 2>/dev/null || true




# Prevent make from removing any build targets, including intermediate ones
.SECONDARY:	$(CLEAN)




# End of file
-include $(ENNERMAKE_INC_FILE_EXIT)
