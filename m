From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 27/64] alim15x3: add ali_fifo_control() helper
Date: Mon, 18 Jan 2010 18:17:50 +0100
Message-ID: <20100118171750.14623.44548.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755669Ab0ARR30@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] alim15x3: add ali_fifo_control() helper

Based on libata pata_ali host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/alim15x3.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

Index: b/drivers/ide/alim15x3.c
===================================================================
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -48,6 +48,19 @@ static u8 m5229_revision;
 static u8 chip_is_1543c_e;
 static struct pci_dev *isa_dev;
 
+static void ali_fifo_control(ide_hwif_t *hwif, ide_drive_t *drive, int on)
+{
+	struct pci_dev *pdev = to_pci_dev(hwif->dev);
+	int pio_fifo = 0x54 + hwif->channel;
+	u8 fifo;
+	int shift = 4 * (drive->dn & 1);
+
+	pci_read_config_byte(pdev, pio_fifo, &fifo);
+	fifo &= ~(0x0F << shift);
+	fifo |= (on << shift);
+	pci_write_config_byte(pdev, pio_fifo, fifo);
+}
+
 /**
  *	ali_set_pio_mode	-	set host controller for PIO mode
  *	@drive: drive
@@ -64,8 +77,7 @@ static void ali_set_pio_mode(ide_drive_t
 	int bus_speed = ide_pci_clk ? ide_pci_clk : 33;
 	unsigned long T =  1000000 / bus_speed; /* PCI clock based */
 	int port = hwif->channel ? 0x5c : 0x58;
-	int portFIFO = hwif->channel ? 0x55 : 0x54;
-	u8 cd_dma_fifo = 0, unit = drive->dn & 1;
+	u8 unit = drive->dn & 1;
 	struct ide_timing t;
 
 	ide_timing_compute(drive, XFER_PIO_0 + pio, &t, T, 1);
@@ -79,20 +91,7 @@ static void ali_set_pio_mode(ide_drive_t
 	/* 
 	 * PIO mode => ATA FIFO on, ATAPI FIFO off
 	 */
-	pci_read_config_byte(dev, portFIFO, &cd_dma_fifo);
-	if (drive->media==ide_disk) {
-		if (unit) {
-			pci_write_config_byte(dev, portFIFO, (cd_dma_fifo & 0x0F) | 0x50);
-		} else {
-			pci_write_config_byte(dev, portFIFO, (cd_dma_fifo & 0xF0) | 0x05);
-		}
-	} else {
-		if (unit) {
-			pci_write_config_byte(dev, portFIFO, cd_dma_fifo & 0x0F);
-		} else {
-			pci_write_config_byte(dev, portFIFO, cd_dma_fifo & 0xF0);
-		}
-	}
+	ali_fifo_control(hwif, drive, (drive->media == ide_disk) ? 0x05 : 0x00);
 
 	pci_write_config_byte(dev, port, t.setup);
 	pci_write_config_byte(dev, port + unit + 2,
