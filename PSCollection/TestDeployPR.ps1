$TenantId = 'f0534ee3-b610-4b69-bde4-e61348741294'

# Force Azure Login if not already logged in
Try {
	$AccountType = (Get-AzureRmContext).Account.Type
	Write-Host "AUthenticated using AccountType: $AccountType"
	if ($AccountType -eq 'AccessToken') {
		throw "Cant access KeyVault with AccessToken auth, forcing User login..."
	}
    Select-AzureRmSubscription -SubscriptionName Gandalf
}
Catch {
    Add-AzureRmAccount -TenantId $TenantId
	Write-Host "AUthenticated using AccountType: $((Get-AzureRmContext).Account.Type)"
    Select-AzureRmSubscription -SubscriptionName Gandalf
}


#Staff UI
C:\Users\Z6MYW\source\repos\DevOps\Gandalf.DevOps\Gandalf.Vsts\Scripts\Validate-ArmTemplate.ps1 -ArtifactStagingDirectory 'C:\Users\Z6MYW\source\repos\Gandalf\src\Gandalf.Azure\Templates' -ResourceGroupLocation 'West Europe' -ResourceGroupName 'ArmTemplateValidation' -TemplateFile 'C:\Users\Z6MYW\source\repos\Gandalf\src\Gandalf.Azure\Templates\azuredeploy.frontend.json' -TemplateParametersFile 'C:\Users\Z6MYW\source\repos\Gandalf\src\Gandalf.Azure\Templates\azuredeploy.parameters.json' -TenantId 'f0534ee3-b610-4b69-bde4-e61348741294'

#Backend
#C:\Users\Z6MYW\source\repos\DevOps\Gandalf.DevOps\Gandalf.Vsts\Scripts\Validate-ArmTemplate.ps1 -UploadArtifacts -ArtifactStagingDirectory 'C:\Users\Z6MYW\source\repos\GandalfBackend\src\Gandalf.Azure\Templates' -ResourceGroupLocation 'West Europe' -ResourceGroupName 'ArmTemplateValidation' -TemplateFile 'C:\Users\Z6MYW\source\repos\GandalfBackend\src\Gandalf.Azure\Templates\azuredeploy.backend.json' -TemplateParametersFile 'C:\Users\Z6MYW\source\repos\GandalfBackend\src\Gandalf.Azure\Templates\azuredeploy.parameters.json' -TenantId 'f0534ee3-b610-4b69-bde4-e61348741294' -KeyVaultResourceGrp 'develop15-gandalf' -KeyVaultName 'vault-develop15-gandalf'

#MemberUI
#C:\Users\Z6MYW\source\repos\DevOps\Gandalf.DevOps\Gandalf.Vsts\Scripts\Validate-ArmTemplate.ps1 -ArtifactStagingDirectory 'C:\Users\Z6MYW\source\repos\MemberUI\Gandalf.MemberUI.Azure\Templates' -ResourceGroupLocation 'West Europe' -ResourceGroupName 'ArmTemplateValidation' -TemplateFile 'C:\Users\Z6MYW\source\repos\MemberUI\Gandalf.MemberUI.Azure\Templates\azuredeploy.json' -TemplateParametersFile 'C:\Users\Z6MYW\source\repos\MemberUI\Gandalf.MemberUI.Azure\Templates\azuredeploy.parameters.json' -TenantId 'f0534ee3-b610-4b69-bde4-e61348741294' -UploadArtifacts -KeyVaultResourceGrp 'DevOps' -KeyVaultName 'DevDefault-KeyVault'

#MemberUI - Forms
#C:\Users\Z6MYW\source\repos\DevOps\Gandalf.DevOps\Gandalf.Vsts\Scripts\Validate-ArmTemplate.ps1 -ArtifactStagingDirectory 'C:\Users\Z6MYW\source\repos\MemberUI\Gandalf.Forms.Azure\Templates' -ResourceGroupLocation 'West Europe' -ResourceGroupName 'ArmTemplateValidation' -TemplateFile 'C:\Users\Z6MYW\source\repos\MemberUI\Gandalf.Forms.Azure\Templates\azuredeploy.json' -TemplateParametersFile 'C:\Users\Z6MYW\source\repos\MemberUI\Gandalf.Forms.Azure\Templates\azuredeploy.parameters.json' -TenantId 'f0534ee3-b610-4b69-bde4-e61348741294' -UploadArtifacts -KeyVaultResourceGrp 'DevOps' -KeyVaultName 'DevDefault-KeyVault'
#-appInsightsPlan 'Basic'
#-appInsightsGroup 'develop-foeniks'