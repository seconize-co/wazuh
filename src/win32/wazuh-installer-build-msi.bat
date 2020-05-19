SETLOCAL
SET PATH=%PATH%;C:\Program Files\Microsoft SDKs\Windows\v7.0\Bin
SET PATH=%PATH%;C:\Program Files (x86)\WiX Toolset v3.11\bin

set VERSION=%1
set REVISION=%2

REM IF VERSION or REVISION are empty, ask for their value
IF [%VERSION%] == [] set /p VERSION=Enter the version of the Seconize agent (x.y.z):
IF [%REVISION%] == [] set /p REVISION=Enter the revision of the Seconize agent:

SET MSI_NAME=seconize-agent-%VERSION%-%REVISION%.msi

candle.exe -nologo "wazuh-installer.wxs" -out "wazuh-installer.wixobj" -ext WixUtilExtension -ext WixUiExtension
light.exe "wazuh-installer.wixobj" -out "%MSI_NAME%"  -ext WixUtilExtension -ext WixUiExtension

signtool sign /a /tr http://rfc3161timestamp.globalsign.com/advanced /d "%MSI_NAME%" /td SHA256 "%MSI_NAME%"

pause
