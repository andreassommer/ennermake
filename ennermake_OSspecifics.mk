-include $(ENNERMAKE_INC_FILE_ENTRY)



# Detect OS and set UNAME
include $(ENNERMAKE_SETUP_OS_DETECTION)



# Ensure that OS is supported
SUPPORTED_UNAMES = Linux Darwin Windows
ifneq ($(findstring $(UNAME),$(SUPPORTES_UNAMES)), )
   $(error Unsupported OS: $(UNAME))
else
   $(info __ Loading OS specific settings for: $(UNAME))
endif



# =====
# LINUX
# =====
ifeq ($(UNAME),Linux)
   $(info __ Setting Linux commands)
   export CXX   := g++
   export CC    := gcc
   export F77   := gfortran
   export AR    := ar
   export RM    := rm -fv 
   export FIND  := find
   export ECHO  := @echo __
   export CD    := cd
   export CP    := cp
   export MV    := mv
   export LS    := ls
   export MKDIR := mkdir -p
   export DEBUG := $(ECHO) DEBUG: 

   # File extensions
   EXT.obj        := .o
   EXT.objPIC     := .pic
   EXT.exe        :=
   EXT.libstatic  := .a
   EXT.libdynamic := .so
   EXT.depend     := .d
   EXT.archive    := .a

   # File prefixes
   PREFIX.libstatic  := lib
   PREFIX.libdynamic := lib
#endif at end of file !



# =====
# LINUX
# =====
else ifeq ($(UNAME),Cygwin)
   $(info __ Setting Cygwin commands)
   export CXX   := x86_64-w64-mingw32-g++.exe
   export CC    := x86_64-w64-mingw32-gcc.exe
   export F77   := x86_64-w64-mingw32-gfortran.exe
   export AR    := x86_64-w64-mingw32-ar.exe
   export RM    := rm -fv 
   export FIND  := find
   export ECHO  := @echo __
   export CD    := cd
   export CP    := cp
   export MV    := mv
   export LS    := ls
   export MKDIR := mkdir -p
   export DEBUG := $(ECHO) DEBUG: 

   # File extensions
   EXT.obj        := .o
   EXT.objPIC     := .pic
   EXT.exe        := .exe
   EXT.libstatic  := .a
   EXT.libdynamic := .dll
   EXT.depend     := .d
   EXT.archive    := .a

   # File prefixes
   PREFIX.libstatic  := lib
   PREFIX.libdynamic := lib
#endif at end of file !



# ======
# Darwin (=MACOS)
# ======
else ifeq ($(UNAME),Darwin)
   $(info __ Setting Darwin commands)
   export CXX   := g++
   export CC    := gcc
   export F77   := gfortran
   export AR    := ar
   export RM    := rm -f
   export FIND  := find
   export ECHO  := echo
   export CD    := cd
   export CP    := cp
   export MV    := mv
   export LS    := ls
   export MKDIR := mkdir -p
   export DEBUG := echo DEBUG: 

   # File extensions
   EXT.obj        := .o
   EXT.objPIC     := .pic
   EXT.exe        :=
   EXT.libstatic  := .a
   EXT.libdynamic := .dylib
   EXT.depend     := .d
   EXT.archive    := .a

   # File prefixes
   PREFIX.libstatic  := lib
   PREFIX.libdynamic := lib
$(error Darwin commands not yet tested)
#endif at end of file !



# =======
# Windows
# =======
else ifeq ($(UNAME),Windows)
   $(info __ Setting Windows commands)
   export CXX   := g++
   export CC    := gcc
   export F77   := gfortran
   export AR    := ar
   export RM    := del
   export FIND  := where 
   export ECHO  := echo
   export CD    := cd
   export CP    := copy
   export MV    := move
   export LS    := dir
   export MKDIR := mkdir
   export DEBUG := echo DEBUG: 

   # File extensions
   EXT.obj        := .o
   EXT.objPIC     := .pic
   EXT.exe        := .exe
   EXT.libstatic  := .lib
   EXT.libdynamic := .dll
   EXT.depend     := .d
   EXT.archive    := .a

   # File prefixes
   PREFIX.libstatic  :=
   PREFIX.libdynamic :=

$(error Windows commands not yet tested)
#endif at end of file !


else
$(error Unknown platform $(UNAME) -- Abort!)

endif


