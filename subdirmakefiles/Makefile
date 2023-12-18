# This file shall be present in every subdirectory to ensure that the top-level makefile is invoked by a plain "make"
MAKEHELPER_SELF_DIR   := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
MAKEHELPER_PARENT_DIR := $(realpath $(MAKEHELPER_SELF_DIR)/..)
include $(MAKEHELPER_PARENT_DIR)/Makefile
