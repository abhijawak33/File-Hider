@echo off
color 0a
setlocal enabledelayedexpansion

set "hiddenFolder=.hidden"
REM change Pass@123 to your password and saved batch script
set "password=Pass@123"
set "creatorInfo=Created by Abhishek Jawak, Cyber Forensics Expert"

if not exist %hiddenFolder% mkdir %hiddenFolder%

:menu
cls
echo 1. Hide a file or folder
echo 2. Unhide a file or folder (password protected)
echo 3. Exit
echo 4. Creator Info

set /p choice=Enter your choice (1-4): 

if "%choice%" equ "1" goto hideFile
if "%choice%" equ "2" goto unhideFile
if "%choice%" equ "3" goto :eof
if "%choice%" equ "4" goto creator

:hideFile
set /p "fileOrFolder=Enter the path of the file or folder to hide: "
set /p "readOnly=Do you want to set it as read-only? (Y/N): "
if /i "%readOnly%" equ "Y" (
    echo Setting read-only attribute...
    attrib +r "%fileOrFolder%"
)
attrib +h +s "%fileOrFolder%"

echo File or folder hidden successfully!
pause
goto menu

:unhideFile
set /p "enteredPassword=Enter the password to unhide files: "
if /i "!enteredPassword!" equ "!password!" (
    echo Correct password. Access granted.
    goto showHiddenFiles
) else (
    echo Incorrect password. Access denied.
    pause
    goto menu
)

:showHiddenFiles
set "hiddenFiles="
for %%i in ("%hiddenFolder%\*") do (
    set "hiddenFiles=!hiddenFiles!%%~nxi"    
)
if not defined hiddenFiles (
    echo No files or folders are hidden.
    pause
    goto menu
)

echo Hidden files and folders:
echo %hiddenFiles%

set /p "fileToUnhide=Enter the name of the file or folder to unhide: "
set "fileToUnhide=!fileToUnhide:"=!"
if exist "%hiddenFolder%\%fileToUnhide%" (
    attrib -h -s "%hiddenFolder%\%fileToUnhide%"
    echo File or folder unhidden successfully!
) else (
    echo File or folder not found in the hidden list.
)

pause
goto menu

:creator
echo %creatorInfo%
pause 
goto menu
