@echo off
rem ===========================================================================
rem  Quick environment check: Python, deobfuscator, luau binaries, config, token.
rem  ASCII only on purpose. Safe to double-click; the window always stays open.
rem ===========================================================================
setlocal EnableExtensions DisableDelayedExpansion
title Luraph bot - environment check
pushd "%~dp0" 1>nul 2>nul
if errorlevel 1 (
    echo [x] Cannot open the folder this script lives in: %~dp0
    echo.
    pause
    exit /b 1
)
if not exist "bot.py" (
    echo [x] bot.py is missing next to this file. Extract the whole luraph-bot.zip
    echo     into one folder first.
    echo.
    pause
    exit /b 1
)

call "%~dp0_find_python.bat"
if errorlevel 3 goto :too_old
if errorlevel 1 goto :no_python
if not defined PYEXE goto :no_python

set "PYTHONUTF8=1"
set "PYTHONIOENCODING=utf-8"
call "%PYEXE%" %PYARG% bot.py --check
set "RC=%ERRORLEVEL%"
echo.
echo [*] exit code = %RC%
echo     [x] lines above are the things to fix; everything else is fine.
echo.
pause
popd
exit /b %RC%

:no_python
echo [x] Python 3.10+ was not found. Run setup.bat - it installs and configures
echo     everything for you.
echo.
pause
popd
exit /b 1

:too_old
echo [x] The Python found is older than 3.10 - this bot needs 3.10 or newer.
echo     found: %PYOLDVER%  (%PYOLD%)
echo     Install Python 3.12 from https://www.python.org/downloads/windows/
echo     and tick "Add python.exe to PATH".
echo.
pause
popd
exit /b 1
