#!/bin/sh
#bof
stubby_installed(){
	scriptname='Stubby DNS'
	localVother="v$(grep -m1 "^VERSION=" "$scriptloc" | sed -e 's/VERSION=//;s/"//g')"
	if [ "$su" = 1 ]; then
		remoteurl="https://raw.githubusercontent.com/Xentrk/Stubby-Installer-Asuswrt-Merlin/master/install_stubby.sh"
		remoteVother="v$(c_url "$remoteurl" | grep -m1 "^VERSION=" | sed -e 's/VERSION=//;s/"//g')"
		grepcheck=Xentrk
	fi
	script_check
	printf "${GN_BG} sd${NC} %-9s%-21s%${COR}s\\n" "open" "Stubby DNS    $localver" " $upd"
	case_sd(){
		/jffs/scripts/install_stubby.sh
		sleep 2
		show_amtm menu
	}
}
install_stubby(){
	p_e_l
	echo " This installs Stubby DNS Privacy Daemon"
	echo " on your router."
	echo
	echo " Authors: Xentrk, Adamm"
	echo " https://www.snbforums.com/threads/stubby-installer-asuswrt-merlin.49469/"
	c_d

	if [ -d "/jffs/dnscrypt" ] || [ -f /opt/sbin/dnscrypt-proxy ]; then
		am=;show_amtm " Stubby DNS install failed. It is not\\n compatible with dnscrypt installer which\\n is installed on this router"
	fi

	c_url "https://raw.githubusercontent.com/Xentrk/Stubby-Installer-Asuswrt-Merlin/master/install_stubby.sh" -o "/jffs/scripts/install_stubby.sh" && chmod 755 /jffs/scripts/install_stubby.sh && sh /jffs/scripts/install_stubby.sh
	sleep 2
	if [ -f /jffs/scripts/install_stubby.sh ] && [ -f /opt/etc/stubby/stubby.yml ]; then
		show_amtm " Stubby DNS installed"
	else
		am=;show_amtm" Stubby DNS installation failed"
	fi
}
#eof
