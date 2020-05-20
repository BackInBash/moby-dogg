# This file checks if Plex has been run before in this container
# If no machine id is found in the registry but a backup excists in the config dir, it will restore the reg backup
# If no machine id is found in the registry and there is no reg backup, restore nothing
# If a machine id is found, it will export the current registry to a backup file

Write-Output "[$(Get-Date)]: Bootstrapping... "

Write-Output "[$(Get-Date)]: Checking if this is a new container... "

$MachineID = (Get-ItemProperty 'HKCU:\Software\Plex, Inc.\Plex Media Server').MachineIdentifier
Write-Output "Plex Machine ID: $MachineID"

if ($MachineID -eq $null) 
{
	# There is no machine ID (clean container? plex never ran?) Look for the backup file
	Write-Output "[$(Get-Date)]: No Plex Machine ID found!"
	Write-Output "[$(Get-Date)]: Checking if there is a regbackup..."
	if ((Test-Path 'C:\Users\ContainerAdministrator\AppData\Local\Plex Media Server\regbackup.reg') -eq $true)
	{
		# We found the backup, restore it
		Write-Output "[$(Get-Date)]: Found a backup and no machine ID, assuming this is a reinstalled container..."
		# Wipe out some placeholder data, the backup should have all the needed info
		Remove-Item "HKCU:\Software\Plex, Inc.\Plex Media Server" -Force
		REG import 'C:\Users\ContainerAdministrator\AppData\Local\Plex Media Server\regbackup.reg'
	}
} else {
	# There is a machine ID, no need to restore anything. Make a backup to be sure
	Write-Output "[$(Get-Date)]: Making a regbackup... "
	Remove-Item 'C:\Users\ContainerAdministrator\AppData\Local\Plex Media Server\regbackup.old' -Force -ErrorAction SilentlyContinue
	Rename-Item 'C:\Users\ContainerAdministrator\AppData\Local\Plex Media Server\regbackup.reg' 'C:\Users\ContainerAdministrator\AppData\Local\Plex Media Server\regbackup.old' -Force -ErrorAction SilentlyContinue
	REG export 'HKCU\Software\Plex, Inc.\Plex Media Server' 'C:\Users\ContainerAdministrator\AppData\Local\Plex Media Server\regbackup.reg'
}
   
  
   Write-Output "[$(Get-Date)]: Bootstrapping Plex Media Server.exe.. "
   & 'C:\Plex\Plex Media Server.exe'