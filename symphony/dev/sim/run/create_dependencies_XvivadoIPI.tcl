#!/bin/bash
# -----------------------------------------------------------------------//
#
# Copyright (C) 2018 Fidus Systems Inc.
#
# Project       : simu
# Author        : Jacob von Chorus
# Created       : 2019-02-15
# -----------------------------------------------------------------------//
# -----------------------------------------------------------------------//
# Description   : Creates dependencies required to run a regression of all testcases               
#               Usage:
#                   cd sim/run/
#                   tclsh create_regression_dependencies.tcl
#   CURRENT TOOL VERSION REQUIREMENTS
#   - Vivado 2018.2
#   - Quartus 18.1 Standard
#   - Questa 10.6d
#   - Redhat 7
#       * Change checks below if versions change.
#
# Updated       : date / author - comments
#-----------------------------------------------------------------------//

# Check licenses.
puts stdout "################################################################"
puts stdout "Checking /export/ssd/common_settings_licenses"
puts stdout "################################################################"
if { ![info exists ::env(LM_LICENSE_FILE)] } {
    puts stdout "ERROR LICENSES NOT SOURCED: source /export/ssd/common_settings/licenses"
    return;
}

# Check Vivado 2018.2 path.
puts stdout "################################################################"
puts stdout "Checking /export/ssd/set_vivado.sh for 2018.2"
puts stdout "################################################################"
if { [catch {exec which vivado} msg] } {
    puts stdout "ERROR NO VIVADO: source /export/ssd/common_settings/set_vivado.sh 2018.2"
    return;
} else {
    # Check version
    if {[regexp -line "2018\\.2" $msg] == 0} {
        puts stdout "ERROR WRONG VIVADO VERSION: Requries 2018.2"
        return;
    }
}

######################################################################
# Build IPI example.
puts stdout "################################################################"
puts stdout "Building IPI example design."
puts stdout "################################################################"
cd ../../builds/vivado/projects/
if { ![file exists ipi_example.xpr] } {
    exec >&@stdout vivado -mode batch -source ../../scripts/create_project.tcl
} else {
    puts stdout ">>>>>>IPI EXAMPLE DESIGN ALREADY EXISTS."
}
cd ../../../sim/run


puts stdout "################################################################"
puts stdout "!!!NOT FINISHED: Dependencies for regression need Questa/Modelsim Simulation Libraries!!!"
puts stdout "################################################################"
