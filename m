From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (pata-2.6 fix queue) cmd64x: use interrupt status from MRDMODE register
Date: Fri, 16 Feb 2007 23:21:40 +0300
Message-ID: <200702162321.40813.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:53839 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946120AbXBPUVu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 15:21:50 -0500
In-Reply-To: <200702040004.24918.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Fold the parts of the ide_dma_end() methods indetical to __ide_dma_end() into a
mere call to it.
Start using faster versions of the ide_dma_end() and ide_dma_test_irq() methods
for the PCI0646U and newer chips that have the duplicate interrupt status bits
in the I/O mapped MRDMODE register, determing what methods to use at the driver
load time.  Do some cleanup/renaming in the "old" ide_dma_test_irq() method.

While at it, fix minor issues with PCI0646 chipset reporting:

- "IRQ workaround enabled" printed out not only for revision 0x01;

- "CMD646: chipset revision" printed twice (by IDE core and the driver itself);

- empty/pointless switch cases for the chips other than PCI0646.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Warning: this is derived from the specs and completely untested.  Shouldn't
harm though, as those interrupt bits don't seem to really affect anything,
being mere IDE INTR signal latches...

Argh! Forgot the summary -- resending... :-<

 drivers/ide/pci/cmd64x.c |  151 ++++++++++++++++++++++++-----------------------
 1 files changed, 80 insertions(+), 71 deletions(-)

Index: linux-2.6/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6/drivers/ide/pci/cmd64x.c
@@ -1,6 +1,6 @@
 /* $Id: cmd64x.c,v 1.21 2000/01/30 23:23:16
  *
- * linux/drivers/ide/pci/cmd64x.c		Version 1.46	Feb 15, 2007
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.47	Feb 16, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Note, this driver is not used at all on other systems because
@@ -445,67 +445,80 @@ fast_ata_pio:
 	return 0;
 }
 
-static int cmd64x_alt_dma_status (struct pci_dev *dev)
+static int cmd648_ide_dma_end (ide_drive_t *drive)
 {
-	switch(dev->device) {
-		case PCI_DEVICE_ID_CMD_648:
-		case PCI_DEVICE_ID_CMD_649:
-			return 1;
-		default:
-			break;
-	}
-	return 0;
+	ide_hwif_t *hwif	= HWIF(drive);
+	int err			= __ide_dma_end(drive);
+	u8  irq_mask		= hwif->channel ? MRDMODE_INTR_CH1 :
+						  MRDMODE_INTR_CH0;
+	u8  mrdmode		= inb(hwif->dma_master + 0x01);
+
+	/* clear the interrupt bit */
+	outb(mrdmode | irq_mask, hwif->dma_master + 0x01);
+
+	return err;
 }
 
 static int cmd64x_ide_dma_end (ide_drive_t *drive)
 {
-	u8 dma_stat = 0, dma_cmd = 0;
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
+	int irq_reg		= hwif->channel ? ARTTIM23 : CFR;
+	u8  irq_mask		= hwif->channel ? ARTTIM23_INTR_CH1 :
+						  CFR_INTR_CH0;
+	u8  irq_stat		= 0;
+	int err			= __ide_dma_end(drive);
 
-	drive->waiting_for_dma = 0;
-	/* read DMA command state */
-	dma_cmd = hwif->INB(hwif->dma_command);
-	/* stop DMA */
-	hwif->OUTB((dma_cmd & ~1), hwif->dma_command);
-	/* get DMA status */
-	dma_stat = hwif->INB(hwif->dma_status);
-	/* clear the INTR & ERROR bits */
-	hwif->OUTB(dma_stat|6, hwif->dma_status);
-	if (cmd64x_alt_dma_status(dev)) {
-		u8 dma_intr	= 0;
-		u8 dma_mask	= (hwif->channel) ? ARTTIM23_INTR_CH1 :
-						    CFR_INTR_CH0;
-		u8 dma_reg	= (hwif->channel) ? ARTTIM2 : CFR;
-		(void) pci_read_config_byte(dev, dma_reg, &dma_intr);
-		/* clear the INTR bit */
-		(void) pci_write_config_byte(dev, dma_reg, dma_intr|dma_mask);
-	}
-	/* purge DMA mappings */
-	ide_destroy_dmatable(drive);
-	/* verify good DMA status */
-	return (dma_stat & 7) != 4;
+	(void) pci_read_config_byte(dev, irq_reg, &irq_stat);
+	/* clear the interrupt bit */
+	(void) pci_write_config_byte(dev, irq_reg, irq_stat | irq_mask);
+
+	return err;
+}
+
+static int cmd648_ide_dma_test_irq (ide_drive_t *drive)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	u8 irq_mask		= hwif->channel ? MRDMODE_INTR_CH1 :
+						  MRDMODE_INTR_CH0;
+	u8 dma_stat		= inb(hwif->dma_status);
+	u8 mrdmode		= inb(hwif->dma_master + 0x01);
+
+#ifdef DEBUG
+	printk("%s: dma_stat: 0x%02x mrdmode: 0x%02x irq_mask: 0x%02x\n",
+	       drive->name, dma_stat, mrdmode, irq_mask);
+#endif
+	if (!(mrdmode & irq_mask))
+		return 0;
+
+	/* return 1 if INTR asserted */
+	if (dma_stat & 4)
+		return 1;
+
+	return 0;
 }
 
 static int cmd64x_ide_dma_test_irq (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	u8 irq_reg		= hwif->channel ? ARTTIM23 : CFR;
-	u8 irq_stat = 0, mask	= hwif->channel ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
-	u8 dma_stat		= hwif->INB(hwif->dma_status);
+	int irq_reg		= hwif->channel ? ARTTIM23 : CFR;
+	u8  irq_mask		= hwif->channel ? ARTTIM23_INTR_CH1 :
+						  CFR_INTR_CH0;
+	u8  dma_stat		= inb(hwif->dma_status);
+	u8  irq_stat		= 0;
 
 	(void) pci_read_config_byte(dev, irq_reg, &irq_stat);
 
 #ifdef DEBUG
-	printk("%s: dma_stat: 0x%02x irq_stat: 0x%02x mask: 0x%02x\n",
-	       drive->name, dma_stat, irq_stat, mask);
+	printk("%s: dma_stat: 0x%02x irq_stat: 0x%02x irq_mask: 0x%02x\n",
+	       drive->name, dma_stat, irq_stat, irq_mask);
 #endif
-	if (!(irq_stat & mask))
+	if (!(irq_stat & irq_mask))
 		return 0;
 
 	/* return 1 if INTR asserted */
-	if ((dma_stat & 4) == 4)
+	if (dma_stat & 4)
 		return 1;
 
 	return 0;
@@ -544,32 +557,21 @@ static unsigned int __devinit init_chips
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
 
-	switch(dev->device) {
-		case PCI_DEVICE_ID_CMD_643:
-			break;
-		case PCI_DEVICE_ID_CMD_646:
-			printk(KERN_INFO "%s: chipset revision 0x%02X, ", name, class_rev);
-			switch(class_rev) {
-				case 0x07:
-				case 0x05:
-					printk("UltraDMA Capable");
-					break;
-				case 0x03:
-					printk("MultiWord DMA Force Limited");
-					break;
-				case 0x01:
-				default:
-					printk("MultiWord DMA Limited, IRQ workaround enabled");
-					break;
-				}
-			printk("\n");
-                        break;
-		case PCI_DEVICE_ID_CMD_648:
-		case PCI_DEVICE_ID_CMD_649:
+	if (dev->device == PCI_DEVICE_ID_CMD_646)
+		switch(class_rev) {
+		case 0x07:
+		case 0x05:
+			printk("%s: UltraDMA capable", name);
 			break;
+		case 0x03:
 		default:
+			printk("%s: MultiWord DMA force limited", name);
 			break;
-	}
+		case 0x01:
+			printk("%s: MultiWord DMA limited, "
+			       "IRQ workaround enabled\n", name);
+			break;
+		}
 
 	/* Set a good latency timer and cache line size value. */
 	(void) pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
@@ -661,23 +663,30 @@ static void __devinit init_hwif_cmd64x(i
 		hwif->ultra_mask = 0x1f;
 
 	hwif->ide_dma_check = &cmd64x_config_drive_for_dma;
-	if (!(hwif->udma_four))
+	if (!hwif->udma_four)
 		hwif->udma_four = ata66_cmd64x(hwif);
 
-	if (dev->device == PCI_DEVICE_ID_CMD_646) {
+	switch(dev->device) {
+	case PCI_DEVICE_ID_CMD_648:
+	case PCI_DEVICE_ID_CMD_649:
+	alt_irq_bits:
+		hwif->ide_dma_end = &cmd648_ide_dma_end;
+		hwif->ide_dma_test_irq = &cmd648_ide_dma_test_irq;
+		break;
+	case PCI_DEVICE_ID_CMD_646:
 		hwif->chipset = ide_cmd646;
 		if (class_rev == 0x01) {
 			hwif->ide_dma_end = &cmd646_1_ide_dma_end;
-		} else {
-			hwif->ide_dma_end = &cmd64x_ide_dma_end;
-			hwif->ide_dma_test_irq = &cmd64x_ide_dma_test_irq;
-		}
-	} else {
+			break;
+		} else if (class_rev >= 0x03)
+			goto alt_irq_bits;
+		/* fall thru */
+	default:
 		hwif->ide_dma_end = &cmd64x_ide_dma_end;
 		hwif->ide_dma_test_irq = &cmd64x_ide_dma_test_irq;
+		break;
 	}
 
-
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->autodma;

