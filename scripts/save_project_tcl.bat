REM  Call save_project_tcl script
call vivado -mode tcl -source %~dp0\save_project_tcl.tcl -notrace

REM Remove junk files
rmdir /s /q .Xil
del /q vivado.jou
del /q vivado.log
del /q layout
