From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: RE: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 3 Dec 2007 07:27:27 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>
References: <4751A2DA.6030403@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from empbedex1.empirix.com ([12.38.203.54]:42733 "EHLO
	empbedex1.empirix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbXLCM1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 07:27:37 -0500
Content-class: urn:content-classes:message
In-Reply-To: <4751A2DA.6030403@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, Hein-Pieter van Braam <hp@syntomax.com>

Ack - works in my 'unique' setup as well...:-)...

Thank you Mark!

Tom Morrison


-----Original Message-----
From: Mark Lord [mailto:liml@rtr.ca] 
Sent: Saturday, December 01, 2007 1:07 PM
To: IDE/ATA development list; Jeff Garzik
Cc: Tejun Heo; Alan Cox; Morrison, Tom; Hein-Pieter van Braam
Subject: [PATCH] sata_mv: Fix broken Marvell 7042 support.

sata_mv:  Fix broken Marvell 7042 support.

The Marvell 7042 chip is more or less the same as the 6042 internally,
but sports a PCIe bus.  Despite having identical SATA cores, the 7042
does differ from its PCI bus counterparts in placment and layout of
certain bus related registers.

This patch fixes sata_mv to distinguish between the PCI bus registers
of earlier chips, and the PCIe bus registers of the 7042.

Specifically, move the offsets and bit patterns for the
PCI/PCIe interrupt cause/mask registers into the struct mv_host_priv,
as these values differ between the 6xxx and 7xxx series chips.

This fixes the driver to not access reserved PCI addresses,
and prevents the lockups reported in linux-2.6.24 with 7042 boards.

Also add a new PCI ID for the Highpoint 2300 7042-based board
that I'm using for testing this stuff here.

Tested with Marvell 6081 + 7042 chips, on x86 & x86_64.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Patch is agains 2.6.24-rc3-git5, and should go into 2.6.24.

--- old/drivers/ata/sata_mv.c	2007-12-01 11:48:28.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2007-12-01 12:06:30.000000000 -0500
@@ -164,10 +164,14 @@
 	MV_PCI_ERR_ATTRIBUTE	= 0x1d48,
 	MV_PCI_ERR_COMMAND	= 0x1d50,
 
-	PCI_IRQ_CAUSE_OFS		= 0x1d58,
-	PCI_IRQ_MASK_OFS		= 0x1d5c,
+	PCI_IRQ_CAUSE_OFS	= 0x1d58,
+	PCI_IRQ_MASK_OFS	= 0x1d5c,
 	PCI_UNMASK_ALL_IRQS	= 0x7fffff,	/* bits 22-0 */
 
+	PCIE_IRQ_CAUSE_OFS	= 0x1900,
+	PCIE_IRQ_MASK_OFS	= 0x1910,
+	PCIE_UNMASK_ALL_IRQS	= 0x70a,	/* assorted bits */
+
 	HC_MAIN_IRQ_CAUSE_OFS	= 0x1d60,
 	HC_MAIN_IRQ_MASK_OFS	= 0x1d64,
 	PORT0_ERR		= (1 << 0),	/* shift by port # */
@@ -303,6 +307,7 @@
 	MV_HP_GEN_I		= (1 << 6),	/* Generation I: 50xx */
 	MV_HP_GEN_II		= (1 << 7),	/* Generation II: 60xx
*/
 	MV_HP_GEN_IIE		= (1 << 8),	/* Generation IIE:
6042/7042 */
+	MV_HP_PCIE		= (1 << 9),	/* PCIe bus/regs: 7042
*/
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),	/* is EDMA engine
enabled? */
@@ -388,7 +393,15 @@
 	u32			pre;
 };
 
-struct mv_host_priv;
+struct mv_host_priv {
+	u32			hp_flags;
+	struct mv_port_signal	signal[8];
+	const struct mv_hw_ops	*ops;
+	u32			irq_cause_ofs;
+	u32			irq_mask_ofs;
+	u32			unmask_all_irqs;
+};
+
 struct mv_hw_ops {
 	void (*phy_errata)(struct mv_host_priv *hpriv, void __iomem
*mmio,
 			   unsigned int port);
@@ -401,12 +414,6 @@
 	void (*reset_bus)(struct pci_dev *pdev, void __iomem *mmio);
 };
 
-struct mv_host_priv {
-	u32			hp_flags;
-	struct mv_port_signal	signal[8];
-	const struct mv_hw_ops	*ops;
-};
-
 static void mv_irq_clear(struct ata_port *ap);
 static int mv_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u32
*val);
 static int mv_scr_write(struct ata_port *ap, unsigned int sc_reg_in,
u32 val);
@@ -631,11 +638,13 @@
 	/* Adaptec 1430SA */
 	{ PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },
 
-	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
-
-	/* add Marvell 7042 support */
+	/* Marvell 7042 support */
 	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },
 
+	/* Highpoint RocketRAID PCIe series */
+	{ PCI_VDEVICE(TTI, 0x2300), chip_7042 },
+	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
+
 	{ }			/* terminate list */
 };
 
@@ -1648,13 +1657,14 @@
 
 static void mv_pci_error(struct ata_host *host, void __iomem *mmio)
 {
+	struct mv_host_priv *hpriv = host->private_data;
 	struct ata_port *ap;
 	struct ata_queued_cmd *qc;
 	struct ata_eh_info *ehi;
 	unsigned int i, err_mask, printed = 0;
 	u32 err_cause;
 
-	err_cause = readl(mmio + PCI_IRQ_CAUSE_OFS);
+	err_cause = readl(mmio + hpriv->irq_cause_ofs);
 
 	dev_printk(KERN_ERR, host->dev, "PCI ERROR; PCI IRQ
cause=0x%08x\n",
 		   err_cause);
@@ -1662,7 +1672,7 @@
 	DPRINTK("All regs @ PCI error\n");
 	mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
 
-	writelfl(0, mmio + PCI_IRQ_CAUSE_OFS);
+	writelfl(0, mmio + hpriv->irq_cause_ofs);
 
 	for (i = 0; i < host->n_ports; i++) {
 		ap = host->ports[i];
@@ -1926,6 +1936,8 @@
 #define ZERO(reg) writel(0, mmio + (reg))
 static void mv_reset_pci_bus(struct pci_dev *pdev, void __iomem *mmio)
 {
+	struct ata_host     *host = dev_get_drvdata(&pdev->dev);
+	struct mv_host_priv *hpriv = host->private_data;
 	u32 tmp;
 
 	tmp = readl(mmio + MV_PCI_MODE);
@@ -1937,8 +1949,8 @@
 	writel(0x000100ff, mmio + MV_PCI_XBAR_TMOUT);
 	ZERO(HC_MAIN_IRQ_MASK_OFS);
 	ZERO(MV_PCI_SERR_MASK);
-	ZERO(PCI_IRQ_CAUSE_OFS);
-	ZERO(PCI_IRQ_MASK_OFS);
+	ZERO(hpriv->irq_cause_ofs);
+	ZERO(hpriv->irq_mask_ofs);
 	ZERO(MV_PCI_ERR_LOW_ADDRESS);
 	ZERO(MV_PCI_ERR_HIGH_ADDRESS);
 	ZERO(MV_PCI_ERR_ATTRIBUTE);
@@ -2490,6 +2502,7 @@
 		break;
 
 	case chip_7042:
+		hp_flags |= MV_HP_PCIE;
 	case chip_6042:
 		hpriv->ops = &mv6xxx_ops;
 		hp_flags |= MV_HP_GEN_IIE;
@@ -2516,6 +2529,15 @@
 	}
 
 	hpriv->hp_flags = hp_flags;
+	if (hp_flags & MV_HP_PCIE) {
+		hpriv->irq_cause_ofs	= PCIE_IRQ_CAUSE_OFS;
+		hpriv->irq_mask_ofs	= PCIE_IRQ_MASK_OFS;
+		hpriv->unmask_all_irqs	= PCIE_UNMASK_ALL_IRQS;
+	} else {
+		hpriv->irq_cause_ofs	= PCI_IRQ_CAUSE_OFS;
+		hpriv->irq_mask_ofs	= PCI_IRQ_MASK_OFS;
+		hpriv->unmask_all_irqs	= PCI_UNMASK_ALL_IRQS;
+	}
 
 	return 0;
 }
@@ -2595,10 +2617,10 @@
 	}
 
 	/* Clear any currently outstanding host interrupt conditions */
-	writelfl(0, mmio + PCI_IRQ_CAUSE_OFS);
+	writelfl(0, mmio + hpriv->irq_cause_ofs);
 
 	/* and unmask interrupt generation for host regs */
-	writelfl(PCI_UNMASK_ALL_IRQS, mmio + PCI_IRQ_MASK_OFS);
+	writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
 
 	if (IS_GEN_I(hpriv))
 		writelfl(~HC_MAIN_MASKED_IRQS_5, mmio +
HC_MAIN_IRQ_MASK_OFS);
@@ -2609,8 +2631,8 @@
 		"PCI int cause/mask=0x%08x/0x%08x\n",
 		readl(mmio + HC_MAIN_IRQ_CAUSE_OFS),
 		readl(mmio + HC_MAIN_IRQ_MASK_OFS),
-		readl(mmio + PCI_IRQ_CAUSE_OFS),
-		readl(mmio + PCI_IRQ_MASK_OFS));
+		readl(mmio + hpriv->irq_cause_ofs),
+		readl(mmio + hpriv->irq_mask_ofs));
 
 done:
 	return rc;
