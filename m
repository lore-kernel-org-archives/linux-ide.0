From: "kacer" <kacerxy@seznam.cz>
Subject: Kernel driver for Sil 3112 (sata_sil.c) problems
Date: Fri, 24 Feb 2006 20:48:45 +0100
Message-ID: <20060224194919.6B81F37B09@relay.netbox.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.netbox.cz ([83.240.0.201]:56769 "EHLO relay.netbox.cz")
	by vger.kernel.org with ESMTP id S932443AbWBXTt0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2006 14:49:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Dear Jeff,
sorry for disturbing you, but I tried nearly everything to get this SATA
controller (Silicon Image Sil 3112) working, but it always crashes while
writing data (few hundred MBs or few GBs). In dmesg I can see something like
that:

end_request: I/O error, dev sdb, sector 459620760 
Buffer I/O error on device dm-3, logical block 155125763 
lost page write due to I/O error on dm-3 
ATA: abnormal status 0xD8 on port 0xE08180C7 
ATA: abnormal status 0xD8 on port 0xE08180C7 
ATA: abnormal status 0xD8 on port 0xE08180C7 

ata2: command 0x35 timeout, stat 0x58 host_stat 0x0 
ata2: status=0x58 { DriveReady SeekComplete DataRequest } 
SCSI error : <1 0 0 0> return code = 0x8000002 
sdb: Current: sense key=0xb 
    ASC=0x47 ASCQ=0x0 
end_request: I/O error, dev sdb, sector 459620744 
Buffer I/O error on device dm-3, logical block 155125761 
lost page write due to I/O error on dm-3 
ATA: abnormal status 0x58 on port 0xE08180C7 
ATA: abnormal status 0x58 on port 0xE08180C7 
ATA: abnormal status 0x58 on port 0xE08180C7

And same problems with /dev/sda. In this moment system is locked and nearly
not working, the only thing what I can do is HW reset...

I have Sil 3112 in Asus TUSL2-C (i815) motherboard, 2x256 MB RAM, there are
2 WD Raid Edition 400 GB drives on controller (2 of 4 ports used), BIOS of
controller is 4.2.0, I tried several kernels from 2.6.12 up to 2.6.15.4.
Nothing changed and I'm still getting same error messages. If you need some
other additional info or cooperation, just write me, I'm feeling desperate,
I don't know that to do to get that working. I tried to search the internet
for some suggestions, but I was not able to fix the the problems.

Sincerely
Jiri Bartosik

