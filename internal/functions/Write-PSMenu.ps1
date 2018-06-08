function Write-PSMenu
{
    [cmdletbinding()]
    param (
          [Object[]]$MenuItems
        , [int]$MenuPosition
        , [Switch]$Multiselect
        , [Object[]]$Selection
    )
    $l = @($MenuItems).Count
    if ($($MenuItems).Count -eq 0)
    {
        return
    }

    for ($i = 0; $i -lt $l; $i++)
    {
        #if ($menuItems[$i] -ne $null)
        $item = $menuItems[$i]
        if ($Multiselect)
        {
            if ($selection -contains $i)
            {
                $item = '[x] ' + $item
            }
            else
            {
                $item = '[ ] ' + $item
            }
        }
        if ($i -eq $menuPosition)
        {
            Write-Host "> $($item)" -ForegroundColor Green
        }
        else
        {
            Write-Host "  $($item)"
        }

    }
}
