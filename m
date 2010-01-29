From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 65/68] triflex: convert to ide2libata
Date: Fri, 29 Jan 2010 17:10:07 +0100
Message-ID: <20100129161007.21495.57251.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755185Ab0A2QKb@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] triflex: convert to ide2libata

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/triflex.c |   57 +++++---------------------------------------------
 1 file changed, 6 insertions(+), 51 deletions(-)

Index: b/drivers/ide/triflex.c
===================================================================
--- a/drivers/ide/triflex.c
+++ b/drivers/ide/triflex.c
@@ -34,62 +34,17 @@
 
 #define DRV_NAME "triflex"
 
-static void triflex_set_mode(ide_hwif_t *hwif, ide_drive_t *drive)
-{
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	u32 triflex_timings = 0;
-	u16 timing = 0;
-	u8 channel_offset = hwif->channel ? 0x74 : 0x70, unit = drive->dn & 1;
-
-	pci_read_config_dword(dev, channel_offset, &triflex_timings);
-
-	switch (drive->dma_mode) {
-		case XFER_MW_DMA_2:
-			timing = 0x0103; 
-			break;
-		case XFER_MW_DMA_1:
-			timing = 0x0203;
-			break;
-		case XFER_MW_DMA_0:
-			timing = 0x0808;
-			break;
-		case XFER_SW_DMA_2:
-		case XFER_SW_DMA_1:
-		case XFER_SW_DMA_0:
-			timing = 0x0f0f;
-			break;
-		case XFER_PIO_4:
-			timing = 0x0202;
-			break;
-		case XFER_PIO_3:
-			timing = 0x0204;
-			break;
-		case XFER_PIO_2:
-			timing = 0x0404;
-			break;
-		case XFER_PIO_1:
-			timing = 0x0508;
-			break;
-		case XFER_PIO_0:
-			timing = 0x0808;
-			break;
-	}
-
-	triflex_timings &= ~(0xFFFF << (16 * unit));
-	triflex_timings |= (timing << (16 * unit));
-	
-	pci_write_config_dword(dev, channel_offset, triflex_timings);
-}
+#include <linux/ide2libata.h>
+#include "../ata/pata_triflex.h"
 
-static void triflex_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
+static void triflex_set_dmamode(ide_hwif_t *hwif, ide_drive_t *drive)
 {
-	drive->dma_mode = drive->pio_mode;
-	triflex_set_mode(hwif, drive);
+	triflex_load_timing(hwif, drive, drive->dma_mode);
 }
 
 static const struct ide_port_ops triflex_port_ops = {
-	.set_pio_mode		= triflex_set_pio_mode,
-	.set_dma_mode		= triflex_set_mode,
+	.set_pio_mode		= triflex_set_piomode,
+	.set_dma_mode		= triflex_set_dmamode,
 };
 
 static const struct ide_port_info triflex_device __devinitdata = {
