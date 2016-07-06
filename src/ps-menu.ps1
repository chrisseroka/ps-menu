function DrawMenu {
    param ($menuItems, $menuPosition)
    [console]::CursorVisible=$false #prevents cursor flickering
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
    [console]::CursorVisible=$true
}

function Menu {
    param ([array]$menuItems)
    $vkeycode = 0
    $pos = 0
    $cur_pos = [System.Console]::CursorTop
    if ($menuItems.Length -gt 0)
	{
		DrawMenu $menuItems $pos
		While ($vkeycode -ne 13 -and $vkeycode -ne 27) {
			$press = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown")
			$vkeycode = $press.virtualkeycode
			If ($vkeycode -eq 38 -or $press.Character -eq 'k') {$pos--}
			If ($vkeycode -eq 40 -or $press.Character -eq 'j') {$pos++}
			if ($pos -lt 0) {$pos = 0}
			If ($vkeycode -eq 27) {$pos = -1 }
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
		$pos = -1
	}
	return $pos
}
