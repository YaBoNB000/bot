@echo off
rem ===========================================================================
rem  Luraph deobfuscator Discord bot - launcher (double-click friendly).
rem  ASCII only on purpose. Real work is done by bot.py.
rem
rem  - normal stop (Ctrl+C)  -> restarts automatically after 5 seconds
rem  - crash / bad config    -> stops and keeps the window open so you can read it
rem  - with arguments        -> runs once and exits (e.g. run.bat --check)
rem ===========================================================================
setlocal EnableExtensions DisableDelayedExpansion
title Luraph bot
pushd "%~dp0" 1>nul 2>nul
if errorlevel 1 (
    echo [x] Cannot open the folder this script lives in:
    echo     %~dp0
    echo     If it is a network path ^(\\server\share^), copy the folder to a local
    echo     disk first, then run run.bat there.
    echo.
    pause
    exit /b 1
)
if not exist "bot.py" (
    echo [x] bot.py is missing next to this file. Extract the whole luraph-bot.zip
    echo     into one folder first, then run run.bat there.
    echo.
    pause
    exit /b 1
)

call "%~dp0_find_python.bat"
if errorlevel 3 goto :too_old
if errorlevel 1 goto :no_python
if not defined PYEXE goto :no_python

set "ARGS=%*"
set "PYTHONUTF8=1"
set "PYTHONIOENCODING=utf-8"
echo ============================================================
echo  Luraph bot - starting
echo  python : %PYVER%  (%PYEXE% %PYARG%)
echo  folder : %CD%
echo ============================================================
echo.

:loop
call "%PYEXE%" %PYARG% bot.py %ARGS%
set "RC=%ERRORLEVEL%"
if not "%RC%"=="0" goto :failed
if not "%ARGS%"=="" goto :done

echo.
echo [*] Bot stopped normally. Restarting in 5 seconds...
echo     Close this window (or press Ctrl+C) to quit for good.
timeout /t 5 /nobreak >nul 2>nul
if errorlevel 1 ping -n 6 127.0.0.1 >nul 2>nul
goto :loop

:failed
echo.
echo [x] bot.py exited with code %RC% - NOT restarting, so you can read the text above.
echo     - Quick environment check : check.bat
echo     - Full log                : logs\bot.log
echo.
pause
popd
exit /b %RC%

:done
popd
exit /b 0

:no_python
echo [x] Python 3.10+ was not found. Run setup.bat first ^(it installs everything^),
echo     or read the instructions it prints.
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
