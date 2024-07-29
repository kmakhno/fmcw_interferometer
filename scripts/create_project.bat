REM Go to project root from scripts/ folder
cd ..

REM Clean BD directories
for /d %%x in (src\bd\*) do rmdir /s /q %%x\hw_handoff
for /d %%x in (src\bd\*) do rmdir /s /q %%x\ip
for /d %%x in (src\bd\*) do rmdir /s /q %%x\ipshared
for /d %%x in (src\bd\*) do rmdir /s /q %%x\sim
for /d %%x in (src\bd\*) do rmdir /s /q %%x\synth
for /d %%x in (src\bd\*) do rmdir /s /q %%x\ui
for /d %%x in (src\bd\*) do del /q %%x\*.bd
for /d %%x in (src\bd\*) do del /q %%x\*.bmm
for /d %%x in (src\bd\*) do del /q %%x\*.bxml
for /d %%x in (src\bd\*) do del /q %%x\*_ooc.xdc
REM for /d %%x in (src\bd\*) do rmdir /s /q %%x

REM Remove Vivado project directory
rmdir /s /q vivado

REM Create Vivado project
call vivado -mode tcl -source %~dp0\..\create_project.tcl -notrace

REM Remove temp and debug files
rmdir /s /q .Xil
rmdir /s /q src\bd\.Xil
del /q vivado.jou
del /q vivado.log
del /q *backup.jou
del /q *backup.log
