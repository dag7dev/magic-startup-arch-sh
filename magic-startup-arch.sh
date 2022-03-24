#!/bin/bash

# dag7 - 2020

# This script will configure EndeavourOS (arch based) with custom settings
# Tested on: EndeavourOS Linux x86_64 with bash 5.0.18 - Manjaro Linux x86_64 with bash 5.1.8

# Run it with sudo to avoid errors.
########################################

pac_apps=("vlc" "firefox" "telegram-desktop" "code" "feh" "tlp" "thermald" "qpdfview" "python-pip" "thefuck" "nitrogen" "neofetch" "curl" "bitwarden-cli" "brave-browser")
aur_apps=("obsidian" "zoom" "android-studio" "redshiftgui-bin" "otpclient")
dotfiles_apps=("alacritty" "df" "i3" "nano" "pacman" "picom" "polybar" "yay" "alsamixer" "brightnessctl" "maim" "xclip")

# DECLARING FUNCTIONS
# return 1 if the OS doesn't have pacman 0 if it does
function has_cmd {
	result=`command -v $1`
	if [ -z "$result" ]; then
		return 1	# false
	else:
		return 0	# true
	fi

}

function print_opt {
	echo -ne "$1\t\t\t\t"
	if [ "$2" = false ] ; then
		echo "WON'T be installed"
	else
		echo "WILL be installed"
	fi
}

function print_list {
	
	# @params: flag, name before list element, array 
	if [ "$1" = true ] ; then
		elts=("$@")
		echo "$2:"

		# unset first two parameters
		unset 'elts[0]'
		unset 'elts[1]'
		unset 'elts[2]'

		# installing aur apps
		for element in ${elts[@]}; do
			echo "[$3] $element"
		done
		echo ""
	fi
}

function print_recap {
	echo "RECAP: "

	print_opt "PACM packages: " "$PACMAN"
	print_opt "AUR packages: " "$AUR"
	print_opt "Dotfiles: " "$DOTFILES"
	
	echo ""
	
	# printing pacman packages which are goin' to be installed
	print_list "$PACMAN" "Pacman packages" "PAC" "${pac_apps[@]}"
	print_list "$AUR" "AUR Packages" "AUR" "${aur_apps[@]}"
	
	echo "[Press [ENTER] to continue]"
	echo "[Press [CTRL+C] to quit]"

	read -p ""
}

function print_footer {
	echo "Brought to you with <3 by dag7 - the enemy of ennui"
}

function show_help {
	clear

	echo -e "magic-startup-arch - by dag7 \n"

	echo "Speed up your fresh-new-os-arch-based-pc with this script."

	echo -e "More info: https://github.com/dag7dev/magic-startup-arch-sh \n"

	echo "Options:"
	echo "-h --help:	show this message"
	echo "--pacman:	install pacman packages"
	echo "--aur:	install packages with aur (including aur manager)"
	echo "--dotfiles:	add my dotfiles in your home folder."
	echo "--full:		run the script performing all the operations "
}

function pac_install {
	if [[ "$HAS_PACMAN" -eq 1 ]]; then
		echo -e "You can't install 'pacman apps' without having pacman!\n"
	else
		for pacapp in "$@"; do
			echo ""
			echo "[INFO] Installing $pacapp ..."
			"yes" | sudo pacman -S $pacapp >> /dev/null
		done
	fi
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

has_cmd pacman
HAS_PACMAN=$?

has_cmd yay
HAS_YAY=$?

has_cmd git
HAS_GIT=$?

if [[ "$#" -lt 1 ]]; then
	show_help
	exit 0
fi

# Managing parameters
for option in "$@"; do
	case $option in
	"--full")
		PACMAN=true
		AUR=true
		DOTFILES=true
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
	  show_help
	  exit 0
	  ;;

	"--help")
	  show_help
	  exit 0
	  ;;
	esac
done

# PACMAN INSTALLER
# ================
if [ "$PACMAN" = true ]; then
	pac_install "${pac_apps[@]}"
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
	for aurapp in "${aur_apps[@]}"; do
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
		
		echo ""
		
		if [[ "$user_reply" == "Y" ]] || [[ "$user_reply" == "yes" ]] || [[ "$user_reply" == "y" ]]; then
			echo "Do you want to install reccomended dotfiles' programs (in this way i3 keybindings will works)?"
			print_list "$DOTFILES" "Dotfiles reccomended programs" "DOT" "${dotfiles_apps[@]}"
			read -p "[y/N]: " user_reply

			if [[ "$user_reply" == "Y" ]] || [[ "$user_reply" == "yes" ]] || [[ "$user_reply" == "y" ]]; then
				pac_install $dotfiles_apps
			fi

			# if backup dir / file exist, then remove them
			if [ -d "$HOME/.configbackup" ]; then
				rm -rf "$HOME/.configbackup"
			fi

			if [ -f "$HOME/.bashrcbackup" ]; then
				rm "$HOME/.bashrcbackup"
			fi

			# creates a backup
			cp -a "$HOME/.config" "$HOME/.configbackup"
			cp -a "$HOME/.bashrc" "$HOME/.bashrcbackup"

			# remove actual files			
			rm -rf "$HOME/.config"
			rm -rf "$HOME/.bashrc"
			
			# clone dotfiles
			git clone https://github.com/dag7dev/dotfiles.git "$HOME/tmp"
			
			# copy all dotfiles folder and pastes it into your HOME dir
			cp -a "$HOME/tmp/." "$HOME"
			
			# enable nano syntax highlight
			rm "$HOME/.nanorc"
			cp -a "$HOME/.nano/.nanorc" "$HOME"
			
			# remove un-needed folders
			rm -rf "$HOME/tmp"
			rm -rf "$HOME/.git"
			rm -rf "$HOME/README.md"
		fi

		read -p "Press [ENTER] to continue"
	fi
fi

echo ""
echo "Script has been executed successfully! Have a nice day / night! :)"
echo ""

print_footer
