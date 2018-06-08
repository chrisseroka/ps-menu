$moduleRoot = $moduleRoot = Split-Path $PSScriptRoot -Parent | Split-Path -Parent

. "$PSScriptRoot\FileIntegrity.Exceptions.ps1"

function Get-FileEncoding
{
    <#
	.SYNOPSIS
		Tests a file for encoding.

	.DESCRIPTION
		Tests a file for encoding.

	.PARAMETER Path
		The file to test
#>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)]
        [Alias('FullName')]
        [string]
        $Path
    )

    [byte[]]$byte = get-content -Encoding byte -ReadCount 4 -TotalCount 4 -Path $Path

    if ($byte[0] -eq 0xef -and $byte[1] -eq 0xbb -and $byte[2] -eq 0xbf) { 'UTF8' }
    elseif ($byte[0] -eq 0x23 -and $byte[1] -eq 0x20 -and $byte[2] -eq 0x41 -and $byte[3] -eq 0x64) { 'UTF8' } #possibly with BOM
    elseif ($byte[0] -eq 0xfe -and $byte[1] -eq 0xff) { 'Unicode' }
    elseif ($byte[0] -eq 0 -and $byte[1] -eq 0 -and $byte[2] -eq 0xfe -and $byte[3] -eq 0xff) { 'UTF32' }
    elseif ($byte[0] -eq 0x2b -and $byte[1] -eq 0x2f -and $byte[2] -eq 0x76) { 'UTF7' }
    else
    {
        'Unknown, possible ASCII'
        write-warning ([string[]]($Byte | % { "`$byte[{0}] -eq $($_ |  Convert-ByteArrayToHexString)" -f $x++}) -join "`n")
    }
}

function Convert-ByteArrayToHexString
{
    ################################################################
    #.Synopsis
    # Returns a hex representation of a System.Byte[] array as
    # one or more strings. Hex format can be changed.
    #.Parameter ByteArray
    # System.Byte[] array of bytes to put into the file. If you
    # pipe this array in, you must pipe the [Ref] to the array.
    # Also accepts a single Byte object instead of Byte[].
    #.Parameter Width
    # Number of hex characters per line of output.
    #.Parameter Delimiter
    # How each pair of hex characters (each byte of input) will be
    # delimited from the next pair in the output. The default
    # looks like "0x41,0xFF,0xB9" but you could specify "\x" if
    # you want the output like "\x41\xFF\xB9" instead. You do
    # not have to worry about an extra comma, semicolon, colon
    # or tab appearing before each line of output. The default
    # value is ",0x".
    #.Parameter Prepend
    # An optional string you can prepend to each line of hex
    # output, perhaps like '$x += ' to paste into another
    # script, hence the single quotes.
    #.Parameter AddQuotes
    # A switch which will enclose each line in double-quotes.
    #.Example
    # [Byte[]] $x = 0x41,0x42,0x43,0x44
    # Convert-ByteArrayToHexString $x
    #
    # 0x41,0x42,0x43,0x44
    #.Example
    # [Byte[]] $x = 0x41,0x42,0x43,0x44
    # Convert-ByteArrayToHexString $x -width 2 -delimiter "\x" -addquotes
    #
    # "\x41\x42"
    # "\x43\x44"
    ################################################################
    [CmdletBinding()] Param (
        [Parameter(Mandatory = $True, ValueFromPipeline = $True)] [System.Byte[]] $ByteArray,
        [Parameter()] [Int] $Width = 10,
        [Parameter()] [String] $Delimiter = ",0x",
        [Parameter()] [String] $Prepend = "",
        [Parameter()] [Switch] $AddQuotes )

    if ($Width -lt 1) { $Width = 1 }
    if ($ByteArray.Length -eq 0) { Return }
    $FirstDelimiter = $Delimiter -Replace "^[\,\:\t]", ""
    $From = 0
    $To = $Width - 1
    Do
    {
        $String = [System.BitConverter]::ToString($ByteArray[$From..$To])
        $String = $FirstDelimiter + ($String -replace "\-", $Delimiter)
        if ($AddQuotes) { $String = '"' + $String + '"' }
        if ($Prepend -ne "") { $String = $Prepend + $String }
        $String
        $From += $Width
        $To += $Width
    } While ($From -lt $ByteArray.Length)
}
Describe "Verifying integrity of module files" {
    Context "Validating PS1 Script files" {
        $allFiles = Get-ChildItem -Path $moduleRoot -Recurse -Filter "*.ps1" | Where-Object {$_.FullName -NotLike "$moduleRoot\tests\*" -and $_.FullName -notmatch '(VstsTaskSdk)|(xml)|(tepp)'}

        foreach ($file in $allFiles)
        {
            $name = $file.FullName.Replace("$moduleRoot\", '')

            <# 		It "[$name] Should have UTF8 encoding" {
				Get-FileEncoding -Path $file.FullName | Should Be 'UTF8'
			} #>

            It "[$name] Should have no trailing space" {
                ($file | Select-String "\s$" | Where-Object { $_.Line.Trim().Length -gt 0} | Measure-Object).Count | Should Be 0
            }

            $tokens = $null
            $parseErrors = $null
            $ast = [System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$tokens, [ref]$parseErrors)

            It "[$name] Should have no syntax errors" {
                $parseErrors | Should Be $Null
            }

            foreach ($command in $global:BannedCommands)
            {
                if ($global:MayContainCommand["$command"] -notcontains $file.Name)
                {
                    It "[$name] Should not use $command" {
                        $tokens | Where-Object Text -EQ $command | Should Be $null
                    }
                }
            }

            <# It "[$name] Should not contain aliases" {
                $tokens | Where-Object TokenFlags -eq CommandName | Where-Object { Test-Path "alias:\$($_.Text)" } | Measure-Object | Select-Object -ExpandProperty Count | Should Be 0
            } #>
        }
    }

    Context "Validating help.txt help files" {
        $allFiles = Get-ChildItem -Path $moduleRoot -Recurse -Filter "*.help.txt" | Where-Object {$_.FullName -NotLike "$moduleRoot\tests\*" -and $_.FullName -notmatch '(VstsTaskSdk)|(xml)|(tepp)'}

        foreach ($file in $allFiles)
        {
            $name = $file.FullName.Replace("$moduleRoot\", '')

            <# 	It "[$name] Should have UTF8 encoding" {
				Get-FileEncoding -Path $file.FullName | Should Be 'UTF8'
			} #>

            It "[$name] Should have no trailing space" {
                ($file | Select-String "\s$" | Where-Object { $_.Line.Trim().Length -gt 0 } | Measure-Object).Count | Should Be 0
            }
        }
    }
}