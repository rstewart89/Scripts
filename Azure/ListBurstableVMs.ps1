#Author: Mathias Wrobel - Innofactor
#Script to read burstable VM's

$currentContext = Get-AzContext
$subscriptionIDlist = Get-AzSubscription

$arrayOfVMs = @()

#Looping through all available subscriptions
ForEach ($sub in $subscriptionIDlist) {
    Set-AzContext -SubscriptionId $sub.Id | Out-Null

    #Looping through VM's in current subscription
        $listOfVMs = (Get-AzVm)
        $listOfVMs | ForEach-Object {
            if ($_.HardwareProfile.VmSize.ToString() -match "b") {
                $arrayOfVMs += New-Object -TypeName psobject -Property @{Name = $_.Name;
                                                                        ResourceGroupName = $_.ResourceGroupName;
                                                                        VmSize = $_.HardwareProfile.VmSize;
                                                                        Subscription = $sub.Name
                                                                        }
            }
        }
}

Set-AzContext $currentContext | Out-Null
$arrayOfVMs | Format-Table -Property Name, ResourceGroupName, VmSize, Subscription