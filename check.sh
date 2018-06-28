#!/bin/bash
#########################################################################
# File Name: check.sh
# Author: NLP_Team
# Mail: zhaozhenyu@corp.netease.com
# Created Time: 14:51:59 2018-06-27
#########################################################################
while :
do
    
    DATE=$(date +%Y%m%d%H%M%S)
    time=$(date +%H)
    SERVICE='docVulgar_1'
    LOGPATH='./log'
    
    #当前日志中的error数量
    ERROR=`grep "ERROR" $LOGPATH |wc -l `
    
    #cpu负载
    CPU=`uptime | awk '{print int($10)}'`
    
    #磁盘负载
    DISKLIST=`df -k| grep -v FIlesystem |awk '{print int($5)}'`
    DISK=''
    for i in $DISKLIST
    do
        DISK=${DISK}' '$i
    done
    
    #日志数量
    LOG=`wc -l $LOGPATH`
    if [ $time -eq 17 ]
    then
    mail_content=${DATE}' log statistics is : error count :'${ERROR}' cpu load is :'${CPU}' disk load is '${DISK}' log total count is : '${LOG}
    mail_subject=${DATE}' '${SERVICE}' log statistics'
    `python ./sendmail.py "${mail_subject}" "${mail_content}"`
    fi  
    
    #报警设置
    for i in $DISKLIST
    do
        if [ $i -gt 80 ]
        then
            mail_subject=${DATE}' '${SERVICE}' disk overload with '${i}
            mail_content='RT'
            `python ./sendmail.py "${mail_subject}" "${mail_content}"`
        fi
    done
    if [ $CPU -gt 12 ]
    then
        mail_subject=${DATE}' '${SERVICE}' cpu overload with '${CPU}
        mail_content='RT'
        `python ./sendmail.py "${mail_subject}" "${mail_content}"`
    fi
    sleep 3600
done

