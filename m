From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/11] ide-pmac: use __ide_wait_stat()
Date: Sun, 22 Jul 2007 20:33:08 +0200
Message-ID: <200707222033.08794.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:48318 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757736AbXGVSTL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:19:11 -0400
Received: by nf-out-0910.google.com with SMTP id g13so97866nfb
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 11:19:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


* Use __ide_wait_stat() instead of wait_for_ready() in pmac_ide_do_setfeature().

While at it do following changes to match __ide_wait_stat() call in
ide_config_drive_speed():

* Wait WAIT_CMD time (20 sec) instead of 2 sec for device to clear BUSY_STAT.

* Check DRQ_STAT bit (shouldn't be set for good device status).

Also remove no longer needed wait_for_ready() from ide-iops.c.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |   31 +------------------------------
 drivers/ide/ppc/pmac.c |    9 +++++----
 include/linux/ide.h    |    2 +-
 3 files changed, 7 insertions(+), 35 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -473,35 +473,6 @@ int drive_is_ready (ide_drive_t *drive)
 EXPORT_SYMBOL(drive_is_ready);
 
 /*
- * Global for All, and taken from ide-pmac.c. Can be called
- * with spinlock held & IRQs disabled, so don't schedule !
- */
-int wait_for_ready (ide_drive_t *drive, int timeout)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat			= 0;
-
-	while(--timeout) {
-		stat = hwif->INB(IDE_STATUS_REG);
-		if (!(stat & BUSY_STAT)) {
-			if (drive->ready_stat == 0)
-				break;
-			else if ((stat & drive->ready_stat)||(stat & ERR_STAT))
-				break;
-		}
-		mdelay(1);
-	}
-	if ((stat & ERR_STAT) || timeout <= 0) {
-		if (stat & ERR_STAT) {
-			printk(KERN_ERR "%s: wait_for_ready, "
-				"error status: %x\n", drive->name, stat);
-		}
-		return 1;
-	}
-	return 0;
-}
-
-/*
  * This routine busy-waits for the drive status to be not "busy".
  * It then checks the status for all of the "good" bits and none
  * of the "bad" bits, and if all is okay it returns 0.  All other
@@ -512,7 +483,7 @@ int wait_for_ready (ide_drive_t *drive, 
  * setting a timer to wake up at half second intervals thereafter,
  * until timeout is achieved, before timing out.
  */
-static int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad, unsigned long timeout, u8 *rstat)
+int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad, unsigned long timeout, u8 *rstat)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	unsigned long flags;
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -540,7 +540,8 @@ static int
 pmac_ide_do_setfeature(ide_drive_t *drive, u8 command)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	int result = 1;
+	int result;
+	u8 stat;
 	
 	disable_irq_nosync(hwif->irq);
 	udelay(1);
@@ -551,9 +552,9 @@ pmac_ide_do_setfeature(ide_drive_t *driv
 	hwif->OUTB(command, IDE_NSECTOR_REG);
 	hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
 	hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
-	udelay(1);
-	/* Timeout bumped for some powerbooks */
-	result = wait_for_ready(drive, 2000);
+	result = __ide_wait_stat(drive, drive->ready_stat,
+				 BUSY_STAT|DRQ_STAT|ERR_STAT,
+				 WAIT_CMD, &stat);
 	hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 	if (result)
 		printk(KERN_ERR "%s: pmac_ide_do_setfeature disk not ready "
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1152,7 +1152,7 @@ extern void SELECT_MASK(ide_drive_t *, i
 extern void QUIRK_LIST(ide_drive_t *);
 
 extern int drive_is_ready(ide_drive_t *);
-extern int wait_for_ready(ide_drive_t *, int /* timeout */);
+int __ide_wait_stat(ide_drive_t *, u8, u8, unsigned long);
 
 /*
  * taskfile io for disks for now...and builds request from ide_ioctl
