From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/8] ide: propagate AltStatus workarounds to ide_driveid_update()
Date: Thu, 22 Jan 2009 15:18:14 +0100
Message-ID: <20090122141814.25516.17811.sendpatchset@localhost.localdomain>
References: <20090122141801.25516.5620.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f20.google.com ([209.85.219.20]:58120 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757244AbZAVORp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 09:17:45 -0500
In-Reply-To: <20090122141801.25516.5620.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: propagate AltStatus workarounds to ide_driveid_update()

Propagate AltStatus workarounds from try_to_identify()
to ide_driveid_update().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -293,8 +293,8 @@ int ide_driveid_update(ide_drive_t *driv
 	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
 	u16 *id;
 	unsigned long flags;
-	int rc;
-	u8 uninitialized_var(s);
+	int use_altstatus = 0, rc;
+	u8 a, uninitialized_var(s);
 
 	id = kmalloc(SECTOR_SIZE, GFP_ATOMIC);
 	if (id == NULL)
@@ -308,9 +308,24 @@ int ide_driveid_update(ide_drive_t *driv
 	SELECT_MASK(drive, 1);
 	tp_ops->set_irq(hwif, 0);
 	msleep(50);
+
+	if (hwif->io_ports.ctl_addr &&
+	    (hwif->host_flags & IDE_HFLAG_BROKEN_ALTSTATUS) == 0) {
+		a = tp_ops->read_altstatus(hwif);
+		s = tp_ops->read_status(hwif);
+		if ((a ^ s) & ~ATA_IDX)
+			/* ancient Seagate drives, broken interfaces */
+			printk(KERN_INFO "%s: probing with STATUS(0x%02x) "
+					 "instead of ALTSTATUS(0x%02x)\n",
+					 drive->name, s, a);
+		else
+			/* use non-intrusive polling */
+			use_altstatus = 1;
+	}
+
 	tp_ops->exec_command(hwif, ATA_CMD_ID_ATA);
 
-	if (ide_busy_sleep(hwif, WAIT_WORSTCASE, 1)) {
+	if (ide_busy_sleep(hwif, WAIT_WORSTCASE, use_altstatus)) {
 		rc = 1;
 		goto out_err;
 	}
