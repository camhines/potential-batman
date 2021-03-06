<# Author: Johann Romero
	Scripts tries to ping servers on the list provided
#>

Param([parameter(Mandatory=$false)][string]$txtPath)
#[parameter(Mandatory=$true)][string]$Type,
#[parameter(Mandatory=$true)][string]$OrgUnit
if (!$txtPath)
    {
        Write-Host ("Path to Server List is missing")
    }
	else
	{
		Get-SvrListfromtxt	
	}
	

#Read a txt file with serverv list to ping
Function Get-SvrListfromtxt 
{
 	try
	{	
		#$svrlist = Get-Content -Path "C:\Users\romeroj1\Documents\Work\utils\Scripts\Input Files\svr2ping.txt"
		$svrlist = Get-Content -Path $txtPath
		foreach($item in $svrlist)
		{	
			#ping -4 $item
			#Write-Host "Total systems to Ping: " + $svrlist.count()
			Get-svrips -svrName $item			
		}
	}
	catch [System.Exception]
	{
		Write-Host $Error + $StackTrace -ForegroundColor Red
	}
}

Function Get-svrips
{
	Param($svrName)
	try
	{
		#Pinging Server Name		
		ping -4 $svrname
	}
	catch [System.Exception]
	{
		Write-Host $Error + $StackTrace -ForegroundColor Red
	}
}

