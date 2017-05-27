::purpose of this code is to find a distribution for 1) ping time at peak usage time 2) the frequency of (time elapsed between) blackouts 3) the duration of blackouts

::If a failure occurs, a null character will be received. Add a filter to catch this case and timestamp it(set time=%time:~-0,10%), so that the relative time can be found.


set date=%date:~-0,6%
set time=%time:~-0,6%
set time=%time::=%
::This "colon sandwiched-character equal sign" string attached behind the variable name is for removing the sandwiched-character from the actual variable

set output=%date%%time%.txt
set output=%output: =%

:start
for /F "tokens=8 delims==<m " %%A in ('ping 8.8.8.8 ^| find "TTL"') do (
	echo %%A>>%output%
)

Timeout 2
goto start
