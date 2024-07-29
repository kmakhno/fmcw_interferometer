#!/bin/sh

# Get this script directory
BASEDIR=$(dirname "$0")

# Go to parent dir
cd $BASEDIR/..

# Clean BD directories
for d in ./src/bd/*/ ; do
    rm -rf $d/hw_handoff
    rm -rf $d/ip
    rm -rf $d/ipshared
    rm -rf $d/sim
    rm -rf $d/synth
    rm -rf $d/ui
    rm -f $d/*.bd
    rm -f $d/*.bmm
    rm -f $d/*.bxml
    rm -f $d/*_ooc.xdc
done

# Remove Vivado project directory
rm -r vivado

# Create Vivado project
vivado -mode tcl -source ./create_project.tcl -notrace

# Remove temp and debug files
rm -rf .Xil
rm -f ./vivado*.jou
rm -f ./vivado*.log

