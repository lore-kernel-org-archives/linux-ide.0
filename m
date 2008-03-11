From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] ide: remove obsoleted "hdx=noautotune" kernel parameter
Date: Tue, 11 Mar 2008 21:30:49 +0100
Message-ID: <200803112130.49698.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:42069 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbYCKUTI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 16:19:08 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2546213fga.17
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 13:19:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Remove obsoleted "hdx=noautotune" kernel parameter
(it has been obsoleted since 1 Nov 2004).

Then make ide_hwif_t.autotune a single bit flag
and remove no longer needed IDE_TUNE_* defines.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c    |    4 +---
 drivers/ide/ide-probe.c |   10 ++--------
 drivers/ide/ide.c       |    7 ++-----
 include/linux/ide.h     |    9 +--------
 4 files changed, 6 insertions(+), 24 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1909,9 +1909,7 @@ static int ide_cdrom_setup(ide_drive_t *
 	/* set correct block size */
 	blk_queue_hardsect_size(drive->queue, CD_FRAMESIZE);
 
-	if (drive->autotune == IDE_TUNE_DEFAULT ||
-	    drive->autotune == IDE_TUNE_AUTO)
-		drive->dsc_overlap = (drive->next != drive);
+	drive->dsc_overlap = (drive->next != drive);
 
 	if (ide_cdrom_register(drive, nslots)) {
 		printk(KERN_ERR "%s: %s failed to register device with the"
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -472,9 +472,7 @@ static int do_probe (ide_drive_t *drive,
 		if (stat == (BUSY_STAT | READY_STAT))
 			return 4;
 
-		if ((rc == 1 && cmd == WIN_PIDENTIFY) &&
-			((drive->autotune == IDE_TUNE_DEFAULT) ||
-			(drive->autotune == IDE_TUNE_AUTO))) {
+		if (rc == 1 && cmd == WIN_PIDENTIFY) {
 			printk(KERN_ERR "%s: no response (status = 0x%02x), "
 					"resetting drive\n", drive->name, stat);
 			msleep(50);
@@ -828,13 +826,9 @@ static void ide_port_tune_devices(ide_hw
 		ide_drive_t *drive = &hwif->drives[unit];
 
 		if (drive->present) {
-			if (drive->autotune == IDE_TUNE_AUTO)
+			if (drive->autotune)
 				ide_set_max_pio(drive);
 
-			if (drive->autotune != IDE_TUNE_DEFAULT &&
-			    drive->autotune != IDE_TUNE_AUTO)
-				continue;
-
 			drive->nice1 = 1;
 
 			if (hwif->dma_ops)
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -910,7 +910,7 @@ static int __init ide_setup(char *s)
 	if (s[0] == 'h' && s[1] == 'd' && s[2] >= 'a' && s[2] <= max_drive) {
 		const char *hd_words[] = {
 			"none", "noprobe", "nowerr", "cdrom", "nodma",
-			"autotune", "noautotune", "-8", "-9", "-10",
+			"autotune", "-7", "-8", "-9", "-10",
 			"noflush", "remap", "remap63", "scsi", NULL };
 		unit = s[2] - 'a';
 		hw   = unit / MAX_DRIVES;
@@ -939,10 +939,7 @@ static int __init ide_setup(char *s)
 				drive->nodma = 1;
 				goto done;
 			case -6: /* "autotune" */
-				drive->autotune = IDE_TUNE_AUTO;
-				goto obsolete_option;
-			case -7: /* "noautotune" */
-				drive->autotune = IDE_TUNE_NOAUTO;
+				drive->autotune = 1;
 				goto obsolete_option;
 			case -11: /* noflush */
 				drive->noflush = 1;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -49,13 +49,6 @@ typedef unsigned char	byte;	/* used ever
 #define ERROR_RECAL	1	/* Recalibrate every 2nd retry */
 
 /*
- * Tune flags
- */
-#define IDE_TUNE_NOAUTO		2
-#define IDE_TUNE_AUTO		1
-#define IDE_TUNE_DEFAULT	0
-
-/*
  * state flags
  */
 
@@ -329,7 +322,7 @@ typedef struct ide_drive_s {
 	unsigned atapi_overlap	: 1;	/* ATAPI overlap (not supported) */
 	unsigned doorlocking	: 1;	/* for removable only: door lock/unlock works */
 	unsigned nodma		: 1;	/* disallow DMA */
-	unsigned autotune	: 2;	/* 0=default, 1=autotune, 2=noautotune */
+	unsigned autotune	: 1;	/* 0=default, 1=autotune */
 	unsigned remap_0_to_1	: 1;	/* 0=noremap, 1=remap 0->1 (for EZDrive) */
 	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned vdma		: 1;	/* 1=doing PIO over DMA 0=doing normal DMA */
