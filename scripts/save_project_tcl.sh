#!/bin/sh

# Go to this script directory
BASEDIR=$(dirname "$0")
cd $BASEDIR

# Call TCL script
vivado -mode tcl -source ./save_project_tcl.tcl -notrace

# Remove junk files
rm -f layout
rm -rf .Xil
rm -f vivado*.jou
rm -f vivado*.log

