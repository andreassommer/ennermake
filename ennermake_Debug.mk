ennermake_debug_enabled = 0
ifeq ($(ennermake_debug_enabled),1)
   ennermake_debug = $(info __ DEBUG: $(1))
else
   ennermake_debug =
endif
