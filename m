From: Rafal Krzewski <Rafal.Krzewski@caltha.pl>
Subject: SATA I/O error problems
Date: Wed, 28 Dec 2005 09:30:12 +0100
Message-ID: <43B24D14.1020603@caltha.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from robur.caltha.pl ([80.72.33.166]:11485 "EHLO robur.caltha.pl")
	by vger.kernel.org with ESMTP id S932492AbVL1IaQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Dec 2005 03:30:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I am having problems with SATA disks in one of my servers. I tried 
googling up info about it and I found it was reported by several people 
over the past few months, but no answers/solutions were given.

Once in a while (several hours/days) the kernel starts spitting out 
messages included below to the console and the machine becomes 
completely non-responsive:

ATA: abnormal status 0xD0 on port 0xEFF7
ATA: abnormal status 0xD0 on port 0xEFF7
ATA: abnormal status 0xD0 on port 0xEFF7
ata1: command 0xca timeout, stat 0xd0 host_stat 0x21
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xd0 { Busy }
sd 0:0:0:0 SCSI error: return code = 0x8000002
sda: Current: sense key=0xb
     ASC=0x47 ASCQ=0x0
Info fld=0x559a48
end_request: I/O error, dev sda, sector 5613328

There is a 30s pause between writing the first 3 lines and the rest of 
the message. Next batch of messages follows immediately. Sector number 
increases each time in the increments of 8.

Rebooting the machine brings things back to normal - provided that it is 
left alone for the time the MD array resyncs. Putting some load on 
machine during the resync makes the another I/O error flood very 
probable. OTOH I have seen the problem occurring at night when the 
machine is completely idle (or maybe it was triggered by the early 
morning cron jobs?)

The problem persists for a long time now - I was using kernels 2.6.12.1, 
  2.6.13.4 and recently 2.6.15-rc6 hoping it would go away with another 
upgrade, but no luck.
It is also independent from SMP - the machine has dual core P4, but the 
problem happens just as often with SMP on and off.

Machine info:
Asus P4P800-X mobo, 865PE / ICH5 chipset 
(http://www.asus.com/products.aspx?l1=3&l2=12&l3=31&model=181&modelmenu=1)
2xWD Caviar WD800JD disks 
(http://www.westerndigital.com/en/products/Products.asp?DriveID=83)
Linux 2.6.16-rc6, config: http://caltha.pl/~rafal/morus-oops/config,
dmesg http://caltha.pl/~rafal/morus-oops/dmesg,
PCI http://caltha.pl/~rafal/morus-oops/config

I'd be happy to provide other information as necessary, and am willing 
to test patches on my box (yes, I have the data backed up ;-)).

Thanks in advance!
Rafal

PS. I'd appreciate CCing answers to me - I am not this list's regular.
