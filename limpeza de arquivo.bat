set dataexe=%date:~-4%_%date:~3,2%_%date:~0,2%
cd %temp%
dir *.tmp | find /I "arquivo(s)" > "%temp%\log_count_%dataexe%_%random%.log"
del /q *.tmp


