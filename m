From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (pata-2.6 fix queue) cmd64x: interrupt status fixes (resend)
Date: Thu, 15 Feb 2007 16:53:00 +0300
Message-ID: <200702151653.00416.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:40656 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932759AbXBONxM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 08:53:12 -0500
In-Reply-To: <200702040004.24918.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The driver's ide_dma_test_irq() method was reading the MRDMODE register even on
PCI0643/6 where it was write-only -- fix this by always reading the "backward-
compatible" interrupt bits, renaming dma_alt_stat to irq_stat as these interrupt
status bits are not coupled to DMA.
In addition, wrong interrupt bit was tested/cleared for the primary channel --
it's bit 2 in all the chip specs and the driver used bit 1... :-/

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Warning: as usual, this has only been compile-tested. :-)
Grrr, lost signoff somewhere again, so resending...

 drivers/ide/pci/cmd64x.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6/drivers/ide/pci/cmd64x.c
@@ -1,6 +1,6 @@
 /* $Id: cmd64x.c,v 1.21 2000/01/30 23:23:16
  *
- * linux/drivers/ide/pci/cmd64x.c		Version 1.43	Feb 8, 2007
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.44	Feb 13, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Note, this driver is not used at all on other systems because
@@ -39,7 +39,7 @@
  * CMD64x specific registers definition.
  */
 #define CFR		0x50
-#define   CFR_INTR_CH0		0x02
+#define   CFR_INTR_CH0		0x04
 #define CNTRL		0x51
 #define	  CNTRL_DIS_RA0		0x40
 #define   CNTRL_DIS_RA1		0x80
@@ -510,19 +510,19 @@ static int cmd64x_ide_dma_end (ide_drive
 
 static int cmd64x_ide_dma_test_irq (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif		= HWIF(drive);
-	struct pci_dev *dev		= hwif->pci_dev;
-        u8 dma_alt_stat = 0, mask	= (hwif->channel) ? MRDMODE_INTR_CH1 :
-							    MRDMODE_INTR_CH0;
-	u8 dma_stat = hwif->INB(hwif->dma_status);
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct pci_dev *dev	= hwif->pci_dev;
+	u8 irq_reg		= hwif->channel ? ARTTIM23 : CFR;
+	u8 irq_stat = 0, mask	= hwif->channel ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
+	u8 dma_stat		= hwif->INB(hwif->dma_status);
+
+	(void) pci_read_config_byte(dev, irq_reg, &irq_stat);
 
-	(void) pci_read_config_byte(dev, MRDMODE, &dma_alt_stat);
 #ifdef DEBUG
-	printk("%s: dma_stat: 0x%02x dma_alt_stat: "
-		"0x%02x mask: 0x%02x\n", drive->name,
-		dma_stat, dma_alt_stat, mask);
+	printk("%s: dma_stat: 0x%02x irq_stat: 0x%02x mask: 0x%02x\n",
+	       drive->name, dma_stat, irq_stat, mask);
 #endif
-	if (!(dma_alt_stat & mask))
+	if (!(irq_stat & mask))
 		return 0;
 
 	/* return 1 if INTR asserted */

