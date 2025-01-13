-include $(MAKE_INC_FILE_ENTRY)

# Package definitions

# -------------------------------------------------------------------------------------------------

# This file should set for every package/submodule xxx:
# - the base directories  (xxx_BASEDIR) 
# - the build directories (xxx_BUILD_DIR)
# - library directories   (xxx_LIB_DIR)
# - include directories   (xxx_INC_DIR)

# All variables can be initialized/overridden from the environment

# All BASEDIRs are transformed in absolute paths and made immediate
# by using  VAR := $(abspath $(wildcard $(VAR)))
#   :=       --> make the variable immediate (see documentation of make)
#   abspath  --> transforms into absolute path names (see also realpath)
#   wildcard --> ensures that "~" for the user home is correctly translated 

# -------------------------------------------------------------------------------------------------



# =====================
# Project Configuration
# =====================

# -------------------------------------------------------------------------------------------------
# Directories, external libraries, library name, etc.

# project directories
PROJECT_BASEDIR  ?= $(BASEDIR)
PROJECT_SRC_DIR  ?= $(PROJECT_BASEDIR)/src
PROJECT_BIN_DIR  ?= $(PROJECT_BASEDIR)/bin
PROJECT_LIB_DIR  ?= $(PROJECT_BASEDIR)/lib
PROJECT_INC_DIRS ?= $(PROJECT_SRC_DIR)

# Required libaries for building PROJECT (content is collected in these variables)
PROJECT_EXTLIBS_NAMES ?=
PROJECT_EXTLIBS_DIRS  ?=

# Name of PROJECT library
# PROJECT_LIB_NAME := projectlib


# -------------------------------------------------------------------------------------------------
# Package directories configuration    ( BASEDIRs  -  Set the base directories of all packages )



# END OF FILE

