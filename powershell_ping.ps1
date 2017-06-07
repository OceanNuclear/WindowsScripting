#$outfile=$outfile -replace ":"
$downfile="downTime.txt"
$outfile="pingTime.txt"
$outfile2="pingTime2.txt"

$ping = new-object System.Net.NetworkInformation.Ping
$pingNumber = 0

$lastPingTime = Get-Date -UFormat "%s"

#make a subprogram here in order to loop:
$pingprog =
{
	$reply = $ping.Send('8.8.8.8')
	$thisPing = $reply.Status
	$date = Get-Date -UFormat "%d-%m-%y"
	$time = Get-Date -UFormat "%T"
	$hourMin = Get-Date -UFormat "%H:%M"
	
	if ($thisPing -ne "Success")
		{
		echo $thisPing
		}
		
	if ($lastPing -eq "Success" -And $thisPing -ne "Success")
		{
		$dur_start = $lastPingTime
		}
	if ($lastPing -ne "Success" -And $thisPing -eq "Success" -And $pingNumber -ne 0)
		{
		$dur_end = Get-Date -UFormat "%s"
		$duration = $dur_end - $dur_start
		
		$date+"`t"+$time+"`t"+$duration>>$downfile
		echo $duration
		}

	if ($thisPing -eq "Success")
		{
		$inverse = 1000/$reply.RoundtripTime
		$date+"`t"+$time+"`t"+$hourMin+"`t"+$reply.RoundtripTime+"`t"+$inverse>>$outfile2
		echo $reply.RoundtripTime
		}
		
	$pingNumber = $pingNumber +1
	$lastPing = $thisPing
	$lastPingTime = Get-Date -UFormat "%s"
	
	start-sleep(1)
	.$pingprog
}


&$pingprog