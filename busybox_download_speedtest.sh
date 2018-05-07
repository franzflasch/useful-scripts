#!/bin/sh

log_file=$1

dl_link="http://speedtest.wdc01.softlayer.com/downloads/test10.zip"

dl_speed_bytes=`curl -w "%{speed_download}" $dl_link -o /dev/null`

dl_speed_bits=`awk -v var=$dl_speed_bytes 'BEGIN{print var*8}'`
dl_speed_kbits=`awk -v var=$dl_speed_bits 'BEGIN{print var/1024}'`
dl_speed_mbits=`awk -v var=$dl_speed_kbits 'BEGIN{print var/1024}'`

time_date=`date`
alias cmd='echo "DOWNLOAD: $time_date File: $dl_link - Speed: $dl_speed_bytes bytes, $dl_speed_bits bits, $dl_speed_kbits kbits, $dl_speed_mbits mbits"'

if [ $# -eq 0 ]; then
    cmd
    else cmd >> $1
fi
