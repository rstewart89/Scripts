# Make sure that Pester is installed
if (Get-Module -ListAvailable -Name Pester) {
    Import-Module Pester
}
else {
    Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
    Install-Module -Name Pester -Force -Verbose -Scope CurrentUser
    Import-Module Pester
}
    

. $PSScriptRoot\Validate-ArmTemplate-Functions.ps1

Describe 'Get-Values' {

    it "Should return 'validation'" {
        $types = "string"
        $result = TypeValue($types)
        $result | should be 'validation'
        $result | should beoftype string
    }

    it "Should return '1'" {
        $types = "int"
        $result = TypeValue($types)
        $result | should be 1
        $result | should beoftype int
    }

    it "Should return 'true'" {
        $types = "bool"
        $result = TypeValue($types)
        $result | should be $true
        $result | should beoftype bool
    }

    it "Should return 'null' - Non supported type" {
        $types = "strings"
        $result = TypeValue($types)
        $result | should be $null
    }
}

Describe 'checking new parameters' {
    $TemplateFile = "$PSScriptRoot\Test-Files\Templates\test-template.json"

    it "should return true if 'TestVarString' is generated" {     
        $parameters = Validate($TemplateFile)
        if ( $parameters -match '-TestVarString validation' ) {
            $result = $true
            }
    
        else {
            $result = $false
            }

    $result | should be $true   
    }

    it "should return true if 'TestVarInt' is generated" {
        $parameters = Validate($TemplateFile)
        if ( $parameters -match '-TestVarInt 1' ) {
            $result = $true
            }
    
        else {
            $result = $false
            }

    $result | should be $true
    }

    it "should return true if 'TestVarBool' is generated" {
        $parameters = Validate($TemplateFile)
        if ( $parameters -match '-TestVarBool true' ) {
            $result = $true
            }
    
        else {
            $result = $false
            }

    $result | should be $true
    }
}