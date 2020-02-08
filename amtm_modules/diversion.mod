#!/bin/sh
#bof
diversion_installed(){
	atii=1
	if [ -s "$divconf" ]; then
		divver="$(grep "thisVERSION=" "$divconf" | sed -e 's/thisVERSION=//')"
		divMver="$(grep "thisM_VERSION=" "$divconf" | sed -e 's/thisM_VERSION=//')"
		[ "$divMver" ] && divver="${divver}.$divMver" || divver=$divver
	fi
	localver="v$divver"
	upd="${E_BG}${NC}$localver"
	if [ "$su" = 1 ]; then
		case "$release" in
			*XX*) 	remoteurl="http://diversion.test/diversion";;
			*) 		remoteurl="https://diversion.ch/diversion";;
		esac
		if c_url "$remoteurl/diversion.info" | grep -q "^S_VERSION=\|^S_M_VERSION="; then
			remotever="$(c_url "$remoteurl/diversion.info" | grep "^S_VERSION=\|^S_M_VERSION=" | sed -e 's/.*_VERSION=//')"
			S_VERSION=$(echo $remotever | awk '{print $1}')
			S_M_VERSION=$(echo $remotever | awk '{print $2}')
			[ "$S_M_VERSION" ] && remotever="v${S_VERSION}.$S_M_VERSION" || remotever="v$S_VERSION"
			upd="${GN_BG}v$divver${NC}"
			if [ "$localver" != "$remotever" ]; then
				localver="v$divver"
				upd="${E_BG}-> $remotever${NC}"
				suUpd=1
			else
				localmd5="$(md5sum "$scriptloc" | awk '{print $1}')"
				remotemd5="$(c_url "$remoteurl/$S_VERSION/diversion" | md5sum | awk '{print $1}')"
				if [ "$localmd5" != "$remotemd5" ]; then
					localver="v$divver"
					upd="${E_BG}-> min upd${NC}"
					suUpd=1
				else
					localver=
				fi
			fi
		else
			upd=" ${E_BG}upd err${NC}"
			updErr=1
		fi
	else
		localver=
	fi
	printf "${GN_BG} 1 ${NC} %-9s%-21s%${COR}s\\n" "open" "Diversion     $localver" " $upd"
	case_1(){
		trap trap_ctrl 2
		trap_ctrl(){
			sleep 2
			exec "$0"
		}
		/opt/bin/diversion
		trap - 2
		sleep 2
		show_amtm menu
	}
}
install_diversion(){
	p_e_l
	echo " This installs Diversion - the Router Adblocker"
	echo " on your router."
	echo
	echo " Author: thelonelycoder"
	echo " https://www.snbforums.com/threads/diversion-the-router-adblocker.48538/"
	c_d
	case "$release" in
		*XX*) 	remoteurl="http://diversion.test/install";;
		*) 		remoteurl="https://diversion.ch/install";;
	esac
	c_url -Os "$remoteurl" && sh install
	sleep 2
	if [ -f /opt/bin/diversion ]; then
		show_amtm " Diversion installed"
	else
		am=;show_amtm " Diversion installation failed"
	fi
}
#eof
