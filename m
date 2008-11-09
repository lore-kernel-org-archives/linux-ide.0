From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/11] ide: push local_irq_{save,restore}() to do_identify()
Date: Sun, 09 Nov 2008 17:23:31 +0100
Message-ID: <20081109162331.18999.93299.sendpatchset@localhost.localdomain>
References: <20081109162219.18999.74912.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:60863 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784AbYKIQZb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 11:25:31 -0500
In-Reply-To: <20081109162219.18999.74912.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: push local_irq_{save,restore}() to do_identify()

Push local_irq_{save,restore}() from actual_try_to_identify()
to do_identify() and remove no longer needed local_irq_enable().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -116,14 +116,16 @@ static inline void do_identify (ide_driv
 	ide_hwif_t *hwif = HWIF(drive);
 	u16 *id = drive->id;
 	char *m = (char *)&id[ATA_ID_PROD];
+	unsigned long flags;
 	int bswap = 1, is_cfa;
 
+	/* local CPU only; some systems need this */
+	local_irq_save(flags);
 	/* read 512 bytes of id info */
 	hwif->tp_ops->input_data(drive, NULL, id, SECTOR_SIZE);
+	local_irq_restore(flags);
 
 	drive->dev_flags |= IDE_DFLAG_ID_READ;
-
-	local_irq_enable();
 #ifdef DEBUG
 	printk(KERN_INFO "%s: dumping identify data\n", drive->name);
 	ide_dump_identify((u8 *)id);
@@ -305,17 +307,12 @@ static int actual_try_to_identify (ide_d
 	s = tp_ops->read_status(hwif);
 
 	if (OK_STAT(s, ATA_DRQ, BAD_R_STAT)) {
-		unsigned long flags;
-
-		/* local CPU only; some systems need this */
-		local_irq_save(flags);
 		/* drive returned ID */
 		do_identify(drive, cmd);
 		/* drive responded with ID */
 		rc = 0;
 		/* clear drive IRQ */
 		(void)tp_ops->read_status(hwif);
-		local_irq_restore(flags);
 	} else {
 		/* drive refused ID */
 		rc = 2;
