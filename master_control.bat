@echo off
TITLE ## Workstation Setup ##
set DRIVE=MEDIA
set buildselect=NONE
echo.
IF NOT EXIST .\exec\ set MODE=FIRSTRUN
IF %MODE%==FIRSTRUN echo ## All commands are commented out. Nothing will be executed.
REM ########################################################################### Network Detection
:OKIMREADY
REM set currentnet=Internal
REM ping (internal resource) | find "Reply" > nul
REM if %errorlevel% equ 1 set currentnet=Public
ping google.com | find "Reply" > nul
if %errorlevel% equ 1 set currentnet=Disconnected
:RESTART
REM ########################################################################### State Detection
REM IF EXIST D:\master_control.bat set DRIVE=D
REM IF EXIST E:\master_control.bat set DRIVE=E
REM IF EXIST F:\master_control.bat set DRIVE=F
REM IF EXIST G:\master_control.bat set DRIVE=G
REM IF EXIST H:\master_control.bat set DRIVE=H
REM IF EXIST I:\master_control.bat set DRIVE=I
REM IF EXIST J:\master_control.bat set DRIVE=J
REM IF EXIST K:\master_control.bat set DRIVE=K
REM IF /I %DRIVE%==MEDIA GOTO BUILDUSB
REM ########################################################################### Power Settings
IF %MODE%==FIRSTRUN echo ## Create 'exec' next to this script to hold your installers.
IF %MODE%==FIRSTRUN echo ## Create 'config' next to this script to hold configurations.
IF %MODE%==FIRSTRUN echo ## Create 'lpgo' to put your group policies in for import.
IF %MODE%==FIRSTRUN echo ## Make sure you read this whole file before adding anything to it.
REM IF NOT EXIST %DRIVE%:\exec set buildselect=EXE
REM IF NOT EXIST %DRIVE%:\exec GOTO INSTALLERS
TITLE ## Workstation Setup
REM powercfg /h off
REM powercfg /change monitor-timeout-ac 60
REM powercfg /change monitor-timeout-dc 15
REM powercfg /change disk-timeout-ac 0
REM powercfg /change disk-timeout-dc 0
REM powercfg /change standby-timeout-ac 0
REM powercfg /change standby-timeout-dc 30
REM powercfg /change hibernate-timeout-ac
REM ########################################################################### Imports Wifi Network
REM netsh wlan add profile filename="location\WifiExportFile.xml" user=all
REM netsh wlan set profileparameter name="WIFINAME" connectionmode=auto
REM ########################################################################### Group Policy Import
:GPO
REM copy %DRIVE%:\config\lgpo\policytemplates\*.ADMX C:\Windows\PolicyDefinitions\
REM copy %DRIVE%:\config\lgpo\policytemplates\*.ADML C:\Windows\PolicyDefinitions\en-US\
REM %DRIVE%:\config\lgpo\lgpo.exe /g %DRIVE%:\config\lgpo\...\
REM gpupdate /force
REM ########################################################################### Bitlocker Settings
REM manage-bde -protectors C: -add -tpm -recoverypassword
REM manage-bde -protectors C: -get > "%DRIVE%:\config\inventory\%username% %computername% Bitlocker.txt"
REM ########################################################################### Inventory
REM wmic csproduct > "%DRIVE%:\config\inventory\%username% %computername% Service Tag.txt"
REM ########################################################################### Computer Name
REM echo  ## Set Computer Name
REM echo.
REM echo  Example: DocMc-lt for Doc McStuffins Laptop
REM echo.
REM set /p NewComputerName= # Enter desired computer name: 
REM echo.
REM ########################################################################### Browser Favorites
REM copy %DRIVE%:\config\browsers\Favorites\*.* "C:\Users\%username%\Favorites\Links"
REM ########################################################################### Configure Timezone
echo  ## Current Time Zone
tzutil /g
echo.
REM set /p ZONENEEDED=Do you need to change the timezone? [ (P)ac (M)ou (C)en (E)as or 'N' ]: 
REM if /I %ZONENEEDED%==P set WHATISTIMEZ="Pacific Standard Time"
REM if /I %ZONENEEDED%==M set WHATISTIMEZ="Mountain Standard Time"
REM if /I %ZONENEEDED%==C set WHATISTIMEZ="Central Standard Time"
REM if /I %ZONENEEDED%==E set WHATISTIMEZ="Eastern Standard Time"
REM if /I %ZONENEEDED%==N GOTO NOPE
echo.
REM tzutil /s %WHATISTIMEZ%
:NOPE
REM ########################################################################### Scrubbing Windows
REM powershell.exe set-executionpolicy remotesigned
:OOB
echo Scrubbing Dell Software
REM start "Scrubbing Dell" /w /min cmd /c %DRIVE%:\config\windows\remove_dell_oob.bat
REM IF /I %buildselect%==DLL GOTO UNOMAS
:DEBLOAT
echo Scrubbing Windows
REM start /w /min cmd /c powershell.exe %DRIVE%:\config\windows\Windows10SysPrepDebloater.ps1 -Debloat
REM start /w /min cmd /c powershell.exe %DRIVE%:\config\windows\Windows10AppCleanup.ps1
REM IF /I %buildselect%==WIN GOTO UNOMAS
REM ########################################################################### Build Select
:UNOMAS
TITLE ## Workstation Setup ## Installation
echo.
echo  Select your build:
echo.
echo  # B1 - 
echo  # B2 - 
echo  # B3 - 
echo.
echo  More options:
echo.
IF %MODE%==FIRSTRUN echo ## All commands are commented out. Nothing will be executed.
REM echo  # RES - Reset this PC completely
REM echo  # WSU - Reset Windows Updates Service
REM echo  # CRE - Create a user
REM echo  # BAK - Backup a profile from this machine
REM echo  # GPO - Import standard local group policies
REM echo  # DLL - Remove Dell OOB Applications
REM echo  # WIN - Debloat Windows 10
REM echo  # EXE - Download updated installers from share
echo.
REM set /p buildselect= # Select your build: 
REM IF /I %buildselect%==RES systemreset –factoryreset
REM IF /I %buildselect%==GPO GOTO GPO
REM IF /I %buildselect%==DLL GOTO OOB
REM IF /I %buildselect%==WIN GOTO DEBLOAT
REM IF /I %buildselect%==EXE GOTO INSTALLERS
REM IF /I %buildselect%==UPD GOTO 
REM ########################################################################### Install Applications (OS)
:OS
REM %DRIVE%:\exec\Installer0.msi /qn
echo.
REM echo Something Installed
REM %DRIVE%:\exec\Installer1.msi /qn
echo.
REM echo Something Installed
REM %DRIVE%:\exec\Installer2.msi /qn
echo.
REM echo Something Installed
REM %DRIVE%:\exec\Installer3.msi /qn
echo.
REM echo Something Installed
REM IF %buildselect%==OS GOTO POLISHING
REM ########################################################################### Install Applications (B1)
:B1
REM wuauclt /detectnow
echo.
REM %DRIVE%:\exec\Installer0.msi /quiet /qn
echo.
REM echo Something Installed
REM %DRIVE%:\exec\Installer1.msi /qn
echo.
REM echo Something Installed
REM %DRIVE%:\exec\Executable1.exe /silent /verysilent
echo.
REM echo Something Installed
REM powershell "Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0"
:B2
REM ########################################################################### Install Applications (B2)
REM IF NOT EXIST "%userprofile%\.ssh\" mkdir "%userprofile%\.ssh\"
REM xcopy %DRIVE%:\config\ssh\powershell\config "%userprofile%\.ssh\"
REM powershell "Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0"
echo.
REM echo Powershell configured for ssh
REM %DRIVE%:\exec\NotepadPlusPlusSetup.exe /S
echo.
REM echo NotepadPlusPlus Setup
REM %DRIVE%:\exec\PuttySetup.msi /qn
echo.
REM echo Putty Installed
echo.
REM %DRIVE%:\exec\WinSCPSetup.exe /allusers /verysilent
echo.
REM echo WinSCP Installed
echo.
REM dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
REM powershell "wsl --install"
REM powershell "wsl --update"
echo.
REM echo WSL Installed
:POLISHING
REM ########################################################################### Finishing Up
WMIC computersystem where caption='%computername%' rename '%NewComputerName%'
REM IF /I EXIST "%userprofile%\Desktop\Microsoft Edge.lnk" del "%userprofile%\Desktop\Microsoft Edge.lnk"
REM manage-bde C: -on
echo.
REM IF %buildselect%==OS net user /add localadmin
REM IF %buildselect%==OS net user localadmin localadminpassword
REM IF %buildselect%==OS net localgroup Administrators /add localadmin
REM IF %buildselect%==OS wmic useraccount where "Name='localadmin'" set PasswordExpires=false
REM echo Setup Complete - Reboot Required
REM pause
timeout 45
REM shutdown -r -t 10
exit
