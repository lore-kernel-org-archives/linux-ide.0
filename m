From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/20] ide-cd: fix non-SECTOR_SIZE-multiples PIO transfers for fs requests
Date: Mon, 16 Feb 2009 01:14:55 +0100
Message-ID: <20090216001455.27491.90708.sendpatchset@localhost.localdomain>
References: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:51735 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756130AbZBPANa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 19:13:30 -0500
In-Reply-To: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cd: fix non-SECTOR_SIZE-multiples PIO transfers for fs requests

We now support arbitrary number of bytes per-IRQ also for fs requests
so remove ide_cd_check_transfer_size() and IDE_AFLAG_LIMIT_NFRAMES.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |   36 +-----------------------------------
 include/linux/ide.h  |    5 -----
 2 files changed, 1 insertion(+), 40 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -501,31 +501,6 @@ static int ide_cd_check_ireason(ide_driv
 	return -1;
 }
 
-/*
- * Assume that the drive will always provide data in multiples of at least
- * SECTOR_SIZE, as it gets hairy to keep track of the transfers otherwise.
- */
-static int ide_cd_check_transfer_size(ide_drive_t *drive, int len)
-{
-	ide_debug_log(IDE_DBG_FUNC, "len: %d", len);
-
-	if ((len % SECTOR_SIZE) == 0)
-		return 0;
-
-	printk(KERN_ERR PFX "%s: %s: Bad transfer size %d\n", drive->name,
-			__func__, len);
-
-	if (drive->atapi_flags & IDE_AFLAG_LIMIT_NFRAMES)
-		printk(KERN_ERR PFX "This drive is not supported by this "
-				"version of the driver\n");
-	else {
-		printk(KERN_ERR PFX "Trying to limit transfer sizes\n");
-		drive->atapi_flags |= IDE_AFLAG_LIMIT_NFRAMES;
-	}
-
-	return 1;
-}
-
 static ide_startstop_t ide_cd_prepare_rw_request(ide_drive_t *drive,
 						 struct request *rq)
 {
@@ -744,13 +719,7 @@ static ide_startstop_t cdrom_newpc_intr(
 	if (rc)
 		goto out_end;
 
-	if (blk_fs_request(rq)) {
-		if (write == 0) {
-			if (ide_cd_check_transfer_size(drive, len))
-				goto out_end;
-		}
-		cmd->last_xfer_len = 0;
-	}
+	cmd->last_xfer_len = 0;
 
 	if (ireason == 0) {
 		write = 1;
@@ -1611,9 +1580,6 @@ static const struct ide_proc_devset *ide
 #endif
 
 static const struct cd_list_entry ide_cd_quirks_list[] = {
-	/* Limit transfer size per interrupt. */
-	{ "SAMSUNG CD-ROM SCR-2430", NULL,   IDE_AFLAG_LIMIT_NFRAMES	     },
-	{ "SAMSUNG CD-ROM SCR-2432", NULL,   IDE_AFLAG_LIMIT_NFRAMES	     },
 	/* SCR-3231 doesn't support the SET_CD_SPEED command. */
 	{ "SAMSUNG CD-ROM SCR-3231", NULL,   IDE_AFLAG_NO_SPEED_SELECT	     },
 	/* Old NEC260 (not R) was released before ATAPI 1.2 spec. */
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -458,11 +458,6 @@ enum {
 	IDE_AFLAG_TOCADDR_AS_BCD	= (1 << 3),
 	/* TOC track numbers are in BCD. */
 	IDE_AFLAG_TOCTRACKS_AS_BCD	= (1 << 4),
-	/*
-	 * Drive does not provide data in multiples of SECTOR_SIZE
-	 * when more than one interrupt is needed.
-	 */
-	IDE_AFLAG_LIMIT_NFRAMES		= (1 << 5),
 	/* Saved TOC information is current. */
 	IDE_AFLAG_TOC_VALID		= (1 << 6),
 	/* We think that the drive door is locked. */
