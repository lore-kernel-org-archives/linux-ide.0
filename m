From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 4/4] pata_cmd64x: implement sff_irq_check() method
Date: Sun, 11 Mar 2012 22:28:18 +0300
Message-ID: <201203112228.18896.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:48021 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753711Ab2CKS3H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Mar 2012 14:29:07 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Implement sff_irq_check() method for both old and new chips.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
 drivers/ata/pata_cmd64x.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/ata/pata_cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_cmd64x.c
+++ linux-2.6/drivers/ata/pata_cmd64x.c
@@ -33,7 +33,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_cmd64x"
-#define DRV_VERSION "0.2.17"
+#define DRV_VERSION "0.2.18"
 
 /*
  * CMD64x specific registers definition.
@@ -230,6 +230,26 @@ static void cmd64x_set_dmamode(struct at
 }
 
 /**
+ *	cmd64x_sff_irq_check	-	check IDE interrupt
+ *	@ap: ATA interface
+ *
+ *	Check IDE interrupt in CFR/ARTTIM23 registers.
+ */
+
+static bool cmd64x_sff_irq_check(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	int irq_mask = ap->port_no ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
+	int irq_reg  = ap->port_no ? ARTTIM23 : CFR;
+	u8 irq_stat;
+
+	/* NOTE: reading the register should clear the interrupt */
+	pci_read_config_byte(pdev, irq_reg, &irq_stat);
+
+	return irq_stat & irq_mask;
+}
+
+/**
  *	cmd64x_sff_irq_clear	-	clear IDE interrupt
  *	@ap: ATA interface
  *
@@ -249,6 +269,23 @@ static void cmd64x_sff_irq_clear(struct 
 }
 
 /**
+ *	cmd648_sff_irq_check	-	check IDE interrupt
+ *	@ap: ATA interface
+ *
+ *	Check IDE interrupt in MRDMODE register.
+ */
+
+static bool cmd648_sff_irq_check(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	unsigned long base = pci_resource_start(pdev, 4);
+	int irq_mask = ap->port_no ? MRDMODE_INTR_CH1 : MRDMODE_INTR_CH0;
+	u8 mrdmode = inb(base + 1);
+
+	return mrdmode & irq_mask;
+}
+
+/**
  *	cmd648_sff_irq_clear	-	clear IDE interrupt
  *	@ap: ATA interface
  *
@@ -294,12 +331,14 @@ static const struct ata_port_operations 
 
 static struct ata_port_operations cmd64x_port_ops = {
 	.inherits	= &cmd64x_base_ops,
+	.sff_irq_check	= cmd64x_sff_irq_check,
 	.sff_irq_clear	= cmd64x_sff_irq_clear,
 	.cable_detect	= ata_cable_40wire,
 };
 
 static struct ata_port_operations cmd646r1_port_ops = {
 	.inherits	= &cmd64x_base_ops,
+	.sff_irq_check	= cmd64x_sff_irq_check,
 	.sff_irq_clear	= cmd64x_sff_irq_clear,
 	.bmdma_stop	= cmd646r1_bmdma_stop,
 	.cable_detect	= ata_cable_40wire,
@@ -307,12 +346,14 @@ static struct ata_port_operations cmd646
 
 static struct ata_port_operations cmd646r3_port_ops = {
 	.inherits	= &cmd64x_base_ops,
+	.sff_irq_check	= cmd648_sff_irq_check,
 	.sff_irq_clear	= cmd648_sff_irq_clear,
 	.cable_detect	= ata_cable_40wire,
 };
 
 static struct ata_port_operations cmd648_port_ops = {
 	.inherits	= &cmd64x_base_ops,
+	.sff_irq_check	= cmd648_sff_irq_check,
 	.sff_irq_clear	= cmd648_sff_irq_clear,
 	.cable_detect	= cmd648_cable_detect,
 };
