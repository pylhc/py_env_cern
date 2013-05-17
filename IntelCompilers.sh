#!/bin/bash

#. $DIR/x86_64/Compiler/11.1/056/bin/iccvars.sh intel64
#

if (( $# != 1 )) 
then
  echo "You must specify the environment for 'arch'. Accepted arguments: intel64, ia32"
  echo
  return 1
elif [   "$1" == "ia32" ] 
then
	arch=ia32
	archdir=bin32
elif [ "$1" == "intel64" ] 
then
	arch=intel64
	archdir=bin64
else 
		echo "$1 is not a valid architecture, possible options are intel64,ia32"
		return 1
fi

echo "Starting.."
export INTEL_LOCAL_DIR="/afs/cern.ch/sw/IntelSoftware/linux/"

export FC=ifort

version=$1
echo $PATH | grep $INTEL_LOCAL_DIR > /dev/null
if (( $? == 0 ))
then
  echo "Removing existing PATH"
  PATH=`echo $PATH | sed 's?'$INTEL_LOCAL_DIR'.*/bin/intel64??'`
fi

if [ "$version" == "0" ]
then
    echo "Wrong version: ${version}"
    return 0
fi
source $INTEL_LOCAL_DIR/setup.sh
source $INTEL_LOCAL_DIR/x86_64/xe2013/bin/ifortvars.sh $arch

# YIL added:
export CC=`which icc`
export CXX=`which icpc`
export FC=`which ifort`
