# This script will check if Onedrive is backing up Desktop, Documents and Pictues folder
# This will run through each profile on the specified computer(s)
#
#Script by Maclin
#
#Last updated on 09/12/2023

$Servers = $env:COMPUTERNAME
foreach ($Server in $Servers){ 
$Profiles = (Get-childItem C:\Users -Directory -Recurse -Depth 1 | Where-Object { $_.Name -match '^Desktop|^Documents|^Pictures'} | ? { $_.FullName -inotmatch 'Default*|Public'})
	foreach($Profile in $Profiles){
    $size = [math]::Round((Get-ChildItem -Path $Profile.FullName -File -Recurse | Measure-Object -Property Length -Sum).Sum/ 1MB,2)
	$ProfilePath = $Profile.Parent
    $ProfilePath2 = $Profile.Name
    $ProfilePath3 = $Profile
    #$result = Split-Path "$ProfilePath" "$ProfilePath2" "$size"
    Write-Output "$Server $ProfilePath contains $ProfilePath2 = $size MB" 

	}
 #$result | Out-GridView
}