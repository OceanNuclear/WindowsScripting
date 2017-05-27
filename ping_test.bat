set date=%date:~-0,6%
set date=%date: =%
set time=%time:~-0,6%
set time=%time::=%

set output=%date%%time%_.txt
output=%output: =%
::filename set.

:start
::for every reply at position x in the reply to command y do the following
for /F "tokens=5 delims==<m" %%A in ('ping -n 1 8.8.8.8 ^| find "TTL"') do (
	echo %%A>>%output%
)
if %errorlevel% EQU 1 set error=win
if %errorlevel% NEQ 1 set error=fail
echo %errorlevel%
pause
goto start