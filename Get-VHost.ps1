<#
PSScriptInfo

Version: 1.0
Author: catline


DESCRIPTION
Retrieve the name of the Hyper-v host that hosts your virtual machine


EXAMPLE
Get-VHost -Computername srv-dc02

#>
param ([string]$Computername)
    #Test computer availability
    try
        {
        $ping = Test-Connection $Computername -Count 1 -ErrorAction SilentlyContinue
        }
    catch{}
    #Get value of remote registry
    if ($ping)
        {
        $Virtual = reg query "$Computername\HKLM\Software\Microsoft\Virtual Machine" /s
        if ($Virtual -like "hostname")
            {
            $hostname = reg query "$Computername\HKLM\Software\Microsoft\Virtual Machine\Guest\Parameters" /v hostname
            $hostname = $hostname -split 'REG_SZ'
            $hostname = $hostname[3]
            "Hostname: $hostname"
            }
            else
            {
            "That computer is not a Hyper-V virtual machine"
            }
        }
        else
            {
            "Computer is not available"
            }