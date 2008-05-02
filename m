From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 01/12] sata_mv more cosmetic changes
Date: Fri, 02 May 2008 02:07:51 -0400
Message-ID: <481AAFB7.4090708@rtr.ca>
References: <481AAF84.40501@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1114 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbYEBGHx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:07:53 -0400
In-Reply-To: <481AAF84.40501@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

More cosmetic changes; no code changes.

 -- try and improve consistency of naming.
 -- add missing _OFS to tails of register offset definitions.
 -- rename mv_setup_ifctl() to mv_setup_ifcfg(), since that's what it really does.
 -- remove/move some dead comments

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-05-01 15:37:20.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-01 17:23:50.000000000 -0400
@@ -91,9 +91,9 @@
 	MV_IRQ_COAL_TIME_THRESHOLD	= (MV_IRQ_COAL_REG_BASE + 0xd0),
 
 	MV_SATAHC0_REG_BASE	= 0x20000,
-	MV_FLASH_CTL		= 0x1046c,
-	MV_GPIO_PORT_CTL	= 0x104f0,
-	MV_RESET_CFG		= 0x180d8,
+	MV_FLASH_CTL_OFS	= 0x1046c,
+	MV_GPIO_PORT_CTL_OFS	= 0x104f0,
+	MV_RESET_CFG_OFS	= 0x180d8,
 
 	MV_PCI_REG_SZ		= MV_MAJOR_REG_AREA_SZ,
 	MV_SATAHC_REG_SZ	= MV_MAJOR_REG_AREA_SZ,
@@ -147,18 +147,21 @@
 	/* PCI interface registers */
 
 	PCI_COMMAND_OFS		= 0xc00,
+	PCI_COMMAND_MRDTRIG	= (1 << 7),	/* PCI Master Read Trigger */
 
 	PCI_MAIN_CMD_STS_OFS	= 0xd30,
 	STOP_PCI_MASTER		= (1 << 2),
 	PCI_MASTER_EMPTY	= (1 << 3),
 	GLOB_SFT_RST		= (1 << 4),
 
-	MV_PCI_MODE		= 0xd00,
+	MV_PCI_MODE_OFS		= 0xd00,
+	MV_PCI_MODE_MASK	= 0x30,
+
 	MV_PCI_EXP_ROM_BAR_CTL	= 0xd2c,
 	MV_PCI_DISC_TIMER	= 0xd04,
 	MV_PCI_MSI_TRIGGER	= 0xc38,
 	MV_PCI_SERR_MASK	= 0xc28,
-	MV_PCI_XBAR_TMOUT	= 0x1d04,
+	MV_PCI_XBAR_TMOUT_OFS	= 0x1d04,
 	MV_PCI_ERR_LOW_ADDRESS	= 0x1d40,
 	MV_PCI_ERR_HIGH_ADDRESS	= 0x1d44,
 	MV_PCI_ERR_ATTRIBUTE	= 0x1d48,
@@ -225,16 +228,18 @@
 	PHY_MODE4		= 0x314,
 	PHY_MODE2		= 0x330,
 	SATA_IFCTL_OFS		= 0x344,
+	SATA_TESTCTL_OFS	= 0x348,
 	SATA_IFSTAT_OFS		= 0x34c,
 	VENDOR_UNIQUE_FIS_OFS	= 0x35c,
 
-	FIS_CFG_OFS		= 0x360,
-	FIS_CFG_SINGLE_SYNC	= (1 << 16),	/* SYNC on DMA activation */
+	FISCFG_OFS		= 0x360,
+	FISCFG_WAIT_DEV_ERR	= (1 << 8),	/* wait for host on DevErr */
+	FISCFG_SINGLE_SYNC	= (1 << 16),	/* SYNC on DMA activation */
 
 	MV5_PHY_MODE		= 0x74,
-	MV5_LT_MODE		= 0x30,
-	MV5_PHY_CTL		= 0x0C,
-	SATA_INTERFACE_CFG	= 0x050,
+	MV5_LTMODE_OFS		= 0x30,
+	MV5_PHY_CTL_OFS		= 0x0C,
+	SATA_INTERFACE_CFG_OFS	= 0x050,
 
 	MV_M2_PREAMP_MASK	= 0x7e0,
 
@@ -332,10 +337,16 @@
 	EDMA_CMD_OFS		= 0x28,		/* EDMA command register */
 	EDMA_EN			= (1 << 0),	/* enable EDMA */
 	EDMA_DS			= (1 << 1),	/* disable EDMA; self-negated */
-	ATA_RST			= (1 << 2),	/* reset trans/link/phy */
+	EDMA_RESET		= (1 << 2),	/* reset eng/trans/link/phy */
+
+	EDMA_STATUS_OFS		= 0x30,		/* EDMA engine status */
+	EDMA_STATUS_CACHE_EMPTY	= (1 << 6),	/* GenIIe command cache empty */
+	EDMA_STATUS_IDLE	= (1 << 7),	/* GenIIe EDMA enabled/idle */
 
-	EDMA_IORDY_TMOUT	= 0x34,
-	EDMA_ARB_CFG		= 0x38,
+	EDMA_IORDY_TMOUT_OFS	= 0x34,
+	EDMA_ARB_CFG_OFS	= 0x38,
+
+	EDMA_HALTCOND_OFS	= 0x60,		/* GenIIe halt conditions */
 
 	GEN_II_NCQ_MAX_SECTORS	= 256,		/* max sects/io on Gen2 w/NCQ */
 
@@ -359,6 +370,7 @@
 #define IS_GEN_I(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_I)
 #define IS_GEN_II(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_II)
 #define IS_GEN_IIE(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_IIE)
+#define IS_PCIE(hpriv) ((hpriv)->hp_flags & MV_HP_PCIE)
 #define HAS_PCI(host) (!((host)->ports[0]->flags & MV_FLAG_SOC))
 
 #define WINDOW_CTRL(i)		(0x20030 + ((i) << 4))
@@ -1059,22 +1071,22 @@
 
 static void mv_config_fbs(void __iomem *port_mmio, int enable_fbs)
 {
-	u32 old_fcfg, new_fcfg, old_ltmode, new_ltmode;
+	u32 old_fiscfg, new_fiscfg, old_ltmode, new_ltmode;
 	/*
 	 * Various bit settings required for operation
 	 * in FIS-based switching (fbs) mode on GenIIe:
 	 */
-	old_fcfg   = readl(port_mmio + FIS_CFG_OFS);
+	old_fiscfg = readl(port_mmio + FISCFG_OFS);
 	old_ltmode = readl(port_mmio + LTMODE_OFS);
 	if (enable_fbs) {
-		new_fcfg   = old_fcfg   |  FIS_CFG_SINGLE_SYNC;
+		new_fiscfg = old_fiscfg |  FISCFG_SINGLE_SYNC;
 		new_ltmode = old_ltmode |  LTMODE_BIT8;
 	} else { /* disable fbs */
-		new_fcfg   = old_fcfg   & ~FIS_CFG_SINGLE_SYNC;
+		new_fiscfg = old_fiscfg & ~FISCFG_SINGLE_SYNC;
 		new_ltmode = old_ltmode & ~LTMODE_BIT8;
 	}
-	if (new_fcfg != old_fcfg)
-		writelfl(new_fcfg, port_mmio + FIS_CFG_OFS);
+	if (new_fiscfg != old_fiscfg)
+		writelfl(new_fiscfg, port_mmio + FISCFG_OFS);
 	if (new_ltmode != old_ltmode)
 		writelfl(new_ltmode, port_mmio + LTMODE_OFS);
 }
@@ -1894,7 +1906,7 @@
 
 static void mv5_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio)
 {
-	writel(0x0fcfffff, mmio + MV_FLASH_CTL);
+	writel(0x0fcfffff, mmio + MV_FLASH_CTL_OFS);
 }
 
 static void mv5_read_preamp(struct mv_host_priv *hpriv, int idx,
@@ -1913,7 +1925,7 @@
 {
 	u32 tmp;
 
-	writel(0, mmio + MV_GPIO_PORT_CTL);
+	writel(0, mmio + MV_GPIO_PORT_CTL_OFS);
 
 	/* FIXME: handle MV_HP_ERRATA_50XXB2 errata */
 
@@ -1931,14 +1943,14 @@
 	int fix_apm_sq = (hpriv->hp_flags & MV_HP_ERRATA_50XXB0);
 
 	if (fix_apm_sq) {
-		tmp = readl(phy_mmio + MV5_LT_MODE);
+		tmp = readl(phy_mmio + MV5_LTMODE_OFS);
 		tmp |= (1 << 19);
-		writel(tmp, phy_mmio + MV5_LT_MODE);
+		writel(tmp, phy_mmio + MV5_LTMODE_OFS);
 
-		tmp = readl(phy_mmio + MV5_PHY_CTL);
+		tmp = readl(phy_mmio + MV5_PHY_CTL_OFS);
 		tmp &= ~0x3;
 		tmp |= 0x1;
-		writel(tmp, phy_mmio + MV5_PHY_CTL);
+		writel(tmp, phy_mmio + MV5_PHY_CTL_OFS);
 	}
 
 	tmp = readl(phy_mmio + MV5_PHY_MODE);
@@ -1956,11 +1968,6 @@
 {
 	void __iomem *port_mmio = mv_port_base(mmio, port);
 
-	/*
-	 * The datasheet warns against setting ATA_RST when EDMA is active
-	 * (but doesn't say what the problem might be).  So we first try
-	 * to disable the EDMA engine before doing the ATA_RST operation.
-	 */
 	mv_reset_channel(hpriv, mmio, port);
 
 	ZERO(0x028);	/* command */
@@ -1975,7 +1982,7 @@
 	ZERO(0x024);	/* respq outp */
 	ZERO(0x020);	/* respq inp */
 	ZERO(0x02c);	/* test control */
-	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT);
+	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT_OFS);
 }
 #undef ZERO
 
@@ -2021,13 +2028,13 @@
 	struct mv_host_priv *hpriv = host->private_data;
 	u32 tmp;
 
-	tmp = readl(mmio + MV_PCI_MODE);
+	tmp = readl(mmio + MV_PCI_MODE_OFS);
 	tmp &= 0xff00ffff;
-	writel(tmp, mmio + MV_PCI_MODE);
+	writel(tmp, mmio + MV_PCI_MODE_OFS);
 
 	ZERO(MV_PCI_DISC_TIMER);
 	ZERO(MV_PCI_MSI_TRIGGER);
-	writel(0x000100ff, mmio + MV_PCI_XBAR_TMOUT);
+	writel(0x000100ff, mmio + MV_PCI_XBAR_TMOUT_OFS);
 	ZERO(PCI_HC_MAIN_IRQ_MASK_OFS);
 	ZERO(MV_PCI_SERR_MASK);
 	ZERO(hpriv->irq_cause_ofs);
@@ -2045,10 +2052,10 @@
 
 	mv5_reset_flash(hpriv, mmio);
 
-	tmp = readl(mmio + MV_GPIO_PORT_CTL);
+	tmp = readl(mmio + MV_GPIO_PORT_CTL_OFS);
 	tmp &= 0x3;
 	tmp |= (1 << 5) | (1 << 6);
-	writel(tmp, mmio + MV_GPIO_PORT_CTL);
+	writel(tmp, mmio + MV_GPIO_PORT_CTL_OFS);
 }
 
 /**
@@ -2121,7 +2128,7 @@
 	void __iomem *port_mmio;
 	u32 tmp;
 
-	tmp = readl(mmio + MV_RESET_CFG);
+	tmp = readl(mmio + MV_RESET_CFG_OFS);
 	if ((tmp & (1 << 0)) == 0) {
 		hpriv->signal[idx].amps = 0x7 << 8;
 		hpriv->signal[idx].pre = 0x1 << 5;
@@ -2137,7 +2144,7 @@
 
 static void mv6_enable_leds(struct mv_host_priv *hpriv, void __iomem *mmio)
 {
-	writel(0x00000060, mmio + MV_GPIO_PORT_CTL);
+	writel(0x00000060, mmio + MV_GPIO_PORT_CTL_OFS);
 }
 
 static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
@@ -2235,11 +2242,6 @@
 {
 	void __iomem *port_mmio = mv_port_base(mmio, port);
 
-	/*
-	 * The datasheet warns against setting ATA_RST when EDMA is active
-	 * (but doesn't say what the problem might be).  So we first try
-	 * to disable the EDMA engine before doing the ATA_RST operation.
-	 */
 	mv_reset_channel(hpriv, mmio, port);
 
 	ZERO(0x028);		/* command */
@@ -2254,7 +2256,7 @@
 	ZERO(0x024);		/* respq outp */
 	ZERO(0x020);		/* respq inp */
 	ZERO(0x02c);		/* test control */
-	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT);
+	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT_OFS);
 }
 
 #undef ZERO
@@ -2297,38 +2299,39 @@
 	return;
 }
 
-static void mv_setup_ifctl(void __iomem *port_mmio, int want_gen2i)
+static void mv_setup_ifcfg(void __iomem *port_mmio, int want_gen2i)
 {
-	u32 ifctl = readl(port_mmio + SATA_INTERFACE_CFG);
+	u32 ifcfg = readl(port_mmio + SATA_INTERFACE_CFG_OFS);
 
-	ifctl = (ifctl & 0xf7f) | 0x9b1000;	/* from chip spec */
+	ifcfg = (ifcfg & 0xf7f) | 0x9b1000;	/* from chip spec */
 	if (want_gen2i)
-		ifctl |= (1 << 7);		/* enable gen2i speed */
-	writelfl(ifctl, port_mmio + SATA_INTERFACE_CFG);
+		ifcfg |= (1 << 7);		/* enable gen2i speed */
+	writelfl(ifcfg, port_mmio + SATA_INTERFACE_CFG_OFS);
 }
 
-/*
- * Caller must ensure that EDMA is not active,
- * by first doing mv_stop_edma() where needed.
- */
 static void mv_reset_channel(struct mv_host_priv *hpriv, void __iomem *mmio,
 			     unsigned int port_no)
 {
 	void __iomem *port_mmio = mv_port_base(mmio, port_no);
 
+	/*
+	 * The datasheet warns against setting EDMA_RESET when EDMA is active
+	 * (but doesn't say what the problem might be).  So we first try
+	 * to disable the EDMA engine before doing the EDMA_RESET operation.
+	 */
 	mv_stop_edma_engine(port_mmio);
-	writelfl(ATA_RST, port_mmio + EDMA_CMD_OFS);
+	writelfl(EDMA_RESET, port_mmio + EDMA_CMD_OFS);
 
 	if (!IS_GEN_I(hpriv)) {
-		/* Enable 3.0gb/s link speed */
-		mv_setup_ifctl(port_mmio, 1);
+		/* Enable 3.0gb/s link speed: this survives EDMA_RESET */
+		mv_setup_ifcfg(port_mmio, 1);
 	}
 	/*
-	 * Strobing ATA_RST here causes a hard reset of the SATA transport,
+	 * Strobing EDMA_RESET here causes a hard reset of the SATA transport,
 	 * link, and physical layers.  It resets all SATA interface registers
 	 * (except for SATA_INTERFACE_CFG), and issues a COMRESET to the dev.
 	 */
-	writelfl(ATA_RST, port_mmio + EDMA_CMD_OFS);
+	writelfl(EDMA_RESET, port_mmio + EDMA_CMD_OFS);
 	udelay(25);	/* allow reset propagation */
 	writelfl(0, port_mmio + EDMA_CMD_OFS);
 
@@ -2392,7 +2395,7 @@
 		sata_scr_read(link, SCR_STATUS, &sstatus);
 		if (!IS_GEN_I(hpriv) && ++attempts >= 5 && sstatus == 0x121) {
 			/* Force 1.5gb/s link speed and try again */
-			mv_setup_ifctl(mv_ap_base(ap), 0);
+			mv_setup_ifcfg(mv_ap_base(ap), 0);
 			if (time_after(jiffies + HZ, deadline))
 				extra = HZ; /* only extend it once, max */
 		}
@@ -2590,6 +2593,7 @@
 				" and avoid the final two gigabytes on"
 				" all RocketRAID BIOS initialized drives.\n");
 		}
+		/* drop through */
 	case chip_6042:
 		hpriv->ops = &mv6xxx_ops;
 		hp_flags |= MV_HP_GEN_IIE;
