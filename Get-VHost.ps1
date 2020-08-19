param ([string]$Computername)
    try
        {
        $ping = Test-Connection $Computername -Count 1 -ErrorAction SilentlyContinue
        }
    catch{}
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