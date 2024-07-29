# Setting the directory where this file resides
set script_dir [file dirname [info script]]

#Setting root directory
set origin_dir $script_dir/../

#Setting directory for block designs relative to root directory 
set bd_dir src/bd/

#Setting directory for Vivado project local files relative to root directory 
set vivado_dir vivado/

#Setting file for main tcl script for creating project
set tcl_script_name create_project.tcl

# Function that recursively looks through directories -> https://stackoverflow.com/questions/429386/tcl-recursively-search-subdirectories-to-source-all-tcl-files
proc findFiles { basedir pattern } {
	set basedir [string trimright [file join [file normalize $basedir] { }]]
	set fileList {}
	foreach fileName [glob -nocomplain -type {f r} -path $basedir $pattern] {
		lappend fileList $fileName
	}
	foreach dirName [glob -nocomplain -type {d  r} -path $basedir *] {
		set subDirList [findFiles $dirName $pattern]
		if { [llength $subDirList] > 0 } {
			foreach subDirFile $subDirList {
				lappend fileList $subDirFile
			}
		}
	}
	return $fileList
}

# Function that looks only in one directory
proc findFilesInDir { basedir pattern } {
	set basedir [string trimright [file join [file normalize $basedir] { }]]
	set fileList {}
	foreach fileName [glob -nocomplain -type {f r} -path $basedir $pattern] {
		lappend fileList $fileName
	}
	return $fileList
}

# Function that looks for python command
proc find_python {} {
    if {![catch {set output [exec python3 --version]} errmsg]} {
        return python3
    } else {
        if {![catch {set output [exec python --version]} errmsg]} {
            if {[string index $output 7] == 3} {
                return python
            } else {
                puts "ERROR: Python version 3 is needed"
                exit
            }
        } else {
            puts "ERROR: Python not found"
            exit
        }
    }
}

# Function to call python script and capture its output
proc call_python_modify_bd {python origin_dir bd_dir bd_name enabled} {
	# Backup and unset environment variables set by Vivado
	set python_home $::env(PYTHONHOME)
	set python_path $::env(PYTHONPATH)
	unset ::env(PYTHONHOME)
	unset ::env(PYTHONPATH)
	# Call python script
	set output [exec $python ./modify_bd_tcl.py $origin_dir/$bd_dir/$bd_name.tcl $bd_name $enabled]
	puts $output
	# Restore environment variables
	set ::env(PYTHONHOME) $python_home
	set ::env(PYTHONPATH) $python_path
}

# Function to call python script and capture its output
proc call_python_modify_project {python tcl_script_name origin_dir bd_dir} {
	# Backup and unset environment variables set by Vivado
	set python_home $::env(PYTHONHOME)
	set python_path $::env(PYTHONPATH)
	unset ::env(PYTHONHOME)
	unset ::env(PYTHONPATH)
	# Call python script
	set output [exec $python ./modify_project_tcl.py $tcl_script_name $origin_dir $bd_dir]
	puts $output
	# Restore environment variables
	set ::env(PYTHONHOME) $python_home
	set ::env(PYTHONPATH) $python_path
}

# Looking for python
set python [ find_python ]

#Looking for project name
set project_name [file rootname [file tail [findFilesInDir $origin_dir/$vivado_dir "*.xpr"]]]
puts $project_name
 
#Opening the project
open_project $origin_dir/$vivado_dir/$project_name.xpr

#Creating a list of all .bd files 
set bd_files [findFiles $origin_dir/$bd_dir "*.bd"]
puts $bd_files

#Doing this procedure for every block design in the folder
foreach bd_file $bd_files {

	#Getting the name of the current design (no extension and no path)
	set bd_name [file rootname [file tail $bd_file]]
	puts $bd_name

	#Check if BD exists in project
	if { [llength [get_files $bd_name.bd]] > 0 } {
			
		#Check if BD is enabled
		set enabled [get_property IS_ENABLED [get_files $bd_name.bd]]
		puts $enabled
		
		#Opening the block diagram
		open_bd_design $origin_dir/$bd_dir/$bd_name/$bd_name.bd

		#Loading BD layout to temporary file (must be done to use -include_layout option in write_bd_tcl command)
		write_bd_layout -force layout
		
		#Writing the tcl script in the right directory
		write_bd_tcl -force -include_layout -bd_folder $bd_dir $origin_dir/$bd_dir/$bd_name.tcl
		
		close_bd_design $bd_name

		#Applies some changes to the BD tcl file
		call_python_modify_bd $python $origin_dir $bd_dir $bd_name $enabled
		
	} else {
		puts "WARNING: BD not found"
	}

}

#Creating a tcl file that represents the project
write_project_tcl -force -use_bd_files -target_proj_dir $vivado_dir $origin_dir/$tcl_script_name

close_project

#Applies some changes to the project tcl file created previously
call_python_modify_project $python $tcl_script_name $origin_dir $bd_dir

#Exiting cmd prompt
exit
