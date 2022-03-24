# magic-startup-arch-sh
## What it does
This script allows to speed up the installation process
of your computer in case of a fresh installation of an operating system based on arch.

This script has been developed using an arch-based distro, therefore you should have at least pacman installed on your system.

> Please install pacman!!!  ᗧ···🍒···ᗣ 

Features:
- install packages from pacman
- install packages from aur
- install aur manager (yay)
- install suggested packages (default list coming from my dotfiles config files)
- use my personal dotfiles files


## Info on packages
| Pacman           | AUR             | Suggested Apps (dotfiles) |
| ---------------- | --------------- | ------------------------- |
| vlc              | obsidian        | alacritty                 |
| firefox          | zoom            | df                      |
| telegram-desktop | android-studio  | i3                        |
| code             | redshiftgui-bin | nano                        |
| feh              | otpclient| picom               |
| tlp              |                 |polybar|
| thermald         |                 |alsamixer|
| qpdfview         |                 |brightnessctl|
| python-pip                 |                 |maim|
| nitrogen                 |                 |xclip|
| neofetch                 |                 ||
| curl                 |                 ||
| bitwarden-cli                 |                 |                      |
| brave-browser | | |


## Usage
Make the script executable and run it.
```
chmod 755 magic-startup-arch.sh
./magic-startup-arch.sh
```
There will be a recap on what are you doing to install, **[make sure to have read the previous section](#what-it-does)!**

Remember: **you will need sudo access** to install everything.

## Options:
```
./magic-startup-arch.sh -h
-h --help:		show this message
--pacman:     install pacman packages
--aur:	      install packages with aur (including aur manager if not present)
--dotfiles:	  add my dotfiles (optionally: install reccomended packages)
--full:		    run the script performing all the above operations
```

## FAQ
Q: How to add other programs that needs to be installed by pacman / yay?
- You can customize each list by adding or removing entries in the script in the variables 'pacapps' and 'aurapps'.

Q: Can I use other separators than space character as you've done?
- No, each program is separated by a space: **DON'T** use any other separator.

Q: I wrote 'neofotch' but it doesn't install neofetch. What should I do? 
- You will need to know the exact name of the package.

**For instance**: if you want to install IntelliJ by using aur, you can't simply add "IntelliJ" to aurapps.

First, search what is the name of a proper IntelliJ package on aur; once you've figured out (it is "intellij-idea-ultimate-edition"), place this name enclosed with double quotes in the array of `aurapps` in the script.

In the end, you should have something like this:
```
aurapps=("sublime" "zoom" "intellij-idea-ultimate-edition")
```
Q: Where did you tested this script?
- EndeavourOS Linux x86_64 with bash 5.0.18, it should works great on Manjaro and arch too.


## Problems?
Just open an issue here: https://github.com/dag7dev/magic-startup-arch-sh/issues or send me a mail: it is free, and I will look at it for sure!


