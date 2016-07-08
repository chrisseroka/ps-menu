function DrawMenu {
    param ($menuItems, $menuPosition)
    $l = $menuItems.length
    for ($i = 0; $i -le $l;$i++) {
		if ($menuItems[$i] -ne $null){
			if ($i -eq $menuPosition) {
				Write-Host "> $($menuItems[$i])" -ForegroundColor Green
			} else {
				Write-Host "  $($menuItems[$i])"
			}
		}
    }
}

function Menu {
    param ([array]$menuItems, [switch]$ReturnIndex=$false)
    $vkeycode = 0
    $pos = 0
    $cur_pos = [System.Console]::CursorTop
    [console]::CursorVisible=$false #prevents cursor flickering
    if ($menuItems.Length -gt 0)
	{
		DrawMenu $menuItems $pos
		While ($vkeycode -ne 13 -and $vkeycode -ne 27) {
			$press = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown")
			$vkeycode = $press.virtualkeycode
			If ($vkeycode -eq 38 -or $press.Character -eq 'k') {$pos--}
			If ($vkeycode -eq 40 -or $press.Character -eq 'j') {$pos++}
			if ($pos -lt 0) {$pos = 0}
			If ($vkeycode -eq 27) {$pos = $null }
			if ($pos -ge $menuItems.length) {$pos = $menuItems.length -1}
			if ($vkeycode -ne 27)
			{
				[System.Console]::SetCursorPosition(0,$cur_pos)
				DrawMenu $menuItems $pos
			}
		}
	}
	else 
	{
		$pos = $null
	}
    [console]::CursorVisible=$true

    if ($pos -eq $null)
	{
		return $null
	}
    elseif ($ReturnIndex -eq $false)
	{
		return $menuItems[$pos]
	}
	else 
	{
		return $pos
	}
}
