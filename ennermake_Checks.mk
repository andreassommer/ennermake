# Check if unit name is unique
ennermake_check_unitname_is_unique = \
   $(if $(filter $(1),$(UNITS)),\
      $(call ennermake_error, Unit name "$(1)" already exists.))


# Check if module name is available
ennermake_check_module_name_available= \
   $(if $(MODULE_$(d)),\
   ,\
   $(call ennermake_error, No module name specified.))


# Check if intent is valid
ennermake_check_intent = \
   $(if $(filter $(1),$(INTENTS)),\
   ,\
   $(call ennermake_error, Invalid intent: $(1)))


# Message that a check failed
ennermake_error = \
  $(info Error while processing directory $(d))\
  $(error Error: $(1))