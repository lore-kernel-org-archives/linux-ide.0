From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 05/16] ide-probe: remove needless Status register reads
Date: Tue, 22 Jan 2008 00:31:10 +0100
Message-ID: <20080121233110.30311.7772.sendpatchset@localhost.localdomain>
References: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:43625 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756919AbYAUXSG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 18:18:06 -0500
Received: by ug-out-1314.google.com with SMTP id z38so975308ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 15:18:04 -0800 (PST)
In-Reply-To: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


* Cache value read from the Status register in 'stat' variable in do_probe()
  and enable_nest(), then remove remove needless Status register reads.

While at it:

* Add proper KERN_* levels to printk() calls.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -423,8 +423,9 @@ static int ide_busy_sleep(ide_hwif_t *hw
 
 static int do_probe (ide_drive_t *drive, u8 cmd)
 {
-	int rc;
 	ide_hwif_t *hwif = HWIF(drive);
+	int rc;
+	u8 stat;
 
 	if (drive->present) {
 		/* avoid waiting for inappropriate probes */
@@ -461,15 +462,17 @@ static int do_probe (ide_drive_t *drive,
 			/* failed: try again */
 			rc = try_to_identify(drive,cmd);
 		}
-		if (hwif->INB(IDE_STATUS_REG) == (BUSY_STAT|READY_STAT))
+
+		stat = hwif->INB(IDE_STATUS_REG);
+
+		if (stat == (BUSY_STAT | READY_STAT))
 			return 4;
 
 		if ((rc == 1 && cmd == WIN_PIDENTIFY) &&
 			((drive->autotune == IDE_TUNE_DEFAULT) ||
 			(drive->autotune == IDE_TUNE_AUTO))) {
-			printk("%s: no response (status = 0x%02x), "
-				"resetting drive\n", drive->name,
-				hwif->INB(IDE_STATUS_REG));
+			printk(KERN_ERR "%s: no response (status = 0x%02x), "
+					"resetting drive\n", drive->name, stat);
 			msleep(50);
 			hwif->OUTB(drive->select.all, IDE_SELECT_REG);
 			msleep(50);
@@ -477,11 +480,13 @@ static int do_probe (ide_drive_t *drive,
 			(void)ide_busy_sleep(hwif);
 			rc = try_to_identify(drive, cmd);
 		}
+
+		/* ensure drive IRQ is clear */
+		stat = hwif->INB(IDE_STATUS_REG);
+
 		if (rc == 1)
-			printk("%s: no response (status = 0x%02x)\n",
-				drive->name, hwif->INB(IDE_STATUS_REG));
-		/* ensure drive irq is clear */
-		(void) hwif->INB(IDE_STATUS_REG);
+			printk(KERN_ERR "%s: no response (status = 0x%02x)\n",
+					drive->name, stat);
 	} else {
 		/* not present or maybe ATAPI */
 		rc = 3;
@@ -502,6 +507,7 @@ static int do_probe (ide_drive_t *drive,
 static void enable_nest (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
+	u8 stat;
 
 	printk("%s: enabling %s -- ", hwif->name, drive->id->model);
 	SELECT_DRIVE(drive);
@@ -515,11 +521,12 @@ static void enable_nest (ide_drive_t *dr
 
 	msleep(50);
 
-	if (!OK_STAT((hwif->INB(IDE_STATUS_REG)), 0, BAD_STAT)) {
-		printk("failed (status = 0x%02x)\n", hwif->INB(IDE_STATUS_REG));
-	} else {
-		printk("success\n");
-	}
+	stat = hwif->INB(IDE_STATUS_REG);
+
+	if (!OK_STAT(stat, 0, BAD_STAT))
+		printk(KERN_CONT "failed (status = 0x%02x)\n", stat);
+	else
+		printk(KERN_CONT "success\n");
 
 	/* if !(success||timed-out) */
 	if (do_probe(drive, WIN_IDENTIFY) >= 2) {
