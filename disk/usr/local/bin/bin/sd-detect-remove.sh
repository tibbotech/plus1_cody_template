#!/bin/bash
#---version:21.03.23-0.0.1

#--------------------------------------------------------------------
# This script should be copied into /usr/local/bin
# Dependencies:
#   /etc/udev/rules.d/detect.rules
#   /etc/systemd/system/sd-detect@.service
#--------------------------------------------------------------------
# This script is run AFTER 'sd-detect@.service'
#--------------------------------------------------------------------
# REMARK: this script is written based on 'usb-mount.sh'
#--------------------------------------------------------------------

#---ENVIRONMENT VARIABLES
etc_dir=/etc
dev_dir=/dev
usr_dir=/usr
bin_dir=/bin
media_dir=/media
sbin_dir=/sbin
usr_bin_dir=${usr_dir}/bin
usr_local_bin_dir=${usr_dir}/local/bin

regex_pattern="mmcblk*p*"


#---INPUT ARGS
devpart_in=${1}
devfullpath_in="${dev_dir}/${devpart_in}"



#---COLORS CONSTANTS
NOCOLOR=$'\e[0m'
FG_LIGHTRED=$'\e[1;31m'
FG_ORANGE=$'\e[30;38;5;209m'
FG_LIGHTGREY=$'\e[30;38;5;246m'
FG_LIGHTGREEN=$'\e[30;38;5;71m'
FG_SOFLIGHTRED=$'\e[30;38;5;131m'
BLINK=$'\e[5m'



#---SUBROUTINES/FUNCTIONS
usage_sub() 
{
	echo -e "\r"
    echo -e ":-->${BLINK}${FG_LIGHTRED}USAGE${NOCOLOR}: $0 <dev_id> (e.g. mmcblk1p1)"
	echo -e "\r"
	
    exit 99
}

function get_MEDIAFULLPATH__func() {
	#---------------------------------------------------------------#
	# 	Check if this ${mediafullpath} (e.g. /media/HIEN_E) can be	 	#
	# found in /etc/mtab.											#
	# 	if ${mediafullpath} does exist, then check whether				#
	# ${mtab_devfullpath} matches with ${devfullpath}						#
	# 	If NO match, then it means that the mounted devfullpath 		#
	# (e.g. /dev/sda1) is not ACTIVE, and thus can be UNmounted		#
	#	and Removed													#
	#---------------------------------------------------------------#
	#Input args
    local mediapart=${1}

    #In case 'mediapart' is an empty string
    #It means that the Micro-SD card does NOT have a label
    if [[ -z ${mediapart} ]]; then
    #    mediapart="${devpart_in}"
        mediapart="MMC_DRIVE"
    fi

	#Using the Mount information, get ${mtab_devfullpath} (e.g. /dev/sda1) which is stored in /etc/mtab
    local mediafullpath=${media_dir}/${mediapart}	#redefine variable, but now with seqnum
	local mtab_devfullpath=`cat ${etc_dir}/mtab | grep -w "${mediafullpath}" | cut -d " " -f1`	#grep EXACT match
	local mediafullpath_isFound=""

	if [[ ! -z ${mtab_devfullpath} ]]; then	#only continue if ${mtab_devfullpath} is NOT an empty string
		#Rename 'mediapart', because '${mediafullpath}' was found in /etc/mtab
		local seqnum=0
		while true
		do
			mediapart="${mediapart}_${seqnum}"	#redefine variable, but now with seqnum
			mediafullpath=${media_dir}/${mediapart}	#redefine variable, but now with seqnum

			mediafullpath_isFound=`cat ${etc_dir}/mtab | grep "${mediafullpath}" | cut -d " " -f1`
			#Only continue if ${mtab_devfullpath} is an empty string...
			#	...this would mean that '${mediafullpath}' has not been used yet as a mount-point
			if [[ -z ${mediafullpath_isFound} ]]; then
				break
			else
				seqnum=$((seqnum + 1))
			fi
		done
	fi

	#OUTPUT
	echo ${mediafullpath}
}

remove_unused_mountpoints__sub() {
	#---------------------------------------------------------------#
	# 	Delete all empty folders in directory /media that aren't 	#
	# being used as mount points. 									#
	# 	If the drive was unmounted prior to removal we no longer	#
	# know its mount point, and we don't want to leave it orphaned.	#
	#---------------------------------------------------------------#
	#Define variables
	local mediafullpath_array=${media_dir}/*	#note: mediafullpath_array is an ARRAY containing mediafullpaths
	local mediafullpath_arrayitem=""
	local mtab_devfullpath=""

	for mediafullpath_arrayitem in ${mediafullpath_array}	#note: mediafullpath_arrayitem is the same as 'mediafullpath'
	do
		#Using the Mount information, get ${mtab_devfullpath} (e.g. /dev/sda1) which is stored in /etc/mtab
		mtab_devfullpath=`cat ${etc_dir}/mtab | grep "${mediafullpath_arrayitem}" | cut -d " " -f1`

		if [[ -z ${mtab_devfullpath} ]]; then	#no match was found for '${mediafullpath_arrayitem}
			if [[ -d "$mediafullpath_arrayitem" ]]; then
				#${usr_bin_dir}/umount -l ${mediafullpath_arrayitem}	#unmount with forcibly removing entry in /etc/mtab

				${usr_bin_dir}/umount ${mediafullpath_arrayitem}	#unmount

				${usr_bin_dir}/rm -r ${mediafullpath_arrayitem}	#remove
			fi
		else
			#Checkif there is a match for 'mtab_devfullpath'
			local match_isFound=`/sbin/blkid | grep "${mtab_devfullpath}"`

			if [[ -z ${match_isFound} ]]; then	#In case no info is found, then umount & remove the ${mediafullpath}
				#${usr_bin_dir}/umount -l ${mediafullpath_arrayitem}	#unmount with forcibly removing entry in /etc/mtab

				${usr_bin_dir}/umount ${mediafullpath_arrayitem}	#unmount

				${usr_bin_dir}/rm -r ${mediafullpath_arrayitem}	#remove
			fi
		fi
	done
}

do_UNmount_sub() 
{
	#Using the Mount information, get ${mtab_MEDIAFULLPATH} (e.g. /media/HIEN_E) which is stored in /etc/mtab
	local mtab_MEDIAFULLPATH=`cat ${etc_dir}/mtab | grep "${devfullpath_in}" | cut -d " " -f2`

	#Unmount devfullpath_in (e.g. /dev/sda1) 
	${usr_bin_dir}/umount ${devfullpath_in}

	#Remove folder ${mtab_MEDIAFULLPATH}
	if [[ ! -d ${mtab_MEDIAFULLPATH} ]]; then
		rm -rf ${mtab_MEDIAFULLPATH}
	fi

	echo -e "\r"	
	echo -e "\r"
	echo -e "${FG_ORANGE}INFO${NOCOLOR}: ${BLINK}${FG_SOFLIGHTRED}UNMOUNTED${NOCOLOR} MMC: ${FG_LIGHTGREY}${devfullpath_in}${NOCOLOR}"
	echo -e "${FG_ORANGE}INFO${NOCOLOR}: MOUNT-POINT: ${FG_LIGHTGREY}${mtab_MEDIAFULLPATH}${NOCOLOR}"
	echo -e "\r"
	echo -e "\r"


	#Remove unused mointpoints
	remove_unused_mountpoints__sub
}

#---Show message
# echo -e "\r"
# echo -e "\r"
# echo -e "${FG_ORANGE}INFO${NOCOLOR}: EJECTED MMC: ${FG_LIGHTGREY}${devpart_in}${NOCOLOR}"
# echo -e "\r"


#---Check input args
if [[ $# -ne 1 ]]; then	#input args is not equal to 2 
    usage_sub
else
    if [[ ${1} != ${regex_pattern} ]]; then	#only allow the following keys to be pressed 'sd'
		usage_sub
	fi
fi


#---Unmount MMC SD-card
do_UNmount_sub