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



#
#
# The following is an example used for project PDO (ParDynOpt)
#
#



# =================================
# PDO Configuration and Directories
# =================================

# -------------------------------------------------------------------------------------------------
# Directories, external libraries, pdo library name

# PDO directories
PDO_BASEDIR  ?= $(BASEDIR)
PDO_SRC_DIR  ?= $(PDO_BASEDIR)/src
PDO_BIN_DIR  ?= $(PDO_BASEDIR)/bin
PDO_LIB_DIR  ?= $(PDO_BASEDIR)/lib
PDO_INC_DIRS ?= $(PDO_SRC_DIR)

# Required libaries for building pdo (content is collected in these variables)
PDO_EXTLIBS_NAMES ?=
PDO_EXTLIBS_DIRS  ?=

# Name of PDO library
PDO_LIB_NAME := pardynopt

# -------------------------------------------------------------------------------------------------
# Package directories configuration    ( BASEDIRs  -  Set the base directories of all packages )

IPOPT_BASEDIR     ?= ~/source/ipopt
SNOPT_BASEDIR     ?= ~/source/snopt
FILTERSQP_BASEDIR ?= ~/source/filtersqp
EIGEN_BASEDIR     ?= ~/source/eigen
RBDL_BASEDIR      ?= ~/source/rbdl

SOLVINDSUITE_BASEDIR   ?= ~/source/solvind_suite
SOLVINDSUITE_BUILDTYPE := Debug



# -------------------------------------------------------------------------------------------------
# PDO configuration

#  ParDynOpt specific configurations
PDO_MEASURE_TIMINGS   := 1

# gtest for unit testing
PDO_WITH_GTEST        := 1

# NLP solvers
PDO_WITH_IPOPT        := 1
PDO_WITH_SNOPT        := 0
PDO_WITH_FILTERSQP    := 0

#  rbdl and eigen
PDO_WITH_EIGEN        := 1
PDO_WITH_RBDL         := 0


#  SolvIND suite
PDO_WITH_SOLVINDSUITE := 1
ifeq ($(PDO_WITH_SOLVINDSUITE), 1)
   PDO_WITH_SOLVIND     := 1
   PDO_WITH_SONIC       := 1
   PDO_WITH_COMMONCODE  := 1
   PDO_WITH_ADOLC       := 1
   PDO_WITH_UMFPACK     := 1
   PDO_WITH_UFCONFIG    := 1
   PDO_WITH_AMD         := 1
endif






# =================================
# INDIVIDUAL PACKAGES CONFIGURATION
# =================================


# -------------------------------------------------------------------------------------------------
#  NLP solvers

# IPOPT
ifeq ($(PDO_WITH_IPOPT), 1)
   IPOPT_BASEDIR   := $(abspath $(wildcard $(IPOPT_BASEDIR)))
   IPOPT_BUILD_DIR ?= $(IPOPT_BASEDIR)/build
   IPOPT_INC_DIRS  ?= $(IPOPT_BUILD_DIR)/include
   IPOPT_LIB_NAMES ?= ipopt coinasl coinmumps coinmetis coinhsl 
   IPOPT_LIB_DIRS  ?= $(IPOPT_BUILD_DIR)/lib
   PDO_EXTLIBS_NAMES += $(IPOPT_LIB_NAMES)
   PDO_EXTLIBS_DIRS  += $(IPOPT_LIB_DIRS)
endif

# SNOPT
ifeq ($(PDO_WITH_SNOPT), 1)
   SNOPT_BASEDIR   := $(abspath $(wildcard $(SNOPT_BASEDIR)))
   SNOPT_INC_DIRS  ?= $(SNOPT_BASEDIR)/cppsrc \
                      $(SNOPT_BASEDIR)/f2c/src
   SNOPT_LIB_DIRS  ?= $(SNOPT_BASEDIR)/lib
   SNOPT_LIB_NAMES ?= snopt snprint            #TODO: Which are needed?
   PDO_EXTLIBS_NAMES += $(SNOPT_LIB_NAMES)
   PDO_EXTLIBS_DIRS  += $(SNOPT_LIB_DIRS)
endif

# FILTER-SQP
ifeq ($(PDO_WITH_FILTERSQP), 1)
   FILTERSQP_BASEDIR   := $(abspath $(wildcard $(FILTERSQP_BASEDIR)))
   FILTERSQP_INC_DIRS  ?= $(FILTERSQP_BASEDIR)/include  #TODO
   FILTERSQP_LIB_DIRS  ?= $(FILTERSQP_BASEDIR)/lib
   FILTERSQP_LIB_NAMES ?= filtersqp                     #TODO 
   PDO_EXTLIBS_NAMES += $(FILTERSQP_LIB_NAMES)
   PDO_EXTLIBS_DIRS  += $(FILTERSQP_LIB_DIRS)
endif




# -------------------------------------------------------------------------------------------------
#  rbdl examples

ifeq ($(PDO_WITH_EIGEN), 1)
   EIGEN_BASEDIR   := $(abspath $(wildcard $(EIGEN_BASEDIR)))
   EIGEN_INC_DIRS  ?= $(EIGEN_BASEDIR) 
endif

ifeq ($(PDO_WITH_RBDL), 1)
   RBDL_BASEDIR    := $(abspath $(wildcard $(RBDL_BASEDIR)))
   RBDL_INC_DIRS   ?= $(RBDL_BASEDIR)/build/include
   RBDL_LIB_DIRS   ?= $(RBDL_BASEDIR)/build/lib
   RBDL_LIB_NAMES  ?= rdbl              #TODO
   PDO_EXTLIBS_NAMES += $(RBDL_LIB_NAMES)
   PDO_EXTLIBS_DIRS  += $(RDBL_LIB_DIRS)
endif



# -------------------------------------------------------------------------------------------------
#  SOLVIND SUITE  ( Solvind, Sonic, SuiteSparse=(UMFpack,UFconfig,AMD), ADOLC, CommonCode)

ifeq ($(PDO_WITH_SOLVINDSUITE), 1)
   SOLVINDSUITE_BASEDIR := $(abspath $(wildcard $(SOLVINDSUITE_BASEDIR)))
   SOLVIND_BASEDIR      ?= $(SOLVINDSUITE_BASEDIR)/Packages/SOLVIND
   SOLVIND_BUILD_DIR    ?= $(SOLVIND_BASEDIR)/$(SOLVINDSUITE_BUILDTYPE)
   SONIC_BASEDIR        ?= $(SOLVINDSUITE_BASEDIR)/Packages/SONIC
   SONIC_BUILD_DIR      ?= $(SONIC_BASEDIR)/$(SOLVINDSUITE_BUILDTYPE)
   COMMONCODE_BASEDIR   ?= $(SOLVINDSUITE_BASEDIR)/Packages/COMMON_CODE
   COMMONCODE_BUILD_DIR ?= $(COMMONCODE_BASEDIR)/$(SOLVINDSUITE_BUILDTYPE)
   ADOLC_BASEDIR        ?= $(SOLVINDSUITE_BASEDIR)/Packages/ADOL-C/adolc_base
   #---DEBUG: UMFpack is a subsystem of suitesparse --> rename, update and adjust  (#TODO)
   SUITESPARSE_BASEDIR  ?= $(SOLVINDSUITE_BASEDIR)/Packages/UMFPACK
   UMFPACK_BASEDIR      ?= $(SUITESPARSE_BASEDIR)/UMFPACK
   UFCONFIG_BASEDIR     ?= $(SUITESPARSE_BASEDIR)/UFconfig
   AMD_BASEDIR          ?= $(SUITESPARSE_BASEDIR)/AMD
   #---DEBUG: UMFpack
   SOLVIND_INC_DIRS     ?= $(SOLVIND_BUILD_DIR)/include
   SOLVIND_LIB_DIRS     ?= $(SOLVIND_BUILD_DIR)/lib64
   SONIC_INC_DIRS       ?= $(SONIC_BUILD_DIR)/include
   SONIC_LIB_DIRS       ?= $(SONIC_BUILD_DIR)/lib64
   COMMONCODE_INC_DIRS  ?= $(COMMONCODE_BUILD_DIR)/include
   COMMONCODE_LIB_DIRS  ?= $(COMMONCODE_BUILD_DIR)/lib64
endif

ifeq ($(PDO_WITH_ADOLC), 1)
   ADOLC_INC_DIRS    ?= $(ADOLC_BASEDIR)/include \
                        $(ADOLC_BASEDIR)/include/adolc
   ADOLC_LIB_DIRS    ?= $(ADOLC_BASEDIR)/lib64
endif

ifeq ($(PDO_WITH_UMFPACK), 1)
   UMFPACK_INC_DIRS  ?= $(UMFPACK_BASEDIR)/Include
   UMFPACK_LIB_DIRS  ?= $(UMFPACK_BASEDIR)/Lib
endif

ifeq ($(PDO_WITH_UFCONFIG), 1)
   UFCONFIG_INC_DIRS ?= $(UFCONFIG_BASEDIR)
endif

ifeq ($(PDO_WITH_AMD), 1)
   AMD_INC_DIRS      ?= $(AMD_BASEDIR)/Include
   AMD_LIB_DIRS      ?= $(AMD_BASEDIR)/Lib
endif

# Collect all include dirs for SOLVINDSUITE
ifeq ($(PDO_WITH_SOLVINDSUITE), 1)
   SOLVINDSUITE_INC_DIRS := $(SOLVIND_INC_DIRS) \
                            $(SONIC_INC_DIRS) \
                            $(COMMONCODE_INC_DIRS) \
                            $(ADOLC_INC_DIRS) \
                            $(UMFPACK_INC_DIRS) \
                            $(UFCONFIG_INC_DIRS) \
                            $(AMD_INC_DIRS) 
   SOLVINDSUITE_LIB_DIRS := $(SOLVIND_LIB_DIRS) \
                            $(SONIC_LIB_DIRS) \
                            $(COMMONCODE_LIB_DIRS) \
                            $(ADOLC_LIB_DIRS) \
                            $(UMFPACK_LIB_DIRS) \
                            $(AMD_LIB_DIRS) 
   SOLVINDSUITE_LIB_NAMES := solvind solvind_factory daesol2 sonic common_code_logging common_code_utilities common_code_problem_handling adolc umfpack amd
   PDO_EXTLIBS_NAMES   += $(SOLVINDSUITE_LIB_NAMES) 
   PDO_EXTLIBS_DIRS    += $(SOLVINDSUITE_LIB_DIRS)
endif







# END OF FILE

