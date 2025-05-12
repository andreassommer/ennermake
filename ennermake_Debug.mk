ennermake_debug_enabled = 1
ennermake_debug_include_makefilename = 0;

ifeq ($(ennermake_debug_include_makefilename),1)
	ennermake_debug_makefilename = [$(lastword $(MAKEFILE_LIST))]
else
	ennermake_debug_makefilename =
endif


ifeq ($(ennermake_debug_enabled),1)
   ennermake_debug = $(info __ $(ennermake_debug_makefilename) DEBUG: $(1))
   ennermake_show  = $(info __ $(ennermake_debug_makefilename) DEBUG: Variable $(1) with origin $(origin $(strip $(1))) = $($(strip $(1))))
else
   ennermake_debug =
   ennermake_show  = 
endif

