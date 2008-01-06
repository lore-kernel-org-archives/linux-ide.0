From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/8] dtc2278: fix ->io_32bit handling
Date: Sun, 06 Jan 2008 18:02:27 +0100
Message-ID: <20080106170227.6861.71421.sendpatchset@localhost.localdomain>
References: <20080106170220.6861.4814.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:18967 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757549AbYAFQul (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2008 11:50:41 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3036620ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jan 2008 08:50:40 -0800 (PST)
In-Reply-To: <20080106170220.6861.4814.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On DTC2278 32-bit I/O has to be enabled for both devices on the port
so always enable it during init time and disallow further changes.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c            |    4 ----
 drivers/ide/legacy/dtc2278.c |   12 ++++++------
 2 files changed, 6 insertions(+), 10 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -791,10 +791,6 @@ int set_io_32bit(ide_drive_t *drive, int
 		return -EBUSY;
 
 	drive->io_32bit = arg;
-#ifdef CONFIG_BLK_DEV_DTC2278
-	if (HWIF(drive)->chipset == ide_dtc2278)
-		HWIF(drive)->drives[!drive->select.b.unit].io_32bit = arg;
-#endif /* CONFIG_BLK_DEV_DTC2278 */
 
 	spin_unlock_irq(&ide_lock);
 
Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -84,12 +84,6 @@ static void dtc2278_set_pio_mode(ide_dri
 		/* Actually we do - there is a data sheet available for the
 		   Winbond but does anyone actually care */
 	}
-
-	/*
-	 * 32bit I/O has to be enabled for *both* drives at the same time.
-	 */
-	drive->io_32bit = 1;
-	HWIF(drive)->drives[!drive->select.b.unit].io_32bit = 1;
 }
 
 static int __init dtc2278_probe(void)
@@ -123,18 +117,24 @@ static int __init dtc2278_probe(void)
 	local_irq_restore(flags);
 
 	hwif->serialized = 1;
+	hwif->no_io_32bit = 1;	/* disallow ->io_32bit changes */
 	hwif->chipset = ide_dtc2278;
 	hwif->pio_mask = ATA_PIO4;
 	hwif->set_pio_mode = &dtc2278_set_pio_mode;
 	hwif->drives[0].no_unmask = 1;
 	hwif->drives[1].no_unmask = 1;
+	hwif->drives[0].io_32bit = 1;
+	hwif->drives[1].io_32bit = 1;
 	hwif->mate = mate;
 
 	mate->serialized = 1;
+	mate->no_io_32bit = 1;
 	mate->chipset = ide_dtc2278;
 	mate->pio_mask = ATA_PIO4;
 	mate->drives[0].no_unmask = 1;
 	mate->drives[1].no_unmask = 1;
+	mate->drives[0].io_32bit = 1;
+	mate->drives[1].io_32bit = 1;
 	mate->mate = hwif;
 	mate->channel = 1;
 
