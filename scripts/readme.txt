!!! ATTENTION !!!
=================

This scripts were tested with Vivado 2019.1 in Microsoft Windows 10 and Ubuntu 20.04.
Correct performance is not guaranteed in other versions of Vivado or other OS.
Correct performance is not guaranteed for your project.
Always back up your essential projects!



Description
===========

The main goal of this project is simplification of version control for Vivado projects (especially with block designs (BD)).
This is set of scripts for saving Vivado project to TCL script and recreating Vivado project from TCL script.
Project settings and links to all remote source files are saved in main TCL script. Every BD is saved in separate TCL script and calls of these BD scripts are added to main TCL script. So only these TCL scripts and remote source files need to be version controlled.
To recreate Vivado project and all BDs you need just run main TCL script.



Requirements
============

- Microsoft Windows or Ubuntu
- Xilinx Vivado 2019.1 (path to Vivado /bin directory must be added to PATH system variable)
- Python 3 (only for saving project to TCL script)



Content
=======

- readme.txt - this file
- save_project_tcl.bat - batch file that runs save_project_tcl.tcl script in Vivado shell
- save_project_tcl.sh - shell script that runs save_project_tcl.tcl script in Vivado shell
- save_project_tcl.tcl - TCL script that generates TCL scripts for project recreating and modifies them with Python scripts
- modify_bd_tcl.py - Python script for modifying block design TCL script
- modify_project_tcl.py - Python script for modifying project TCL script
- create_project.bat - batch file that creates Vivado project from create_project.tcl file
- create_project.sh - shell script that creates Vivado project from create_project.tcl file



How to use
==========

Project structure
-----------------

Project directory hierarchy should has the following structure:

    some_project/
    ├── ip_repo/
    ├── scripts/
    │   ├── create_project.bat             ┐
    │   ├── modify_bd_tcl.tcl              │
    │   ...                                │ These scripts
    │   ├── save_project_tcl.bat           │
    │   ├── save_project_tcl.tcl           ┘
    │   └── some_script.tcl
    ├── sdk/
    ├── src/                               ┐
    │   ├── bd/                            │
    │   │   ├── some_bd/                   │
    │   │   │   ├── hdl/                   │
    │   │   │   ├── ip/                    │
    │   │   │   ├── sim/                   │
    │   │   │   ├── synth/                 │
    │   │   │   ├── ui/                    │
    │   │   │   ├── some_bd.bd             │
    │   │   │   ...                        │
    │   │   └── some_bd.tcl                │
    │   ├── constr/                        │ Remote sources
    │   │   ├── timing.xdc                 │
    │   │   ...                            │
    │   ├── hdl/                           │
    │   │   ├── some_file.v                │
    │   │   ...                            │
    │   ├── ip/                            │
    │   │   └── some_ip/                   │
    │   │       └── some_ip.xci            │
    │   └── tb/                            │
    │       └── some_testbench.v           ┘
    ├── vivado/
    │   ├── some_project.cache/            ┐
    │   ├── some_project.cache/            │
    │   ...                                │ Vivado project 
    │   ├── some_project.sim/              │
    │   └── some_project.xpr               ┘
    └── create_project.tcl


Project content in version control system:

    some_project/
    ├── ip_repo/
    ├── scripts/
    │   └── some_script.tcl
    ├── sdk/
    ├── src/                               ┐
    │   ├── bd/                            │
    │   │   └── some_bd.tcl                │
    │   ├── constr/                        │ 
    │   │   ├── timing.xdc                 │
    │   │   ...                            │
    │   ├── hdl/                           │ Remote sources
    │   │   ├── some_file.v                │
    │   │   ...                            │
    │   ├── ip/                            │
    │   │   └── some_ip/                   │
    │   │       └── some_ip.xci            │
    │   └── tb/                            │
    │       └── some_testbench.v           ┘
    └── create_project.tcl


Principles for starting new project
-----------------------------------

- project should be located in vivado/ directory
- [Project Settings > IP > Default IP Location] points to src/ip/ directory
- if using custom IPs it is recommended to place IPs in ip_repo/ (specific IP for current project only) or in ../ip_repo (IP for all projects). Paths to custom IP repos should be added to [Project Settings > IP > Repository > IP Repositories]
- existing sources should be located in src/ directory in proper subdirectory and added to Vivado project as remote sources without copying into project
- new sources should be saved in src/ in proper subdirectory
- block designs should be created in src/bd/ directory


Creating project from TCL script
--------------------------------

1. Run create_project.bat (Windows) or create_project.sh (Linux) to create Vivado project
2. Open project in Vivado and check for errors
3. Try to generate bitstream


Updating project from TCL script
--------------------------------

1. Backup current project
2. Update project from repository
2. Run create_project.bat (Windows) or create_project.sh (Linux) to recreate Vivado project
3. Open project in Vivado and check for errors
4. Try to generate bitstream


Saving project to TCL script
----------------------------

1. Check project is correct and bitstream could be generated
2. Run save_project_tcl.bat (Windows) or save_project_tcl.sh (Linux) to generate create_project.tcl script
3. Copy project to temporary directory and try to recreate project via create_project.bat/create_project.sh
4. If project was recreated successfully commit changes and publish project to repository


Upgrade project TCL scripts to new Vivado version
-------------------------------------------------

1. Recreate project from TCL using old Vivado version
2. Open project with new Vivado version
3. Upgrade IPs, check settings etc.
4. Check PATH system variable points to new Vivado version (run "vivado -version" in command line)
5. Save project to TCL
6. Back up project
7. Recreate project from TCL
8. If project was recreated successfully commit changes and publish project to repository



Credits
=======

This project is based on work of marcel42 (https://forums.xilinx.com/t5/Vivado-TCL-Community/Using-version-control-with-Vivado-in-project-mode/td-p/863202)
