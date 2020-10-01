@echo off
TITLE CLAVES Regedit Y ODBC
COLOR 0A
MODE con:cols=45 lines=20


IF EXIST "%windir%\SysWOW64\odbcad32.exe" (GOTO 64BIT) ELSE (GOTO 32BIT)
:64BIT
cd %windir%\SysWOW64\
set arquitectura==64
goto CheckSystem1

:32BIT
cd %windir%\system32\
set arquitectura==32
goto CheckSystem1

:CheckSystem1
cls
echo ษออออออออออออออออออออออออออออออออออออออออออป
echo   CLAVES Regedit Y ODBC
echo ฬออออออออออออออออออออออออออออออออออออออออออฮ
echo ณ                                          ณ
echo ณ                                          ณ
echo ณ     Ingresa la cantidad de claves        ณ
echo ณ                                          ณ
echo ณ     a registrar de 3 a 10 maximo         ณ
echo ณ                                          ณ
echo ณ                                          ณ
echo ณ      x) Salir                            ณ
echo ณ                                          ณ
echo ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
echo                 [ github.com/rdz-lab ]
echo.
echo.
set /p clave=: 
if "%clave%"=="1" set clave=1
if "%clave%"=="2" set clave=2
if "%clave%"=="3" set clave=3
if "%clave%"=="4" set clave=4
if "%clave%"=="5" set clave=5
if "%clave%"=="6" set clave=6
if "%clave%"=="7" set clave=7
if "%clave%"=="8" set clave=8
if "%clave%"=="9" set clave=9
if "%clave%"=="10" set clave=10
if "%clave%"=="x" exit

:CheckSystem2
cls
echo ษออออออออออออออออออออออออออออออออออออออออออป
echo   CLAVES Regedit Y ODBC
echo ฬออออออออออออออออออออออออออออออออออออออออออฮ
echo ณ                                          ณ
echo ณ                                          ณ
echo ณ     Selecciona el sistema:               ณ
echo ณ                                          ณ
echo ณ      1) ICAAVWIN                         ณ
echo ณ      2) IRISWIN                          ณ
echo ณ      3) CENTAURO                         ณ
echo ณ      4) NOMINA                           ณ
echo ณ      5) ZEUS                             ณ
echo ณ                                          ณ
echo ณ      x) Salir                            ณ
echo ณ                                          ณ
echo ณ                                          ณ
echo ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
echo                 [ github.com/rdz-lab ]
echo.
echo.
set /p sist=: 
if "%sist%"=="1" goto icaavwin
if "%sist%"=="2" goto iriswin
if "%sist%"=="3" goto centauro
if "%sist%"=="4" goto nomina
if "%sist%"=="5" goto zeus
if "%sist%"=="x" exit
if ERRORLEVEL 0 GOTO CheckSystem2

:icaavwin
set sist1=icaavcapa
set sist2=icaavwin
goto loop

:iriswin
set sist1=iris
set sist2=iriswin
goto loop

:nomina
set sist1=nominadb
set sist2=nomina
goto loop

:zeus
set sist1=icaavcapa
set sist2=zeus
goto loop

:loop
dbdsn.exe -y -x tcpip() -w "%sist1%%clave%" -c "uid=admin;pwd=admin" -n "%sist2%"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\%sist2%" /v  DBParm%clave% /t REG_SZ /d ConnectString='DSN="%sist1%%clave%";UID=admin;PWD=admin',DelimitIdentifier='Yes'  /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\%sist2%" /v  database%clave% /t REG_SZ /d "%sist1%%clave%"  /f

set /a clave=clave-1
if %clave%==1 goto base
if %clave%==0 goto exit
goto loop

:base
dbdsn.exe -y -x tcpip() -w %sist1% -c "uid=admin;pwd=admin" -n "%sist2%"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\%sist2%" /v  DBMS /t REG_SZ /d ODBC /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\%sist2%\Printers" /v  PDF /t REG_SZ /d PDFCreator /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\%sist2%" /v  DBParm /t REG_SZ /d ConnectString='DSN=%sist1%;UID=admin;PWD=admin',DelimitIdentifier='Yes'  /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\%sist2%" /v  database /t REG_SZ /d %sist1% /f
goto exit


:centauro
dbdsn.exe -y -x tcpip() -w Centauro%clave% -c "uid=dba;pwd=sql;CON=Centauro" -n "icaawvin"

set /a clave=clave-1
if %clave%==1 goto base_cent
if %clave%==0 goto exit
goto centauro

:base_cent
dbdsn.exe -y -x tcpip() -w Centauro -c "uid=dba;pwd=sql;CON=Centauro" -n "icaawvin"
goto exit
