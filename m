From: Oliver Joa <oliver@j-o-a.de>
Subject: promise sata 300 TX4 and Samsung HD (SP2004C) -> Sector errors
Date: Wed, 22 Feb 2006 13:02:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602221302210.2270@majestix.gallier.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gatrixx.com ([217.111.11.44]:18321 "EHLO mail.gatrixx.com")
	by vger.kernel.org with ESMTP id S1750860AbWBVMCl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2006 07:02:41 -0500
Received: from majestix.gallier.de (majestix [127.0.0.1])
	by majestix.gallier.de (8.13.5/8.13.5/Debian-3) with ESMTP id k1MC2dnD006312
	for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 13:02:39 +0100
Received: from localhost (olli@localhost)
	by majestix.gallier.de (8.13.5/8.13.5/Submit) with ESMTP id k1MC2dlP006307
	for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 13:02:39 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

i have a brandnew Promise SATA 300 TX4 Controller and 2 Samsung HD
(SP2004C). I am using Linux 2.6.15 and also tried 2.6.15.4 with
sata_promise-driver. I get sector-errors:

ata2: PIO error
ata2: status=0x50 { DriveReady SeekComplete }
ata2: PIO error
ata2: status=0x50 { DriveReady SeekComplete }
ata2: PIO error
ata2: status=0x50 { DriveReady SeekComplete }
ata2: PIO error
ata2: status=0x50 { DriveReady SeekComplete }
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ATA: abnormal status 0xFF on port 0xF880029C
ata2: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata2: status=0xff { Busy }
ata2: command timeout
ATA: abnormal status 0xFF on port 0xF880029C
ata2: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata2: status=0xff { Busy }
sd 1:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Aborted Command
     Additional sense: Scsi parity error
end_request: I/O error, dev sda, sector 9482176
Buffer I/O error on device sda, logical block 1185272

I get the error at heavy hd-usage, and also on both harddisks. So i think
it is not a problem of the harddisks. I use softwareraid, but it does not
work. I think it should take out the harddisk with the error, but it does
not. The system is hanging....

Do you have any idea?

Thanks a lot

Olli
