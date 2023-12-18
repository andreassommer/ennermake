# Debug helper for makefiles.
#
# USAGE:   include ennermake_inc_show_variables.mk
#
# To display only changed values, and to exclude main shell environment variables,
# set the MAKEDEBUG_VARS_EXCLUDED in an appropriate place of the main makefile
# (e.g. as the first line), i.e. set
#    MAKEDEBUG_VARS_EXCLUDED := $(.VARIABLES)
#
# If using in submakes, you probably want to
#    export MAKEDEBUG_VARS_EXCLUDED := $(.VARIABLES)
# in the calling makefile.
#
# Notes: - Immediate assignment is necessary (note the := assignment!)
#        - If using gmake, "make -pn" gives valuable output about the building process.
#
# Andreas Sommer, Jan2021
# andreas.sommer@iwr.uni-heidelberg.de
# code@andreas-sommer.eu


# Set variables to display
MAKEDEBUG_VARS_CURRENT   := $(sort $(.VARIABLES))
MAKEDEBUG_VARS_EXCLUDED  += MAKEDEBUG_VARS_EXCLUDED

# Display available and excluded variable names
#$(info __MAKEDEBUG_VARS_CURRENT:  $(MAKEDEBUG_VARS_CURRENT))
#$(info __MAKEDEBUG_VARS_EXCLUDED: $(MAKEDEBUG_VARS_EXCLUDED))

# Display the content of all but excluded variables
$(info __MAKEDEBUG LIST OF VARIABLES START)
$(foreach v,   \
  $(filter-out $(MAKEDEBUG_VARS_EXCLUDED),$(MAKEDEBUG_VARS_CURRENT)), \
  $(info __ $(v) = $($(v))))
$(info __MAKEDEBUG LIST OF VARIABLES END)


