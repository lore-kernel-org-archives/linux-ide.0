From: Kevin Shanahan <kmshanah@ucwb.org.au>
Subject: sata media errors not propagated? (was Re: sata_via issue)
Date: Tue, 17 Aug 2004 20:47:28 +0930
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1092741447.1581.33.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.ucwb.org.au ([202.45.120.126]:44811 "EHLO mail.ucwb.org.au")
	by vger.kernel.org with ESMTP id S268184AbUHQLPj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2004 07:15:39 -0400
Received: from [192.168.2.53] (unknown [192.168.2.53])
	by mail.ucwb.org.au (Postfix) with ESMTP id B709E12B66
	for <linux-ide@vger.kernel.org>; Tue, 17 Aug 2004 20:45:18 +0930 (CST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

This is reply to this message sent just before I subscribed:
  http://marc.theaimsgroup.com/?l=linux-ide&m=109273319729824&w=2

I'm pretty sure this is a general sata issue as I'm in the same
situation where I'm trying to recover some data from a dying sata disk
using dd_rescue. I've tried on both promise and via based controllers
and the behaviour is the same on both.

strace ends like this:

pread(4, "\355\201\0\0tv\0\0$\232\21A4\232\21Ab^\20A\0\0\0\0\0\0"..., 16384, 7389184) = 16384
pwrite(5, "\355\201\0\0tv\0\0$\232\21A4\232\21Ab^\20A\0\0\0\0\0\0"..., 16384, 7389184) = 16384
pread(4, "\377C\0\0\0\20\0\0D\224\35A\204|\36A\204|\36A\0\0\0\0\0"..., 16384, 7405568) = 16384
pwrite(5, "\377C\0\0\0\20\0\0D\224\35A\204|\36A\204|\36A\0\0\0\0\0"..., 16384, 7405568) = 16384
pread(4, "\240\201\0\0\307\1\0\0\\gS@\372A\25A\323\5\\@\0\0\0\0\4"..., 16384, 7421952) = 16384
pwrite(5, "\240\201\0\0\307\1\0\0\\gS@\372A\25A\323\5\\@\0\0\0\0\4"..., 16384, 7421952) = 16384
pread(4, 

dmesg shows several (10) errors like this:

Buffer I/O error on device sdb2, logical block 7281
ata2: command 0x25 timeout, stat 0x59 host_stat 0x1
scsi1: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 00 03 29 f0 00 00 ec 00 
Current sdb: sense = 70  3
ASC=11 ASCQ= 4
Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 0x00 0x11 0x04 
end_request: I/O error, dev sdb, sector 207344

Then always ends with the following:

ATA: abnormal status 0x59 on port 0xB807
ATA: abnormal status 0x59 on port 0xB807
ATA: abnormal status 0x59 on port 0xB807

ps shows the process is in 'D' state and is unkillable:

milamber:~# ps x | grep dd_rescue
 1773 pts/1    S+     0:00 strace -o ddr-strace.txt dd_rescue -l ddr-errors.txt -A /dev/sdb2 /sda1
 1774 pts/1    D+     0:00 dd_rescue -l ddr-errors.txt -A /dev/sdb2 /sda1
 3101 pts/2    S+     0:00 grep dd_rescue

Perhaps this is already a known limitation of the SATA drivers (still
developing features I guess), but if I can help get this working I'm
willing to test patches or provide more info if needed. In terms of just
getting my data back, I guess another option is to buy a PATA->SATA
adapter and see if the "ide" drivers fare any better.

Thanks,
Kevin.


