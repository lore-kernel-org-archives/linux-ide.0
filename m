From: Oliver Joa <oliver@j-o-a.de>
Subject: Re: promise sata 300 TX4 and Samsung HD (SP2004C) -> Sector errors
Date: Wed, 22 Feb 2006 16:34:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602221633580.1308@majestix.gallier.de>
References: <Pine.LNX.4.63.0602221302210.2270@majestix.gallier.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gatrixx.com ([217.111.11.44]:59853 "EHLO mail.gatrixx.com")
	by vger.kernel.org with ESMTP id S1750717AbWBVPed (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2006 10:34:33 -0500
Received: from majestix.gallier.de (majestix [127.0.0.1])
	by majestix.gallier.de (8.13.5/8.13.5/Debian-3) with ESMTP id k1MFYOxo002160
	for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 16:34:24 +0100
Received: from localhost (olli@localhost)
	by majestix.gallier.de (8.13.5/8.13.5/Submit) with ESMTP id k1MFYN1Q002155
	for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 16:34:24 +0100
In-Reply-To: <Pine.LNX.4.63.0602221302210.2270@majestix.gallier.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Wed, 22 Feb 2006, Oliver Joa wrote:

> Hi,
>
> i have a brandnew Promise SATA 300 TX4 Controller and 2 Samsung HD
> (SP2004C). I am using Linux 2.6.15 and also tried 2.6.15.4 with
> sata_promise-driver. I get sector-errors:
>
> ata2: PIO error
> ata2: status=0x50 { DriveReady SeekComplete }
> ata2: PIO error
> ata2: status=0x50 { DriveReady SeekComplete }
> ata2: PIO error
> ata2: status=0x50 { DriveReady SeekComplete }
> ata2: PIO error
> ata2: status=0x50 { DriveReady SeekComplete }
> hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> ATA: abnormal status 0xFF on port 0xF880029C
> ata2: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata2: status=0xff { Busy }
> ata2: command timeout
> ATA: abnormal status 0xFF on port 0xF880029C
> ata2: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata2: status=0xff { Busy }
> sd 1:0:0:0: SCSI error: return code = 0x8000002
> sda: Current: sense key: Aborted Command
>    Additional sense: Scsi parity error
> end_request: I/O error, dev sda, sector 9482176
> Buffer I/O error on device sda, logical block 1185272
>
> I get the error at heavy hd-usage, and also on both harddisks. So i think
> it is not a problem of the harddisks. I use softwareraid, but it does not
> work. I think it should take out the harddisk with the error, but it does
> not. The system is hanging....
>
> Do you have any idea?

I tried kernel-2.6.16-rc4 with the same problem. Any Idea? I think about
to buy a other controller. Someone out there who can recommend one. I need
4 Ports.


Olli
