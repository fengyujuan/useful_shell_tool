#!/usr/bin/env python
#-*- coding:UTF-8 -*-
#########################################################################
# File Name: sendmail.py
# Author: NLP_Team
# Mail: zhaozhenyu@corp.netease.com
# Created Time: 11:31:49 2018-06-28
#########################################################################
import sys
 
import smtplib
from email.mime.text import MIMEText
from email.header import Header
 
# 第三方 SMTP 服务
mail_host="smtp.tju.edu.cn"  #设置服务器
mail_user="zhaozhenyu_tx@tju.edu.cn"    #用户名
mail_pass="whatever"   #口令 
 
 
sender = 'zhaozhenyu_tx@tju.edu.cn'
receivers = ['zhaozhenyu@corp.netease.com']  # 接收邮件，可设置为你的QQ邮箱或者其他邮箱
 
message = MIMEText(sys.argv[2], 'plain', 'utf-8')
message['From'] = Header("zzy", 'utf-8')
message['To'] =  Header("cangjie", 'utf-8')
 
subject = sys.argv[1]
message['Subject'] = Header(subject, 'utf-8')
 
 
try:
    smtpObj = smtplib.SMTP('localhost') 
    smtpObj.connect(mail_host, 25)    # 25 为 SMTP 端口号
    smtpObj.login(mail_user,mail_pass)
    smtpObj.sendmail(sender, receivers, message.as_string())
    #print ("邮件发送成功")
except smtplib.SMTPException as e:
    #(a,f)=list(e)
    f= b'\xd3\xc3\xbb\xa7\xce\xde\xc8\xa8\xb5\xc7\xc2\xbd'
    #print(str(f).encode('utf-8').decode())
    #print ("Error: 无法发送邮件"+str(e).encode('utf-8').decode('utf-8'))
