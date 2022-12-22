[CmdletBinding()]
param (

    [Parameter()]
    [string]
    $RGName,

    [Parameter()]
    [string]
    $dnsLabelPrefix,

    [Parameter()]
    [string]
    $adminUsername,

    [Parameter()]
    [string]
    $adminPassword
)

# $pwd = $adminPassword
$pwd = ConvertTo-SecureString $adminPassword -AsPlainText -Force
# $adminUsername = "nikhil"
# $dnsLabelPrefix = "nkhl"
# $RGName = "Sonar_test"
$location = "South India"

# Connect-AzAccount
# Set-AzContext -Subscription "1b528990-0c0e-475f-85b2-4ccffe89f9ce"
New-AzResourceGroup -Name $RGName -Location $location -Force

New-AzResourceGroupDeployment `
    -ResourceGroupName $RGName `
    -TemplateFile $(Build.SourcesDirectory)/CreateSonarQubeVM.json `
    -adminUsername $adminUsername `
    -adminPassword $pwd `
    -dnsLabelPrefix $dnsLabelPrefix `
    -OSVersion "2022-datacenter" `
    -vmName "SonarQubeServer"

(Get-AzVm -ResourceGroupName $RGName).name
