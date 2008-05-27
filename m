From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 01/03] sata_mv: move SOC_FLAG to hpriv
Date: Tue, 27 May 2008 17:54:48 -0400
Message-ID: <483C8328.1030807@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2255 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758541AbYE0Vyu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 May 2008 17:54:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Convert the System-on-Chip flag from a host flag to an hpriv flag,
for better consistency with other chip-rev flags, and for easier use
in errata fixes etc.

Also change the related "HAS_PCI()" into "!IS_SOC()" for better consistency
of naming/use (everything else SOC-related already uses "SOC").

There are no functionality changes in this patch.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
This is the first of three patches aimed at fixing/completing
various PHY_MODEx register errata workarounds.

--- old/drivers/ata/sata_mv.c	2008-05-19 08:52:17.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-27 11:53:01.000000000 -0400
@@ -122,8 +122,6 @@
 	/* Host Flags */
 	MV_FLAG_DUAL_HC		= (1 << 30),  /* two SATA Host Controllers */
 	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
-	/* SoC integrated controllers, no PCI interface */
-	MV_FLAG_SOC		= (1 << 28),
 
 	MV_COMMON_FLAGS		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
@@ -362,6 +360,7 @@
 	MV_HP_GEN_IIE		= (1 << 8),	/* Generation IIE: 6042/7042 */
 	MV_HP_PCIE		= (1 << 9),	/* PCIe bus/regs: 7042 */
 	MV_HP_CUT_THROUGH	= (1 << 10),	/* can use EDMA cut-through */
+	MV_HP_FLAG_SOC		= (1 << 11),	/* SystemOnChip, no PCI */
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),	/* is EDMA engine enabled? */
@@ -374,7 +373,7 @@
 #define IS_GEN_II(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_II)
 #define IS_GEN_IIE(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_IIE)
 #define IS_PCIE(hpriv) ((hpriv)->hp_flags & MV_HP_PCIE)
-#define HAS_PCI(host) (!((host)->ports[0]->flags & MV_FLAG_SOC))
+#define IS_SOC(hpriv) ((hpriv)->hp_flags & MV_HP_FLAG_SOC)
 
 #define WINDOW_CTRL(i)		(0x20030 + ((i) << 4))
 #define WINDOW_BASE(i)		(0x20034 + ((i) << 4))
@@ -652,7 +651,7 @@
 		.port_ops	= &mv_iie_ops,
 	},
 	{  /* chip_soc */
-		.flags		= MV_GENIIE_FLAGS | MV_FLAG_SOC,
+		.flags		= MV_GENIIE_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &mv_iie_ops,
@@ -1254,7 +1253,7 @@
 
 		cfg |= (1 << 23);	/* do not mask PM field in rx'd FIS */
 		cfg |= (1 << 22);	/* enab 4-entry host queue cache */
-		if (HAS_PCI(ap->host))
+		if (!IS_SOC(hpriv))
 			cfg |= (1 << 18);	/* enab early completion */
 		if (hpriv->hp_flags & MV_HP_CUT_THROUGH)
 			cfg |= (1 << 17); /* enab cut-thru (dis stor&forwrd) */
@@ -2225,7 +2224,7 @@
 	 * a bogus register value which can indicate HW removal or PCI fault.
 	 */
 	if (pending_irqs && main_irq_cause != 0xffffffffU) {
-		if (unlikely((pending_irqs & PCI_ERR) && HAS_PCI(host)))
+		if (unlikely((pending_irqs & PCI_ERR) && !IS_SOC(hpriv)))
 			handled = mv_pci_error(host, hpriv->base);
 		else
 			handled = mv_host_intr(host, pending_irqs);
@@ -2876,7 +2875,7 @@
 	void __iomem *mmio = hpriv->base;
 	u32 reg;
 
-	if (!HAS_PCI(host) || !IS_PCIE(hpriv))
+	if (IS_SOC(hpriv) || !IS_PCIE(hpriv))
 		return 0;	/* not PCI-X capable */
 	reg = readl(mmio + MV_PCI_MODE_OFS);
 	if ((reg & MV_PCI_MODE_MASK) == 0)
@@ -3018,7 +3017,7 @@
 		break;
 	case chip_soc:
 		hpriv->ops = &mv_soc_ops;
-		hp_flags |= MV_HP_ERRATA_60X1C0;
+		hp_flags |= MV_HP_FLAG_SOC | MV_HP_ERRATA_60X1C0;
 		break;
 
 	default:
@@ -3062,12 +3061,12 @@
 	if (rc)
 		goto done;
 
-	if (HAS_PCI(host)) {
-		hpriv->main_irq_cause_addr = mmio + PCI_HC_MAIN_IRQ_CAUSE_OFS;
-		hpriv->main_irq_mask_addr  = mmio + PCI_HC_MAIN_IRQ_MASK_OFS;
-	} else {
+	if (IS_SOC(hpriv)) {
 		hpriv->main_irq_cause_addr = mmio + SOC_HC_MAIN_IRQ_CAUSE_OFS;
 		hpriv->main_irq_mask_addr  = mmio + SOC_HC_MAIN_IRQ_MASK_OFS;
+	} else {
+		hpriv->main_irq_cause_addr = mmio + PCI_HC_MAIN_IRQ_CAUSE_OFS;
+		hpriv->main_irq_mask_addr  = mmio + PCI_HC_MAIN_IRQ_MASK_OFS;
 	}
 
 	/* global interrupt mask: 0 == mask everything */
@@ -3093,7 +3092,7 @@
 		mv_port_init(&ap->ioaddr, port_mmio);
 
 #ifdef CONFIG_PCI
-		if (HAS_PCI(host)) {
+		if (!IS_SOC(hpriv)) {
 			unsigned int offset = port_mmio - mmio;
 			ata_port_pbar_desc(ap, MV_PRIMARY_BAR, -1, "mmio");
 			ata_port_pbar_desc(ap, MV_PRIMARY_BAR, offset, "port");
@@ -3113,7 +3112,7 @@
 		writelfl(0, hc_mmio + HC_IRQ_CAUSE_OFS);
 	}
 
-	if (HAS_PCI(host)) {
+	if (!IS_SOC(hpriv)) {
 		/* Clear any currently outstanding host interrupt conditions */
 		writelfl(0, mmio + hpriv->irq_cause_ofs);
 
