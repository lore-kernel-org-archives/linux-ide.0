From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/8] ide: add ide_set_irq() inline helper
Date: Thu, 29 Nov 2007 01:04:21 +0100
Message-ID: <200711290104.21376.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:44019 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756050AbXK2ACq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 19:02:46 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1659756ugc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 16:02:44 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c       |    9 +++------
 drivers/ide/ide-iops.c     |   10 ++++------
 drivers/ide/ide-probe.c    |   12 ++++--------
 drivers/ide/ide-taskfile.c |    3 +--
 include/linux/ide.h        |    5 +++++
 5 files changed, 17 insertions(+), 22 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -939,8 +939,7 @@ static void ide_check_pm_state(ide_drive
 		if (rc)
 			printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
 		SELECT_DRIVE(drive);
-		if (IDE_CONTROL_REG)
-			HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
+		ide_set_irq(drive, 1);
 		rc = ide_wait_not_busy(HWIF(drive), 100000);
 		if (rc)
 			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name);
@@ -1212,15 +1211,13 @@ static void ide_do_request (ide_hwgroup_
 		}
 	again:
 		hwif = HWIF(drive);
-		if (hwgroup->hwif->sharing_irq &&
-		    hwif != hwgroup->hwif &&
-		    hwif->io_ports[IDE_CONTROL_OFFSET]) {
+		if (hwgroup->hwif->sharing_irq && hwif != hwgroup->hwif) {
 			/*
 			 * set nIEN for previous hwif, drives in the
 			 * quirk_list may not like intr setups/cleanups
 			 */
 			if (drive->quirk_list != 1)
-				hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
+				ide_set_irq(drive, 0);
 		}
 		hwgroup->hwif = hwif;
 		hwgroup->drive = drive;
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -688,8 +688,7 @@ int ide_driveid_update(ide_drive_t *driv
 	 */
 
 	SELECT_MASK(drive, 1);
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);
+	ide_set_irq(drive, 1);
 	msleep(50);
 	hwif->OUTB(WIN_IDENTIFY, IDE_COMMAND_REG);
 	timeout = jiffies + WAIT_WORSTCASE;
@@ -769,13 +768,12 @@ int ide_config_drive_speed(ide_drive_t *
 	SELECT_DRIVE(drive);
 	SELECT_MASK(drive, 0);
 	udelay(1);
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
+	ide_set_irq(drive, 0);
 	hwif->OUTB(speed, IDE_NSECTOR_REG);
 	hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
 	hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
-	if ((IDE_CONTROL_REG) && (drive->quirk_list == 2))
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
+	if (drive->quirk_list == 2)
+		ide_set_irq(drive, 1);
 
 	error = __ide_wait_stat(drive, drive->ready_stat,
 				BUSY_STAT|DRQ_STAT|ERR_STAT,
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -364,22 +364,19 @@ static int try_to_identify (ide_drive_t 
 	 * the irq handler isn't expecting.
 	 */
 	if (IDE_CONTROL_REG) {
-		u8 ctl = drive->ctl | 2;
 		if (!hwif->irq) {
 			autoprobe = 1;
 			cookie = probe_irq_on();
-			/* enable device irq */
-			ctl &= ~2;
 		}
-		hwif->OUTB(ctl, IDE_CONTROL_REG);
+		ide_set_irq(drive, autoprobe);
 	}
 
 	retval = actual_try_to_identify(drive, cmd);
 
 	if (autoprobe) {
 		int irq;
-		/* mask device irq */
-		hwif->OUTB(drive->ctl|2, IDE_CONTROL_REG);
+
+		ide_set_irq(drive, 0);
 		/* clear drive IRQ */
 		(void) hwif->INB(IDE_STATUS_REG);
 		udelay(5);
@@ -667,8 +664,7 @@ static int wait_hwif_ready(ide_hwif_t *h
 		/* Ignore disks that we will not probe for later. */
 		if (!drive->noprobe || drive->present) {
 			SELECT_DRIVE(drive);
-			if (IDE_CONTROL_REG)
-				hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
+			ide_set_irq(drive, 1);
 			mdelay(2);
 			rc = ide_wait_not_busy(hwif, 35000);
 			if (rc)
Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -83,8 +83,7 @@ void ide_tf_load(ide_drive_t *drive, ide
 		tf->hob_lbam, tf->hob_lbah);
 #endif
 
-	if (IDE_CONTROL_REG)
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG); /* clear nIEN */
+	ide_set_irq(drive, 1);
 
 	if ((task->tf_flags & IDE_TFLAG_NO_SELECT_MASK) == 0)
 		SELECT_MASK(drive, 0);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1302,4 +1302,9 @@ static inline ide_drive_t *ide_get_paire
 	return &hwif->drives[(drive->dn ^ 1) & 1];
 }
 
+static inline void ide_set_irq(ide_drive_t *drive, int on)
+{
+	drive->hwif->OUTB(drive->ctl | (on ? 0 : 2), IDE_CONTROL_REG);
+}
+
 #endif /* _IDE_H */
