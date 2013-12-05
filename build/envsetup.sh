#!/bin/bash
function help(){
cat <<EOF
Invoke ". build/envsetup.sh" from your shell to add the following functions to your environment:
- cwyy:		Builds bootloader

Look at the source to view more functions.The complete list is:
EOF
	local A
	A=""
	for i in `cat build/envsetup.sh | sed -n "/^function /s/function \([a-z_]*\).*/\1/p" | sort`;
	do
		A="$A $i"
	done
	echo $A
}
function cwyy()
{
	BOARD_LIST=(smdkv210single_config\
				smdkv210single_ubi_config\
				mdkv210vogue_config\
				mdkv210onenand_config
				)
	if [ "$1" ];then
		BOARD_NUMBER=$1
	else
		for element in $(seq 0 $((${#BOARD_LIST[@]} - 1)))
		do
			echo $element ${BOARD_LIST[$element]}
		done
		
		read -p "Which Board do you choice?" BOARD_NUMBER
	fi
	
	echo 
	echo "*******Build uboot********"
	echo 
	
	if [ -e u-boot.bin ]
	then
		echo "u-boot.bin is exist,and will be deleted now!"
		rm u-boot.bin -f
	fi
	make ${BOARD_LIST[$BOARD_NUMBER]}
	make
}
