#!/bin/bash

set -eu

source ../../common-functions.sh

echo ""
echo "${info} *** Removing any existing executable directories *** ${normal}"
rm -rf executable

echo ""
echo "${info} *** Create an executable version of the com.greetings module *** ${normal}"
if [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] ; then
    # Windows users: please not that if the below fails due to JAVA_HOME substitution, please hard-code the JAVA_HOME path into the script
    jlink --module-path "${JAVA_HOME}\mods;mlib" \
          --add-modules com.greetings \
          --output test
else
    jlink --module-path "${JAVA_HOME}"/mods:mlib \
          --add-modules com.greetings \
          --output test
          #[add the module(s) that you want included in the final executable] \
          #[specify the folder where the distributable should be created]
fi

# Check out documentation on jlink to survive at this stage

echo ""
echo "${info} *** Displaying the contents (modules) of the 'executable' folder *** ${normal}"
runTree executable

# ****************************************************************************************************************************
# The value to `--module-path` is a PATH of directories containing the packaged modules.
# Replace the path separator ':' with ';' on Microsoft Windows.
# ****************************************************************************************************************************
