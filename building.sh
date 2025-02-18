#!/bin/bash

#
clone() {
  sudo apt-get update -y ; apt-get install -y bc build-essential git unzip
  git clone --depth=1 https://github.com/OpenIPC/openipc-2.1.git
}

fresh() {
  make distclean #clean
  [ -d buildroot* ] && echo -e "\nBuildroot found, OK\n" || make prepare
}

rename() {
  mv -v ./output/images/rootfs.squashfs ./output/images/rootfs.squashfs.${soc}
  mv -v ./output/images/uImage ./output/images/uImage.${soc}
}

upload() {
  server="zig@172.28.200.74:/sync/Archive/Incoming/Tftp/"
  echo -e "\n\nStart transferring files to the TFTP server...\n"
  scp -P 22 -r ./output/images/rootfs.squashfs.* ./output/images/uImage.* ${server}
  echo -e "\n"
  date
}

sdk() {
  make br-sdk
}

hi3516cv100() {
  soc="hi3516cv100"
  fresh && make PLATFORM=hisilicon BOARD=unknown_unknown_${soc}_unknown all && rename
}

hi3516cv200() {
  soc="hi3516cv200"
  fresh && make PLATFORM=hisilicon BOARD=unknown_unknown_${soc}_unknown all && rename
}

hi3516cv300() {
  soc="hi3516cv300"
  fresh && make PLATFORM=hisilicon BOARD=unknown_unknown_${soc}_unknown all && rename
}

hi3516ev200() {
  fresh && make PLATFORM=hisilicon BOARD=unknown_unknown_hi3516ev200_openipc all && rename
}

hi3516ev300() {
  fresh && make PLATFORM=hisilicon BOARD=unknown_unknown_hi3516ev300_openipc all && rename
}

hi3516ev300_dev() {
  fresh && make PLATFORM=hisilicon BOARD=unknown_unknown_hi3516ev300_dev all && rename
}

hi3516ev300_glibc() {
  fresh && make PLATFORM=hisilicon BOARD=unknown_unknown_hi3516ev300_glibc all && rename
}

hi3516ev300_tehshield() {
  fresh && make PLATFORM=hisilicon BOARD=unknown_unknown_hi3516ev300_tehshield all && rename
}

ssc335() {
  fresh && make PLATFORM=sigmastar BOARD=unknown_unknown_ssc335_openipc all && rename
}

ssc335_blackbird() {
  fresh && make PLATFORM=sigmastar BOARD=unknown_unknown_ssc335_blackbird all && rename
}

xm530() {
  fresh && make PLATFORM=xiongmai BOARD=unknown_unknown_xm530_openipc all && rename
}



# Build firmware
#
# hi3516cv100                   # testing..
# hi3516cv200                   # testing..
# hi3516cv300                   # testind..
#
# hi3516ev200                   # OK
#
# hi3516ev300                   # OK
# hi3516ev300_dev               # testing..
# hi3516ev300_glibc             # testing..
# hi3516ev300_tehshield         # partner..
#
# ssc335                        # OK
# ssc335_blackbird              # partner..
#
# xm530                         # OK
#
#
#
# More examples
#
# make PLATFORM=sigmastar br-linux-{dirclean,rebuild}
#

