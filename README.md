# magic-startup-arch-sh
## What it does
This program allows you to speed up the installation process
of your pc in case of a fresh installation of the operating system.

Since this script has been developed using an arch-based distro
you should have at least pacman installed on your system.

> 🍒 Please install pacman!!! 🍒＼⍩⃝／

It works in three modes:
- pacman: it will install some programs using pacman.
- aur: it will install some programs using yay as aur manager. If it is not present it will be installed using pacman.
- alias: it will append to your .bashrc useful aliases which let you perform some easy operations using CLI.

The packages (for the unmodified script, the vanilla edition) are:
|Pacman apps|Aur apps|
|-----------|--------|
|vlc    |sublime     |
|firefox|zoom        |
|gimp   |intellij-idea-ultimate-edition|

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
-h:		show this message
-no-pacman:	it won't install pacman packages
-no-aur:	it won't install packages with aur (including aur manager)
-no-alias:	it won't add aliases in your .bashrc
-full:		it will run the script performing all the operations without recap
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

