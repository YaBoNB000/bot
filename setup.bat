@echo off
rem ===========================================================================
rem  Luraph deobfuscator Discord bot - one-click setup (double-click friendly).
rem  ASCII only on purpose: cmd.exe may run with any code page, and a .bat with
rem  Chinese/emoji bytes in it can break string parsing on some systems.
rem  All the real work (deps, config.json, self-check) is done by setup_wizard.py.
rem ===========================================================================
setlocal EnableExtensions DisableDelayedExpansion
title Luraph bot - setup
pushd "%~dp0" 1>nul 2>nul
if errorlevel 1 (
    echo [x] Cannot open the folder this script lives in:
    echo     %~dp0
    echo     If it is a network path ^(\\server\share^), copy the folder to a local
    echo     disk first, then run setup.bat there.
    echo.
    pause
    exit /b 1
)
echo ============================================================
echo  Luraph bot - setup
echo  folder: %CD%
echo ============================================================
echo.

if not exist "setup_wizard.py" (
    echo [x] setup_wizard.py is missing next to this file.
    echo     Extract the WHOLE luraph-bot.zip into one folder first
    echo     ^(do not run setup.bat from inside the zip preview^), then run it again.
    echo.
    pause
    exit /b 1
)

call "%~dp0_find_python.bat"
if errorlevel 3 goto :too_old
if errorlevel 1 goto :no_python
if not defined PYEXE goto :no_python
if defined PYVER echo [*] Python %PYVER% via %PYEXE% %PYARG%
echo.

set "PYTHONUTF8=1"
set "PYTHONIOENCODING=utf-8"
call "%PYEXE%" %PYARG% setup_wizard.py %*
set "RC=%ERRORLEVEL%"
echo.
if not "%RC%"=="0" (
    echo [x] setup_wizard.py exited with code %RC%.
    echo     - The lines above say what went wrong ^(missing internet, pip blocked,
    echo       antivirus, read-only folder...^).
    echo     - Run "check.bat" afterwards to see the environment state.
) else (
    echo [*] Setup finished. Next: double-click run.bat
)
echo.
pause
popd
exit /b %RC%

:no_python
echo [x] Python 3.10+ was not found on this machine.
echo.
echo     Fix it like this:
echo       1. Download Python 3.12 from https://www.python.org/downloads/windows/
echo       2. In the installer TICK "Add python.exe to PATH", then Install Now
echo       3. Close this window and run setup.bat again
echo.
echo     Already installed but still not found? It is not on PATH:
echo       - open a new PowerShell and try:  py -V     or   python -V
echo       - or reinstall Python and tick "Add python.exe to PATH"
echo.
pause
popd
exit /b 1

:too_old
echo [x] The Python found is older than 3.10 - this bot needs 3.10 or newer.
echo     found: %PYOLDVER%  (%PYOLD%)
echo     Install Python 3.12 from https://www.python.org/downloads/windows/
echo     and tick "Add python.exe to PATH", then run setup.bat again.
echo.
pause
popd
exit /b 1
