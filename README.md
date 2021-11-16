# PS-Menu
Simple module to generate interactive console menus (like yeoman)

# Examples:

```powershell
$Options  = @("Option 1", "Option 2", "Option 3")
New-Menu -MenuItems $Options
```
 ![Example1](docs/example1.gif)

Example of a multi-select menu:

 ![Example2](docs/example2.gif)

 Example of a custom message:

![Example3](docs/Example3.gif)

# Installation

You can install it from the PowerShellGallery using PowerShellGet

```powershell
Install-Module PS-Menu
```
# Features

* Returns value of selected menu item
* Returns index of selected menu item (using `-ReturnIndex` switch)
* Allows multiple selections and returns an array (using `-MultiSelect` switch)
* Allows displaying a custom message with options
* Navigation with `up/down` arrows
* Navigation with `j/k` (vim style)
* Esc key quits the menu (`null` value returned)

# Contributing

* Source hosted at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]

Pull requests are very welcome! 
