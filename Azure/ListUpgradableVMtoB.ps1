#Author: Mathias Wrobel - Innofactor
#Script to list VM's that can be upgraded to series B available to that tenant.

$currentContext = Get-AzContext
$subscriptionIDlist = Get-AzSubscription

$arrayOfVMs = @()

#Looping through all available subscriptions
ForEach ($sub in $subscriptionIDlist) {
    Set-AzContext -SubscriptionId $sub.Id | Out-Null

    #Looping through VM's in current subscription
        $listOfVMs = (Get-AzVm)
        $listOfVMDisks = (Get-AzDisk)
        ForEach ($vm in $listOfVMs) {
            if ($vm.HardwareProfile.VmSize.ToString() -notmatch "b") {
                $disk = ($listOfVMDisks | Where-Object { $_.ManagedBy -eq $vm.Id })
                if ($disk.Sku.Tier -eq "Premium") {
                    $arrayOfVMs += New-Object -TypeName psobject -Property @{Name = $vm.Name;
                                                                            ResourceGroupName = $vm.ResourceGroupName;
                                                                            VmSize = $vm.HardwareProfile.VmSize;
                                                                            Subscription = $sub.Name;
                                                                            DiskName = $disk.Name;
                                                                            DiskSku = $disk.Sku.Name
                                                                            }
                }
            }
        }
}

Set-AzContext $currentContext | Out-Null
$arrayOfVMs | Format-Table -Property Name, ResourceGroupName, VmSize, DiskName, DiskSku, Subscription