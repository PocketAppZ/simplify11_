@echo off
setlocal EnableDelayedExpansion
net session >nul 2>&1 || (powershell start -verb runas '%~0' & exit)

set cMauve=[38;5;141m
set cGrey=[38;5;250m
set cReset=[0m
set cRed=[38;5;203m
set cGreen=[38;5;120m

:launchPrivacySexy
cls
echo %cMauve% +--------------------------------------------------------+%cReset%
echo %cMauve% '%cGrey% Privacy.Sexy Settings                                  %cMauve%'%cReset%
echo %cMauve% +--------------------------------------------------------+%cReset%
echo %cMauve% '%cGrey% [1] Open Privacy.Sexy Website (Customizable)           %cMauve%'%cReset%
echo %cMauve% '%cGrey% [2] Download and Run Script (Standard Preset)          %cMauve%'%cReset%
echo %cMauve% '%cGrey% [3] Back to Main Menu                                  %cMauve%'%cReset%
echo %cMauve% +--------------------------------------------------------+%cReset%

choice /C 123 /N /M ">"
set /a "privacy_choice=%errorlevel%"
if !privacy_choice! equ 3 goto main
if !privacy_choice! equ 2 (
    echo %cGrey%Downloading and executing privacy script...%cReset%
    powershell -Command "irm 'https://raw.githubusercontent.com/emylfy/simplify11/refs/heads/main/src/scripts/privacy-standart.bat' -OutFile \"%TEMP%\privacy-standart.bat\"" && start cmd /c "%TEMP%\privacy-standart.bat"
    if !errorlevel! equ 0 (
        echo %cGreen%Privacy script executed successfully.%cReset%
    ) else (
        echo %cRed%Failed to execute privacy script.%cReset%
    )
    pause
    goto main
)
if errorlevel 1 (
    start "" "https://privacy.sexy"
    goto main
)
goto main