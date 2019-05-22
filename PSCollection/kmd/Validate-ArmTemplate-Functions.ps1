#List of hardcoded test values
$testbool = $true
$teststring = "validation"
$testint = 1

#Function to fill in values according to type
Function TypeValue {
Param ($types)
if ($types -eq "string") {
        $dummyParam = $teststring
    }
elseif ($types -eq "bool") {
        $dummyParam = $testbool
    }
elseif ($types -eq "int") {
        $dummyParam = $testint
    }
    return $dummyParam
}

function Validate {
Param ($TemplateFile)

#Get content from json file
$TemplateJsonContent = Get-Content $TemplateFile -Raw | ConvertFrom-Json

#Check for missing default value
$TemplateJsonContent.parameters | Get-Member -Type NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    $dfv = Get-Member -InputObject $TemplateJsonContent.parameters.$_ -MemberType All -Name defaultValue
    $types = $TemplateJsonContent.parameters.$_.type
    if (($_ -ne "_artifactsLocationSasToken") -and ($_ -ne "_artifactsLocation") -and ($dfv -eq $null) -and ($types -ne 'securestring')) {
            $newparameters += " -$_ "
            $newparameters += TypeValue ($types)
        }    
    }
return $newparameters
}