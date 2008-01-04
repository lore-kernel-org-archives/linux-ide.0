From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/15] ide: remove hwif->present manipulations from hwif_init()
Date: Fri, 04 Jan 2008 22:24:46 +0100
Message-ID: <20080104212446.6978.63773.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:38027 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871AbYADVNK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:13:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833654ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:13:09 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Call hwif_init() only if hwif->present is set.

* If hwif_init() fails clear hwif->present.

* Remove hwif->present manipulations from hwif_init().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-24 bytes
 drivers/ide/ide-probe.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1245,28 +1245,21 @@ static int hwif_init(ide_hwif_t *hwif)
 {
 	int old_irq;
 
-	/* Return success if no device is connected */
-	if (!hwif->present)
-		return 1;
-
 	if (!hwif->irq) {
 		if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET])))
 		{
 			printk("%s: DISABLED, NO IRQ\n", hwif->name);
-			return (hwif->present = 0);
+			return 0;
 		}
 	}
 #ifdef CONFIG_BLK_DEV_HD
 	if (hwif->irq == HD_IRQ && hwif->io_ports[IDE_DATA_OFFSET] != HD_DATA) {
 		printk("%s: CANNOT SHARE IRQ WITH OLD "
 			"HARDDISK DRIVER (hd.c)\n", hwif->name);
-		return (hwif->present = 0);
+		return 0;
 	}
 #endif /* CONFIG_BLK_DEV_HD */
 
-	/* we set it back to 1 if all is ok below */	
-	hwif->present = 0;
-
 	if (register_blkdev(hwif->major, hwif->name))
 		return 0;
 
@@ -1305,10 +1298,7 @@ static int hwif_init(ide_hwif_t *hwif)
 
 done:
 	init_gendisk(hwif);
-
 	ide_acpi_init(hwif);
-
-	hwif->present = 1;	/* success */
 	return 1;
 
 out:
@@ -1352,9 +1342,13 @@ int ide_device_add_all(u8 *idx)
 
 		hwif = &ide_hwifs[idx[i]];
 
+		if (!hwif->present)
+			continue;
+
 		if (hwif_init(hwif) == 0) {
 			printk(KERN_INFO "%s: failed to initialize IDE "
 					 "interface\n", hwif->name);
+			hwif->present = 0;
 			rc = -1;
 			continue;
 		}
