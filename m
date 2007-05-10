From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6 fix queue] cmd64x: init. code cleanup
Date: Fri, 11 May 2007 00:04:16 +0400
Message-ID: <200705110004.16552.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:49939 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750833AbXEJUCo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 May 2007 16:02:44 -0400
In-Reply-To: <200702162321.40813.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Fix two minor issues with PCI0646 chip reporting in the init_chipset() method:
"IRQ workaround enabled" message printed out not only for revision 0x01 and
"CMD646: chipset revision" printed twice (by IDE core and the driver itself).
Also, remove empty/pointless switch cases for the chips other than PCI0646,
duplicate write to the MRDMODE register when enabling interrupts and MEMORY
READ LINE cycles, and needless/misplaced initialization of the timing registers
in this method.
Switch to reading only the PCI revision ID register itself, not the whole 32
bits at its address in init_chipset() and init_hwif() methods; in addition,
get rid of the useless clearing of hwif->autodma and perform some cosmetic
style changes in the latter method.
Refactor ata66_cmd64x() by moving all the code into the 'switch' statement,
renaming/adding variables, and fixing the coding style.
While at it, finally get rid of the meaningless aliasing register #define's...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Oops, hit the "send" button too soon the first time. :-)
The patch should apply somewhere near the start of pata-2.6 patchset.
It has been tested on PCI-649 only.

 drivers/ide/pci/cmd64x.c |  126 ++++++++++++++++-------------------------------
 1 files changed, 45 insertions(+), 81 deletions(-)

Index: linux-2.6/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6/drivers/ide/pci/cmd64x.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cmd64x.c		Version 1.47	Mar 19, 2007
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.50	May 10, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Due to massive hardware bugs, UltraDMA is only supported
@@ -52,9 +52,6 @@
 #define   ARTTIM23_DIS_RA2	0x04
 #define   ARTTIM23_DIS_RA3	0x08
 #define   ARTTIM23_INTR_CH1	0x10
-#define ARTTIM2		0x57
-#define ARTTIM3		0x57
-#define DRWTIM23	0x58
 #define DRWTIM2		0x58
 #define BRST		0x59
 #define DRWTIM3		0x5b
@@ -482,71 +479,43 @@ static int cmd646_1_ide_dma_end (ide_dri
 
 static unsigned int __devinit init_chipset_cmd64x(struct pci_dev *dev, const char *name)
 {
-	u32 class_rev = 0;
 	u8 mrdmode = 0;
 
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
-	class_rev &= 0xff;
+	if (dev->device == PCI_DEVICE_ID_CMD_646) {
+		u8 rev = 0;
 
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
+		pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+
+		switch (rev) {
+		case 0x07:
+		case 0x05:
+			printk("%s: UltraDMA capable", name);
 			break;
+		case 0x03:
 		default:
+			printk("%s: MultiWord DMA force limited", name);
+			break;
+		case 0x01:
+			printk("%s: MultiWord DMA limited, "
+			       "IRQ workaround enabled\n", name);
 			break;
+		}
 	}
 
 	/* Set a good latency timer and cache line size value. */
 	(void) pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
 	/* FIXME: pci_set_master() to ensure a good latency timer value */
 
-	/* Setup interrupts. */
-	(void) pci_read_config_byte(dev, MRDMODE, &mrdmode);
-	mrdmode &= ~(0x30);
-	(void) pci_write_config_byte(dev, MRDMODE, mrdmode);
-
-	/* Use MEMORY READ LINE for reads.
-	 * NOTE: Although not mentioned in the PCI0646U specs,
-	 *       these bits are write only and won't be read
-	 *       back as set or not.  The PCI0646U2 specs clarify
-	 *       this point.
+	/*
+	 * Enable interrupts, select MEMORY READ LINE for reads.
+	 *
+	 * NOTE: although not mentioned in the PCI0646U specs,
+	 * bits 0-1 are write only and won't be read back as
+	 * set or not -- PCI0646U2 specs clarify this point.
 	 */
-	(void) pci_write_config_byte(dev, MRDMODE, mrdmode | 0x02);
-
-	/* Set reasonable active/recovery/address-setup values. */
-	(void) pci_write_config_byte(dev, ARTTIM0,  0x40);
-	(void) pci_write_config_byte(dev, DRWTIM0,  0x3f);
-	(void) pci_write_config_byte(dev, ARTTIM1,  0x40);
-	(void) pci_write_config_byte(dev, DRWTIM1,  0x3f);
-#ifdef __i386__
-	(void) pci_write_config_byte(dev, ARTTIM23, 0x1c);
-#else
-	(void) pci_write_config_byte(dev, ARTTIM23, 0x5c);
-#endif
-	(void) pci_write_config_byte(dev, DRWTIM23, 0x3f);
-	(void) pci_write_config_byte(dev, DRWTIM3,  0x3f);
-#ifdef CONFIG_PPC
-	(void) pci_write_config_byte(dev, UDIDETCR0, 0xf0);
-#endif /* CONFIG_PPC */
+	(void) pci_read_config_byte (dev, MRDMODE, &mrdmode);
+	mrdmode &= ~0x30;
+	(void) pci_write_config_byte(dev, MRDMODE, (mrdmode | 0x02));
 
 #if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_IDE_PROC_FS)
 
@@ -563,27 +532,25 @@ static unsigned int __devinit init_chips
 
 static unsigned int __devinit ata66_cmd64x(ide_hwif_t *hwif)
 {
-	u8 ata66 = 0, mask = (hwif->channel) ? 0x02 : 0x01;
+	struct pci_dev  *dev	= hwif->pci_dev;
+	u8 bmidecsr = 0, mask	= hwif->channel ? 0x02 : 0x01;
 
-	switch(hwif->pci_dev->device) {
-		case PCI_DEVICE_ID_CMD_643:
-		case PCI_DEVICE_ID_CMD_646:
-			return ata66;
-		default:
-			break;
+	switch (dev->device) {
+	case PCI_DEVICE_ID_CMD_648:
+	case PCI_DEVICE_ID_CMD_649:
+ 		pci_read_config_byte(dev, BMIDECSR, &bmidecsr);
+		return (bmidecsr & mask) ? 1 : 0;
+	default:
+		return 0;
 	}
-	pci_read_config_byte(hwif->pci_dev, BMIDECSR, &ata66);
-	return (ata66 & mask) ? 1 : 0;
 }
 
 static void __devinit init_hwif_cmd64x(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev	= hwif->pci_dev;
-	unsigned int class_rev;
+	u8 rev			= 0;
 
-	hwif->autodma = 0;
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
-	class_rev &= 0xff;
+	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
 
 	hwif->tuneproc  = &cmd64x_tune_drive;
 	hwif->speedproc = &cmd64x_tune_chipset;
@@ -593,8 +560,8 @@ static void __devinit init_hwif_cmd64x(i
 	if (!hwif->dma_base)
 		return;
 
-	hwif->atapi_dma = 1;
-
+	hwif->atapi_dma  = 1;
+	hwif->mwdma_mask = 0x07;
 	hwif->ultra_mask = hwif->cds->udma_mask;
 
 	/*
@@ -609,16 +576,15 @@ static void __devinit init_hwif_cmd64x(i
 	 *
 	 * So we only do UltraDMA on revision 0x05 and 0x07 chipsets.
 	 */
-	if (dev->device == PCI_DEVICE_ID_CMD_646 && class_rev < 5)
+	if (dev->device == PCI_DEVICE_ID_CMD_646 && rev < 5)
 		hwif->ultra_mask = 0x00;
 
-	hwif->mwdma_mask = 0x07;
-
 	hwif->ide_dma_check = &cmd64x_config_drive_for_dma;
-	if (!(hwif->udma_four))
+
+	if (!hwif->udma_four)
 		hwif->udma_four = ata66_cmd64x(hwif);
 
-	switch(dev->device) {
+	switch (dev->device) {
 	case PCI_DEVICE_ID_CMD_648:
 	case PCI_DEVICE_ID_CMD_649:
 	alt_irq_bits:
@@ -627,10 +593,10 @@ static void __devinit init_hwif_cmd64x(i
 		break;
 	case PCI_DEVICE_ID_CMD_646:
 		hwif->chipset = ide_cmd646;
-		if (class_rev == 0x01) {
+		if (rev == 0x01) {
 			hwif->ide_dma_end = &cmd646_1_ide_dma_end;
 			break;
-		} else if (class_rev >= 0x03)
+		} else if (rev >= 0x03)
 			goto alt_irq_bits;
 		/* fall thru */
 	default:
@@ -639,11 +605,9 @@ static void __devinit init_hwif_cmd64x(i
 		break;
 	}
 
-
 	if (!noautodma)
 		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
+	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
 }
 
 static int __devinit init_setup_cmd64x(struct pci_dev *dev, ide_pci_device_t *d)

