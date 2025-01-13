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
   echo "Usage: $0 [--force] PROJECTDIR"
   echo
   echo "Initializes ennermake using PROJECTDIR as project base directory."
   echo "If a Makefile already exists there, invoke with --force to overwrite existing files."
   echo
   exit 9
}

# error display
echoERR() { echo "$@" 1>&2; }



# SCRIPT CODE
# ===========

# argument check
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
   echoERR "Invalid number of arguments"
   echo
   usage
   exit 9
fi


# init vars
ENNERMAKEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECTDIR=$1
FORCED=0
CONFIGFILE="ennermake.packageconfig"


# if two args are specified, check if second argument is --forced
if [ $2 == "--force" ]; then
   FORCED=1
fi

# ensure PROJECTDIR exists
if [ ! -d "$PROJECTDIR" ]; then
   echoERR "Specified project base directory '$PROJECTDIR' does not exist."
   exit 9
fi

# transform to absolute path
PROJECTDIR=$( cd -- "$( dirname -- "${PROJECTDIR}" )" &> /dev/null && pwd )

# stop, if config file is already there and no --force flag was specified
if [ -f "$PROJECTDIR/$CONFIGFILE" ]; then
   if [ "$FORCED" -eq 0 ]; then
      echo "Config file $CONFIGFILE already present in $PROJECTDIR. Use --force to force overwrite."
      exit 9
   fi
fi

# initialize
echo "Using ennermake directory in '$ENNERMAKEDIR'"
echo "Initializing ennermake in project base directory '$PROJECTDIR'"

# make a backup of existing project file (even if forced!)
if [ -f "$PROJECTDIR/$CONFIGFILE" ]; then
   echo "--> Creating BACKUP of config file"
   cp -v $PROJECTDIR/$CONFIGFILE $PROJECTDIR/$CONFIGFILE.bak
fi

# copy configuration template and top level makefiles
cp -v "$ENNERMAKEDIR/ennermake_PackageConfigTemplate.mk" $PROJECTDIR/$CONFIGFILE
cp -v "$ENNERMAKEDIR/basedirmakefiles/Makefile" $PROJECTDIR
cp -v "$ENNERMAKEDIR/basedirmakefiles/MakeRules.mk" $PROJECTDIR


# finito
echo "Initialized ennermake in project dir $PROJECTDIR"
exit 0


