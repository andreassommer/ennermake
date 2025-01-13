#!/usr/bin/env bash


# script is not sourced
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
   echo "This script ${BASH_SOURCE[0]} must not be sourced. Abort!"
   return 9 
fi


# HELPER FUNCTIONS
# ================

# display help
usage() {
   echo
   echo "Usage: $0 init DESTINATION [--force]"
   echo "   Initializes ennermake using DESTINATION as project base directory."
   echo "   If a config file already exists there, invoke with --force to overwrite existing files."
   echo
   echo "Usage: $0 initsub SUBDIR [--force]"
   echo "   Initializes ennermake in SUBDIR as a project subdirectory."
   echo "   If a Makefile already exists there, invoke with --force to overwrite existing files."
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


# named arguments
ARG_COMMAND=$1
ARG_DESTINATION=$2
ARG_FORCE=$3

# init vars
ENNERMAKEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
COMMAND=$ARG_COMMAND
DESTINATION=$ARG_DESTINATION
FORCED=0
CONFIGFILE="ennermake.packageconfig"

# if two args are specified, check if second argument is --forced
if [ ARG_FORCE == "--force" ]; then
   FORCED=1
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


case $COMMAND in

   init | INIT)
      echo "Initializing ennermake in project base directory $DESTINATION"
      init_project_dir
      echo "Initialized ennermake in project dir $DESTINATION"
      ;;

   initsub | INITSUB)
      echo "Initializing ennermake in subdirectory $DESTINATION"
      init_sub_dir
      ;;

   *)
      echo "Unknown Command '$COMMAND'"
      echo "Abort!"
      exit 9
      ;;
esac


# finito
echo "Done."
exit 0


# HELPER SCRIPT:  Initialize in project base dir
init_project_dir() {
   # copy configuration template and top level makefiles
   cp -v --backup --suffix=.bak "$ENNERMAKEDIR/ennermake_PackageConfigTemplate.mk" $DESTINATION/$CONFIGFILE
   cp -v "$ENNERMAKEDIR/basedirmakefiles/Makefile"     $DESTINATION
   cp -v "$ENNERMAKEDIR/basedirmakefiles/MakeRules.mk" $DESTINATION
}


# HELPER SCRIPT:  Initialize in project subdirectory
init_sub_dir() {
   cp -v --backup --suffix=.bak "$ENNERMAKEDIR/subdirmakefiles/Makefile"     $DESTINATION
   cp -v --backup --suffix=.bak "$ENNERMAKEDIR/subdirmakefiles/MakeRules.mk" $DESTINATION
}