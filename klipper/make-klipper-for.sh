#!/bin/bash
# this script assumes:
#   klipper is installed in ~/klipper directory
#   config files are in the current directory
#

klipperDir='~/klipper/'
configDir='~/printer_data/config'
configKlipperDir=${configDir}/klipper
sourceFile="${configKlipperDir}/.config-$1"
expandedSourceFile="$(eval "ls ${sourceFile} 2> /dev/null")"
expandedKlipperDir="$(eval "ls -d ${klipperDir} 2> /dev/null")"

if [[ -f ${expandedSourceFile} && -d ${expandedKlipperDir} ]]; then
	cmd="cp ${expandedSourceFile} ${expandedKlipperDir}.config"
	echo $cmd
	eval ${cmd}
elif [[ ! -f ${expandedSourceFile} ]]; then
	echo "source file ${sourceFile} doesn't exist"
	exit -1
elif [[ ! -d ${expandedKlipperDir} ]]; then
	echo "klipper directory ${expandedKlipperDir} doesn't exist"
	exit -1
fi
pushd ${expandedKlipperDir}
make menuconfig
make clean
make
popd

grep -B 1 canbus_uuid $(eval "ls ${configDir}/printer.cfg 2> /dev/null")
