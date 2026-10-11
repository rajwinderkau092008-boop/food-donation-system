@echo off
title Food Donation Coordination System - Local Server
cd /d "%~dp0"

echo =======================================================
echo    Starting Localhost Server for Food Donation System
echo =======================================================
echo.

:: Try Python
where python >nul 2>nul
if %ERRORLEVEL% equ 0 (
    echo Starting server with Python on http://localhost:8080 ...
    python server.py
    goto end
)

:: Try Py launcher
where py >nul 2>nul
if %ERRORLEVEL% equ 0 (
    echo Starting server with Py on http://localhost:8080 ...
    py server.py
    goto end
)

:: Try Node.js
where node >nul 2>nul
if %ERRORLEVEL% equ 0 (
    echo Starting server with Node.js on http://localhost:8080 ...
    node server.js
    goto end
)

:: Fallback: Open index.html directly in default browser
echo Neither Python nor Node.js found in PATH.
echo Opening index.html directly in your default browser...
start "" "index.html"

:end
pause
