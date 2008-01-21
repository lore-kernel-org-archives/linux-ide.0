From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 13/16] ide: remove ide_ata66_check()
Date: Tue, 22 Jan 2008 00:32:05 +0100
Message-ID: <20080121233205.30311.62567.sendpatchset@localhost.localdomain>
References: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:43625 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761035AbYAUXTC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 18:19:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so975308ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 15:18:59 -0800 (PST)
In-Reply-To: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c     |   15 ---------------
 drivers/ide/ide-taskfile.c |    5 ++++-
 include/linux/ide.h        |    1 -
 3 files changed, 4 insertions(+), 17 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -612,21 +612,6 @@ no_80w:
 	return 0;
 }
 
-int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
-{
-	if (args->tf.command == WIN_SETFEATURES &&
-	    args->tf.nsect > XFER_UDMA_2 &&
-	    args->tf.feature == SETFEATURES_XFER) {
-		if (eighty_ninty_three(drive) == 0) {
-			printk(KERN_WARNING "%s: UDMA speeds >UDMA33 cannot "
-					    "be set\n", drive->name);
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_BLK_DEV_IDEDMA
 static u8 ide_auto_reduce_xfer (ide_drive_t *drive)
 {
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -798,8 +798,11 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 	    tf->nsect >= XFER_SW_DMA_0 &&
 	    (id->dma_ultra || id->dma_mword || id->dma_1word)) {
 		xfer_rate = args[1];
-		if (ide_ata66_check(drive, &tfargs))
+		if (tf->nsect > XFER_UDMA_2 && !eighty_ninty_three(drive)) {
+			printk(KERN_WARNING "%s: UDMA speeds >UDMA33 cannot "
+					    "be set\n", drive->name);
 			goto abort;
+		}
 	}
 
 	err = ide_raw_taskfile(drive, &tfargs, buf, args[3]);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -990,7 +990,6 @@ int ide_task_ioctl(ide_drive_t *, unsign
 extern int system_bus_clock(void);
 
 extern int ide_driveid_update(ide_drive_t *);
-extern int ide_ata66_check(ide_drive_t *, ide_task_t *);
 extern int ide_config_drive_speed(ide_drive_t *, u8);
 extern u8 eighty_ninty_three (ide_drive_t *);
 extern int taskfile_lib_get_identify(ide_drive_t *drive, u8 *);
