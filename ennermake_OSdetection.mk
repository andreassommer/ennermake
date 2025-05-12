-include $(ENNERMAKE_INC_FILE_ENTRY)

# Detect operating system 

# OLD:  Only windows uses semicolon ";" in path, the others have uname
#       That does not work anymore, as MinGW has the PATH variable in Windows format

# On Windows, the OS environment variable contains "Windows_NT"
UNAME_S := $(shell uname -s)
ifeq ($(OS),Windows_NT)
  ifeq ($(findstring MINGW,$(UNAME_S)),MINGW)
    UNAME := MINGW
  else ifeq ($(findstring MSYS,$(UNAME_S)),MSYS)
    UNAME := MSYS
  else ifeq ($(findstring CYGWIN,$(UNAME_S)),CYGWIN)
    UNAME := CYGWIN
  else
    UNAME := WINDOWS
  endif
else
  ifeq ($(UNAME_S),Linux)
    UNAME := LINUX
  else ifeq ($(UNAME_S),Darwin)
    UNAME := DARWIN
  else
    UNAME := LINUX
  endif
endif

# UNAME is now one of WINDOWS, LINUX, CYGWIN, MSYS, MINGW, DARWIN.
# If the uname command fails, it is set to Unknown.

# Display the detected OS
$(info __ Detected OS/Kernel: $(UNAME))

