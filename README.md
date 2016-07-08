# PS-Menu
Simple module to generate interactive console menus (like yeoman)

# Examples:

```powershell
menu @("option 1", "option 2", "option 3")
```
 ![Example](https://github.com/chrisseroka/ps-menu/raw/master/docs/example1.gif)

More useful example:

 ![Example](https://github.com/chrisseroka/ps-menu/raw/master/docs/example2.gif)

# Installation

You can install it from the PowerShellGallery using PowerShellGet

```powershell
Install-Module PS-Menu
```
# Features

* Returns value of selected menu item
* Returns index of selected menu item (using `-ReturnIndex` switch)
* Navigation with `up/down` arrows
* Navigation with `j/k` (vim style)
* Esc key quits the menu (`null` value returned)

# Contributing

* Source hosted at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]

Pull requests are very welcome! 
