# magic-startup-arch-sh
## What it does
This program allows you to speed up the installation process
of your pc in case of a fresh installation of the operating system.

Since this script has been developed using an arch-based distro
you should have at least pacman installed on your system.

> 🍒 Please install pacman!!! 🍒＼⍩⃝／

It can install some packages from pacman and aur, and add my config file in your arch installation.

The packages (for the unmodified script, the vanilla edition) are:
| Pacman           | AUR            |
| ---------------- | -------------- |
| vlc              | obsidian       |
| firefox          | zoom           |
| telegram-desktop | android-studio |
| code             | redshifgui-bin |
| feh              |                |
| tlp              |                |
| thermald         |                |

Optional packages:

| Dotfiles Suggested Apps |
| ----------------------- |
| alacritty               |
| curl                    |
| df                      |
| i3                      |
| nano                    |
| neofetch                |
| picom                   |
| polybar                 |
| alsamixer               |
| brightnessctl           |
| maim                    |
| nitrogen                |
| xclip                   |



## Usage
Make the script executable and run it.

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
-h --help:		show this message
--pacman: install pacman packages
--aur:	install packages with aur (including aur manager)
--dotfiles:	add my dotfiles
--full:		run the script performing all the above operations
```

## How to add other programs that needs to be installed by pacman / yay?
You can customize each list by adding or removing entries in the script in the variables 'pacapps' and 'aurapps'.

Each program is separated by a space: **DON'T** use any other separator.

**NOTE:** you will need to know and write exactly the name of the package as you would do it by typing by hand on CLI.


***For instance***: if you want to install IntelliJ by using aur, you can't simply add "IntelliJ" to aurapps.

First search what is the name of a proper IntelliJ package on aur, once you have figured out what it is (in our case is "intellij-idea-ultimate-edition"), place this name enclosed with double quotes in the array of aurapps in the script.

```
aurapps=("sublime" "zoom")
```
will become
```
aurapps=("sublime" "zoom" "intellij-idea-ultimate-edition")
```

## Problems?
Just open an issue here: https://github.com/dag7dev/magic-startup-arch-sh/issues
or send me a mail.

It is free, it doesn't take you time, moreover, I will look at it for sure!

What else?☕ 

## Where did you tested this script?
Tested on: EndeavourOS Linux x86_64 with bash 5.0.18 

