From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/8] ide: clear drive IRQ after re-enabling local IRQs in ide_driveid_update()
Date: Thu, 22 Jan 2009 15:18:48 +0100
Message-ID: <20090122141848.25516.13248.sendpatchset@localhost.localdomain>
References: <20090122141801.25516.5620.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f20.google.com ([209.85.219.20]:58120 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756188AbZAVOST (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 09:18:19 -0500
In-Reply-To: <20090122141801.25516.5620.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: clear drive IRQ after re-enabling local IRQs in ide_driveid_update()

Clear drive IRQ after re-enabling local IRQs in ide_driveid_update()
to match try_to_identify().

Also remove superfluous local_irq_enable() call while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -341,10 +341,10 @@ int ide_driveid_update(ide_drive_t *driv
 
 	local_irq_save(flags);
 	tp_ops->input_data(drive, NULL, id, SECTOR_SIZE);
-	(void)tp_ops->read_status(hwif);	/* clear drive IRQ */
-	local_irq_enable();
 	local_irq_restore(flags);
 
+	(void)tp_ops->read_status(hwif); /* clear drive IRQ */
+
 	ide_fix_driveid(id);
 
 	SELECT_MASK(drive, 0);
