From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/11] ide-pmac: remove extra good status wait from pmac_ide_do_setfeature()
Date: Sun, 22 Jul 2007 20:32:28 +0200
Message-ID: <200707222032.28467.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:34860 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758108AbXGVSTK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:19:10 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1001371ugf
        for <linux-ide@vger.kernel.org>; Sun, 22 Jul 2007 11:19:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Don't check for good device status before executing the command in
pmac_ide_do_setfeature() (ide_config_drive_speed() doesn't do this).

It is a job of upper layers to guarantee that the device is ready to
accept new command before we get here.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -547,16 +547,6 @@ pmac_ide_do_setfeature(ide_drive_t *driv
 	SELECT_DRIVE(drive);
 	SELECT_MASK(drive, 0);
 	udelay(1);
-	/* Get rid of pending error state */
-	(void) hwif->INB(IDE_STATUS_REG);
-	/* Timeout bumped for some powerbooks */
-	if (wait_for_ready(drive, 2000)) {
-		/* Timeout bumped for some powerbooks */
-		printk(KERN_ERR "%s: pmac_ide_do_setfeature disk not ready "
-			"before SET_FEATURE!\n", drive->name);
-		goto out;
-	}
-	udelay(10);
 	hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
 	hwif->OUTB(command, IDE_NSECTOR_REG);
 	hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
@@ -568,7 +558,7 @@ pmac_ide_do_setfeature(ide_drive_t *driv
 	if (result)
 		printk(KERN_ERR "%s: pmac_ide_do_setfeature disk not ready "
 			"after SET_FEATURE !\n", drive->name);
-out:
+
 	SELECT_MASK(drive, 0);
 	if (result == 0) {
 		drive->id->dma_ultra &= ~0xFF00;
