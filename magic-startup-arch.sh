#!/bin/bash

# dag7 - 2020

# This script will configure EndeavourOS (arch based) with custom settings
# Tested on: EndeavourOS Linux x86_64 with bash 5.0.18 

# Run it with sudo to avoid errors.
########################################

pacapps=("vlc" "firefox" "telegram-desktop" "code" "feh" "tlp" "thermald")
aurapps=("obsidian" "zoom" "android-studio" "redshiftgui-bin")

# DECLARING FUNCTIONS
# return 1 if the OS doesn't have pacman, 0 if it does
function hascmd {
	result=`command -v $1`
	if [ -z "$result" ]; then
		return 1	# false
	else:
		return 0	# true
	fi

}

function print_recap {
	echo "RECAP: "

	echo -ne "Pacman packages: \t"
	if [ "$PACMAN" = false ] ; then
		echo "WON'T be installed"
	else
		echo "WILL be installed"
	fi
	
	echo -ne "AUR packages: \t\t"
	if [ "$AUR" = false ] ; then
		echo "WON'T be installed"
	else
		echo "WILL be installed"
	fi
	
	echo -ne "Dotfiles: \t\t"
	if [ "$DOTFILES" = false ] ; then
		echo "WON'T be downloaded"
	else
		echo "WILL be downloaded"
	fi


	echo ""
	
	# printing pacman packages which are goin' to be installed
	if [ "$PACMAN" = true ] ; then
		echo "Pacman packages:"
		# installing aur apps
		for pacapp in ${pacapps[@]}; do
			echo "[PACMAN] $pacapp"
		done
		echo ""
	fi
	
	# printing aur packages which are goin' to be installed	
	if [ "$AUR" = true ] ; then
		echo "Aur packages:"
		for aurapp in ${aurapps[@]}; do
			echo "[AUR] $aurapp"
		done
		echo ""
	fi
	
	echo "[Press [ENTER] to continue]"
	echo "[Press [CTRL+C] to quit]"

	read -p ""
}

function printfooter {
	echo "Brought to you with <3 by dag7 - the enemy of ennui"
}

function showhelp {
	clear

	echo -e "magic-startup-arch - by dag7 \n"

	echo "Speed up your fresh-new-os-arch-based-pc with this script."

	echo -e "More info: github.com/dag7dev/magic-startup-arch-sh \n"

	echo "Options:"
	echo "-h --help:	show this message"
	echo "--pacman:	install pacman packages"
	echo "--aur:	install packages with aur (including aur manager)"
	echo "--dotfiles:	add my dotfiles in your home folder."
	echo "--full:		run the script performing all the operations "
	echo -e "\t\twithout recap\n"

}

########################################

# Header
clear

echo "    magic-startup-arch    "
echo "         by dag7          "
echo ""

# setting variables
FULL=false
AUR=false
PACMAN=false
DOTFILES=false

hascmd pacman
HAS_PACMAN=$?

hascmd yay
HAS_YAY=$?

hascmd git
HAS_GIT=$?

if [[ "$#" -lt 1 ]]; then
	showhelp
	exit 0
fi

# Managing parameters
for option in "$@"; do
	case $option in
	"--full")
		FULL=true
	  ;;
	
	"--smarmella")
		FULL=true
	  ;;

	"--pacman")
	  PACMAN=true
	  ;;
	
	"--aur")
	  AUR=true
	  ;;
	
	"--dotfiles")
	  DOTFILES=true
	  ;;

	"-h")
	  showhelp
	  exit 0
	  ;;

	"--help")
	  showhelp
	  exit 0
	  ;;
	esac
done

# recap installation
if [ "$FULL" = true ] ; then
	PACMAN=true
	AUR=true
	DOTFILES=true

	echo "Full activated! Skipping recap and everything else..."
	echo ""

else
	print_recap
fi


# PACMAN INSTALLER
# ================
if [ "$PACMAN" = true ]; then
	# preliminary operation: checking if pacman is installed
	if [[ "$HAS_PACMAN" -eq 1 ]]; then
		echo -e "You can't install 'pacman apps' without having pacman!\n"
	else
		for pacapp in "${pacapps[@]}"; do
			echo ""
			echo "[INFO] Installing $pacapp ..."
			"yes" | sudo pacman -S $pacapp >> /dev/null
		done
	fi
fi

# AUR INSTALLER
# =============
if [ "$AUR" = true ]; then
	# preliminary operation: checking if yay is installed
	if [[ "$HAS_YAY" -eq 1 ]]; then
		echo "[WARNING] Error! Yay is not present! Installing yay..."
		"yes" | sudo pacman -S yay >> /dev/null
	fi

	# installing aur apps
	for aurapp in "${aurapps[@]}"; do
		echo ""
		echo "[INFO] Installing $aurapp ..."
		yay -S --noconfirm $aurapp >> /dev/null
	done
fi

# DOTFILES INSTALLER
# ================
if [ "$DOTFILES" = true ]; then
	if [[ "$HAS_GIT" -eq 1 ]]; then
		echo -e "You can't have my dotfiles without having git!\n"
	else
		echo "WARNING! This may OVERWRITE your dotfiles config. A backup could be found in .configbackup and .bashrcbackup. Are you sure?"
		read -p "[y/N]: " user_reply

		if [[ "$user_reply" == "Y" ]] || [[ "$user_reply" == "yes" ]] || [[ "$user_reply" == "y" ]]; then
			# creates a backup
			cp -a "$HOME/.config" "$HOME/.configbackup"
			cp -a "$HOME/.bashrc" "$HOME/.bashrcbackup"

			# remove actual files			
			rm -rf "$HOME/.config"
			rm -rf "$HOME/.bashrc"
			
			# clon dotfiles
			git clone https://github.com/dag7dev/dotfiles.git "$HOME/tmp"
			rm "$HOME/tmp/README.md"

			# copy all dotfiles folder and pastes it into your HOME dir
			cp -a "$HOME/tmp/." "$HOME"
			
			# enable nano syntax highlight
			rm "$HOME/.nanorc"
			cp -a "$HOME/.nano/.nanorc" "$HOME"
			
			# remove un-needed folders
			rm -rf "$HOME/tmp"
			rm -rf "$HOME/.git"
		fi

		read -p "Press [ENTER] to continue"
	fi
fi

clear

echo ""
echo "Script has been executed successfully! Have a nice day / night! :)"
echo ""

printfooter
