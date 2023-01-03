# Import the VMware vSphere PowerCLI module
Import-Module VMware.PowerCLI

# Getting the values from the container
$server=$env:server
$username=$env:username
$password=$env:password

# Connect to the vSphere server
Connect-VIServer -Server $server -User $username -Password $password

# Get a list of all VMs on the vSphere server
$vms = Get-VM | Sort-Object -Property Name

$current_date=Get-Date -Format "yyyy.MM.dd"

# Loop through the VMs and create a snapshot for each one
foreach ($vm in $vms)
{
    # Create a snapshot of the VM
    New-Snapshot -VM $vm -Name $current_date -Description 'Automated Snapshot using backup script'

    # Get a list of all snapshots for the VM
    $snapshots = Get-Snapshot -VM $vm

    # If there are more than 3 snapshots, delete the oldest ones
    while ($snapshots.Count -gt 3)
    {
        $snapshot = $snapshots | Sort-Object -Property Created | Select-Object -First 1
        Remove-Snapshot -Snapshot $snapshot -Confirm:$false
        $snapshots = Get-Snapshot -VM $vm
    }
}

# Disconnect from the vSphere server
Disconnect-VIServer -Server $server -Confirm:$false

