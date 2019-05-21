# Make sure that Pester is installed
if (Get-Module -ListAvailable -Name Pester) {
    Import-Module Pester
}
else {
    Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
    Install-Module -Name Pester -Force -Verbose -Scope CurrentUser
    Import-Module Pester
}


describe "Correct containers for deletion" {
    
    it "Should return list with container to be deleted - Prefix" {
        $dummyObject = New-Object -TypeName psobject 
        $dummyObject | Add-Member -MemberType NoteProperty -Name ContainerName -Value "dummyContainer"
        
        Mock Select-AzureRmSubscription
        Mock Get-AzureRmSubscription
        Mock Get-AzureRmStorageAccount
        Mock Get-AzureStorageContainer -MockWith { return $dummyObject }
        Mock Remove-AzureStorageContainer

        Mock Write-Host
        
        . $PSScriptRoot\Remove-Container.ps1 -prefix "notNull"

        Assert-MockCalled Get-AzureStorageContainer -Times 1
        Assert-MockCalled Remove-AzureStorageContainer -Times 1 -ParameterFilter { $listOfContainersToDelete }
        }

     
     it "Should not attempt to remove any container if list is not populated - Prefix" {
        Mock Select-AzureRmSubscription        
        Mock Get-AzureRmSubscription
        Mock Get-AzureRmStorageAccount
        Mock Get-AzureStorageContainer -MockWith { return $null }
        Mock Remove-AzureStorageContainer
        Mock Write-Host
        
        . $PSScriptRoot\Remove-Container.ps1 -prefix "notNull"

        Assert-MockCalled Get-AzureStorageContainer -Times 1
        Assert-MockCalled Remove-AzureStorageContainer -Times 0 -ParameterFilter { $listOfContainersToDelete }
        }

     
     it "Should return list with container to be deleted - Container" {
        $dummyObject = New-Object -TypeName psobject 
        $dummyObject | Add-Member -MemberType NoteProperty -Name ContainerName -Value "dummyContainer"
        
        Mock Select-AzureRmSubscription
        Mock Get-AzureRmSubscription
        Mock Get-AzureRmStorageAccount
        Mock Get-AzureStorageContainer -MockWith { return $dummyObject }
        Mock Remove-AzureStorageContainer
        Mock Write-Host
        
        . $PSScriptRoot\Remove-Container.ps1 -container "notNull"

        Assert-MockCalled Get-AzureStorageContainer -Times 1
        Assert-MockCalled Remove-AzureStorageContainer -Times 1 -ParameterFilter { $listOfContainersToDelete }
        }

     
     it "Should not attempt to remove any container if list is not populated - Container" {
        Mock Select-AzureRmSubscription        
        Mock Get-AzureRmSubscription
        Mock Get-AzureRmStorageAccount
        Mock Get-AzureStorageContainer -MockWith { return $null }
        Mock Remove-AzureStorageContainer
        Mock Write-Host
        
        . $PSScriptRoot\Remove-Container.ps1 -container "notNull"

        Assert-MockCalled Get-AzureStorageContainer -Times 1
        Assert-MockCalled Remove-AzureStorageContainer -Times 0 -ParameterFilter { $listOfContainersToDelete }
        }
}
           
