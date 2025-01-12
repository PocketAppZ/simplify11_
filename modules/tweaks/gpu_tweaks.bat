@echo off
setlocal EnableDelayedExpansion
net session >nul 2>&1 || (powershell start -verb runas '%~0' & exit)

set cMauve=[38;5;141m
set cGrey=[38;5;250m
set cReset=[0m
set cRed=[38;5;203m
set cGreen=[38;5;120m

:next
cls
echo.
echo %cMauve% +-------------------------------------+%cReset%
echo %cMauve% '%cGrey% Select your GPU manufacturer:       %cMauve%'%cReset%
echo %cMauve% +-------------------------------------+%cReset%
echo %cMauve% '%cGrey% [1] NVIDIA                          %cMauve%'%cReset%
echo %cMauve% '%cGrey% [2] AMD                             %cMauve%'%cReset%
echo %cMauve% +-------------------------------------+%cReset%
echo %cMauve% '%cGrey% [3] Skip                            %cMauve%'%cReset%
echo %cMauve% +-------------------------------------+%cReset%

choice /C 123 /N /M ">"
if errorlevel 3 exit
if errorlevel 2 call :amd
if errorlevel 1 call :nvidia

:nvidia
:: NVIDIA Specific Tweaks
: source - https://github.com/AlchemyTweaks/Verified-Tweaks/blob/main/Nvidia/RmGpsPsEnablePerCpuCoreDpc
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" "RmGpsPsEnablePerCpuCoreDpc" "REG_DWORD" "1" "Enabled per-CPU core DPC for NVIDIA drivers"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" "RmGpsPsEnablePerCpuCoreDpc" "REG_DWORD" "1" "Enabled power-aware per-CPU core DPC"
call :reg "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" "RmGpsPsEnablePerCpuCoreDpc" "REG_DWORD" "1" "Enabled NVIDIA driver per-CPU core DPC"
call :reg "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\NVAPI" "RmGpsPsEnablePerCpuCoreDpc" "REG_DWORD" "1" "Enabled NVIDIA API per-CPU core DPC"
call :reg "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" "RmGpsPsEnablePerCpuCoreDpc" "REG_DWORD" "1" "Enabled global NVIDIA tweaks for per-CPU core DPC"
pause
exit

:amd
: source - https://youtu.be/nuUV2RoPOWc
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "AllowSnapshot" "REG_DWORD" "0" "Disabled AMD snapshot feature"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "AllowSubscription" "REG_DWORD" "0" "Disabled AMD subscription feature"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "AllowRSOverlay" "REG_SZ" "false" "Disabled AMD RS overlay"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "AllowSkins" "REG_SZ" "false" "Disabled AMD skins"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "AutoColorDepthReduction_NA" "REG_DWORD" "0" "Disabled automatic color depth reduction"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "DisableUVDPowerGatingDynamic" "REG_DWORD" "1" "Disabled UVD power gating"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "DisableVCEPowerGating" "REG_DWORD" "1" "Disabled VCE power gating"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "DisablePowerGating" "REG_DWORD" "1" "Disabled general power gating"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "DisableDrmdmaPowerGating" "REG_DWORD" "1" "Disabled DRMDMA power gating"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "DisableDMACopy" "REG_DWORD" "1" "Disabled DMA copy"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "DisableBlockWrite" "REG_DWORD" "0" "Enabled block write"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "StutterMode" "REG_DWORD" "0" "Disabled stutter mode"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "PP_GPUPowerDownEnabled" "REG_DWORD" "0" "Disabled GPU power down"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "LTRSnoopL1Latency" "REG_DWORD" "1" "Optimized LTR Snoop L1 latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "LTRSnoopL0Latency" "REG_DWORD" "1" "Optimized LTR Snoop L0 latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "LTRNoSnoopL1Latency" "REG_DWORD" "1" "Optimized LTR No Snoop L1 latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "LTRMaxNoSnoopLatency" "REG_DWORD" "1" "Optimized LTR max no snoop latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "KMD_RpmComputeLatency" "REG_DWORD" "1" "Optimized KMD RPM compute latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "DalUrgentLatencyNs" "REG_DWORD" "1" "Optimized DAL urgent latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "memClockSwitchLatency" "REG_DWORD" "1" "Optimized memory clock switch latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "PP_RTPMComputeF1Latency" "REG_DWORD" "1" "Optimized RTPM compute F1 latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "PP_DGBMMMaxTransitionLatencyUvd" "REG_DWORD" "1" "Optimized DGBMM UVD transition latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "PP_DGBPMMaxTransitionLatencyGfx" "REG_DWORD" "1" "Optimized DGBPM GFX transition latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "DalNBLatencyForUnderFlow" "REG_DWORD" "1" "Optimized DAL NB underflow latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "BGM_LTRSnoopL1Latency" "REG_DWORD" "1" "Optimized BGM LTR Snoop L1 latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "BGM_LTRSnoopL0Latency" "REG_DWORD" "1" "Optimized BGM LTR Snoop L0 latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "BGM_LTRNoSnoopL1Latency" "REG_DWORD" "1" "Optimized BGM LTR No Snoop L1 latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "BGM_LTRNoSnoopL0Latency" "REG_DWORD" "1" "Optimized BGM LTR No Snoop L0 latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "BGM_LTRMaxSnoopLatencyValue" "REG_DWORD" "1" "Optimized BGM LTR max snoop latency"
call :reg "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" "BGM_LTRMaxNoSnoopLatencyValue" "REG_DWORD" "1" "Optimized BGM LTR max no snoop latency"
pause
exit

:reg
call "%~dp0..\..\modules\reg_helper.bat" %*