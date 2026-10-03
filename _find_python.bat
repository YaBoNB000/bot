@echo off
rem ===========================================================================
rem  Shared helper: find a working Python 3.10+ (used by setup.bat/run.bat/
rem  check.bat). ASCII only on purpose: cmd.exe may run with any code page.
rem
rem  On success exports:  PYEXE  = executable   ("py" / "python" / full path)
rem                       PYARG  = extra arg    ("-3" for the py launcher, else empty)
rem                       PYVER  = version      ("3.12.4", best effort)
rem  Exit codes: 0 = usable, 3 = found but older than 3.10, 1 = not found.
rem
rem  NOTE: deliberately no setlocal - the caller must see the variables above.
rem ===========================================================================
set "PYEXE="
set "PYARG="
set "PYVER="
set "PYOLD="
set "PYOLDVER="

call :probe py -3
if not errorlevel 1 goto :done
call :probe python
if not errorlevel 1 goto :done
call :probe python3
if not errorlevel 1 goto :done

rem --- not on PATH: scan the usual install locations -------------------------
set "LA=%LOCALAPPDATA%"
set "PF=%ProgramFiles%"
set "PF86=%ProgramFiles(x86)%"
if defined LA for %%D in ("%LA%\Programs\Python") do call :scan "%%~D"
if defined PF for %%D in ("%PF%") do call :scan "%%~D"
if defined PF86 for %%D in ("%PF86%") do call :scan "%%~D"
if defined PYEXE goto :done
if defined PYOLD exit /b 3
exit /b 1

:scan
rem %1 = parent folder that may contain Python3xx\python.exe
if defined PYEXE goto :eof
for /d %%P in ("%~1\Python3*") do (
    if exist "%%~P\python.exe" call :probe "%%~P\python.exe"
    if exist "%%~P\python3.exe" call :probe "%%~P\python3.exe"
)
goto :eof

:probe
rem %1 = executable, %2 = extra arg (may be empty)
rem Step 1: can it run at all? (tells "not installed" apart from "too old")
call "%~1" %2 -c "import sys" >nul 2>nul
if errorlevel 1 goto :probe_missing
rem Step 2: is it 3.10 or newer?
call "%~1" %2 -c "import sys;raise SystemExit(0 if sys.version_info>=(3,10) else 3)" >nul 2>nul
if errorlevel 1 goto :probe_old
for /f "usebackq delims=" %%V in (`call "%~1" %2 -c "import sys;print(sys.version.split()[0])"`) do set "PYVER=%%V"
set "PYEXE=%~1"
set "PYARG=%2"
exit /b 0

:probe_missing
exit /b 1

:probe_old
set "PYOLD=%~1 %2"
for /f "usebackq delims=" %%V in (`call "%~1" %2 -c "import sys;print(sys.version.split()[0])"`) do set "PYOLDVER=%%V"
exit /b 3

:done
exit /b 0
