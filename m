From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/4] sl82c105: check bridge revision in sl82c105_init_one()
Date: Sun, 9 Mar 2008 16:59:19 +0100
Message-ID: <200803091659.19536.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753800AbYCIPs5@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

* Make sl82c105_bridge_revision() return 'u8' instead of 'unsigned long'.

* Check bridge revision in sl82c105_init_one().

While at:

* Use proper KERN_ level for printk().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sl82c105.c |   35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -232,7 +232,7 @@ static void sl82c105_resetproc(ide_drive
  * Return the revision of the Winbond bridge
  * which this function is part of.
  */
-static unsigned int sl82c105_bridge_revision(struct pci_dev *dev)
+static u8 sl82c105_bridge_revision(struct pci_dev *dev)
 {
 	struct pci_dev *bridge;
 
@@ -287,27 +287,11 @@ static unsigned int __devinit init_chips
  */
 static void __devinit init_hwif_sl82c105(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
-	unsigned int rev;
-
 	DBG(("init_hwif_sl82c105(hwif: ide%d)\n", hwif->index));
 
 	if (!hwif->dma_base)
 		return;
 
-	rev = sl82c105_bridge_revision(dev);
-	if (rev <= 5) {
-		/*
-		 * Never ever EVER under any circumstances enable
-		 * DMA when the bridge is this old.
-		 */
-		printk("    %s: Winbond W83C553 bridge revision %d, "
-		       "BM-DMA disabled\n", hwif->name, rev);
-		return;
-	}
-
-	hwif->mwdma_mask = ATA_MWDMA2;
-
 	hwif->dma_lost_irq		= &sl82c105_dma_lost_irq;
 	hwif->dma_start			= &sl82c105_dma_start;
 	hwif->ide_dma_end		= &sl82c105_dma_end;
@@ -337,11 +321,26 @@ static const struct ide_port_info sl82c1
 #endif
 			  IDE_HFLAG_NO_AUTODMA,
 	.pio_mask	= ATA_PIO5,
+	.mwdma_mask	= ATA_MWDMA2,
 };
 
 static int __devinit sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	return ide_setup_pci_device(dev, &sl82c105_chipset);
+	struct ide_port_info d = sl82c105_chipset;
+	u8 rev = sl82c105_bridge_revision(dev);
+
+	if (rev <= 5) {
+		/*
+		 * Never ever EVER under any circumstances enable
+		 * DMA when the bridge is this old.
+		 */
+		printk(KERN_INFO "W82C105_IDE: Winbond W83C553 bridge "
+				 "revision %d, BM-DMA disabled\n", rev);
+		d.init_hwif = NULL;
+		d.mwdma_mask = 0;
+	}
+
+	return ide_setup_pci_device(dev, &d);
 }
 
 static const struct pci_device_id sl82c105_pci_tbl[] = {
