From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/8] ide: add missing checks for control register existence
Date: Thu, 29 Nov 2007 01:03:32 +0100
Message-ID: <200711290103.32757.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:43996 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243AbXK2ACo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 19:02:44 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1659751ugc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 16:02:43 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add missing checks for control register existence (some legacy m68k specific
IDE controllers don't have it).  Also use drive->ctl while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c    |    3 ++-
 drivers/ide/ide-probe.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -939,7 +939,8 @@ static void ide_check_pm_state(ide_drive
 		if (rc)
 			printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
 		SELECT_DRIVE(drive);
-		HWIF(drive)->OUTB(8, HWIF(drive)->io_ports[IDE_CONTROL_OFFSET]);
+		if (IDE_CONTROL_REG)
+			HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
 		rc = ide_wait_not_busy(HWIF(drive), 100000);
 		if (rc)
 			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name);
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -667,7 +667,8 @@ static int wait_hwif_ready(ide_hwif_t *h
 		/* Ignore disks that we will not probe for later. */
 		if (!drive->noprobe || drive->present) {
 			SELECT_DRIVE(drive);
-			hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
+			if (IDE_CONTROL_REG)
+				hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
 			mdelay(2);
 			rc = ide_wait_not_busy(hwif, 35000);
 			if (rc)
