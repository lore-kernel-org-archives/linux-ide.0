From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 3/4] pata_cmd64x: implement sff_irq_clear() method
Date: Sun, 11 Mar 2012 22:27:01 +0300
Message-ID: <201203112227.01868.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:41853 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753519Ab2CKS1t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Mar 2012 14:27:49 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Convert the driver's two bmdma_stop() methods into sff_irq_clear() methods --
they shouldn't have been bothering with clearing interrupts from the very start;
the driver will now use the standard bmdma_stop() method implementation (where
appropriate).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
 drivers/ata/pata_cmd64x.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

Index: linux-2.6/drivers/ata/pata_cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_cmd64x.c
+++ linux-2.6/drivers/ata/pata_cmd64x.c
@@ -33,7 +33,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_cmd64x"
-#define DRV_VERSION "0.2.16"
+#define DRV_VERSION "0.2.17"
 
 /*
  * CMD64x specific registers definition.
@@ -230,41 +230,39 @@ static void cmd64x_set_dmamode(struct at
 }
 
 /**
- *	cmd64x_bmdma_stop	-	DMA stop callback
- *	@qc: Command in progress
+ *	cmd64x_sff_irq_clear	-	clear IDE interrupt
+ *	@ap: ATA interface
  *
- *	DMA has completed.
+ *	Clear IDE interrupt in CFR/ARTTIM23 and DMA status registers.
  */
 
-static void cmd64x_bmdma_stop(struct ata_queued_cmd *qc)
+static void cmd64x_sff_irq_clear(struct ata_port *ap)
 {
-	struct ata_port *ap = qc->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int irq_reg = ap->port_no ? ARTTIM23 : CFR;
 	u8 irq_stat;
 
-	ata_bmdma_stop(qc);
+	ata_bmdma_irq_clear(ap);
 
 	/* Reading the register should be enough to clear the interrupt */
 	pci_read_config_byte(pdev, irq_reg, &irq_stat);
 }
 
 /**
- *	cmd648_bmdma_stop	-	DMA stop callback
- *	@qc: Command in progress
+ *	cmd648_sff_irq_clear	-	clear IDE interrupt
+ *	@ap: ATA interface
  *
- *	DMA has completed.
+ *	Clear IDE interrupt in MRDMODE and DMA status registers.
  */
 
-static void cmd648_bmdma_stop(struct ata_queued_cmd *qc)
+static void cmd648_sff_irq_clear(struct ata_port *ap)
 {
-	struct ata_port *ap = qc->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned long base = pci_resource_start(pdev, 4);
 	int irq_mask = ap->port_no ? MRDMODE_INTR_CH1 : MRDMODE_INTR_CH0;
 	u8 mrdmode;
 
-	ata_bmdma_stop(qc);
+	ata_bmdma_irq_clear(ap);
 
 	/* Clear this port's interrupt bit (leaving the other port alone) */
 	mrdmode  = inb(base + 1);
@@ -296,25 +294,26 @@ static const struct ata_port_operations 
 
 static struct ata_port_operations cmd64x_port_ops = {
 	.inherits	= &cmd64x_base_ops,
-	.bmdma_stop	= cmd64x_bmdma_stop,
+	.sff_irq_clear	= cmd64x_sff_irq_clear,
 	.cable_detect	= ata_cable_40wire,
 };
 
 static struct ata_port_operations cmd646r1_port_ops = {
 	.inherits	= &cmd64x_base_ops,
+	.sff_irq_clear	= cmd64x_sff_irq_clear,
 	.bmdma_stop	= cmd646r1_bmdma_stop,
 	.cable_detect	= ata_cable_40wire,
 };
 
 static struct ata_port_operations cmd646r3_port_ops = {
 	.inherits	= &cmd64x_base_ops,
-	.bmdma_stop	= cmd648_bmdma_stop,
+	.sff_irq_clear	= cmd648_sff_irq_clear,
 	.cable_detect	= ata_cable_40wire,
 };
 
 static struct ata_port_operations cmd648_port_ops = {
 	.inherits	= &cmd64x_base_ops,
-	.bmdma_stop	= cmd648_bmdma_stop,
+	.sff_irq_clear	= cmd648_sff_irq_clear,
 	.cable_detect	= cmd648_cable_detect,
 };
 
