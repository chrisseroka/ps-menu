
function Show-PSMenu
{
    param ([array]$menuItems
        , [switch]$ReturnIndex = $false
        , [switch]$MultiSelect)
    $vkeycode                = 0
    $pos                     = 0
    $selection               = @()
    $cur_pos                 = [System.Console]::CursorTop
    [console]::CursorVisible = $false #prevents cursor flickering


    if ($menuItems.Length -gt 0)
    {
        Write-PSMenu -MenuItems $menuItems -MenuPosition $pos -MultiSelect:$Multiselect -Selection $selection
        While ($vkeycode -ne 13 -and $vkeycode -ne 27)
        {
            $press    = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown")
            $vkeycode = $press.virtualkeycode
            If ($vkeycode -eq 38 -or $press.Character -eq 'k') {$pos--}
            If ($vkeycode -eq 40 -or $press.Character -eq 'j') {$pos++}
            If ($press.Character -eq ' ')                      { $selection = Switch-PSSelection $pos $selection }
            if ($pos -lt 0)                                    {$pos = 0}
            If ($vkeycode -eq 27)                              {$pos = $null }
            if ($pos -ge @($menuItems).Count)                  {$pos = @($menuItems).count - 1}

            if ($vkeycode -ne 27)
            {
                [System.Console]::SetCursorPosition(0, $cur_pos)
                Write-PSMenu -MenuItems $menuItems -MenuPosition $pos -MultiSelect:$Multiselect -Selection $selection
            }
        }
    }
    else
    {
        $pos = $null
    }
    [console]::CursorVisible = $true

    if ($ReturnIndex -eq $false -and $pos -ne $null)
    {
        if ($Multiselect)
        {
            return $menuItems[$selection]
        }
        else
        {
            return $menuItems[$pos]
        }
    }
    else
    {
        if ($Multiselect)
        {
            return $selection
        }
        else
        {
            return $pos
        }
    }
}