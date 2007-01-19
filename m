From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/15] piix: cleanup
Date: Fri, 19 Jan 2007 01:31:43 +0100
Message-ID: <20070119003143.14846.10407.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932437AbXASA2E@vger.kernel.org>
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

[PATCH] piix: cleanup

* disable DMA masks if no_piix_dma is set and remove now
  not needed no_piix_dma_check from piix_config_drive_for_dma()
* there is no need to read register 0x55 in init_hwif_piix()
* move cable detection code to piix_cable_detect()
* remove unreachable 82371MX code from init_hwif_piix()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/piix.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -369,7 +369,7 @@ static int piix_config_drive_for_dma (id
 	 * If no DMA speed was available or the chipset has DMA bugs
 	 * then disable DMA and use PIO
 	 */
-	if (!speed || no_piix_dma)
+	if (!speed)
 		return 0;
 
 	(void) piix_tune_chipset(drive, speed);
@@ -444,6 +444,16 @@ static unsigned int __devinit init_chips
 	return 0;
 }
 
+static int __devinit piix_cable_detect(ide_hwif_t *hwif)
+{
+	struct pci_dev *dev = hwif->pci_dev;
+	u8 reg54h = 0, mask = hwif->channel ? 0xc0 : 0x30;
+
+	pci_read_config_byte(dev, 0x54, &reg54h);
+
+	return (reg54h & mask) ? 1 : 0;
+}
+
 /**
  *	init_hwif_piix		-	fill in the hwif for the PIIX
  *	@hwif: IDE interface
@@ -454,9 +464,6 @@ static unsigned int __devinit init_chips
 
 static void __devinit init_hwif_piix(ide_hwif_t *hwif)
 {
-	u8 reg54h = 0, reg55h = 0, ata66 = 0;
-	u8 mask = hwif->channel ? 0xc0 : 0x30;
-
 #ifndef CONFIG_IA64
 	if (!hwif->irq)
 		hwif->irq = hwif->channel ? 15 : 14;
@@ -486,9 +493,6 @@ static void __devinit init_hwif_piix(ide
 	hwif->swdma_mask = 0x04;
 
 	switch(hwif->pci_dev->device) {
-		case PCI_DEVICE_ID_INTEL_82371MX:
-			hwif->mwdma_mask = 0x80;
-			hwif->swdma_mask = 0x80;
 		case PCI_DEVICE_ID_INTEL_82371FB_0:
 		case PCI_DEVICE_ID_INTEL_82371FB_1:
 		case PCI_DEVICE_ID_INTEL_82371SB_1:
@@ -501,14 +505,14 @@ static void __devinit init_hwif_piix(ide
 			hwif->ultra_mask = 0x07;
 			break;
 		default:
-			pci_read_config_byte(hwif->pci_dev, 0x54, &reg54h);
-			pci_read_config_byte(hwif->pci_dev, 0x55, &reg55h);
-			ata66 = (reg54h & mask) ? 1 : 0;
+			if (!hwif->udma_four)
+				hwif->udma_four = piix_cable_detect(hwif);
 			break;
 	}
 
-	if (!(hwif->udma_four))
-		hwif->udma_four = ata66;
+	if (no_piix_dma)
+		hwif->ultra_mask = hwif->mwdma_mask = hwif->swdma_mask = 0;
+
 	hwif->ide_dma_check = &piix_config_drive_xfer_rate;
 	if (!noautodma)
 		hwif->autodma = 1;
