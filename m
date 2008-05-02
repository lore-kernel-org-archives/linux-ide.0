From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 02/12] sata_mv pci features
Date: Fri, 02 May 2008 02:08:32 -0400
Message-ID: <481AAFE0.9090101@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1117 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126AbYEBGId (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:08:33 -0400
In-Reply-To: <481AAFB7.4090708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Some of the GenIIe EDMA optimizations should not be used
for non-PCI (SOC) devices, and nor for certain configurations
of conventional PCI (non PCI-X, PCIe) buses.

Logic taken/simplified from that in the Marvell proprietary driver.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-01 17:48:07.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-01 17:49:53.000000000 -0400
@@ -361,6 +361,7 @@
 	MV_HP_GEN_II		= (1 << 7),	/* Generation II: 60xx */
 	MV_HP_GEN_IIE		= (1 << 8),	/* Generation IIE: 6042/7042 */
 	MV_HP_PCIE		= (1 << 9),	/* PCIe bus/regs: 7042 */
+	MV_HP_CUT_THROUGH	= (1 << 10),	/* can use EDMA cut-through */
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),	/* is EDMA engine enabled? */
@@ -1110,8 +1111,10 @@
 	else if (IS_GEN_IIE(hpriv)) {
 		cfg |= (1 << 23);	/* do not mask PM field in rx'd FIS */
 		cfg |= (1 << 22);	/* enab 4-entry host queue cache */
-		cfg |= (1 << 18);	/* enab early completion */
-		cfg |= (1 << 17);	/* enab cut-through (dis stor&forwrd) */
+		if (HAS_PCI(ap->host))
+			cfg |= (1 << 18);	/* enab early completion */
+		if (hpriv->hp_flags & MV_HP_CUT_THROUGH)
+			cfg |= (1 << 17); /* enab cut-thru (dis stor&forwrd) */
 
 		if (want_ncq && sata_pmp_attached(ap)) {
 			cfg |= EDMA_CFG_EDMA_FBS; /* FIS-based switching */
@@ -2496,6 +2499,34 @@
 		readl(port_mmio + EDMA_ERR_IRQ_MASK_OFS));
 }
 
+static unsigned int mv_in_pcix_mode(struct ata_host *host)
+{
+	struct mv_host_priv *hpriv = host->private_data;
+	void __iomem *mmio = hpriv->base;
+	u32 reg;
+
+	if (!HAS_PCI(host) || !IS_PCIE(hpriv))
+		return 0;	/* not PCI-X capable */
+	reg = readl(mmio + MV_PCI_MODE_OFS);
+	if ((reg & MV_PCI_MODE_MASK) == 0)
+		return 0;	/* conventional PCI mode */
+	return 1;	/* chip is in PCI-X mode */
+}
+
+static int mv_pci_cut_through_okay(struct ata_host *host)
+{
+	struct mv_host_priv *hpriv = host->private_data;
+	void __iomem *mmio = hpriv->base;
+	u32 reg;
+
+	if (!mv_in_pcix_mode(host)) {
+		reg = readl(mmio + PCI_COMMAND_OFS);
+		if (reg & PCI_COMMAND_MRDTRIG)
+			return 0; /* not okay */
+	}
+	return 1; /* okay */
+}
+
 static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
@@ -2563,7 +2594,7 @@
 		break;
 
 	case chip_7042:
-		hp_flags |= MV_HP_PCIE;
+		hp_flags |= MV_HP_PCIE | MV_HP_CUT_THROUGH;
 		if (pdev->vendor == PCI_VENDOR_ID_TTI &&
 		    (pdev->device == 0x2300 || pdev->device == 0x2310))
 		{
@@ -2597,6 +2628,8 @@
 	case chip_6042:
 		hpriv->ops = &mv6xxx_ops;
 		hp_flags |= MV_HP_GEN_IIE;
+		if (board_idx == chip_6042 && mv_pci_cut_through_okay(host))
+			hp_flags |= MV_HP_CUT_THROUGH;
 
 		switch (pdev->revision) {
 		case 0x0:
