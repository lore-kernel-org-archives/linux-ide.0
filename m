From: Prashant Alves <prashant.alves@gmail.com>
Subject: [SATA] command 0x35 timeout errors on 2.6.12.5
Date: Sun, 11 Sep 2005 13:35:37 +0800
Message-ID: <200509111335.37247.prashant.alves@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:21274 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932414AbVIKFYp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Sep 2005 01:24:45 -0400
Received: by zproxy.gmail.com with SMTP id r28so1566243nza
        for <linux-ide@vger.kernel.org>; Sat, 10 Sep 2005 22:24:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff,

With a linux-2.6.13.1 kernel my machine freezes and I get the following error 
strings on my console:
ata1: command 0x35 timeout,  stat 0x50 host_stat 0x4
ata 2: command 0x35 timeout,  stat 0x50 host_stat 0x4

The only option after this is to reset the machine using the reset button. 
linux-2.6.12.5 works fine for me as was linux-2.6.9 before that. 

This problems seem similar to the one mentioned here 
http://www.ussg.iu.edu/hypermail/linux/kernel/0506.0/1494.html

Machine:
AMD-64, Nvidia nforce3 based motherboard. 2 Seagate SATA HDDs. (250GB and 
200GB)

Disk From 2.6.12.5 dmesg:

[   26.132398] scsi1 : sata_nv
[   26.132469]   Vendor: ATA       Model: ST3200822AS       Rev: 3.01
[   26.132641]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[   26.132982]   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
[   26.133159]   Type:   Direct-Access                      ANSI SCSI 
revision: 05

Thanks,
Prashant Alves
