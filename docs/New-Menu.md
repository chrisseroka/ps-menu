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
New-Menu [[-MenuItems] <Array>] [-ReturnIndex] [-MultiSelect] [[-Message] <String>] [<CommonParameters>]
```

## DESCRIPTION
This module allows you to generate simple single or multiselect text based menus. Arrow keys can be used for navigation or you can use j/k (Vim style).

## EXAMPLES

### Example 1
```powershell
PS C:\> New-Menu -MenuItems "Option 1","Option 2","Option 3"
  Option 1
> Option 2
  Option 3
```

The above example would return "Option 2" as a string.

### Example 2
```powershell
PS C:\> New-Menu -MenuItems "Option 1","Option 2","Option 3" -MultiSelect
  [x] Option 1
  [ ] Option 2
> [x] Option 3
```

The above example would return "Option 1" and "Option 3" as an array of strings.

### Example 3
```powershell
PS C:\> $Msg = "Please choose from the below"
PS C:\> New-Menu -MenuItems "Option 1","Option 2","Option 3" -Message $Msg
  Option 1
> Option 2
  Option 3
```

The above example would show a custom message and return "Option 2" as a string. 

### Example 4
```powershell
PS C:\> New-Menu -MenuItems "Option 1","Option 2","Option 3" -ReturnIndex
  Option 1
> Option 2
  Option 3
```

The above example would return "2" as an integer.

## PARAMETERS

### -MenuItems
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

### -Message
A message shown to the user when selecting an option.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MultiSelect
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
