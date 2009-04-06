From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 08/08] sata_mv: shorten register names
Date: Mon, 06 Apr 2009 16:43:45 -0400
Message-ID: <49DA6981.9020002@rtr.ca>
References: <49DA2DFD.4010402@rtr.ca> <49DA2E33.4050704@rtr.ca> <49DA2E76.7000800@rtr.ca> <49DA566D.9040501@rtr.ca> <49DA56DE.3000200@rtr.ca> <49DA5709.7060005@rtr.ca> <49DA5733.3050206@rtr.ca> <49DA5760.1040104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:53594 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbZDFUnt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 16:43:49 -0400
In-Reply-To: <49DA5760.1040104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Saeed Bishara <saeed@marvell.com>

Rename a slew of register name constants in sata_mv,
removing the _OFS suffix from them, and shortening some
of them in other ways as well.

Also, bump up the version number to reflect all recent changes.

In theory, no actual changes to the generated code,
other than the version number bump.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
Continuing with the earlier sata_mv patchset.

--- old/drivers/ata/sata_mv.c	2009-04-06 15:04:05.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-04-06 16:35:49.000000000 -0400
@@ -69,7 +69,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"1.27"
+#define DRV_VERSION	"1.28"
 
 /*
  * module options
@@ -114,23 +114,23 @@
 	 * Coalescing defers the interrupt until either the IO_THRESHOLD
 	 * (count of completed I/Os) is met, or the TIME_THRESHOLD is met.
 	 */
-	MV_COAL_REG_BASE	= 0x18000,
-	MV_IRQ_COAL_CAUSE	= (MV_COAL_REG_BASE + 0x08),
+	COAL_REG_BASE		= 0x18000,
+	IRQ_COAL_CAUSE		= (COAL_REG_BASE + 0x08),
 	ALL_PORTS_COAL_IRQ	= (1 << 4),	/* all ports irq event */
 
-	MV_IRQ_COAL_IO_THRESHOLD   = (MV_COAL_REG_BASE + 0xcc),
-	MV_IRQ_COAL_TIME_THRESHOLD = (MV_COAL_REG_BASE + 0xd0),
+	IRQ_COAL_IO_THRESHOLD   = (COAL_REG_BASE + 0xcc),
+	IRQ_COAL_TIME_THRESHOLD = (COAL_REG_BASE + 0xd0),
 
 	/*
 	 * Registers for the (unused here) transaction coalescing feature:
 	 */
-	MV_TRAN_COAL_CAUSE_LO	= (MV_COAL_REG_BASE + 0x88),
-	MV_TRAN_COAL_CAUSE_HI	= (MV_COAL_REG_BASE + 0x8c),
+	TRAN_COAL_CAUSE_LO	= (COAL_REG_BASE + 0x88),
+	TRAN_COAL_CAUSE_HI	= (COAL_REG_BASE + 0x8c),
 
-	MV_SATAHC0_REG_BASE	= 0x20000,
-	MV_FLASH_CTL_OFS	= 0x1046c,
-	MV_GPIO_PORT_CTL_OFS	= 0x104f0,
-	MV_RESET_CFG_OFS	= 0x180d8,
+	SATAHC0_REG_BASE	= 0x20000,
+	FLASH_CTL		= 0x1046c,
+	GPIO_PORT_CTL		= 0x104f0,
+	RESET_CFG		= 0x180d8,
 
 	MV_PCI_REG_SZ		= MV_MAJOR_REG_AREA_SZ,
 	MV_SATAHC_REG_SZ	= MV_MAJOR_REG_AREA_SZ,
@@ -185,41 +185,41 @@
 
 	/* PCI interface registers */
 
-	PCI_COMMAND_OFS		= 0xc00,
-	PCI_COMMAND_MWRCOM	= (1 << 4),	/* PCI Master Write Combining */
-	PCI_COMMAND_MRDTRIG	= (1 << 7),	/* PCI Master Read Trigger */
+	MV_PCI_COMMAND		= 0xc00,
+	MV_PCI_COMMAND_MWRCOM	= (1 << 4),	/* PCI Master Write Combining */
+	MV_PCI_COMMAND_MRDTRIG	= (1 << 7),	/* PCI Master Read Trigger */
 
-	PCI_MAIN_CMD_STS_OFS	= 0xd30,
+	PCI_MAIN_CMD_STS	= 0xd30,
 	STOP_PCI_MASTER		= (1 << 2),
 	PCI_MASTER_EMPTY	= (1 << 3),
 	GLOB_SFT_RST		= (1 << 4),
 
-	MV_PCI_MODE_OFS		= 0xd00,
+	MV_PCI_MODE		= 0xd00,
 	MV_PCI_MODE_MASK	= 0x30,
 
 	MV_PCI_EXP_ROM_BAR_CTL	= 0xd2c,
 	MV_PCI_DISC_TIMER	= 0xd04,
 	MV_PCI_MSI_TRIGGER	= 0xc38,
 	MV_PCI_SERR_MASK	= 0xc28,
-	MV_PCI_XBAR_TMOUT_OFS	= 0x1d04,
+	MV_PCI_XBAR_TMOUT	= 0x1d04,
 	MV_PCI_ERR_LOW_ADDRESS	= 0x1d40,
 	MV_PCI_ERR_HIGH_ADDRESS	= 0x1d44,
 	MV_PCI_ERR_ATTRIBUTE	= 0x1d48,
 	MV_PCI_ERR_COMMAND	= 0x1d50,
 
-	PCI_IRQ_CAUSE_OFS	= 0x1d58,
-	PCI_IRQ_MASK_OFS	= 0x1d5c,
+	PCI_IRQ_CAUSE		= 0x1d58,
+	PCI_IRQ_MASK		= 0x1d5c,
 	PCI_UNMASK_ALL_IRQS	= 0x7fffff,	/* bits 22-0 */
 
-	PCIE_IRQ_CAUSE_OFS	= 0x1900,
-	PCIE_IRQ_MASK_OFS	= 0x1910,
+	PCIE_IRQ_CAUSE		= 0x1900,
+	PCIE_IRQ_MASK		= 0x1910,
 	PCIE_UNMASK_ALL_IRQS	= 0x40a,	/* assorted bits */
 
 	/* Host Controller Main Interrupt Cause/Mask registers (1 per-chip) */
-	PCI_HC_MAIN_IRQ_CAUSE_OFS = 0x1d60,
-	PCI_HC_MAIN_IRQ_MASK_OFS  = 0x1d64,
-	SOC_HC_MAIN_IRQ_CAUSE_OFS = 0x20020,
-	SOC_HC_MAIN_IRQ_MASK_OFS  = 0x20024,
+	PCI_HC_MAIN_IRQ_CAUSE	= 0x1d60,
+	PCI_HC_MAIN_IRQ_MASK	= 0x1d64,
+	SOC_HC_MAIN_IRQ_CAUSE	= 0x20020,
+	SOC_HC_MAIN_IRQ_MASK	= 0x20024,
 	ERR_IRQ			= (1 << 0),	/* shift by (2 * port #) */
 	DONE_IRQ		= (1 << 1),	/* shift by (2 * port #) */
 	HC0_IRQ_PEND		= 0x1ff,	/* bits 0-8 = HC0's ports */
@@ -240,9 +240,9 @@
 	HC_MAIN_RSVD_SOC	= (0x3fffffb << 6),     /* bits 31-9, 7-6 */
 
 	/* SATAHC registers */
-	HC_CFG_OFS		= 0,
+	HC_CFG			= 0x00,
 
-	HC_IRQ_CAUSE_OFS	= 0x14,
+	HC_IRQ_CAUSE		= 0x14,
 	DMA_IRQ			= (1 << 0),	/* shift by port # */
 	HC_COAL_IRQ		= (1 << 4),	/* IRQ coalescing */
 	DEV_IRQ			= (1 << 8),	/* shift by port # */
@@ -254,53 +254,54 @@
 	 * Coalescing defers the interrupt until either the IO_THRESHOLD
 	 * (count of completed I/Os) is met, or the TIME_THRESHOLD is met.
 	 */
-	HC_IRQ_COAL_IO_THRESHOLD_OFS	= 0x000c,
-	HC_IRQ_COAL_TIME_THRESHOLD_OFS	= 0x0010,
+	HC_IRQ_COAL_IO_THRESHOLD	= 0x000c,
+	HC_IRQ_COAL_TIME_THRESHOLD	= 0x0010,
 
-	SOC_LED_CTRL_OFS	= 0x2c,
+	SOC_LED_CTRL		= 0x2c,
 	SOC_LED_CTRL_BLINK	= (1 << 0),	/* Active LED blink */
 	SOC_LED_CTRL_ACT_PRESENCE = (1 << 2),	/* Multiplex dev presence */
 						/*  with dev activity LED */
 
 	/* Shadow block registers */
-	SHD_BLK_OFS		= 0x100,
-	SHD_CTL_AST_OFS		= 0x20,		/* ofs from SHD_BLK_OFS */
+	SHD_BLK			= 0x100,
+	SHD_CTL_AST		= 0x20,		/* ofs from SHD_BLK */
 
 	/* SATA registers */
-	SATA_STATUS_OFS		= 0x300,  /* ctrl, err regs follow status */
-	SATA_ACTIVE_OFS		= 0x350,
-	SATA_FIS_IRQ_CAUSE_OFS	= 0x364,
-	SATA_FIS_IRQ_AN		= (1 << 9),	/* async notification */
+	SATA_STATUS		= 0x300,  /* ctrl, err regs follow status */
+	SATA_ACTIVE		= 0x350,
+	FIS_IRQ_CAUSE		= 0x364,
+	FIS_IRQ_CAUSE_AN	= (1 << 9),	/* async notification */
 
-	LTMODE_OFS		= 0x30c,	/* requires read-after-write */
+	LTMODE			= 0x30c,	/* requires read-after-write */
 	LTMODE_BIT8		= (1 << 8),	/* unknown, but necessary */
 
-	PHY_MODE2_OFS		= 0x330,
-	PHY_MODE3_OFS		= 0x310,
-	PHY_MODE4_OFS		= 0x314,	/* requires read-after-write */
+	PHY_MODE2		= 0x330,
+	PHY_MODE3		= 0x310,
+
+	PHY_MODE4		= 0x314,	/* requires read-after-write */
 	PHY_MODE4_CFG_MASK	= 0x00000003,	/* phy internal config field */
 	PHY_MODE4_CFG_VALUE	= 0x00000001,	/* phy internal config field */
 	PHY_MODE4_RSVD_ZEROS	= 0x5de3fffa,	/* Gen2e always write zeros */
 	PHY_MODE4_RSVD_ONES	= 0x00000005,	/* Gen2e always write ones */
 
-	SATA_IFCTL_OFS		= 0x344,
-	SATA_TESTCTL_OFS	= 0x348,
-	SATA_IFSTAT_OFS		= 0x34c,
-	VENDOR_UNIQUE_FIS_OFS	= 0x35c,
+	SATA_IFCTL		= 0x344,
+	SATA_TESTCTL		= 0x348,
+	SATA_IFSTAT		= 0x34c,
+	VENDOR_UNIQUE_FIS	= 0x35c,
 
-	FISCFG_OFS		= 0x360,
+	FISCFG			= 0x360,
 	FISCFG_WAIT_DEV_ERR	= (1 << 8),	/* wait for host on DevErr */
 	FISCFG_SINGLE_SYNC	= (1 << 16),	/* SYNC on DMA activation */
 
 	MV5_PHY_MODE		= 0x74,
-	MV5_LTMODE_OFS		= 0x30,
-	MV5_PHY_CTL_OFS		= 0x0C,
-	SATA_INTERFACE_CFG_OFS	= 0x050,
+	MV5_LTMODE		= 0x30,
+	MV5_PHY_CTL		= 0x0C,
+	SATA_IFCFG		= 0x050,
 
 	MV_M2_PREAMP_MASK	= 0x7e0,
 
 	/* Port registers */
-	EDMA_CFG_OFS		= 0,
+	EDMA_CFG		= 0,
 	EDMA_CFG_Q_DEPTH	= 0x1f,		/* max device queue depth */
 	EDMA_CFG_NCQ		= (1 << 5),	/* for R/W FPDMA queued */
 	EDMA_CFG_NCQ_GO_ON_ERR	= (1 << 14),	/* continue on error */
@@ -309,8 +310,8 @@
 	EDMA_CFG_EDMA_FBS	= (1 << 16),	/* EDMA FIS-Based Switching */
 	EDMA_CFG_FBS		= (1 << 26),	/* FIS-Based Switching */
 
-	EDMA_ERR_IRQ_CAUSE_OFS	= 0x8,
-	EDMA_ERR_IRQ_MASK_OFS	= 0xc,
+	EDMA_ERR_IRQ_CAUSE	= 0x8,
+	EDMA_ERR_IRQ_MASK	= 0xc,
 	EDMA_ERR_D_PAR		= (1 << 0),	/* UDMA data parity err */
 	EDMA_ERR_PRD_PAR	= (1 << 1),	/* UDMA PRD parity err */
 	EDMA_ERR_DEV		= (1 << 2),	/* device error */
@@ -379,36 +380,36 @@
 				  EDMA_ERR_INTRL_PAR |
 				  EDMA_ERR_IORDY,
 
-	EDMA_REQ_Q_BASE_HI_OFS	= 0x10,
-	EDMA_REQ_Q_IN_PTR_OFS	= 0x14,		/* also contains BASE_LO */
+	EDMA_REQ_Q_BASE_HI	= 0x10,
+	EDMA_REQ_Q_IN_PTR	= 0x14,		/* also contains BASE_LO */
 
-	EDMA_REQ_Q_OUT_PTR_OFS	= 0x18,
+	EDMA_REQ_Q_OUT_PTR	= 0x18,
 	EDMA_REQ_Q_PTR_SHIFT	= 5,
 
-	EDMA_RSP_Q_BASE_HI_OFS	= 0x1c,
-	EDMA_RSP_Q_IN_PTR_OFS	= 0x20,
-	EDMA_RSP_Q_OUT_PTR_OFS	= 0x24,		/* also contains BASE_LO */
+	EDMA_RSP_Q_BASE_HI	= 0x1c,
+	EDMA_RSP_Q_IN_PTR	= 0x20,
+	EDMA_RSP_Q_OUT_PTR	= 0x24,		/* also contains BASE_LO */
 	EDMA_RSP_Q_PTR_SHIFT	= 3,
 
-	EDMA_CMD_OFS		= 0x28,		/* EDMA command register */
+	EDMA_CMD		= 0x28,		/* EDMA command register */
 	EDMA_EN			= (1 << 0),	/* enable EDMA */
 	EDMA_DS			= (1 << 1),	/* disable EDMA; self-negated */
 	EDMA_RESET		= (1 << 2),	/* reset eng/trans/link/phy */
 
-	EDMA_STATUS_OFS		= 0x30,		/* EDMA engine status */
+	EDMA_STATUS		= 0x30,		/* EDMA engine status */
 	EDMA_STATUS_CACHE_EMPTY	= (1 << 6),	/* GenIIe command cache empty */
 	EDMA_STATUS_IDLE	= (1 << 7),	/* GenIIe EDMA enabled/idle */
 
-	EDMA_IORDY_TMOUT_OFS	= 0x34,
-	EDMA_ARB_CFG_OFS	= 0x38,
+	EDMA_IORDY_TMOUT	= 0x34,
+	EDMA_ARB_CFG		= 0x38,
 
-	EDMA_HALTCOND_OFS	= 0x60,		/* GenIIe halt conditions */
-	EDMA_UNKNOWN_RSVD_OFS	= 0x6C,		/* GenIIe unknown/reserved */
+	EDMA_HALTCOND		= 0x60,		/* GenIIe halt conditions */
+	EDMA_UNKNOWN_RSVD	= 0x6C,		/* GenIIe unknown/reserved */
 
-	BMDMA_CMD_OFS		= 0x224,	/* bmdma command register */
-	BMDMA_STATUS_OFS	= 0x228,	/* bmdma status register */
-	BMDMA_PRD_LOW_OFS	= 0x22c,	/* bmdma PRD addr 31:0 */
-	BMDMA_PRD_HIGH_OFS	= 0x230,	/* bmdma PRD addr 63:32 */
+	BMDMA_CMD		= 0x224,	/* bmdma command register */
+	BMDMA_STATUS		= 0x228,	/* bmdma status register */
+	BMDMA_PRD_LOW		= 0x22c,	/* bmdma PRD addr 31:0 */
+	BMDMA_PRD_HIGH		= 0x230,	/* bmdma PRD addr 63:32 */
 
 	/* Host private flags (hp_flags) */
 	MV_HP_FLAG_MSI		= (1 << 0),
@@ -540,8 +541,8 @@
 	void __iomem		*base;
 	void __iomem		*main_irq_cause_addr;
 	void __iomem		*main_irq_mask_addr;
-	u32			irq_cause_ofs;
-	u32			irq_mask_ofs;
+	u32			irq_cause_offset;
+	u32			irq_mask_offset;
 	u32			unmask_all_irqs;
 	/*
 	 * These consistent DMA memory pools give us guaranteed
@@ -846,7 +847,7 @@
 
 static inline void __iomem *mv_hc_base(void __iomem *base, unsigned int hc)
 {
-	return (base + MV_SATAHC0_REG_BASE + (hc * MV_SATAHC_REG_SZ));
+	return (base + SATAHC0_REG_BASE + (hc * MV_SATAHC_REG_SZ));
 }
 
 static inline void __iomem *mv_hc_base_from_port(void __iomem *base,
@@ -901,10 +902,10 @@
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp = ap->private_data;
 
-	pp->cached.fiscfg = readl(port_mmio + FISCFG_OFS);
-	pp->cached.ltmode = readl(port_mmio + LTMODE_OFS);
-	pp->cached.haltcond = readl(port_mmio + EDMA_HALTCOND_OFS);
-	pp->cached.unknown_rsvd = readl(port_mmio + EDMA_UNKNOWN_RSVD_OFS);
+	pp->cached.fiscfg = readl(port_mmio + FISCFG);
+	pp->cached.ltmode = readl(port_mmio + LTMODE);
+	pp->cached.haltcond = readl(port_mmio + EDMA_HALTCOND);
+	pp->cached.unknown_rsvd = readl(port_mmio + EDMA_UNKNOWN_RSVD);
 }
 
 /**
@@ -955,10 +956,10 @@
 	index = pp->req_idx << EDMA_REQ_Q_PTR_SHIFT;
 
 	WARN_ON(pp->crqb_dma & 0x3ff);
-	writel((pp->crqb_dma >> 16) >> 16, port_mmio + EDMA_REQ_Q_BASE_HI_OFS);
+	writel((pp->crqb_dma >> 16) >> 16, port_mmio + EDMA_REQ_Q_BASE_HI);
 	writelfl((pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK) | index,
-		 port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
-	writelfl(index, port_mmio + EDMA_REQ_Q_OUT_PTR_OFS);
+		 port_mmio + EDMA_REQ_Q_IN_PTR);
+	writelfl(index, port_mmio + EDMA_REQ_Q_OUT_PTR);
 
 	/*
 	 * initialize response queue
@@ -967,10 +968,10 @@
 	index = pp->resp_idx << EDMA_RSP_Q_PTR_SHIFT;
 
 	WARN_ON(pp->crpb_dma & 0xff);
-	writel((pp->crpb_dma >> 16) >> 16, port_mmio + EDMA_RSP_Q_BASE_HI_OFS);
-	writelfl(index, port_mmio + EDMA_RSP_Q_IN_PTR_OFS);
+	writel((pp->crpb_dma >> 16) >> 16, port_mmio + EDMA_RSP_Q_BASE_HI);
+	writelfl(index, port_mmio + EDMA_RSP_Q_IN_PTR);
 	writelfl((pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK) | index,
-		 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
+		 port_mmio + EDMA_RSP_Q_OUT_PTR);
 }
 
 static void mv_write_main_irq_mask(u32 mask, struct mv_host_priv *hpriv)
@@ -1028,15 +1029,15 @@
 	u32 hc_irq_cause;
 
 	/* clear EDMA event indicators, if any */
-	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
+	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE);
 
 	/* clear pending irq events */
 	hc_irq_cause = ~((DEV_IRQ | DMA_IRQ) << hardport);
-	writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
+	writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE);
 
 	/* clear FIS IRQ Cause */
 	if (IS_GEN_IIE(hpriv))
-		writelfl(0, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
+		writelfl(0, port_mmio + FIS_IRQ_CAUSE);
 
 	mv_enable_port_irqs(ap, port_irqs);
 }
@@ -1072,10 +1073,10 @@
 		 * GEN_II/GEN_IIE with dual host controllers:
 		 * one set of global thresholds for the entire chip.
 		 */
-		writel(clks,  mmio + MV_IRQ_COAL_TIME_THRESHOLD);
-		writel(count, mmio + MV_IRQ_COAL_IO_THRESHOLD);
+		writel(clks,  mmio + IRQ_COAL_TIME_THRESHOLD);
+		writel(count, mmio + IRQ_COAL_IO_THRESHOLD);
 		/* clear leftover coal IRQ bit */
-		writel(~ALL_PORTS_COAL_IRQ, mmio + MV_IRQ_COAL_CAUSE);
+		writel(~ALL_PORTS_COAL_IRQ, mmio + IRQ_COAL_CAUSE);
 		if (count)
 			coal_enable = ALL_PORTS_COAL_DONE;
 		clks = count = 0; /* force clearing of regular regs below */
@@ -1085,16 +1086,16 @@
 	 * All chips: independent thresholds for each HC on the chip.
 	 */
 	hc_mmio = mv_hc_base_from_port(mmio, 0);
-	writel(clks,  hc_mmio + HC_IRQ_COAL_TIME_THRESHOLD_OFS);
-	writel(count, hc_mmio + HC_IRQ_COAL_IO_THRESHOLD_OFS);
-	writel(~HC_COAL_IRQ, hc_mmio + HC_IRQ_CAUSE_OFS);
+	writel(clks,  hc_mmio + HC_IRQ_COAL_TIME_THRESHOLD);
+	writel(count, hc_mmio + HC_IRQ_COAL_IO_THRESHOLD);
+	writel(~HC_COAL_IRQ, hc_mmio + HC_IRQ_CAUSE);
 	if (count)
 		coal_enable |= PORTS_0_3_COAL_DONE;
 	if (is_dual_hc) {
 		hc_mmio = mv_hc_base_from_port(mmio, MV_PORTS_PER_HC);
-		writel(clks,  hc_mmio + HC_IRQ_COAL_TIME_THRESHOLD_OFS);
-		writel(count, hc_mmio + HC_IRQ_COAL_IO_THRESHOLD_OFS);
-		writel(~HC_COAL_IRQ, hc_mmio + HC_IRQ_CAUSE_OFS);
+		writel(clks,  hc_mmio + HC_IRQ_COAL_TIME_THRESHOLD);
+		writel(count, hc_mmio + HC_IRQ_COAL_IO_THRESHOLD);
+		writel(~HC_COAL_IRQ, hc_mmio + HC_IRQ_CAUSE);
 		if (count)
 			coal_enable |= PORTS_4_7_COAL_DONE;
 	}
@@ -1132,7 +1133,7 @@
 		mv_set_edma_ptrs(port_mmio, hpriv, pp);
 		mv_clear_and_enable_port_irqs(ap, port_mmio, DONE_IRQ|ERR_IRQ);
 
-		writelfl(EDMA_EN, port_mmio + EDMA_CMD_OFS);
+		writelfl(EDMA_EN, port_mmio + EDMA_CMD);
 		pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
 	}
 }
@@ -1152,7 +1153,7 @@
 	 * as a rough guess at what even more drives might require.
 	 */
 	for (i = 0; i < timeout; ++i) {
-		u32 edma_stat = readl(port_mmio + EDMA_STATUS_OFS);
+		u32 edma_stat = readl(port_mmio + EDMA_STATUS);
 		if ((edma_stat & empty_idle) == empty_idle)
 			break;
 		udelay(per_loop);
@@ -1172,11 +1173,11 @@
 	int i;
 
 	/* Disable eDMA.  The disable bit auto clears. */
-	writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
+	writelfl(EDMA_DS, port_mmio + EDMA_CMD);
 
 	/* Wait for the chip to confirm eDMA is off. */
 	for (i = 10000; i > 0; i--) {
-		u32 reg = readl(port_mmio + EDMA_CMD_OFS);
+		u32 reg = readl(port_mmio + EDMA_CMD);
 		if (!(reg & EDMA_EN))
 			return 0;
 		udelay(10);
@@ -1286,10 +1287,10 @@
 	case SCR_STATUS:
 	case SCR_CONTROL:
 	case SCR_ERROR:
-		ofs = SATA_STATUS_OFS + (sc_reg_in * sizeof(u32));
+		ofs = SATA_STATUS + (sc_reg_in * sizeof(u32));
 		break;
 	case SCR_ACTIVE:
-		ofs = SATA_ACTIVE_OFS;   /* active is not with the others */
+		ofs = SATA_ACTIVE;   /* active is not with the others */
 		break;
 	default:
 		ofs = 0xffffffffU;
@@ -1410,9 +1411,9 @@
 	}
 
 	port_mmio = mv_ap_base(ap);
-	mv_write_cached_reg(port_mmio + FISCFG_OFS, old_fiscfg, fiscfg);
-	mv_write_cached_reg(port_mmio + LTMODE_OFS, old_ltmode, ltmode);
-	mv_write_cached_reg(port_mmio + EDMA_HALTCOND_OFS, old_haltcond, haltcond);
+	mv_write_cached_reg(port_mmio + FISCFG, old_fiscfg, fiscfg);
+	mv_write_cached_reg(port_mmio + LTMODE, old_ltmode, ltmode);
+	mv_write_cached_reg(port_mmio + EDMA_HALTCOND, old_haltcond, haltcond);
 }
 
 static void mv_60x1_errata_sata25(struct ata_port *ap, int want_ncq)
@@ -1421,13 +1422,13 @@
 	u32 old, new;
 
 	/* workaround for 88SX60x1 FEr SATA#25 (part 1) */
-	old = readl(hpriv->base + MV_GPIO_PORT_CTL_OFS);
+	old = readl(hpriv->base + GPIO_PORT_CTL);
 	if (want_ncq)
 		new = old | (1 << 22);
 	else
 		new = old & ~(1 << 22);
 	if (new != old)
-		writel(new, hpriv->base + MV_GPIO_PORT_CTL_OFS);
+		writel(new, hpriv->base + GPIO_PORT_CTL);
 }
 
 /**
@@ -1451,7 +1452,7 @@
 		new = *old | 1;
 	else
 		new = *old & ~1;
-	mv_write_cached_reg(mv_ap_base(ap) + EDMA_UNKNOWN_RSVD_OFS, old, new);
+	mv_write_cached_reg(mv_ap_base(ap) + EDMA_UNKNOWN_RSVD, old, new);
 }
 
 /*
@@ -1479,8 +1480,8 @@
 		return;
 	hpriv->hp_flags |= MV_HP_QUIRK_LED_BLINK_EN;
 	hc_mmio = mv_hc_base_from_port(mv_host_base(host), ap->port_no);
-	led_ctrl = readl(hc_mmio + SOC_LED_CTRL_OFS);
-	writel(led_ctrl | SOC_LED_CTRL_BLINK, hc_mmio + SOC_LED_CTRL_OFS);
+	led_ctrl = readl(hc_mmio + SOC_LED_CTRL);
+	writel(led_ctrl | SOC_LED_CTRL_BLINK, hc_mmio + SOC_LED_CTRL);
 }
 
 static void mv_soc_led_blink_disable(struct ata_port *ap)
@@ -1505,8 +1506,8 @@
 
 	hpriv->hp_flags &= ~MV_HP_QUIRK_LED_BLINK_EN;
 	hc_mmio = mv_hc_base_from_port(mv_host_base(host), ap->port_no);
-	led_ctrl = readl(hc_mmio + SOC_LED_CTRL_OFS);
-	writel(led_ctrl & ~SOC_LED_CTRL_BLINK, hc_mmio + SOC_LED_CTRL_OFS);
+	led_ctrl = readl(hc_mmio + SOC_LED_CTRL);
+	writel(led_ctrl & ~SOC_LED_CTRL_BLINK, hc_mmio + SOC_LED_CTRL);
 }
 
 static void mv_edma_cfg(struct ata_port *ap, int want_ncq, int want_edma)
@@ -1570,7 +1571,7 @@
 		pp->pp_flags |=  MV_PP_FLAG_NCQ_EN;
 	}
 
-	writelfl(cfg, port_mmio + EDMA_CFG_OFS);
+	writelfl(cfg, port_mmio + EDMA_CFG);
 }
 
 static void mv_port_free_dma_mem(struct ata_port *ap)
@@ -1800,13 +1801,13 @@
 	mv_fill_sg(qc);
 
 	/* clear all DMA cmd bits */
-	writel(0, port_mmio + BMDMA_CMD_OFS);
+	writel(0, port_mmio + BMDMA_CMD);
 
 	/* load PRD table addr. */
 	writel((pp->sg_tbl_dma[qc->tag] >> 16) >> 16,
-		port_mmio + BMDMA_PRD_HIGH_OFS);
+		port_mmio + BMDMA_PRD_HIGH);
 	writelfl(pp->sg_tbl_dma[qc->tag],
-		port_mmio + BMDMA_PRD_LOW_OFS);
+		port_mmio + BMDMA_PRD_LOW);
 
 	/* issue r/w command */
 	ap->ops->sff_exec_command(ap, &qc->tf);
@@ -1827,7 +1828,7 @@
 	u32 cmd = (rw ? 0 : ATA_DMA_WR) | ATA_DMA_START;
 
 	/* start host DMA transaction */
-	writelfl(cmd, port_mmio + BMDMA_CMD_OFS);
+	writelfl(cmd, port_mmio + BMDMA_CMD);
 }
 
 /**
@@ -1846,9 +1847,9 @@
 	u32 cmd;
 
 	/* clear start/stop bit */
-	cmd = readl(port_mmio + BMDMA_CMD_OFS);
+	cmd = readl(port_mmio + BMDMA_CMD);
 	cmd &= ~ATA_DMA_START;
-	writelfl(cmd, port_mmio + BMDMA_CMD_OFS);
+	writelfl(cmd, port_mmio + BMDMA_CMD);
 
 	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
 	ata_sff_dma_pause(ap);
@@ -1872,7 +1873,7 @@
 	 * Other bits are valid only if ATA_DMA_ACTIVE==0,
 	 * and the ATA_DMA_INTR bit doesn't exist.
 	 */
-	reg = readl(port_mmio + BMDMA_STATUS_OFS);
+	reg = readl(port_mmio + BMDMA_STATUS);
 	if (reg & ATA_DMA_ACTIVE)
 		status = ATA_DMA_ACTIVE;
 	else
@@ -2080,28 +2081,28 @@
 	int i, timeout = 200, final_word = nwords - 1;
 
 	/* Initiate FIS transmission mode */
-	old_ifctl = readl(port_mmio + SATA_IFCTL_OFS);
+	old_ifctl = readl(port_mmio + SATA_IFCTL);
 	ifctl = 0x100 | (old_ifctl & 0xf);
-	writelfl(ifctl, port_mmio + SATA_IFCTL_OFS);
+	writelfl(ifctl, port_mmio + SATA_IFCTL);
 
 	/* Send all words of the FIS except for the final word */
 	for (i = 0; i < final_word; ++i)
-		writel(fis[i], port_mmio + VENDOR_UNIQUE_FIS_OFS);
+		writel(fis[i], port_mmio + VENDOR_UNIQUE_FIS);
 
 	/* Flag end-of-transmission, and then send the final word */
-	writelfl(ifctl | 0x200, port_mmio + SATA_IFCTL_OFS);
-	writelfl(fis[final_word], port_mmio + VENDOR_UNIQUE_FIS_OFS);
+	writelfl(ifctl | 0x200, port_mmio + SATA_IFCTL);
+	writelfl(fis[final_word], port_mmio + VENDOR_UNIQUE_FIS);
 
 	/*
 	 * Wait for FIS transmission to complete.
 	 * This typically takes just a single iteration.
 	 */
 	do {
-		ifstat = readl(port_mmio + SATA_IFSTAT_OFS);
+		ifstat = readl(port_mmio + SATA_IFSTAT);
 	} while (!(ifstat & 0x1000) && --timeout);
 
 	/* Restore original port configuration */
-	writelfl(old_ifctl, port_mmio + SATA_IFCTL_OFS);
+	writelfl(old_ifctl, port_mmio + SATA_IFCTL);
 
 	/* See if it worked */
 	if ((ifstat & 0x3000) != 0x1000) {
@@ -2199,7 +2200,7 @@
 
 		/* Write the request in pointer to kick the EDMA to life */
 		writelfl((pp->crqb_dma & EDMA_REQ_Q_BASE_LO_MASK) | in_index,
-					port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
+					port_mmio + EDMA_REQ_Q_IN_PTR);
 		return 0;
 
 	case ATA_PROT_PIO:
@@ -2310,7 +2311,7 @@
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 
-	return readl(port_mmio + SATA_TESTCTL_OFS) >> 16;
+	return readl(port_mmio + SATA_TESTCTL) >> 16;
 }
 
 static void mv_pmp_eh_prep(struct ata_port *ap, unsigned int pmp_map)
@@ -2343,9 +2344,9 @@
 	void __iomem *port_mmio = mv_ap_base(ap);
 	u32 in_ptr, out_ptr;
 
-	in_ptr  = (readl(port_mmio + EDMA_REQ_Q_IN_PTR_OFS)
+	in_ptr  = (readl(port_mmio + EDMA_REQ_Q_IN_PTR)
 			>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
-	out_ptr = (readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS)
+	out_ptr = (readl(port_mmio + EDMA_REQ_Q_OUT_PTR)
 			>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
 	return (in_ptr == out_ptr);	/* 1 == queue_is_empty */
 }
@@ -2507,12 +2508,12 @@
 	sata_scr_read(&ap->link, SCR_ERROR, &serr);
 	sata_scr_write_flush(&ap->link, SCR_ERROR, serr);
 
-	edma_err_cause = readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
+	edma_err_cause = readl(port_mmio + EDMA_ERR_IRQ_CAUSE);
 	if (IS_GEN_IIE(hpriv) && (edma_err_cause & EDMA_ERR_TRANS_IRQ_7)) {
-		fis_cause = readl(port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
-		writelfl(~fis_cause, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
+		fis_cause = readl(port_mmio + FIS_IRQ_CAUSE);
+		writelfl(~fis_cause, port_mmio + FIS_IRQ_CAUSE);
 	}
-	writelfl(~edma_err_cause, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
+	writelfl(~edma_err_cause, port_mmio + EDMA_ERR_IRQ_CAUSE);
 
 	if (edma_err_cause & EDMA_ERR_DEV) {
 		/*
@@ -2530,7 +2531,7 @@
 
 	if (IS_GEN_IIE(hpriv) && (edma_err_cause & EDMA_ERR_TRANS_IRQ_7)) {
 		ata_ehi_push_desc(ehi, "fis_cause=%08x", fis_cause);
-		if (fis_cause & SATA_FIS_IRQ_AN) {
+		if (fis_cause & FIS_IRQ_CAUSE_AN) {
 			u32 ec = edma_err_cause &
 			       ~(EDMA_ERR_TRANS_IRQ_7 | EDMA_ERR_IRQ_TRANSIENT);
 			sata_async_notification(ap);
@@ -2632,7 +2633,7 @@
 		u16 edma_status = le16_to_cpu(response->flags);
 		/*
 		 * edma_status from a response queue entry:
-		 *   LSB is from EDMA_ERR_IRQ_CAUSE_OFS (non-NCQ only).
+		 *   LSB is from EDMA_ERR_IRQ_CAUSE (non-NCQ only).
 		 *   MSB is saved ATA status from command completion.
 		 */
 		if (!ncq_enabled) {
@@ -2664,7 +2665,7 @@
 	int ncq_enabled = (pp->pp_flags & MV_PP_FLAG_NCQ_EN);
 
 	/* Get the hardware queue position index */
-	in_index = (readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS)
+	in_index = (readl(port_mmio + EDMA_RSP_Q_IN_PTR)
 			>> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
 
 	/* Process new responses from since the last time we looked */
@@ -2689,7 +2690,7 @@
 	if (work_done)
 		writelfl((pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK) |
 			 (pp->resp_idx << EDMA_RSP_Q_PTR_SHIFT),
-			 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
+			 port_mmio + EDMA_RSP_Q_OUT_PTR);
 }
 
 static void mv_port_intr(struct ata_port *ap, u32 port_cause)
@@ -2746,7 +2747,7 @@
 
 	/* If asserted, clear the "all ports" IRQ coalescing bit */
 	if (main_irq_cause & ALL_PORTS_COAL_DONE)
-		writel(~ALL_PORTS_COAL_IRQ, mmio + MV_IRQ_COAL_CAUSE);
+		writel(~ALL_PORTS_COAL_IRQ, mmio + IRQ_COAL_CAUSE);
 
 	for (port = 0; port < hpriv->n_ports; port++) {
 		struct ata_port *ap = host->ports[port];
@@ -2790,7 +2791,7 @@
 					ack_irqs |= (DMA_IRQ | DEV_IRQ) << p;
 			}
 			hc_mmio = mv_hc_base_from_port(mmio, port);
-			writelfl(~ack_irqs, hc_mmio + HC_IRQ_CAUSE_OFS);
+			writelfl(~ack_irqs, hc_mmio + HC_IRQ_CAUSE);
 			handled = 1;
 		}
 		/*
@@ -2812,7 +2813,7 @@
 	unsigned int i, err_mask, printed = 0;
 	u32 err_cause;
 
-	err_cause = readl(mmio + hpriv->irq_cause_ofs);
+	err_cause = readl(mmio + hpriv->irq_cause_offset);
 
 	dev_printk(KERN_ERR, host->dev, "PCI ERROR; PCI IRQ cause=0x%08x\n",
 		   err_cause);
@@ -2820,7 +2821,7 @@
 	DPRINTK("All regs @ PCI error\n");
 	mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
 
-	writelfl(0, mmio + hpriv->irq_cause_ofs);
+	writelfl(0, mmio + hpriv->irq_cause_offset);
 
 	for (i = 0; i < host->n_ports; i++) {
 		ap = host->ports[i];
@@ -2957,7 +2958,7 @@
 
 static void mv5_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio)
 {
-	writel(0x0fcfffff, mmio + MV_FLASH_CTL_OFS);
+	writel(0x0fcfffff, mmio + FLASH_CTL);
 }
 
 static void mv5_read_preamp(struct mv_host_priv *hpriv, int idx,
@@ -2976,7 +2977,7 @@
 {
 	u32 tmp;
 
-	writel(0, mmio + MV_GPIO_PORT_CTL_OFS);
+	writel(0, mmio + GPIO_PORT_CTL);
 
 	/* FIXME: handle MV_HP_ERRATA_50XXB2 errata */
 
@@ -2994,14 +2995,14 @@
 	int fix_apm_sq = (hpriv->hp_flags & MV_HP_ERRATA_50XXB0);
 
 	if (fix_apm_sq) {
-		tmp = readl(phy_mmio + MV5_LTMODE_OFS);
+		tmp = readl(phy_mmio + MV5_LTMODE);
 		tmp |= (1 << 19);
-		writel(tmp, phy_mmio + MV5_LTMODE_OFS);
+		writel(tmp, phy_mmio + MV5_LTMODE);
 
-		tmp = readl(phy_mmio + MV5_PHY_CTL_OFS);
+		tmp = readl(phy_mmio + MV5_PHY_CTL);
 		tmp &= ~0x3;
 		tmp |= 0x1;
-		writel(tmp, phy_mmio + MV5_PHY_CTL_OFS);
+		writel(tmp, phy_mmio + MV5_PHY_CTL);
 	}
 
 	tmp = readl(phy_mmio + MV5_PHY_MODE);
@@ -3022,7 +3023,7 @@
 	mv_reset_channel(hpriv, mmio, port);
 
 	ZERO(0x028);	/* command */
-	writel(0x11f, port_mmio + EDMA_CFG_OFS);
+	writel(0x11f, port_mmio + EDMA_CFG);
 	ZERO(0x004);	/* timer */
 	ZERO(0x008);	/* irq err cause */
 	ZERO(0x00c);	/* irq err mask */
@@ -3033,7 +3034,7 @@
 	ZERO(0x024);	/* respq outp */
 	ZERO(0x020);	/* respq inp */
 	ZERO(0x02c);	/* test control */
-	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT_OFS);
+	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT);
 }
 #undef ZERO
 
@@ -3079,16 +3080,16 @@
 	struct mv_host_priv *hpriv = host->private_data;
 	u32 tmp;
 
-	tmp = readl(mmio + MV_PCI_MODE_OFS);
+	tmp = readl(mmio + MV_PCI_MODE);
 	tmp &= 0xff00ffff;
-	writel(tmp, mmio + MV_PCI_MODE_OFS);
+	writel(tmp, mmio + MV_PCI_MODE);
 
 	ZERO(MV_PCI_DISC_TIMER);
 	ZERO(MV_PCI_MSI_TRIGGER);
-	writel(0x000100ff, mmio + MV_PCI_XBAR_TMOUT_OFS);
+	writel(0x000100ff, mmio + MV_PCI_XBAR_TMOUT);
 	ZERO(MV_PCI_SERR_MASK);
-	ZERO(hpriv->irq_cause_ofs);
-	ZERO(hpriv->irq_mask_ofs);
+	ZERO(hpriv->irq_cause_offset);
+	ZERO(hpriv->irq_mask_offset);
 	ZERO(MV_PCI_ERR_LOW_ADDRESS);
 	ZERO(MV_PCI_ERR_HIGH_ADDRESS);
 	ZERO(MV_PCI_ERR_ATTRIBUTE);
@@ -3102,10 +3103,10 @@
 
 	mv5_reset_flash(hpriv, mmio);
 
-	tmp = readl(mmio + MV_GPIO_PORT_CTL_OFS);
+	tmp = readl(mmio + GPIO_PORT_CTL);
 	tmp &= 0x3;
 	tmp |= (1 << 5) | (1 << 6);
-	writel(tmp, mmio + MV_GPIO_PORT_CTL_OFS);
+	writel(tmp, mmio + GPIO_PORT_CTL);
 }
 
 /**
@@ -3120,7 +3121,7 @@
 static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 			unsigned int n_hc)
 {
-	void __iomem *reg = mmio + PCI_MAIN_CMD_STS_OFS;
+	void __iomem *reg = mmio + PCI_MAIN_CMD_STS;
 	int i, rc = 0;
 	u32 t;
 
@@ -3178,7 +3179,7 @@
 	void __iomem *port_mmio;
 	u32 tmp;
 
-	tmp = readl(mmio + MV_RESET_CFG_OFS);
+	tmp = readl(mmio + RESET_CFG);
 	if ((tmp & (1 << 0)) == 0) {
 		hpriv->signal[idx].amps = 0x7 << 8;
 		hpriv->signal[idx].pre = 0x1 << 5;
@@ -3186,7 +3187,7 @@
 	}
 
 	port_mmio = mv_port_base(mmio, idx);
-	tmp = readl(port_mmio + PHY_MODE2_OFS);
+	tmp = readl(port_mmio + PHY_MODE2);
 
 	hpriv->signal[idx].amps = tmp & 0x700;	/* bits 10:8 */
 	hpriv->signal[idx].pre = tmp & 0xe0;	/* bits 7:5 */
@@ -3194,7 +3195,7 @@
 
 static void mv6_enable_leds(struct mv_host_priv *hpriv, void __iomem *mmio)
 {
-	writel(0x00000060, mmio + MV_GPIO_PORT_CTL_OFS);
+	writel(0x00000060, mmio + GPIO_PORT_CTL);
 }
 
 static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
@@ -3210,25 +3211,25 @@
 	u32 m2, m3;
 
 	if (fix_phy_mode2) {
-		m2 = readl(port_mmio + PHY_MODE2_OFS);
+		m2 = readl(port_mmio + PHY_MODE2);
 		m2 &= ~(1 << 16);
 		m2 |= (1 << 31);
-		writel(m2, port_mmio + PHY_MODE2_OFS);
+		writel(m2, port_mmio + PHY_MODE2);
 
 		udelay(200);
 
-		m2 = readl(port_mmio + PHY_MODE2_OFS);
+		m2 = readl(port_mmio + PHY_MODE2);
 		m2 &= ~((1 << 16) | (1 << 31));
-		writel(m2, port_mmio + PHY_MODE2_OFS);
+		writel(m2, port_mmio + PHY_MODE2);
 
 		udelay(200);
 	}
 
 	/*
-	 * Gen-II/IIe PHY_MODE3_OFS errata RM#2:
+	 * Gen-II/IIe PHY_MODE3 errata RM#2:
 	 * Achieves better receiver noise performance than the h/w default:
 	 */
-	m3 = readl(port_mmio + PHY_MODE3_OFS);
+	m3 = readl(port_mmio + PHY_MODE3);
 	m3 = (m3 & 0x1f) | (0x5555601 << 5);
 
 	/* Guideline 88F5182 (GL# SATA-S11) */
@@ -3236,7 +3237,7 @@
 		m3 &= ~0x1c;
 
 	if (fix_phy_mode4) {
-		u32 m4 = readl(port_mmio + PHY_MODE4_OFS);
+		u32 m4 = readl(port_mmio + PHY_MODE4);
 		/*
 		 * Enforce reserved-bit restrictions on GenIIe devices only.
 		 * For earlier chipsets, force only the internal config field
@@ -3246,7 +3247,7 @@
 			m4 = (m4 & ~PHY_MODE4_RSVD_ZEROS) | PHY_MODE4_RSVD_ONES;
 		else
 			m4 = (m4 & ~PHY_MODE4_CFG_MASK) | PHY_MODE4_CFG_VALUE;
-		writel(m4, port_mmio + PHY_MODE4_OFS);
+		writel(m4, port_mmio + PHY_MODE4);
 	}
 	/*
 	 * Workaround for 60x1-B2 errata SATA#13:
@@ -3254,10 +3255,10 @@
 	 * so we must always rewrite PHY_MODE3 after PHY_MODE4.
 	 * Or ensure we use writelfl() when writing PHY_MODE4.
 	 */
-	writel(m3, port_mmio + PHY_MODE3_OFS);
+	writel(m3, port_mmio + PHY_MODE3);
 
 	/* Revert values of pre-emphasis and signal amps to the saved ones */
-	m2 = readl(port_mmio + PHY_MODE2_OFS);
+	m2 = readl(port_mmio + PHY_MODE2);
 
 	m2 &= ~MV_M2_PREAMP_MASK;
 	m2 |= hpriv->signal[port].amps;
@@ -3270,7 +3271,7 @@
 		m2 |= 0x0000900F;
 	}
 
-	writel(m2, port_mmio + PHY_MODE2_OFS);
+	writel(m2, port_mmio + PHY_MODE2);
 }
 
 /* TODO: use the generic LED interface to configure the SATA Presence */
@@ -3288,7 +3289,7 @@
 	u32 tmp;
 
 	port_mmio = mv_port_base(mmio, idx);
-	tmp = readl(port_mmio + PHY_MODE2_OFS);
+	tmp = readl(port_mmio + PHY_MODE2);
 
 	hpriv->signal[idx].amps = tmp & 0x700;	/* bits 10:8 */
 	hpriv->signal[idx].pre = tmp & 0xe0;	/* bits 7:5 */
@@ -3304,7 +3305,7 @@
 	mv_reset_channel(hpriv, mmio, port);
 
 	ZERO(0x028);		/* command */
-	writel(0x101f, port_mmio + EDMA_CFG_OFS);
+	writel(0x101f, port_mmio + EDMA_CFG);
 	ZERO(0x004);		/* timer */
 	ZERO(0x008);		/* irq err cause */
 	ZERO(0x00c);		/* irq err mask */
@@ -3315,7 +3316,7 @@
 	ZERO(0x024);		/* respq outp */
 	ZERO(0x020);		/* respq inp */
 	ZERO(0x02c);		/* test control */
-	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT_OFS);
+	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT);
 }
 
 #undef ZERO
@@ -3360,12 +3361,12 @@
 
 static void mv_setup_ifcfg(void __iomem *port_mmio, int want_gen2i)
 {
-	u32 ifcfg = readl(port_mmio + SATA_INTERFACE_CFG_OFS);
+	u32 ifcfg = readl(port_mmio + SATA_IFCFG);
 
 	ifcfg = (ifcfg & 0xf7f) | 0x9b1000;	/* from chip spec */
 	if (want_gen2i)
 		ifcfg |= (1 << 7);		/* enable gen2i speed */
-	writelfl(ifcfg, port_mmio + SATA_INTERFACE_CFG_OFS);
+	writelfl(ifcfg, port_mmio + SATA_IFCFG);
 }
 
 static void mv_reset_channel(struct mv_host_priv *hpriv, void __iomem *mmio,
@@ -3379,7 +3380,7 @@
 	 * to disable the EDMA engine before doing the EDMA_RESET operation.
 	 */
 	mv_stop_edma_engine(port_mmio);
-	writelfl(EDMA_RESET, port_mmio + EDMA_CMD_OFS);
+	writelfl(EDMA_RESET, port_mmio + EDMA_CMD);
 
 	if (!IS_GEN_I(hpriv)) {
 		/* Enable 3.0gb/s link speed: this survives EDMA_RESET */
@@ -3388,11 +3389,11 @@
 	/*
 	 * Strobing EDMA_RESET here causes a hard reset of the SATA transport,
 	 * link, and physical layers.  It resets all SATA interface registers
-	 * (except for SATA_INTERFACE_CFG), and issues a COMRESET to the dev.
+	 * (except for SATA_IFCFG), and issues a COMRESET to the dev.
 	 */
-	writelfl(EDMA_RESET, port_mmio + EDMA_CMD_OFS);
+	writelfl(EDMA_RESET, port_mmio + EDMA_CMD);
 	udelay(25);	/* allow reset propagation */
-	writelfl(0, port_mmio + EDMA_CMD_OFS);
+	writelfl(0, port_mmio + EDMA_CMD);
 
 	hpriv->ops->phy_errata(hpriv, mmio, port_no);
 
@@ -3404,12 +3405,12 @@
 {
 	if (sata_pmp_supported(ap)) {
 		void __iomem *port_mmio = mv_ap_base(ap);
-		u32 reg = readl(port_mmio + SATA_IFCTL_OFS);
+		u32 reg = readl(port_mmio + SATA_IFCTL);
 		int old = reg & 0xf;
 
 		if (old != pmp) {
 			reg = (reg & ~0xf) | pmp;
-			writelfl(reg, port_mmio + SATA_IFCTL_OFS);
+			writelfl(reg, port_mmio + SATA_IFCTL);
 		}
 	}
 }
@@ -3484,11 +3485,11 @@
 	u32 hc_irq_cause;
 
 	/* clear EDMA errors on this port */
-	writel(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
+	writel(0, port_mmio + EDMA_ERR_IRQ_CAUSE);
 
 	/* clear pending irq events */
 	hc_irq_cause = ~((DEV_IRQ | DMA_IRQ) << hardport);
-	writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
+	writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE);
 
 	mv_enable_port_irqs(ap, ERR_IRQ);
 }
@@ -3507,8 +3508,7 @@
  */
 static void mv_port_init(struct ata_ioports *port,  void __iomem *port_mmio)
 {
-	void __iomem *shd_base = port_mmio + SHD_BLK_OFS;
-	unsigned serr_ofs;
+	void __iomem *serr, *shd_base = port_mmio + SHD_BLK;
 
 	/* PIO related setup
 	 */
@@ -3523,23 +3523,23 @@
 	port->status_addr =
 		port->command_addr = shd_base + (sizeof(u32) * ATA_REG_STATUS);
 	/* special case: control/altstatus doesn't have ATA_REG_ address */
-	port->altstatus_addr = port->ctl_addr = shd_base + SHD_CTL_AST_OFS;
+	port->altstatus_addr = port->ctl_addr = shd_base + SHD_CTL_AST;
 
 	/* unused: */
 	port->cmd_addr = port->bmdma_addr = port->scr_addr = NULL;
 
 	/* Clear any currently outstanding port interrupt conditions */
-	serr_ofs = mv_scr_offset(SCR_ERROR);
-	writelfl(readl(port_mmio + serr_ofs), port_mmio + serr_ofs);
-	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
+	serr = port_mmio + mv_scr_offset(SCR_ERROR);
+	writelfl(readl(serr), serr);
+	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE);
 
 	/* unmask all non-transient EDMA error interrupts */
-	writelfl(~EDMA_ERR_IRQ_TRANSIENT, port_mmio + EDMA_ERR_IRQ_MASK_OFS);
+	writelfl(~EDMA_ERR_IRQ_TRANSIENT, port_mmio + EDMA_ERR_IRQ_MASK);
 
 	VPRINTK("EDMA cfg=0x%08x EDMA IRQ err cause/mask=0x%08x/0x%08x\n",
-		readl(port_mmio + EDMA_CFG_OFS),
-		readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS),
-		readl(port_mmio + EDMA_ERR_IRQ_MASK_OFS));
+		readl(port_mmio + EDMA_CFG),
+		readl(port_mmio + EDMA_ERR_IRQ_CAUSE),
+		readl(port_mmio + EDMA_ERR_IRQ_MASK));
 }
 
 static unsigned int mv_in_pcix_mode(struct ata_host *host)
@@ -3550,7 +3550,7 @@
 
 	if (IS_SOC(hpriv) || !IS_PCIE(hpriv))
 		return 0;	/* not PCI-X capable */
-	reg = readl(mmio + MV_PCI_MODE_OFS);
+	reg = readl(mmio + MV_PCI_MODE);
 	if ((reg & MV_PCI_MODE_MASK) == 0)
 		return 0;	/* conventional PCI mode */
 	return 1;	/* chip is in PCI-X mode */
@@ -3563,8 +3563,8 @@
 	u32 reg;
 
 	if (!mv_in_pcix_mode(host)) {
-		reg = readl(mmio + PCI_COMMAND_OFS);
-		if (reg & PCI_COMMAND_MRDTRIG)
+		reg = readl(mmio + MV_PCI_COMMAND);
+		if (reg & MV_PCI_COMMAND_MRDTRIG)
 			return 0; /* not okay */
 	}
 	return 1; /* okay */
@@ -3577,8 +3577,8 @@
 
 	/* workaround for 60x1-B2 errata PCI#7 */
 	if (mv_in_pcix_mode(host)) {
-		u32 reg = readl(mmio + PCI_COMMAND_OFS);
-		writelfl(reg & ~PCI_COMMAND_MWRCOM, mmio + PCI_COMMAND_OFS);
+		u32 reg = readl(mmio + MV_PCI_COMMAND);
+		writelfl(reg & ~MV_PCI_COMMAND_MWRCOM, mmio + MV_PCI_COMMAND);
 	}
 }
 
@@ -3712,12 +3712,12 @@
 
 	hpriv->hp_flags = hp_flags;
 	if (hp_flags & MV_HP_PCIE) {
-		hpriv->irq_cause_ofs	= PCIE_IRQ_CAUSE_OFS;
-		hpriv->irq_mask_ofs	= PCIE_IRQ_MASK_OFS;
+		hpriv->irq_cause_offset	= PCIE_IRQ_CAUSE;
+		hpriv->irq_mask_offset	= PCIE_IRQ_MASK;
 		hpriv->unmask_all_irqs	= PCIE_UNMASK_ALL_IRQS;
 	} else {
-		hpriv->irq_cause_ofs	= PCI_IRQ_CAUSE_OFS;
-		hpriv->irq_mask_ofs	= PCI_IRQ_MASK_OFS;
+		hpriv->irq_cause_offset	= PCI_IRQ_CAUSE;
+		hpriv->irq_mask_offset	= PCI_IRQ_MASK;
 		hpriv->unmask_all_irqs	= PCI_UNMASK_ALL_IRQS;
 	}
 
@@ -3746,11 +3746,11 @@
 		goto done;
 
 	if (IS_SOC(hpriv)) {
-		hpriv->main_irq_cause_addr = mmio + SOC_HC_MAIN_IRQ_CAUSE_OFS;
-		hpriv->main_irq_mask_addr  = mmio + SOC_HC_MAIN_IRQ_MASK_OFS;
+		hpriv->main_irq_cause_addr = mmio + SOC_HC_MAIN_IRQ_CAUSE;
+		hpriv->main_irq_mask_addr  = mmio + SOC_HC_MAIN_IRQ_MASK;
 	} else {
-		hpriv->main_irq_cause_addr = mmio + PCI_HC_MAIN_IRQ_CAUSE_OFS;
-		hpriv->main_irq_mask_addr  = mmio + PCI_HC_MAIN_IRQ_MASK_OFS;
+		hpriv->main_irq_cause_addr = mmio + PCI_HC_MAIN_IRQ_CAUSE;
+		hpriv->main_irq_mask_addr  = mmio + PCI_HC_MAIN_IRQ_MASK;
 	}
 
 	/* initialize shadow irq mask with register's value */
@@ -3792,19 +3792,19 @@
 
 		VPRINTK("HC%i: HC config=0x%08x HC IRQ cause "
 			"(before clear)=0x%08x\n", hc,
-			readl(hc_mmio + HC_CFG_OFS),
-			readl(hc_mmio + HC_IRQ_CAUSE_OFS));
+			readl(hc_mmio + HC_CFG),
+			readl(hc_mmio + HC_IRQ_CAUSE));
 
 		/* Clear any currently outstanding hc interrupt conditions */
-		writelfl(0, hc_mmio + HC_IRQ_CAUSE_OFS);
+		writelfl(0, hc_mmio + HC_IRQ_CAUSE);
 	}
 
 	if (!IS_SOC(hpriv)) {
 		/* Clear any currently outstanding host interrupt conditions */
-		writelfl(0, mmio + hpriv->irq_cause_ofs);
+		writelfl(0, mmio + hpriv->irq_cause_offset);
 
 		/* and unmask interrupt generation for host regs */
-		writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
+		writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_offset);
 	}
 
 	/*
@@ -3911,7 +3911,7 @@
 	host->iomap = NULL;
 	hpriv->base = devm_ioremap(&pdev->dev, res->start,
 				   res->end - res->start + 1);
-	hpriv->base -= MV_SATAHC0_REG_BASE;
+	hpriv->base -= SATAHC0_REG_BASE;
 
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
