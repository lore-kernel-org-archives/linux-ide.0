From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 43/68] cs5520: convert to ide2libata
Date: Fri, 29 Jan 2010 17:07:43 +0100
Message-ID: <20100129160743.21495.78502.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755224Ab0A2QH5@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cs5520: convert to ide2libata

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cs5520.c |   44 ++++----------------------------------------
 1 file changed, 4 insertions(+), 40 deletions(-)

Index: b/drivers/ide/cs5520.c
===================================================================
--- a/drivers/ide/cs5520.c
+++ b/drivers/ide/cs5520.c
@@ -42,55 +42,19 @@
 
 #define DRV_NAME "cs5520"
 
-struct pio_clocks
-{
-	int address;
-	int assert;
-	int recovery;
-};
-
-static struct pio_clocks cs5520_pio_clocks[]={
-	{3, 6, 11},
-	{2, 5, 6},
-	{1, 4, 3},
-	{1, 3, 2},
-	{1, 2, 1}
-};
-
-static void cs5520_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	struct pci_dev *pdev = to_pci_dev(hwif->dev);
-	int controller = drive->dn > 1 ? 1 : 0;
-	const u8 pio = drive->pio_mode - XFER_PIO_0;
-
-	/* 8bit CAT/CRT - 8bit command timing for channel */
-	pci_write_config_byte(pdev, 0x62 + controller, 
-		(cs5520_pio_clocks[pio].recovery << 4) |
-		(cs5520_pio_clocks[pio].assert));
-
-	/* 0x64 - 16bit Primary, 0x68 - 16bit Secondary */
-
-	/* FIXME: should these use address ? */
-	/* Data read timing */
-	pci_write_config_byte(pdev, 0x64 + 4*controller + (drive->dn&1),
-		(cs5520_pio_clocks[pio].recovery << 4) |
-		(cs5520_pio_clocks[pio].assert));
-	/* Write command timing */
-	pci_write_config_byte(pdev, 0x66 + 4*controller + (drive->dn&1),
-		(cs5520_pio_clocks[pio].recovery << 4) |
-		(cs5520_pio_clocks[pio].assert));
-}
+#include <linux/ide2libata.h>
+#include "../ata/pata_cs5520.h"
 
 static void cs5520_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 {
 	printk(KERN_ERR "cs55x0: bad ide timing.\n");
 
 	drive->pio_mode = XFER_PIO_0 + 0;
-	cs5520_set_pio_mode(hwif, drive);
+	cs5520_set_piomode(hwif, drive);
 }
 
 static const struct ide_port_ops cs5520_port_ops = {
-	.set_pio_mode		= cs5520_set_pio_mode,
+	.set_pio_mode		= cs5520_set_piomode,
 	.set_dma_mode		= cs5520_set_dma_mode,
 };
 
