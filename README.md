# magic-startup-arch-sh
## What it does?
This program allow you to speed up the installation process
of your pc in case of a fresh installation of the operating system.

Since this script has been developed using an arch-based distro
you should have at least pacman installed on your system.

You will face issue otherwise.

> 🍒 Please install pacman!!! 🍒＼⍩⃝／

It works in three modes:
- pacman: it will install some programs using pacman.
- aur: it will install some programs using yay as aur manager. If it is not present it will be installed using pacman.
- alias: it will append to your .bashrc useful aliases which let you perform some easy operations using CLI.

You can customize each list by adding or removing entries in the script in the variables pacapps and aurapps.

The packages (for the unmodified script, the vanilla edition) are:
|Pacman apps|Aur apps|
|-----------|--------|
|vlc    |sublime     |
|firefox|zoom        |
|gimp   |intellij-idea-ultimate-edition |

## Usage
Just run it.

```
chmod 755 magic-startup-arch.sh
./magic-startup-arch.sh
```
There will be a recap on what are you doing to do.

Make sure to have read the previous paragraph!

Remember: you will need sudo access to install app.

## Options:
```
./magic-startup-arch.sh -h
-h:		show this message
-no-pacman:	it won't install pacman packages
-no-aur:	it won't install packages with aur (including aur manager)
-no-alias:	it won't add aliases in your .bashrc
-full:		it will run the script performing all the operations without recap
```
## Problems?
Just open an issue here: https://github.com/dag7dev/magic-startup-arch-sh/issues

It is free, it doesn't take you time, moreover I will look at it for sure!

What else?☕ 
