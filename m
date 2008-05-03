From: "Bruce Hill, Jr." <servants@cotse.net>
Subject: Asus DRW-2014L1T SATA DVD drive and sata_via
Date: Sat, 03 May 2008 21:50:23 +0800
Message-ID: <MTAwMDAxMi5zZXJ2YW50cw.1209822671@quikprotect>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.cotse.net ([68.166.125.227]:57879 "EHLO smtp.cotse.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbYECOKM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 May 2008 10:10:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff,

I don't know where to start, and am asking for direction.

I bought an Asus DRW-2014L1T SATA DVD drive. I can blank CD-RWs with 
cdrecord, but can not burn a good CD-R or CD-RW with cdrecord or 
cdrdao from CLI or with K3B. I also can not burn a good DVD with 
growisofs.

I can burn just fine to my TSSTcorp DVD drive (it is PATA).

I'm using sata_via and pata_via ... no IDE stuff in the kernel. I've 
tried different kernel selections, but nothing works.

mingdao@silas:~$ uname -a
Linux silas 2.6.25.1-libata #1 PREEMPT Fri May 2 07:37:20 CST 2008 
i686 AMD Athlon(tm) 64 Processor 3200+ AuthenticAMD GNU/Linux

mingdao@silas:~$ /sbin/lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host 
Bridge (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge 
[K8T800/K8T890 South]
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA 
RAID Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)

I sent a request for help to cdrecord, and Jorge Schilling basically 
made excuses and blamed my media, my drive, and the Linux kernel. He 
offered nothing technical whatsoever.

I updated the firmware in the drive, and have built the latest 
cdrtools and dvd+rw-tools.

Perhaps this Asus DVD burner is not even supported. I've read 
sata_via.c and LKML and every hit on Google and <Linux> Google.

If you could just tell me what to do to submit a possible bug report 
or request for support, I would be grateful.

And though my knowledge is not real deep, I will do anything you ask 
from here to work with you on this ... if it's even something you 
have one minute of time for.

Thanks,
Bruce Hill
-- 
May the Lamb that was slain receive the reward of His suffering!

Bruce Hill, Jr. <servants@cotse.net>
Don't top post: http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please:   http://www.expita.com/nomime.html
