##
## Check ReserverdPorts value in all servers
##

$trackingJob = Invoke-Command -ScriptBlock {
#Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters | Format-List ReservedPorts
(Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters | select-object ReservedPorts).ReservedPorts
} -ComputerName (Get-Content "e:\Utils\PsSuite\serverlist.txt" ) -AsJob

while ($trackingJob.State -like "Running")                #wait until Completed or Failed, Paused, etc.
{
    Start-Sleep -Seconds 1
}
cls
write-host "ServerName `t ReserverdPort"
write-host "-----------`t -------------"
if ($trackingJob.State -like "Completed")
{
        $procs = Receive-Job $trackingJob 
        if ($procs -ne $null)
        {
            foreach ($proc in $procs)
            {
             write-host $proc.PSComputerName `t $proc
            }
        }
}
