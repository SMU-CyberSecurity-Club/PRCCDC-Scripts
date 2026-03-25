# batch file to schedule tasks in windows task scheduler
#
#  ***** AI Genrated Content Below **** - needs validation and testing
#
@echo off
REM Batch file to create a Task Scheduler task that runs a PowerShell script every hour
REM Run this batch file as Administrator

setlocal enabledelayexpansion

REM Configuration variables
set "TASK_NAME=HourlyPowerShellTask"
set "SCRIPT_PATH=C:\path\to\your\script.ps1"
set "TASK_DESCRIPTION=Runs a PowerShell script every hour"

REM Check if script path exists
if not exist "%SCRIPT_PATH%" (
    echo Error: PowerShell script not found at %SCRIPT_PATH%
    echo Please update the SCRIPT_PATH variable with the correct path.
    pause
    exit /b 1
)

REM Check if running as Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: This script must be run as Administrator.
    pause
    exit /b 1
)

REM Delete existing task if it exists
echo Checking for existing task...
tasklist /fi "TASKNAME eq %TASK_NAME%" 2>nul | find /i "%TASK_NAME%" >nul
if %errorlevel% equ 0 (
    echo Removing existing task: %TASK_NAME%
    schtasks /delete /tn "%TASK_NAME%" /f >nul 2>&1
)

REM Create the scheduled task
echo Creating new Task Scheduler task...
schtasks /create /tn "%TASK_NAME%" /tr "powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"%SCRIPT_PATH%\"" /sc hourly /mo 1 /f

REM Check if task was created successfully
if %errorlevel% equ 0 (
    echo.
    echo Task created successfully!
    echo Task Name: %TASK_NAME%
    echo Script Path: %SCRIPT_PATH%
    echo Frequency: Every hour
    echo.
) else (
    echo Error: Failed to create the task.
    pause
    exit /b 1
)

REM Display task details
echo.
echo Task Details:
schtasks /query /tn "%TASK_NAME%" /v /fo list

pause
