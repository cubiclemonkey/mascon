@echo off
echo # Uncomment lines 3-11 to make power config changes to Windows
REM TITLE ## Workstation Setup Menu ##
REM powercfg /h off
REM powercfg /change monitor-timeout-ac 60
REM powercfg /change monitor-timeout-dc 15
REM powercfg /change disk-timeout-ac 0
REM powercfg /change disk-timeout-dc 0
REM powercfg /change standby-timeout-ac 0
REM powercfg /change standby-timeout-dc 30
REM powercfg /change hibernate-timeout-ac 0
echo.
echo # Uncomment here set the timezone 
REM echo  ## Current Time Zone
REM tzutil /g
REM echo.
REM set /p ZONENEEDED=Do you need to change the timezone? [ (P)ac (M)ou (C)en (E)as or 'N' ]: 
REM if /I %ZONENEEDED%==P set WHATISTIMEZ="Pacific Standard Time"
REM if /I %ZONENEEDED%==M set WHATISTIMEZ="Mountain Standard Time"
REM if /I %ZONENEEDED%==C set WHATISTIMEZ="Central Standard Time"
REM if /I %ZONENEEDED%==E set WHATISTIMEZ="Eastern Standard Time"
echo.
REM tzutil /s %WHATISTIMEZ%
echo.
echo # Uncomment lines 17 to run a Windows Update
REM wuauclt /detectnow /updatenow
echo.
echo # Uncomment lines 20 and 21 to enable and configure Bitlocker
REM manage-bde -protectors C: -add -tpm -recoverypassword
REM manage-bde -protectors C: -get > "%DRIVE%:\config\inventory\%username% %computername% Bitlocker.txt"
REM manage-bde C: -on
echo.
echo # Uncomment here to set the new computer name:
REM set /p NewComputerName= # Enter desired computer name: 
REM WMIC computersystem where caption='%computername%' rename '%NewComputerName%'
REM ## CONFIRMS PRIOR TO CREATING ACCOUNT
set /p restart=Everything correct? 
if /I %restart%==N GOTO CREATEU
echo.
net user "%newusername%" /add
net user "%newusername%" /fullname:"%newfullname%"
net user "%newusername%" %password%
net localgroup Administrators /add "%newusername%"
WMIC USERACCOUNT WHERE Name='%newusername%' SET PasswordExpires=FALSE
WMIC computersystem where caption="%computername%" rename "%newcomputername%"
echo %newfullname% Account Created - Local Admin
echo Computer Name Updated
wmic csproduct > "%DRIVE%:\wmic\%newusername%.txt"
REM manage-bde -protectors C: -get > "D:\decryption\%newcomputername% - Bitlocker Recovery Key.txt"
del "C:\Users\Public\Desktop\Microsoft Edge.lnk"
del "C:\Users\Public\Desktop\Zoom.lnk"
IF /I EXIST "%userprofile%\Desktop\Microsoft Edge.lnk" del "%userprofile%\Desktop\Microsoft Edge.lnk"
IF /I EXIST "C:\Users\Public\Desktop\Acrobat Reader DC.lnk" del "C:\Users\Public\Desktop\Acrobat Reader DC.lnk"
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce\ /v "KyrusSetup" /t REG_SZ /d "C:\Windows\Temp\user_setup.bat"
copy %DRIVE%:\config\user_setup.bat C:\Windows\Temp\
echo.
shutdown -r -t 30 /c "Setup Complete: Leave the USB connected when logging in as the user."
