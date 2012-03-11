From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/4] pata_cmd64x: use interrupt status from MRDMODE register
Date: Sun, 11 Mar 2012 22:25:30 +0300
Message-ID: <201203112225.30144.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:41845 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753615Ab2CKS0R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Mar 2012 14:26:17 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Start using faster version of the bmdma_stop() method for the PCI0646U and newer
chips that have the duplicate interrupt status  bits  in  the I/O mapped MRDMODE
register. Use the old, slow bmdma_stop() method on the older chips,  taking into
account that the interrupt bits are not coupled to DMA and that's enough to read
the register to clear the interrupt (on the older chips).  Determine what method
to use at the driver load time.

Fix kernel-doc of the bmdma_stop() methods, while at it.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
 drivers/ata/pata_cmd64x.c |   73 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/ata/pata_cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_cmd64x.c
+++ linux-2.6/drivers/ata/pata_cmd64x.c
@@ -3,6 +3,7 @@
  *			  (C) 2005 Red Hat Inc
  *			  Alan Cox <alan@lxorguk.ukuu.org.uk>
  *			  (C) 2009-2010 Bartlomiej Zolnierkiewicz
+ *			  (C) 2012 MontaVista Software, LLC <source@mvista.com>
  *
  * Based upon
  * linux/drivers/ide/pci/cmd64x.c		Version 1.30	Sept 10, 2002
@@ -32,7 +33,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_cmd64x"
-#define DRV_VERSION "0.2.15"
+#define DRV_VERSION "0.2.16"
 
 /*
  * CMD64x specific registers definition.
@@ -229,7 +230,27 @@ static void cmd64x_set_dmamode(struct at
 }
 
 /**
- *	cmd648_dma_stop	-	DMA stop callback
+ *	cmd64x_bmdma_stop	-	DMA stop callback
+ *	@qc: Command in progress
+ *
+ *	DMA has completed.
+ */
+
+static void cmd64x_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	int irq_reg = ap->port_no ? ARTTIM23 : CFR;
+	u8 irq_stat;
+
+	ata_bmdma_stop(qc);
+
+	/* Reading the register should be enough to clear the interrupt */
+	pci_read_config_byte(pdev, irq_reg, &irq_stat);
+}
+
+/**
+ *	cmd648_bmdma_stop	-	DMA stop callback
  *	@qc: Command in progress
  *
  *	DMA has completed.
@@ -239,18 +260,20 @@ static void cmd648_bmdma_stop(struct ata
 {
 	struct ata_port *ap = qc->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 dma_intr;
-	int dma_mask = ap->port_no ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
-	int dma_reg = ap->port_no ? ARTTIM23 : CFR;
+	unsigned long base = pci_resource_start(pdev, 4);
+	int irq_mask = ap->port_no ? MRDMODE_INTR_CH1 : MRDMODE_INTR_CH0;
+	u8 mrdmode;
 
 	ata_bmdma_stop(qc);
 
-	pci_read_config_byte(pdev, dma_reg, &dma_intr);
-	pci_write_config_byte(pdev, dma_reg, dma_intr | dma_mask);
+	/* Clear this port's interrupt bit (leaving the other port alone) */
+	mrdmode  = inb(base + 1);
+	mrdmode &= ~(MRDMODE_INTR_CH0 | MRDMODE_INTR_CH1);
+	outb(mrdmode | irq_mask, base + 1);
 }
 
 /**
- *	cmd646r1_dma_stop	-	DMA stop callback
+ *	cmd646r1_bmdma_stop	-	DMA stop callback
  *	@qc: Command in progress
  *
  *	Stub for now while investigating the r1 quirk in the old driver.
@@ -273,6 +296,7 @@ static const struct ata_port_operations 
 
 static struct ata_port_operations cmd64x_port_ops = {
 	.inherits	= &cmd64x_base_ops,
+	.bmdma_stop	= cmd64x_bmdma_stop,
 	.cable_detect	= ata_cable_40wire,
 };
 
@@ -282,6 +306,12 @@ static struct ata_port_operations cmd646
 	.cable_detect	= ata_cable_40wire,
 };
 
+static struct ata_port_operations cmd646r3_port_ops = {
+	.inherits	= &cmd64x_base_ops,
+	.bmdma_stop	= cmd648_bmdma_stop,
+	.cable_detect	= ata_cable_40wire,
+};
+
 static struct ata_port_operations cmd648_port_ops = {
 	.inherits	= &cmd64x_base_ops,
 	.bmdma_stop	= cmd648_bmdma_stop,
@@ -306,7 +336,7 @@ static void cmd64x_fixup(struct pci_dev 
 
 static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	static const struct ata_port_info cmd_info[6] = {
+	static const struct ata_port_info cmd_info[7] = {
 		{	/* CMD 643 - no UDMA */
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = ATA_PIO4,
@@ -319,12 +349,18 @@ static int cmd64x_init_one(struct pci_de
 			.mwdma_mask = ATA_MWDMA2,
 			.port_ops = &cmd64x_port_ops
 		},
-		{	/* CMD 646 with working UDMA */
+		{	/* CMD 646U with broken UDMA */
+			.flags = ATA_FLAG_SLAVE_POSS,
+			.pio_mask = ATA_PIO4,
+			.mwdma_mask = ATA_MWDMA2,
+			.port_ops = &cmd646r3_port_ops
+		},
+		{	/* CMD 646U2 with working UDMA */
 			.flags = ATA_FLAG_SLAVE_POSS,
 			.pio_mask = ATA_PIO4,
 			.mwdma_mask = ATA_MWDMA2,
 			.udma_mask = ATA_UDMA2,
-			.port_ops = &cmd64x_port_ops
+			.port_ops = &cmd646r3_port_ops
 		},
 		{	/* CMD 646 rev 1  */
 			.flags = ATA_FLAG_SLAVE_POSS,
@@ -372,16 +408,19 @@ static int cmd64x_init_one(struct pci_de
 		switch (pdev->revision) {
 		/* UDMA works since rev 5 */
 		default:
-			ppi[0] = &cmd_info[2];
-			ppi[1] = &cmd_info[2];
+			ppi[0] = &cmd_info[3];
+			ppi[1] = &cmd_info[3];
 			break;
+		/* Interrupts in MRDMODE since rev 3 */
 		case 3:
 		case 4:
+			ppi[0] = &cmd_info[2];
+			ppi[1] = &cmd_info[2];
 			break;
 		/* Rev 1 with other problems? */
 		case 1:
-			ppi[0] = &cmd_info[3];
-			ppi[1] = &cmd_info[3];
+			ppi[0] = &cmd_info[4];
+			ppi[1] = &cmd_info[4];
 			/* FALL THRU */
 		/* Early revs have no CNTRL_CH0 */
 		case 2:
@@ -429,8 +468,8 @@ static int cmd64x_reinit_one(struct pci_
 static const struct pci_device_id cmd64x[] = {
 	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_643), 0 },
 	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_646), 1 },
-	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_648), 4 },
-	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_649), 5 },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_648), 5 },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_649), 6 },
 
 	{ },
 };
