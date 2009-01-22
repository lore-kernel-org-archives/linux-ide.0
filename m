From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/8] ide: fix kmalloc() failure handling in ide_driveid_update()
Date: Thu, 22 Jan 2009 15:18:08 +0100
Message-ID: <20090122141808.25516.83310.sendpatchset@localhost.localdomain>
References: <20090122141801.25516.5620.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:6453 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156AbZAVORj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 09:17:39 -0500
In-Reply-To: <20090122141801.25516.5620.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix kmalloc() failure handling in ide_driveid_update()

* Doing kmalloc() in the middle of command execution is not only ugly
  but leaves drive waiting to send data on kmalloc() failure.  Fix it.

While at it:

* Unify error code paths.

* Fixup error message to be more useful and add missing KERN_ERR level.

* Rename 'stat' variable to 's'.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -293,7 +293,12 @@ int ide_driveid_update(ide_drive_t *driv
 	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
 	u16 *id;
 	unsigned long flags;
-	u8 stat;
+	int rc;
+	u8 uninitialized_var(s);
+
+	id = kmalloc(SECTOR_SIZE, GFP_ATOMIC);
+	if (id == NULL)
+		return 0;
 
 	/*
 	 * Re-read drive->id for possible DMA mode
@@ -306,25 +311,21 @@ int ide_driveid_update(ide_drive_t *driv
 	tp_ops->exec_command(hwif, ATA_CMD_ID_ATA);
 
 	if (ide_busy_sleep(hwif, WAIT_WORSTCASE, 1)) {
-		SELECT_MASK(drive, 0);
-		return 0;
+		rc = 1;
+		goto out_err;
 	}
 
 	msleep(50);	/* wait for IRQ and ATA_DRQ */
-	stat = tp_ops->read_status(hwif);
 
-	if (!OK_STAT(stat, ATA_DRQ, BAD_R_STAT)) {
-		SELECT_MASK(drive, 0);
-		printk("%s: CHECK for good STATUS\n", drive->name);
-		return 0;
+	s = tp_ops->read_status(hwif);
+
+	if (!OK_STAT(s, ATA_DRQ, BAD_R_STAT)) {
+		rc = 2;
+		goto out_err;
 	}
+
 	local_irq_save(flags);
 	SELECT_MASK(drive, 0);
-	id = kmalloc(SECTOR_SIZE, GFP_ATOMIC);
-	if (!id) {
-		local_irq_restore(flags);
-		return 0;
-	}
 	tp_ops->input_data(drive, NULL, id, SECTOR_SIZE);
 	(void)tp_ops->read_status(hwif);	/* clear drive IRQ */
 	local_irq_enable();
@@ -342,6 +343,12 @@ int ide_driveid_update(ide_drive_t *driv
 		ide_dma_off(drive);
 
 	return 1;
+out_err:
+	SELECT_MASK(drive, 0);
+	if (rc == 2)
+		printk(KERN_ERR "%s: %s: bad status\n", drive->name, __func__);
+	kfree(id);
+	return 0;
 }
 
 int ide_config_drive_speed(ide_drive_t *drive, u8 speed)
