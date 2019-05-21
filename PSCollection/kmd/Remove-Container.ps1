Param (
    $resourceGroup = "ARM_Deploy_Staging",
    $location = "West Europe",
    $storageAccountName = "",
    $prefix,
    $subscriptionName = "",
    $container = "validation" + "$env:BUILD_BUILDID"
)

Get-AzureRmSubscription -SubscriptionName "$subscriptionName" | Select-AzureRmSubscription

# get a reference to the storage account and the context
$storageAccount = Get-AzureRmStorageAccount `
    -ResourceGroupName $resourceGroup `
    -Name $storageAccountName
$ctx = $storageAccount.Context 

# retrieve list of containers to delete
if ($prefix) {
    $listOfContainersToDelete = Get-AzureStorageContainer -Context $ctx -Prefix $prefix
}
else {
    $listOfContainersToDelete = Get-AzureStorageContainer -Context $ctx -Name $container
}

# check if any valid containers is to be deleted
if ($listOfContainersToDelete) {

    # write list of containers to be deleted 
    Write-Host 'Containers to be deleted'
    $listOfContainersToDelete | Select-Object Name

}

else {
    Write-Host 'No valid container for deletion'
    exit 0;
}


# deleting containers
try {
    $listOfContainersToDelete | Remove-AzureStorageContainer -Context $ctx -Force -ErrorAction Stop
    Write-Host 'Container succesfully deleted'    
}

catch {
    Write-Host 'Deletion failed'
    Write-Host $_.Exception.Message
    Write-Host "##vso[task.complete result=Failed;]DONE"
    exit -1;
}
