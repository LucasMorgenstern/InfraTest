:inicio
@echo off
title Aplicacao Batch
cls
echo.
echo ************ Menu ************
echo 1. Testar porta via Netstat
echo 2. Testar via Telnet
echo 3. Verificar rota via tracert
echo 4. verificar aplicacao pelo PID
echo 5. Dados da Maquina
echo 6. Servicos
echo 7. GEO IP
echo 0. Sair
echo ******************************
echo.

set /p escolha= "Digite uma opcao: "
	if "%escolha%" equ "1" (goto:op1)
	if "%escolha%" equ "2" (goto:op2)
	if "%escolha%" equ "3" (goto:op3)
	if "%escolha%" equ "4" (goto:op4)
	if "%escolha%" equ "5" (goto:op5)
	if "%escolha%" equ "6" (goto:op6)
	if "%escolha%" equ "7" (goto:op7)
	if "%escolha%" equ "10" (goto:opteste)
	if "%escolha%" equ "0" (goto:exit) else (
		echo.
		echo ***** Opcao incorreta *****
		timeout 3
	
	goto:inicio
)

:op1
	echo.
	set /p porta= "Informe a porta: "
	netstat -ano | find "%porta%"

	:esco
	echo.
	set /p escolha1= "Deseja verificar o PID ? (1 = Sim / 2 = Nao) "
		if "%escolha1%" equ "1" (goto:op4)
		if "%escolha1%" equ "2" (goto:inicio) else (
			echo.
			echo ***** Opcao incorreta *****
			timeout 3
			goto:esco
		)

goto:inicio	

:op2
	echo.
	set /p ip="Informe o IP: "
	set /p port="Informe a Porta: "
	telnet %ip% %port%
	echo.
	pause
goto:inicio

:op3
	echo.
	set /p ipT="Informe o IP / URL: "
	tracert %ipT%
	echo.
	pause
goto:inicio

:op4
	echo.
	set /p Pid="Informe o PID : "
	echo.
	tasklist | find "%Pid%"
	echo.
	pause
goto:inicio

:op5

	powershell (Get-NetIPConfiguration ^| ? {$_.IPv4DefaultGateway -and $_.NetAdapter.Status -eq 'Up'}).IPv4Address.IPAddress > %TEMP%\ipI.txt
	powershell (iwr ipinfo.io/ip -UseBasicParsing).content > %TEMP%\ipE.txt
	powershell (Get-CimInstance -ClassName Win32_ComputerSystem).domain > %TEMP%\domain.txt
	powershell (Get-ComputerInfo -Property "TimeZone").TimeZone > %TEMP%\tz.txt
	powershell (Get-ComputerInfo -Property "OsArchitecture").OsArchitecture > %TEMP%\ArchOS.txt
	powershell (Get-ComputerInfo -Property "OsLanguage").OsLanguage > %TEMP%\LingOS.txt
	powershell (Get-ComputerInfo -Property "OsName").OsName > %TEMP%\OsName.txt

 	FOR /F "tokens=*" %%y in (%TEMP%\ipI.txt) do set IP4I=%%y
	FOR /F "tokens=*" %%z in (%TEMP%\ipE.txt) do set IP4E=%%z
	FOR /F "tokens=*" %%k in (%TEMP%\domain.txt) do set Domain=%%k
	FOR /F "tokens=*" %%w in (%TEMP%\tz.txt) do set TimeZone=%%w
	FOR /F "tokens=*" %%w in (%TEMP%\ArchOS.txt) do set ArchOS=%%w
	FOR /F "tokens=*" %%w in (%TEMP%\LingOS.txt) do set LingOS=%%w
	FOR /F "tokens=*" %%w in (%TEMP%\OsName.txt) do set OsName=%%w
	FOR /F %%h in ('hostname') do SET Host4=%%h

	cls
	echo.
	echo -----------------------------------------------
	echo Hostname : %Host4%
	echo.
	echo IP Interno : %IP4I%
	echo.
	echo IP Externo : %IP4E%
	echo.
	echo Domain : %Domain%
	echo. 
	echo TimeZone : %TimeZone%
	echo. 
	echo Arquitetura : %ArchOS%
	echo. 
	echo Linguagem OS : %LingOS%
	echo.
	echo Sistema Operacional : %OsName%
	echo -----------------------------------------------
	
	del %TEMP%\ipE.txt
	del %TEMP%\ipI.txt
	del %TEMP%\domain.txt
	del %TEMP%\tz.txt
	del %TEMP%\ArchOS.txt
	del %TEMP%\LingOS.txt
	del %TEMP%\OsName.txt

	pause
goto:inicio

:op6
	echo.
	set /p NameServ="Informe uma palavra para filtrar o servico : "
	echo.
	powershell Get-Service -Displayname "*%NameServ%*"
	pause
goto:inicio

:op7
echo.
set /p IPGEO="Informe a URL ou IP : "

powershell -Command "& {Invoke-RestMethod -Uri http://ip-api.com/json/%IPGEO% | format-list query, status, org,country, regionName, city}" > %TEMP%\GeoIP.txt
echo.
for /F "delims=" %%x in (%TEMP%\GeoIP.txt) do (
     echo %%x
)
echo.
pause

goto:inicio

:opteste

echo -------
echo -Teste-       
echo -------
	
pause
goto:inicio


:exit
exit