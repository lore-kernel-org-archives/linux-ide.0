From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove no longer needed ide_drive_t fields
Date: Thu, 24 Jul 2008 21:42:52 +0200
Message-ID: <200807242142.53203.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:16956 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbYGXTpO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 15:45:14 -0400
Received: by ug-out-1314.google.com with SMTP id h2so629553ugf.16
        for <linux-ide@vger.kernel.org>; Thu, 24 Jul 2008 12:45:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Remove ->remap_0_to_1 and ->sect0 (they are always zero now).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |    2 +-
 drivers/ide/ide-io.c   |   18 +++---------------
 include/linux/ide.h    |    2 --
 3 files changed, 4 insertions(+), 18 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -480,7 +480,7 @@ static void init_idedisk_capacity(ide_dr
 
 static sector_t idedisk_capacity(ide_drive_t *drive)
 {
-	return drive->capacity64 - drive->sect0;
+	return drive->capacity64;
 }
 
 #ifdef CONFIG_IDE_PROC_FS
Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -766,9 +766,7 @@ static void ide_check_pm_state(ide_drive
  *	start_request	-	start of I/O and command issuing for IDE
  *
  *	start_request() initiates handling of a new I/O request. It
- *	accepts commands and I/O (read/write) requests. It also does
- *	the final remapping for weird stuff like EZDrive. Once 
- *	device mapper can work sector level the EZDrive stuff can go away
+ *	accepts commands and I/O (read/write) requests.
  *
  *	FIXME: this function needs a rename
  */
@@ -776,7 +774,6 @@ static void ide_check_pm_state(ide_drive
 static ide_startstop_t start_request (ide_drive_t *drive, struct request *rq)
 {
 	ide_startstop_t startstop;
-	sector_t block;
 
 	BUG_ON(!blk_rq_started(rq));
 
@@ -791,16 +788,6 @@ static ide_startstop_t start_request (id
 		goto kill_rq;
 	}
 
-	block    = rq->sector;
-	if (blk_fs_request(rq) &&
-	    (drive->media == ide_disk || drive->media == ide_floppy)) {
-		block += drive->sect0;
-	}
-	/* Yecch - this will shift the entire interval,
-	   possibly killing some innocent following sector */
-	if (block == 0 && drive->remap_0_to_1 == 1)
-		block = 1;  /* redirect MBR access to EZ-Drive partn table */
-
 	if (blk_pm_request(rq))
 		ide_check_pm_state(drive, rq);
 
@@ -845,7 +832,8 @@ static ide_startstop_t start_request (id
 			return ide_special_rq(drive, rq);
 
 		drv = *(ide_driver_t **)rq->rq_disk->private_data;
-		return drv->do_request(drive, rq, block);
+
+		return drv->do_request(drive, rq, rq->sector);
 	}
 	return do_special(drive);
 kill_rq:
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -427,7 +427,6 @@ struct ide_drive_s {
 	unsigned atapi_overlap	: 1;	/* ATAPI overlap (not supported) */
 	unsigned doorlocking	: 1;	/* for removable only: door lock/unlock works */
 	unsigned nodma		: 1;	/* disallow DMA */
-	unsigned remap_0_to_1	: 1;	/* 0=noremap, 1=remap 0->1 (for EZDrive) */
 	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned scsi		: 1;	/* 0=default, 1=ide-scsi emulation */
 	unsigned sleeping	: 1;	/* 1=sleeping & sleep field valid */
@@ -450,7 +449,6 @@ struct ide_drive_s {
 	u8	io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
 	u8	bad_wstat;	/* used for ignoring ATA_DF */
 	u8	nowerr;		/* used for ignoring ATA_DF */
-	u8	sect0;		/* offset of first sector for DM6:DDO */
 	u8	head;		/* "real" number of heads */
 	u8	sect;		/* "real" sectors per track */
 	u8	bios_head;	/* BIOS/fdisk/LILO number of heads */
