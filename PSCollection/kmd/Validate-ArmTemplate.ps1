Param(
    [string] $ScriptPath = "$($PSScriptRoot)/Deploy-AzureResourceGroup.ps1",
    [string] $ArtifactStagingDirectory = "$PSScriptRoot\Test-Files\Templates",
    [string] $ResourceGroupLocation = "West Europe",
    [string] $TemplateFile = "$PSScriptRoot\Test-Files\Templates\test-template.json",
    [string] $ResourceGroupName = 'TemplateValidation',
    [parameter(ValueFromRemainingArguments=$true)] $additionalparameters

)

. $PSScriptRoot\Validate-ArmTemplate-Functions.ps1
$missingparameters = Validate($TemplateFile)

if ($env:BUILD_BUILDID) {
    $B = "validation"
    $ID = $env:BUILD_BUILDID
    $BID = "$B" + "$ID"
    Write-Host "Upload container: $BID"    
    Invoke-expression "& $ScriptPath -ArtifactStagingDirectory '$ArtifactStagingDirectory' -ResourceGroupName '$ResourceGroupName' -ResourceGroupLocation '$ResourceGroupLocation' -TemplateFile '$TemplateFile' -StorageContainerName '$BID' -ValidateOnly $additionalparameters $missingparameters"
}


else {
    Invoke-expression "& $ScriptPath -ArtifactStagingDirectory '$ArtifactStagingDirectory' -ResourceGroupName '$ResourceGroupName' -ResourceGroupLocation '$ResourceGroupLocation' -TemplateFile '$TemplateFile' -ValidateOnly $additionalparameters $missingparameters"
}

