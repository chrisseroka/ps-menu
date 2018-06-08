function Switch-PSSelection
{
    [cmdletbinding()]
    param ($pos, [array]$selection)
    if ($selection -contains $pos)
    {
        $result = $selection | Where-Object {$_ -ne $pos}
    }
    else
    {
        $selection += $pos
        $result = $selection
    }
    return $result
}