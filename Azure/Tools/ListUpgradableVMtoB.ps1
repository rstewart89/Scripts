#Author: Mathias Wrobel - Innofactor
#Script to list VM's that can be upgraded to series B available to that tenant.

$currentContext = Get-AzContext
$subscriptionIDlist = Get-AzSubscription

if (!($currentContext)) {
    Connect-AzAccount
}

$arrayOfVMs = @()

#Looping through all available subscriptions
ForEach ($sub in $subscriptionIDlist) {
    Set-AzContext -SubscriptionId $sub.Id | Out-Null

    #Looping through VM's in current subscription
        $listOfVMs = (Get-AzVm)
        $listOfVMDisks = (Get-AzDisk)

        #Looping through VM's in current subscription
        ForEach ($vm in $listOfVMs) {
            #Checking if already in B-series
            if ($vm.HardwareProfile.VmSize.ToString() -notmatch "Standard_b") {
                $disk = ($listOfVMDisks | Where-Object { $_.ManagedBy -eq $vm.Id })
                #Checking available resize options for b-series
                if ((Get-AzVMSize -VMName $vm.Name -ResourceGroupName $vm.ResourceGroupName | Where-Object { $_.Name -match "Standard_b"})) {
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

#Setting AzContext to starting point
Set-AzContext $currentContext | Out-Null

#Exporting to csv
if ($export) {
    $arrayOfVMs | Select-Object Name, ResourceGroupName, VmSize, DiskName, DiskSku, Subscription | Export-Csv -Path C:\Users\mathias.wrobel\Desktop\Export.csv -NoTypeInformation -Append -Delimiter ";"
}

$arrayOfVMs | Format-Table -Property Name, ResourceGroupName, Subscription, VmSize, DiskName, DiskSku