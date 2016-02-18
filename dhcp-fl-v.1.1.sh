#!/bin/bash
# This script stop, clean the dhcpd.leases files and restart the DHCP service.
# Script created by Claudio Proietti v. 1.1 created on 17/02/2016

# Script description
echo "$(tput setaf 5)This script stop, clean the dhcpd.leases files and restart the DHCP service."
echo -e "Script created by Claudio Proietti for Gambit Research LTD$(tput sgr 0)\n"

function main ()
{
# This is the main function that show the menu and allows the user to make a choice
	
	# declared integer for user's choice
	declare -i OPT
	while true
	do
		menu
		# readed input from keyboard
		read OPT
		
		# error handling if, it checks if the user insert something different from a number between 1 and 6
		if [ $OPT -ge 1 -a $OPT -le 6 ] 
		then
		# case to select the right option from 1 to 6
			case $OPT in 
				1 ) start-dhcp
				;;
				2 ) stop-dhcp
				;;
				3 ) restart-dhcp
				;;
				4 ) flush-dhcp
				;;
				5 ) fullservice-dhcp
				echo -e "$(tput setaf 7)$(tput setab 0)Thank you for using this script!$(tput sgr 0)\n"
				break
				;;
				6 ) echo -e "$(tput setaf 7)$(tput setab 0)Thank you for using this script!$(tput sgr 0)\n"
				break
				;;
			esac
		else
			echo $OPT
			clear
			echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
		fi

	done

}

function menu () 
{
# The scope of this function is only to show the contextual menu
	echo -e "These are the available options:\n"
	echo "1 - Start DHCP Service"
	echo "2 - Stop DHCP Service" 
	echo "3 - Restart (Stop and Start) DHCPD Service"
	echo "4 - Free DHCP Pool (removes dhcps.leases file)"
	echo -e "\n5 - FULL SERVICE (stop, remove dhcpd.leases file, start the DHCP service and exit the script)"
	echo -e "\n6 - Exit the script\n"
	echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"	
}

function start-dhcp ()
{
# This function start the DHCPD Service
	start isc-dhcp-server
	echo -e "$(tput setaf 0)$(tput setab 2)DHCP SERVICE STARTED!$(tput sgr 0)\n"
}

function stop-dhcp ()
{
# This function stop the DHCPD Service
	stop isc-dhcp-server
	echo -e "$(tput setaf 0)$(tput setab 2)DHCP SERVICE STOPPED!$(tput sgr 0)\n"
}

function restart-dhcp ()
{
# This function restart the DHCPD Service
	restart isc-dhcp-server
	echo -e "$(tput setaf 0)$(tput setab 2)DHCP SERVICE RESTARTED!$(tput sgr 0)\n"
}

function flush-dhcp ()
{
# This function delete every file in the directory /var/lib/dhcp/
# normally the only files contained in that directory are
# dhcpd.leases and a temporary file used by the DHCPD service
	rm /var/lib/dhcp/*
	echo -e "$(tput setaf 0)$(tput setab 2)DHCP LEASE FILE DELETED!$(tput sgr 0)\n"
}

function fullservice-dhcp ()
{
# This function should call in sequence stop-dhcp, flush-dhcp and start-dhcp functions
	stop-dhcp
	flush-dhcp
	start-dhcp
	echo -e "$(tput setaf 0)$(tput setab 2)FULL SERVICE EXECUTED!$(tput sgr 0)\n" 
}

# Call to the main function
main
