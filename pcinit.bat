:: The first part of this file is a copy of elevate.cmd which will grant you admin access.
:: If you want to get to the "real" code - search for "::START"

::::::::::::::::::::::::::::::::::::::::::::
:: Elevate.cmd - Version 4
:: Automatically check & get admin rights
:: see "https://stackoverflow.com/a/12264592/1016343" for description
::::::::::::::::::::::::::::::::::::::::::::
 @echo off
 CLS
 ECHO.
 ECHO =============================
 ECHO Running Admin shell
 ECHO =============================

:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~dpnx0"
 rem this works also from cmd shell, other than %~0
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO.
  ECHO **************************************
  ECHO Invoking UAC for Privilege Escalation
  ECHO **************************************

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"
  
  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

 ::::::::::::::::::::::::::::
 ::START
 ::::::::::::::::::::::::::::
 REM Run shell as admin (example) - put here code as you like
 ECHO %batchName% Arguments: P1=%1 P2=%2 P3=%3 P4=%4 P5=%5 P6=%6 P7=%7 P8=%8 P9=%9
 
 set rootsource=c:\users\jayongg\OneDrive - Microsoft\PCInit
 
rem set up BGInfo Update
::schtasks.exe /Create /XML "%rootsource%\BGInfo Update.xml" /tn "BGInfo Update"

rem call up settings
call updatesettings.bat

winget install -e Microsoft.Sysinternals.BGInfo
winget install -e Microsoft.RemoteDesktopClient
winget install -e Microsoft.Teams
winget install -e OpenJS.NodeJS.LTS
winget install -e Yarn.Yarn
winget install -e Microsoft.Office
winget install -e Git.Git
winget install -e --id GitHub.GitLFS
winget install -e Git.GCM
winget install -e TortoiseGit.TortoiseGit
winget install -e dotPDNLLC.paintdotnet
winget install -e VideoLAN.VLC
winget install -e Google.Chrome
winget install -e Mozilla.Firefox
winget install -e Microsoft.AzureCLI
winget install -e Microsoft.VisualStudioCode
winget install -e Microsoft.PowerToys
winget install -e Gyan.FFmpeg
winget install -e Bruno.Bruno

rem this is SysInternals Suite
winget install -e 9P7KNL5RWT25

rem this is Microsoft Whiteboard
winget install -e 9MSPC6MP8FM4

rem this is Microsoft Loop
winget install -e 9P1HQ5TQZMGD

rem this is Clipchamp
winget install -e 9P1J8S7CCWWT

winget install -e 7zip.7zip

winget install -e Microsoft.RemoteDesktopClient

winget install -e Telerik.Fiddler.Classic
winget install -e Microsoft.Azure.StorageExplorer
winget install -e Microsoft.PowerBI
winget install -e Microsoft.VisualStudio.2022.Enterprise

winget install -e OliverBetz.ExifTool
winget install -e FrankBijnen.ExifToolGUI

rem this is Surface app
winget install -e 9WZDNCRFJB8P

rem this is TreeSize Free
winget install -e JAMSoftware.TreeSizeFree

rem remove user check for git
git config --global --add safe.directory '*'

rem set git config
git config --global user.name %USERNAME%
git config --global user.email %USERNAME%@microsoft.com

rem Windows Defender exclusions
powershell -Command Add-MpPreference -ExclusionPath "D:\src"
powershell -Command Add-MpPreference -ExclusionPath "c:\src"
powershell -Command Add-MpPreference -ExclusionPath "$env:localappdata\npm-cache"
powershell -Command Add-MpPreference -ExclusionPath "$env:localappdata\yarn"

rem remove Notepad alias - not sure that this works!!
rem powershell -inputformat none -outputformat none -NonInteractive -Command remove-item Alias:notepad
rem del %LOCALAPPDATA%\Microsoft\WindowsApps\notepad.exe

rem uninstall windows 11 notepad
powershell -command "Get-AppxPackage *Microsoft.WindowsNotepad* | Remove-AppxPackage"

