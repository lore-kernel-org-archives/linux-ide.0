From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 02/13] sata_mv ncq Mask transient IRQs
Date: Sat, 26 Jan 2008 18:30:37 -0500
Message-ID: <479BC29D.3@rtr.ca>
References: <479BC217.60709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3038 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbYAZXai (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 18:30:38 -0500
In-Reply-To: <479BC217.60709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

The chips can handle many transient errors internally without a software IRQ.
We now mask/ignore those interrupts here.  This is necessary for NCQ, later on.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-01-24 11:11:26.000000000 -0500
+++ new/drivers/ata/sata_mv.c	2008-01-24 11:17:42.000000000 -0500
@@ -170,7 +170,7 @@
 
 	PCIE_IRQ_CAUSE_OFS	= 0x1900,
 	PCIE_IRQ_MASK_OFS	= 0x1910,
-	PCIE_UNMASK_ALL_IRQS	= 0x70a,	/* assorted bits */
+	PCIE_UNMASK_ALL_IRQS	= 0x40a,	/* assorted bits */
 
 	HC_MAIN_IRQ_CAUSE_OFS	= 0x1d60,
 	HC_MAIN_IRQ_MASK_OFS	= 0x1d64,
@@ -241,17 +241,36 @@
 	EDMA_ERR_BIST_ASYNC	= (1 << 8),	/* BIST FIS or Async Notify */
 	EDMA_ERR_TRANS_IRQ_7	= (1 << 8),	/* Gen IIE transprt layer irq */
 	EDMA_ERR_CRQB_PAR	= (1 << 9),	/* CRQB parity error */
-	EDMA_ERR_CRPB_PAR	= (1 << 10),	/* CRPB parity error */
-	EDMA_ERR_INTRL_PAR	= (1 << 11),	/* internal parity error */
-	EDMA_ERR_IORDY		= (1 << 12),	/* IORdy timeout */
-	EDMA_ERR_LNK_CTRL_RX	= (0xf << 13),	/* link ctrl rx error */
-	EDMA_ERR_LNK_CTRL_RX_2	= (1 << 15),
-	EDMA_ERR_LNK_DATA_RX	= (0xf << 17),	/* link data rx error */
-	EDMA_ERR_LNK_CTRL_TX	= (0x1f << 21),	/* link ctrl tx error */
-	EDMA_ERR_LNK_DATA_TX	= (0x1f << 26),	/* link data tx error */
-	EDMA_ERR_TRANS_PROTO	= (1 << 31),	/* transport protocol error */
-	EDMA_ERR_OVERRUN_5	= (1 << 5),
-	EDMA_ERR_UNDERRUN_5	= (1 << 6),
+	EDMA_ERR_CRPB_PAR	= (1 << 10),	/* CRPB parity error */
+	EDMA_ERR_INTRL_PAR	= (1 << 11),	/* internal parity error */
+	EDMA_ERR_IORDY		= (1 << 12),	/* IORdy timeout */
+
+	EDMA_ERR_LNK_CTRL_RX	= (0xf << 13),	/* link ctrl rx error */
+	EDMA_ERR_LNK_CTRL_RX_0	= (1 << 13),	/* transient: CRC err */
+	EDMA_ERR_LNK_CTRL_RX_1	= (1 << 14),	/* transient: FIFO err */
+	EDMA_ERR_LNK_CTRL_RX_2	= (1 << 15),	/* fatal: caught SYNC */
+	EDMA_ERR_LNK_CTRL_RX_3	= (1 << 16),	/* transient: FIS rx err */
+
+	EDMA_ERR_LNK_DATA_RX	= (0xf << 17),	/* link data rx error */
+
+	EDMA_ERR_LNK_CTRL_TX	= (0x1f << 21),	/* link ctrl tx error */
+	EDMA_ERR_LNK_CTRL_TX_0	= (1 << 21),	/* transient: CRC err */
+	EDMA_ERR_LNK_CTRL_TX_1	= (1 << 22),	/* transient: FIFO err */
+	EDMA_ERR_LNK_CTRL_TX_2	= (1 << 23),	/* transient: caught SYNC */
+	EDMA_ERR_LNK_CTRL_TX_3	= (1 << 24),	/* transient: caught DMAT */
+	EDMA_ERR_LNK_CTRL_TX_4	= (1 << 25),	/* transient: FIS collision */
+
+	EDMA_ERR_LNK_DATA_TX	= (0x1f << 26),	/* link data tx error */
+
+	EDMA_ERR_TRANS_PROTO	= (1 << 31),	/* transport protocol error */
+	EDMA_ERR_OVERRUN_5	= (1 << 5),
+	EDMA_ERR_UNDERRUN_5	= (1 << 6),
+
+	EDMA_ERR_IRQ_TRANSIENT  = EDMA_ERR_LNK_CTRL_RX_0 |
+				  EDMA_ERR_LNK_CTRL_RX_1 |
+				  EDMA_ERR_LNK_CTRL_RX_3 |
+				  EDMA_ERR_LNK_CTRL_TX,
+
 	EDMA_EH_FREEZE		= EDMA_ERR_D_PAR |
 				  EDMA_ERR_PRD_PAR |
 				  EDMA_ERR_DEV_DCON |
@@ -1716,18 +1735,19 @@
 	struct ata_host *host = dev_instance;
 	unsigned int hc, handled = 0, n_hcs;
 	void __iomem *mmio = host->iomap[MV_PRIMARY_BAR];
-	u32 irq_stat;
+	u32 irq_stat, irq_mask;
 
+	spin_lock(&host->lock);
 	irq_stat = readl(mmio + HC_MAIN_IRQ_CAUSE_OFS);
+	irq_mask = readl(mmio + HC_MAIN_IRQ_MASK_OFS);
 
 	/* check the cases where we either have nothing pending or have read
 	 * a bogus register value which can indicate HW removal or PCI fault
 	 */
-	if (!irq_stat || (0xffffffffU == irq_stat))
-		return IRQ_NONE;
+	if (!(irq_stat & irq_mask) || (0xffffffffU == irq_stat))
+		goto out_unlock;
 
 	n_hcs = mv_get_hc_count(host->ports[0]->flags);
-	spin_lock(&host->lock);
 
 	if (unlikely(irq_stat & PCI_ERR)) {
 		mv_pci_error(host, mmio);
@@ -2428,8 +2448,8 @@
 	writelfl(readl(port_mmio + serr_ofs), port_mmio + serr_ofs);
 	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
-	/* unmask all EDMA error interrupts */
-	writelfl(~0, port_mmio + EDMA_ERR_IRQ_MASK_OFS);
+	/* unmask all non-transient EDMA error interrupts */
+	writelfl(~EDMA_ERR_IRQ_TRANSIENT, port_mmio + EDMA_ERR_IRQ_MASK_OFS);
 
 	VPRINTK("EDMA cfg=0x%08x EDMA IRQ err cause/mask=0x%08x/0x%08x\n",
 		readl(port_mmio + EDMA_CFG_OFS),
