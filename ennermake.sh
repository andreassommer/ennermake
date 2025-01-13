#!/usr/bin/env bash


# script is not sourced
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
   echo "This script ${BASH_SOURCE[0]} must not be sourced. Abort!"
   return 9 
fi



# ARGUMENT PROCESSING and VARIABLES
# =================================

# named arguments
ARG_COMMAND=$1
ARG_DESTINATION=$2
ARG_FORCE=$3
FORCEFLAG="--force"

# init vars
COMMAND=$ARG_COMMAND
DESTINATION=$ARG_DESTINATION

# check if force flag is specified
FORCED=0
if [ "$ARG_FORCE" == "$FORCEFLAG" ]; then
   FORCED=1
fi

# directories and files
ENNERMAKEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TEMPLATEDIR="$ENNERMAKEDIR/templates"
CONFIGFILE="ennermake_packageconfig.mk"




# HELPER FUNCTIONS
# ================

# display help
usage() {
   echo
   echo "Usage: $0 init DESTINATION [$FORCEFLAG]"
   echo "   Initializes ennermake using DESTINATION as project base directory."
   echo "   If a config file already exists there, invoke with $FORCEFLAG to overwrite existing files."
   echo
   echo "Usage: $0 initsub SUBDIR [$FORCEFLAG]"
   echo "   Initializes ennermake in SUBDIR as a project subdirectory."
   echo "   If a Makefile already exists there, invoke with $FORCEFLAG to overwrite existing files."
   exit 9
}

# error display
echoERR() { echo "$@" 1>&2; }



# SCRIPT CODE
# ===========

# argument check
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
   echoERR "Invalid number of arguments"
   echo
   usage
   exit 9
fi


# ensure DESTINATION exists
if [ ! -d "$DESTINATION" ]; then
   echoERR "Specified project base directory '$DESTINATION' does not exist."
   exit 9
fi

# transform to absolute path
DESTINATION=$( cd -- "$( dirname -- "${DESTINATION}" )" &> /dev/null && pwd )


# initialize
echo "Using ennermake directory in '$ENNERMAKEDIR'"




# HELPER SCRIPT:  Abort if file exists and not overwriting is not forced
abort_if_not_forced() {
   local QUERYFILE=$1
   local QUERYDIR=$2
   local FORCED=$3
   if [ -f "$QUERYDIR/$QUERYFILE" ]; then
      if [ "$FORCED" -eq 0 ]; then
         echo "File $QUERYFILE already present in $QUERYDIR. Use $FORCEFLAG to overwrite."
         exit 9
      fi
   fi
}


# HELPER SCRIPT:  Initialize in project base dir
init_project_dir() {
   # check if file exists
   abort_if_not_forced "$CONFIGFILE" "$DESTINATION" $FORCED
   # copy configuration template and top level makefiles
   cp -v --backup "$TEMPLATEDIR/ennermake_packageconfig.mk" $DESTINATION/$CONFIGFILE
   cp -v --backup "$TEMPLATEDIR/basedir/Makefile"     $DESTINATION
   cp -v --backup "$TEMPLATEDIR/basedir/MakeRules.mk" $DESTINATION
}


# HELPER SCRIPT:  Initialize in project subdirectory
init_sub_dir() {
   cp -v --backup "$TEMPLATEDIR/subdirs/Makefile"     $DESTINATION
   cp -v --backup "$TEMPLATEDIR/subdirs/MakeRules.mk" $DESTINATION
}



# PROCESS COMMAND
case $COMMAND in

   init | INIT)
      echo "Initializing ennermake in PROJECT BASE DIRECTORY $DESTINATION"
      init_project_dir
      echo "Initialized ennermake in project dir $DESTINATION"
      ;;

   initsub | INITSUB)
      echo "Initializing ennermake in SUB-DIRECTORY $DESTINATION"
      init_sub_dir
      ;;

   *)
      echo "Unknown Command '$COMMAND'"
      echo "Abort!"
      exit 9
      ;;
esac


# FINITO
echo "Done."
exit 0

