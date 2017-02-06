function DrawMenu {
    param ($menuItems, $menuPosition, $Multiselect, $selection)
    $l = $menuItems.length
    for ($i = 0; $i -le $l;$i++) {
		if ($menuItems[$i] -ne $null){
			$item = $menuItems[$i]
			if ($Multiselect)
			{
				if ($selection -contains $i){
					$item = '[x] ' + $item
				}
				else {
					$item = '[ ] ' + $item
				}
			}
			if ($i -eq $menuPosition) {
				Write-Host "> $($item)" -ForegroundColor Green
			} else {
				Write-Host "  $($item)"
			}
		}
    }
}

function Toggle-Selection {
	param ($pos, [array]$selection)
	if ($selection -contains $pos){ 
		$result = $selection | where {$_ -ne $pos}
	}
	else {
		$selection += $pos
		$result = $selection
	}
	$result
}

function Menu {
    param ([array]$menuItems, [switch]$ReturnIndex=$false, [switch]$Multiselect)
    $vkeycode = 0
    $pos = 0
    $selection = @()
    $cur_pos = [System.Console]::CursorTop
    [console]::CursorVisible=$false #prevents cursor flickering
    if ($menuItems.Length -gt 0)
	{
		DrawMenu $menuItems $pos $Multiselect $selection
		While ($vkeycode -ne 13 -and $vkeycode -ne 27) {
			$press = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown")
			$vkeycode = $press.virtualkeycode
			If ($vkeycode -eq 38 -or $press.Character -eq 'k') {$pos--}
			If ($vkeycode -eq 40 -or $press.Character -eq 'j') {$pos++}
			If ($press.Character -eq ' ') { $selection = Toggle-Selection $pos $selection }
			if ($pos -lt 0) {$pos = 0}
			If ($vkeycode -eq 27) {$pos = $null }
			if ($pos -ge $menuItems.length) {$pos = $menuItems.length -1}
			if ($vkeycode -ne 27)
			{
				[System.Console]::SetCursorPosition(0,$cur_pos)
				DrawMenu $menuItems $pos $Multiselect $selection
			}
		}
	}
	else 
	{
		$pos = $null
	}
    [console]::CursorVisible=$true

    if ($ReturnIndex -eq $false -and $pos -ne $null)
	{
		if ($Multiselect){
			return $menuItems[$selection]
		}
		else {
			return $menuItems[$pos]
		}
	}
	else 
	{
		if ($Multiselect){
			return $selection
		}
		else {
			return $pos
		}
	}
}
