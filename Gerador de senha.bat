@echo off
title Gerador de senha
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
:inicio
cls
echo ************************************
echo Informe uma palavra chave
echo ************************************
echo.
set /p texto= "Palavra: "

echo.
echo ************************************
echo Informe o tamanho da senha
echo ************************************
echo.
set /p len= "Tamanho: "
echo.

set charpool=12345%texto%!@#$%&

set str=%charpool%
call :strLen str strlen
set len_charpool= %strlen% 

:gerador

set gen_str=
:: Loop %len% times
for /L %%b IN (1, 1, %len%) do (
 
  set /A rnd_index=!RANDOM! * %len_charpool% / 32768

  for /F %%i in ('echo %%charpool:~!rnd_index!^,1%%') do set gen_str=!gen_str!%%i
)

cls
echo ************************************
echo.
echo Senha: %gen_str%
echo.
echo ************************************
echo Deseja gerar outra senha? (S/N)
echo -----
echo Reinicar as especificacoes (Press 1)
echo ************************************
echo.

set /p escolha= "Digite uma opcao: "
	if "%escolha%" equ "1" (goto:inicio)
	if "%escolha%" equ "S" (goto:gerador)
	if "%escolha%" equ "s" (goto:gerador)
	if "%escolha%" equ "N" (goto:exit)
	if "%escolha%" equ "n" (goto:exit) else (
		echo.
		echo ***** Opcao incorreta *****
		timeout 3
	
	goto:inicio
)

pause
exit /b

:strLen
setlocal enabledelayedexpansion

:strLen_Loop
   if not "!%1:~%lenn%!"=="" set /A lenn+=1 & goto :strLen_Loop
(endlocal & set %2=%lenn%)
goto :eof


