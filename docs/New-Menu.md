---
external help file: ps-menu-help.xml
Module Name: ps-menu
online version:
schema: 2.0.0
---

# New-Menu

## SYNOPSIS
Simple module to generate interactive console menus (like yeoman)

## SYNTAX

```
New-Menu [[-menuItems] <Array>] [-ReturnIndex] [-Multiselect]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> $Options = @("Option 1","Option 2","Option 3")
PS C:\> New-Menu -MenuItems $Options
  Option 1
> Option 2
  Option 3
```
The above example would return "Option 2" as a string.


### Example 2
```powershell
PS C:\> $Options = @("Option 1","Option 2","Option 3")
PS C:\> New-Menu -MenuItems $Options -MultiSelect
  [x] Option 1
  [ ] Option 2
> [x] Option 3
```
The above example would return "Option 1" and "Option 3" as an array of strings.

### Example 3
```powershell
PS C:\> $Options = @("Option 1","Option 2","Option 3")
PS C:\> New-Menu -MenuItems $Options
  Option 1
> Option 2
  Option 3
```
The above example would return "1" as an integer.


## PARAMETERS

### -menuItems
Returns value of selected menu item or an array of items if used with the MultiSelect parameter.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Multiselect
Allows the user to select multiple items from the list and returns an array.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReturnIndex
Rather than returning the value selected, this parameter will instead return the index of the selected menu item/s.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
