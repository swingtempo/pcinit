rem Prompt setting
setx prompt "[$d$t]$+$_$p$g"

::::::::::::::::::::::::::::
::some registry settings
::::::::::::::::::::::::::::

::Remove win11 show more options context menu
reg add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /ve /d "" /f 

:: Disable some snapping behavior
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "JointResize" /T REG_DWORD /D "0" /F
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SnapAssist" /T REG_DWORD /D "0" /F
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SnapFill" /T REG_DWORD /D "0" /F

:: remove alt tab to Edge
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /V "MultiTaskingAltTabFilter" /T REG_DWORD /D "4" /F

:: remove Edge restore on startup popup
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /V "HideRestoreDialogEnabled" /T REG_DWORD /D "1" /F

::Enable remote desktop
:: reg add "HKLM\System\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /d 0 /reg:32 /f

rem show file name extensions
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f

::Add search engines
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v ManagedSearchEngines /t REG_SZ /d "[{\"keyword\": \"obo\", \"name\": \"Bohemia\", \"search_url\": \"https://office.visualstudio.com/OC/_search?action=contents^&text={searchTerms}^&type=code^&lp=code-Project^&filters=ProjectFilters%7BOC%7DRepositoryFilters%7Boffice-bohemia%7D^&pageSize=250\"}]" /f