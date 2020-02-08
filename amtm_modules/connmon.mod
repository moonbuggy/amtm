#!/bin/sh
#bof
connmon_installed(){
	scriptname=connmon
	scriptgrep=' SCRIPT_VERSION='
	if [ "$su" = 1 ]; then
		remoteurl="https://raw.githubusercontent.com/jackyaz/connmon/master/connmon.sh"
		grepcheck=jackyaz
	fi
	script_check
	printf "${GN_BG} j1${NC} %-9s%-21s%${COR}s\\n" "open" "connmon       $localver" " $upd"
	case_j1(){
		/jffs/scripts/connmon
		sleep 2
		show_amtm menu
	}
}
install_connmon(){
	p_e_l
	echo " This installs connmon - Internet connection monitoring"
	echo " on your router."
	echo
	echo " Author: Jack Yaz"
	echo " https://www.snbforums.com/threads/connmon-internet-connection-monitoring.56163/"
	c_d

	c_url "https://raw.githubusercontent.com/jackyaz/connmon/master/connmon.sh" -o "/jffs/scripts/connmon" && chmod 0755 /jffs/scripts/connmon && /jffs/scripts/connmon install
	sleep 2
	if [ -f /jffs/scripts/connmon ] && grep -q 'connmon startup' /jffs/scripts/services-start 2> /dev/null; then
		show_amtm " connmon installed"
	else
		am=;show_amtm " connmon installation failed"
	fi
}
#eof
