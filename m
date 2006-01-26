From: Tejun Heo <htejun@gmail.com>
Subject: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 14:50:50 +0900
Message-ID: <20060126055050.GA4737@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.201]:27776 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750813AbWAZFu6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 00:50:58 -0500
Received: by wproxy.gmail.com with SMTP id i3so355362wra
        for <linux-ide@vger.kernel.org>; Wed, 25 Jan 2006 21:50:57 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas.Mailhot@LaPoste.net
Cc: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>, Linux-ide <linux-ide@vger.kernel.org>

Hello, Nicolas.  Hello, all.

Nicolas, I'm probably the guy who broke your filesystem.  :-p This FUA
(forced-unit-access)thing made into the mainline lately, and it seems
that your drive is reporting FUA support but doesn't really do it
properly when it's asked to.

Can you try the followings to verify the problem?

1. make a small partition on the affected drive and do mkfs.ext3 on it.
2. mount -o barrier new_partition /mnt/tmp
3. cd /mnt/tmp; touch asdf; sync

This should give something like the following.

======
ata2: port reset, p_is 40000001 is 2 pis 0 cmd 44017 tf 451 ss 123 se 0
ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x04 { DriveStatusError }
ata2: port reset, p_is 40000001 is 2 pis 0 cmd 44017 tf 451 ss 123 se 0
ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x04 { DriveStatusError }
ata2: port reset, p_is 40000001 is 2 pis 0 cmd 44017 tf 451 ss 123 se 0
ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x04 { DriveStatusError }
ata2: port reset, p_is 40000001 is 2 pis 0 cmd 44017 tf 451 ss 123 se 0
ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x04 { DriveStatusError }
ata2: port reset, p_is 40000001 is 2 pis 0 cmd 44017 tf 451 ss 123 se 0
ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x04 { DriveStatusError }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key: Aborted Command
    Additional sense: No additional sense information
end_request: I/O error, dev sdc, sector 4359
Buffer I/O error on device sdc1, logical block 537
lost page write due to I/O error on sdc1
Aborting journal on device sdc1.
journal commit I/O error
======

The ext3 fs will back off and won't use any barrier from this point.

If this is what you see, please apply the patch at the end of this
mail, which makes libata issue non-FUA commmands even if FUA commands
are asked for.  After recompiling repeat above, create some files,
unmount, mount, verify stuff, unmount and fsck...  All should succeed
without any complaint from the kernel.

If my guess turns out to be true, we'll need a blacklist for those
lying drives.  Damn it.

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 46c4cdb..6ba6ad2 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -565,7 +565,7 @@ static const u8 ata_rw_cmds[] = {
 	0,
 	0,
 	0,
-	ATA_CMD_WRITE_MULTI_FUA_EXT,
+	ATA_CMD_WRITE_MULTI_EXT,
 	/* pio */
 	ATA_CMD_PIO_READ,
 	ATA_CMD_PIO_WRITE,
@@ -583,7 +583,7 @@ static const u8 ata_rw_cmds[] = {
 	0,
 	0,
 	0,
-	ATA_CMD_WRITE_FUA_EXT
+	ATA_CMD_WRITE_EXT
 };
 
 /**
