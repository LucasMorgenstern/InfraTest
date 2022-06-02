:inicio
@echo off
title Aplicacao Batch
cls
echo.
echo ************ Menu ************
echo 1. Alterar Hostname para Home-Office
echo 2. Alterar Hostname para Office
echo 0. Sair
echo ******************************
echo.

set /p escolha= "Digite uma opcao: "
	if "%escolha%" equ "1" (goto:op1)
	if "%escolha%" equ "2" (goto:op2)
	if "%escolha%" equ "0" (goto:exit) else (
		echo.
		echo ***** Opcao incorreta *****
		timeout 3
	
	goto:inicio
)


:op1
	powershell "Rename-Computer -NewName DESKTOP-73ABCDF -LocalCredential LocalUsername -PassThru"
	pause
goto:inicio

:op2
	powershell "Rename-Computer -NewName DESKTOP-73ABCDE -LocalCredential LocalUsername -PassThru"
	pause
goto:inicio

:exit
exit



