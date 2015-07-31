@echo off

set STARTUP_PATH=%~d0%~p0
if "%HOME%" == "" goto sethome
goto makedir

:sethome
echo set HOME variable
set HOME=%UserProfile%

:makedir
if exist %HOME%\bin goto copyshflags
echo make bin folder
mkdir %HOME%\bin

:copyshflags
set MSYS_BIN=%HOME%\bin
echo Installing git-now to "%MSYS_BIN%"

echo copy shFlags
copy %STARTUP_PATH%..\shFlags\src\shflags %MSYS_BIN%\gitnow-shFlags

:copygitnow
xcopy /EXCLUDE:%STARTUP_PATH%exclude.txt /D /Y %STARTUP_PATH%..\* %MSYS_BIN%
