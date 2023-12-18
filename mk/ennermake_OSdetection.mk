-include $(ENNERMAKE_INC_FILE_ENTRY)

# Detect operating system 

# Explanation:  Only windows uses semicolon ";" in path, the others have uname
ifeq ($(findstring ;,$(PATH)), ;)
    UNAME := Windows
else
    UNAME := $(shell uname 2>/dev/null || echo Unknown)
    UNAME := $(patsubst CYGWIN%,Cygwin,$(UNAME))
    UNAME := $(patsubst MSYS%,MSYS,$(UNAME))
    UNAME := $(patsubst MINGW%,MSYS,$(UNAME))
endif
# UNAME is now one of Windows, Linux, Cygwin, MSYS, FreeBSD, NetBSD, Darwin, Solaris, OpenBSD, AIX, HP-UX.
# If the uname command fails, it is set to Unknown.


# Display the detected OS
$(info __ Detected OS/Kernel: $(UNAME))
