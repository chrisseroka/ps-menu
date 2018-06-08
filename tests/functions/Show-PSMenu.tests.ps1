$CommandName = $MyInvocation.MyCommand.Name.Replace(".Tests.ps1", "")
Write-Host -Object "Running $PSCommandpath" -ForegroundColor Cyan


Describe "$CommandName Manual Tests" -Tags "Manual" {
    BeforeAll {
        $Pester1Result = @(
            'addictedGas'
        )

        $Pester5Result = @(
            'addictedGas'
            , 'GlamorousExternal'
            , 'Blue-EyedAddress'
            , 'BrainyBath'
            , 'dampEscape'
        )


    }
    Context "Manual Input Selection" {

        It "single selection to user and returns single selection" {
            Write-Host 'Directions: Press Enter to Select Single Entry' -ForegroundColor Cyan
            $Result = Show-PSMenu -MenuItems $Pester1Result
            $Result | Should -Be "addictedGas"
        }

    }

    Context "Object Selection From Other Cmdlets" {

        It "single Get-Service selection to user and returns single selection" {
            Write-Host 'Directions: Press Space to Select First Entry Then Press Enter' -ForegroundColor Cyan
            $Result = Show-PSMenu -MenuItems (Get-Service | Select -First 1).DisplayName
            $Result.Count | Should -Be 1
        }
        It "multiple Get-Service selection to user and returns single selection" {
            Write-Host 'Directions: Press Space to Select First Entry Then Press Enter' -ForegroundColor Cyan
            $Result = Show-PSMenu -MenuItems (Get-Service | Select -First 5).DisplayName
            $Result.Count | Should -Be 1
        }
    }
    Context "Various MultiSelect Methods" {

        It "single selection to user and returns single selection" {
            Write-Host 'Directions: Press Space to Select First Entry Then Press Enter' -ForegroundColor Cyan
            $Result = Show-PSMenu -MenuItems (Get-Service | Select -First 1).DisplayName -MultiSelect
            $Result.Count | Should -Be 1
        }
        It "multiple selection to user and user selects 5 and gets 5 back" {
            Write-Host 'Directions: Press Space on all names except for the blank and then press enter' -ForegroundColor Cyan
            $Result = Show-PSMenu -MenuItems (Get-Service | Select -First 5).DisplayName -MultiSelect
            $Result.Count | Should -Be 5
        }
        It "multiple selection to user and returns single selection" {
            Write-Host 'Directions: Press Space on **2 NAMES** and then press enter' -ForegroundColor Cyan
            $Result = Show-PSMenu  -MenuItems $Pester5Result -MultiSelect
            $Result.Count | Should -Be 2
            $Result[0] | Should -Be "addictedGas"
            $Result[1] | Should -Be "GlamorousExternal"
        }
        It "user selects none to return" {
            Write-Host 'Directions: Press escape to not enter a value. No blank entries should be presented (manual check)' -ForegroundColor Cyan
            $Result = Show-PSMenu  -MenuItems $Pester5Result -MultiSelect
            $Result.Count | Should -Be 0
            $Result | Should -BeNullOrEmpty

        }
    }
}
