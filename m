From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/6] ide: add ide_busy_sleep() helper
Date: Mon, 3 Dec 2007 22:52:53 +0100
Message-ID: <200712032252.53249.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:20741 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbXLCVrU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 16:47:20 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2458768ugc
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2007 13:47:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add ide_busy_sleep() helper and use it in do_probe(),
enable_nest() and probe_hwif().

As a nice side-effect this fixes a minor bug in enable_nest()
(the code was reading status register without any delay).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -382,6 +382,20 @@ static int try_to_identify (ide_drive_t 
 	return retval;
 }
 
+static int ide_busy_sleep(ide_hwif_t *hwif)
+{
+	unsigned long timeout = jiffies + WAIT_WORSTCASE;
+	u8 stat;
+
+	do {
+		msleep(50);
+		stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
+		if ((stat & BUSY_STAT) == 0)
+			return 0;
+	} while (time_before(jiffies, timeout));
+
+	return 1;
+}
 
 /**
  *	do_probe		-	probe an IDE device
@@ -450,7 +464,6 @@ static int do_probe (ide_drive_t *drive,
 		if ((rc == 1 && cmd == WIN_PIDENTIFY) &&
 			((drive->autotune == IDE_TUNE_DEFAULT) ||
 			(drive->autotune == IDE_TUNE_AUTO))) {
-			unsigned long timeout;
 			printk("%s: no response (status = 0x%02x), "
 				"resetting drive\n", drive->name,
 				hwif->INB(IDE_STATUS_REG));
@@ -458,10 +471,7 @@ static int do_probe (ide_drive_t *drive,
 			hwif->OUTB(drive->select.all, IDE_SELECT_REG);
 			msleep(50);
 			hwif->OUTB(WIN_SRST, IDE_COMMAND_REG);
-			timeout = jiffies;
-			while (((hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) &&
-			       time_before(jiffies, timeout + WAIT_WORSTCASE))
-				msleep(50);
+			(void)ide_busy_sleep(hwif);
 			rc = try_to_identify(drive, cmd);
 		}
 		if (rc == 1)
@@ -489,20 +499,16 @@ static int do_probe (ide_drive_t *drive,
 static void enable_nest (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	unsigned long timeout;
 
 	printk("%s: enabling %s -- ", hwif->name, drive->id->model);
 	SELECT_DRIVE(drive);
 	msleep(50);
 	hwif->OUTB(EXABYTE_ENABLE_NEST, IDE_COMMAND_REG);
-	timeout = jiffies + WAIT_WORSTCASE;
-	do {
-		if (time_after(jiffies, timeout)) {
-			printk("failed (timeout)\n");
-			return;
-		}
-		msleep(50);
-	} while ((hwif->INB(IDE_STATUS_REG)) & BUSY_STAT);
+
+	if (ide_busy_sleep(hwif)) {
+		printk(KERN_CONT "failed (timeout)\n");
+		return;
+	}
 
 	msleep(50);
 
@@ -783,18 +789,11 @@ static void probe_hwif(ide_hwif_t *hwif)
 		}
 	}
 	if (hwif->io_ports[IDE_CONTROL_OFFSET] && hwif->reset) {
-		unsigned long timeout = jiffies + WAIT_WORSTCASE;
-		u8 stat;
-
 		printk(KERN_WARNING "%s: reset\n", hwif->name);
 		hwif->OUTB(12, hwif->io_ports[IDE_CONTROL_OFFSET]);
 		udelay(10);
 		hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
-		do {
-			msleep(50);
-			stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
-		} while ((stat & BUSY_STAT) && time_after(timeout, jiffies));
-
+		(void)ide_busy_sleep(hwif);
 	}
 	local_irq_restore(flags);
 	/*
