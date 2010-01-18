From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 36/64] pdc202xx_old: add ->init_hwif method
Date: Mon, 18 Jan 2010 18:19:14 +0100
Message-ID: <20100118171914.14623.74426.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:57577 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079Ab0ARRUZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:20:25 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pdc202xx_old: add ->init_hwif method

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pdc202xx_old.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

Index: b/drivers/ide/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pdc202xx_old.c
+++ b/drivers/ide/pdc202xx_old.c
@@ -1,7 +1,7 @@
 /*
  *  Copyright (C) 1998-2002		Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2006-2007, 2009	MontaVista Software, Inc.
- *  Copyright (C) 2007			Bartlomiej Zolnierkiewicz
+ *  Copyright (C) 2007-2010		Bartlomiej Zolnierkiewicz
  *
  *  Portions Copyright (C) 1999 Promise Technology, Inc.
  *  Author: Frank Tiernan (frankt@promise.com)
@@ -21,8 +21,6 @@
 
 #define DRV_NAME "pdc202xx_old"
 
-static void pdc_old_disable_66MHz_clock(ide_hwif_t *);
-
 static void pdc202xx_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= drive->hwif;
@@ -32,12 +30,6 @@ static void pdc202xx_set_mode(ide_drive_
 	u8			AP = 0, BP = 0, CP = 0;
 	u8			TA = 0, TB = 0, TC = 0;
 
-	/*
-	 * TODO: do this once per channel
-	 */
-	if (dev->device != PCI_DEVICE_ID_PROMISE_20246)
-		pdc_old_disable_66MHz_clock(hwif);
-
 	pci_read_config_byte(dev, drive_pci,     &AP);
 	pci_read_config_byte(dev, drive_pci + 1, &BP);
 	pci_read_config_byte(dev, drive_pci + 2, &CP);
@@ -145,6 +137,11 @@ static void pdc_old_disable_66MHz_clock(
 	outb(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
 }
 
+static void pdc2026x_init_hwif(ide_hwif_t *hwif)
+{
+	pdc_old_disable_66MHz_clock(hwif);
+}
+
 static void pdc202xx_dma_start(ide_drive_t *drive)
 {
 	if (drive->current_speed > XFER_UDMA_2)
@@ -261,6 +258,7 @@ static const struct ide_dma_ops pdc2026x
 	{ \
 		.name		= DRV_NAME, \
 		.init_chipset	= init_chipset_pdc202xx, \
+		.init_hwif	= pdc2026x_init_hwif, \
 		.port_ops	= &pdc2026x_port_ops, \
 		.dma_ops	= &pdc2026x_dma_ops, \
 		.host_flags	= IDE_HFLAGS_PDC202XX, \
@@ -356,6 +354,6 @@ static void __exit pdc202xx_ide_exit(voi
 module_init(pdc202xx_ide_init);
 module_exit(pdc202xx_ide_exit);
 
-MODULE_AUTHOR("Andre Hedrick, Frank Tiernan");
+MODULE_AUTHOR("Andre Hedrick, Frank Tiernan, Bartlomiej Zolnierkiewicz");
 MODULE_DESCRIPTION("PCI driver module for older Promise IDE");
 MODULE_LICENSE("GPL");
