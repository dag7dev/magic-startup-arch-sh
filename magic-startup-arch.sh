#!/bin/bash

# This script will configure EndeavourOS (arch based) with custom settings
# Tested on: EndeavourOS Linux x86_64 with bash 5.0.18 

########################################

# DECLARATING FUNCTIONS
# return 1 if the operating system doesn't have pacman, 0 if it does
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
	if [ "$NO_PACMAN" = false ] ; then
		echo "WILL be installed"
	else
		echo "WON'T be installed"
	fi
	
	echo -ne "AUR packages: \t\t"
	if [ "$NO_AUR" = false ] ; then
		echo "WILL be installed"
	else
		echo "WON'T be installed"
	fi
	
	
	echo -ne "Alias: \t\t\t"
	if [ "$NO_ALIAS" = false ] ; then
		echo "WILL be added"
	else
		echo "WON'T be added"
	fi
	
	echo ""
	
	# printing pacman packages which are goin' to be installed
	if [ "$NO_PACMAN" = false ] ; then
		echo "Pacman packages:"
		# installing aur apps
		for pacapp in ${pacapps[@]}; do
			echo "[PACMAN] $pacapp"
		done
		echo ""
	fi
	
	# printing aur packages which are goin' to be installed	
	if [ "$NO_AUR" = false ] ; then
		echo "Aur packages:"
		for aurapp in ${aurapps[@]}; do
			echo "[AUR] $aurapp"
		done
		echo ""
	fi
	
	echo "[Press [ENTER] to continue]"
	echo "[Press [CTRL+C] to quit]"
	echo ""

	read -p ""
}

function printfooter {
	echo "Brought to you with <3 by dag7 - the nemesis of ennui"
}

function showhelp {
	clear

	echo -e "magic-startup-arch - by dag7 \n"

	echo "Speed up your fresh-new-os-arch-based-pc with this script."

	echo -e "More info: github.com/dag7dev/magic-startup-arch-sh \n"

	echo "Options:"
	echo "-h:		show this message"
	echo "-no-pacman:	it won't install pacman packages"
	echo "-no-aur:	it won't install packages with aur (including aur manager)"
	echo "-no-alias:	it won't add aliases in your .bashrc"
	echo "-full:		it will run the script performing all the operations "
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
NO_AUR=false
NO_ALIAS=false
NO_PACMAN=false

hascmd pacman
HAS_PACMAN=$?

hascmd yay
HAS_YAY=$?

pacapps=("vlc" "firefox" "gimp")
aurapps=("sublime" "zoom" "intellij-idea-ultimate-edition")

# Managing parameters
for option in "$@"; do
	case $option in
	"-full")
		FULL=true
	  ;;
	
	"-smarmella")
		FULL=true
	  ;;

	"-no-pacman")
	  NO_PACMAN=true
	  ;;
	
	"-no-aur")
	  NO_AUR=true
	  ;;
	
	"-no-alias")
	  NO_ALIAS=true
	  ;;

	"-h")
	  showhelp
	  exit 0
	  ;;
	esac
done

# recap installation
if [ "$FULL" = true ] ; then
	NO_PACMAN=false
	NO_AUR=false
	NO_ALIAS=false
	NO_PACMAN=false

	echo "Full activated! Skipping recap and everything else..."
	echo ""

else
	print_recap
fi


# Setting aliases
# ===============
if [ "$NO_ALIAS" = false ]; then
	#echo "alias update-grub='grub-mkconfig -o /boot/grub/grub.cfg'" 	# this could cause problems if update-grub is already present
	
	if [ -z "$HOME" ]; then
		echo "[ERROR] HOME is not set. Can't add aliases!"
	else
		# if the user has PACMAN (he should) it will install useful aliases
		if [[ "$HAS_PACMAN" -eq 0 ]]; then
			echo $'alias inst=\'sudo pacman -S $1\'' >> $HOME/.bashrc
			echo $'alias uninst=\'sudo pacman -R $1\'' >> $HOME/.bashrc
			echo $'alias update=\'sudo pacman -Syu\'' >> $HOME/.bashrc
			
			echo $'alias instpkg=\'sudo pacman -U $1\'' >> $HOME/.bashrc
		fi

		# if the user has YAY it will install useful aliases
		if [[ "$HAS_YAY" -eq 0 ]]; then
			echo $'alias aurupd=\'yay -Syu\'' >> $HOME/.bashrc
			echo $'alias aurinst=\'yay -S $1\'' >> $HOME/.bashrc
			echo $'alias aursearch=\'yay -Si $1\'' >> $HOME/.bashrc
			echo $'alias aurremove=\'yay -Rns $1\'' >> $HOME/.bashrc
		fi
		# Reload current bashrc to allow usage of aliases
		. ~/.bashrc
	fi
fi



# PACMAN INSTALLER
# ================
if [ "$NO_PACMAN" = false ]; then
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
if [ "$NO_AUR" = false ]; then
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

echo ""
echo "Script has been executed successfully! Have a nice day / night! :)"
echo ""

printfooter