From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 06/07] sata_mv: cosmetic renames
Date: Mon, 06 Apr 2009 15:25:39 -0400
Message-ID: <49DA5733.3050206@rtr.ca>
References: <49DA2DFD.4010402@rtr.ca> <49DA2E33.4050704@rtr.ca> <49DA2E76.7000800@rtr.ca> <49DA566D.9040501@rtr.ca> <49DA56DE.3000200@rtr.ca> <49DA5709.7060005@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:33213 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282AbZDFTZl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 15:25:41 -0400
In-Reply-To: <49DA5709.7060005@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Saeed Bishara <saeed@marvell.com>

Add _OFS suffix to more of the register offset names,
for consistency with the rest of the driver.

Also tag the defines for LTMODE and PHY_MODE4 to note
that read-after-write is necessary when updating those regs.

No code changes here.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-04-06 14:20:53.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-04-06 15:00:16.000000000 -0400
@@ -272,17 +272,17 @@
 	SATA_FIS_IRQ_CAUSE_OFS	= 0x364,
 	SATA_FIS_IRQ_AN		= (1 << 9),	/* async notification */
 
-	LTMODE_OFS		= 0x30c,
+	LTMODE_OFS		= 0x30c,	/* requires read-after-write */
 	LTMODE_BIT8		= (1 << 8),	/* unknown, but necessary */
 
-	PHY_MODE3		= 0x310,
-	PHY_MODE4		= 0x314,
+	PHY_MODE2_OFS		= 0x330,
+	PHY_MODE3_OFS		= 0x310,
+	PHY_MODE4_OFS		= 0x314,	/* requires read-after-write */
 	PHY_MODE4_CFG_MASK	= 0x00000003,	/* phy internal config field */
 	PHY_MODE4_CFG_VALUE	= 0x00000001,	/* phy internal config field */
 	PHY_MODE4_RSVD_ZEROS	= 0x5de3fffa,	/* Gen2e always write zeros */
 	PHY_MODE4_RSVD_ONES	= 0x00000005,	/* Gen2e always write ones */
 
-	PHY_MODE2		= 0x330,
 	SATA_IFCTL_OFS		= 0x344,
 	SATA_TESTCTL_OFS	= 0x348,
 	SATA_IFSTAT_OFS		= 0x34c,
@@ -3168,7 +3168,7 @@
 	}
 
 	port_mmio = mv_port_base(mmio, idx);
-	tmp = readl(port_mmio + PHY_MODE2);
+	tmp = readl(port_mmio + PHY_MODE2_OFS);
 
 	hpriv->signal[idx].amps = tmp & 0x700;	/* bits 10:8 */
 	hpriv->signal[idx].pre = tmp & 0xe0;	/* bits 7:5 */
@@ -3192,25 +3192,25 @@
 	u32 m2, m3;
 
 	if (fix_phy_mode2) {
-		m2 = readl(port_mmio + PHY_MODE2);
+		m2 = readl(port_mmio + PHY_MODE2_OFS);
 		m2 &= ~(1 << 16);
 		m2 |= (1 << 31);
-		writel(m2, port_mmio + PHY_MODE2);
+		writel(m2, port_mmio + PHY_MODE2_OFS);
 
 		udelay(200);
 
-		m2 = readl(port_mmio + PHY_MODE2);
+		m2 = readl(port_mmio + PHY_MODE2_OFS);
 		m2 &= ~((1 << 16) | (1 << 31));
-		writel(m2, port_mmio + PHY_MODE2);
+		writel(m2, port_mmio + PHY_MODE2_OFS);
 
 		udelay(200);
 	}
 
 	/*
-	 * Gen-II/IIe PHY_MODE3 errata RM#2:
+	 * Gen-II/IIe PHY_MODE3_OFS errata RM#2:
 	 * Achieves better receiver noise performance than the h/w default:
 	 */
-	m3 = readl(port_mmio + PHY_MODE3);
+	m3 = readl(port_mmio + PHY_MODE3_OFS);
 	m3 = (m3 & 0x1f) | (0x5555601 << 5);
 
 	/* Guideline 88F5182 (GL# SATA-S11) */
@@ -3218,7 +3218,7 @@
 		m3 &= ~0x1c;
 
 	if (fix_phy_mode4) {
-		u32 m4 = readl(port_mmio + PHY_MODE4);
+		u32 m4 = readl(port_mmio + PHY_MODE4_OFS);
 		/*
 		 * Enforce reserved-bit restrictions on GenIIe devices only.
 		 * For earlier chipsets, force only the internal config field
@@ -3228,17 +3228,18 @@
 			m4 = (m4 & ~PHY_MODE4_RSVD_ZEROS) | PHY_MODE4_RSVD_ONES;
 		else
 			m4 = (m4 & ~PHY_MODE4_CFG_MASK) | PHY_MODE4_CFG_VALUE;
-		writel(m4, port_mmio + PHY_MODE4);
+		writel(m4, port_mmio + PHY_MODE4_OFS);
 	}
 	/*
 	 * Workaround for 60x1-B2 errata SATA#13:
 	 * Any write to PHY_MODE4 (above) may corrupt PHY_MODE3,
 	 * so we must always rewrite PHY_MODE3 after PHY_MODE4.
+	 * Or ensure we use writelfl() when writing PHY_MODE4.
 	 */
-	writel(m3, port_mmio + PHY_MODE3);
+	writel(m3, port_mmio + PHY_MODE3_OFS);
 
 	/* Revert values of pre-emphasis and signal amps to the saved ones */
-	m2 = readl(port_mmio + PHY_MODE2);
+	m2 = readl(port_mmio + PHY_MODE2_OFS);
 
 	m2 &= ~MV_M2_PREAMP_MASK;
 	m2 |= hpriv->signal[port].amps;
@@ -3251,7 +3252,7 @@
 		m2 |= 0x0000900F;
 	}
 
-	writel(m2, port_mmio + PHY_MODE2);
+	writel(m2, port_mmio + PHY_MODE2_OFS);
 }
 
 /* TODO: use the generic LED interface to configure the SATA Presence */
@@ -3269,7 +3270,7 @@
 	u32 tmp;
 
 	port_mmio = mv_port_base(mmio, idx);
-	tmp = readl(port_mmio + PHY_MODE2);
+	tmp = readl(port_mmio + PHY_MODE2_OFS);
 
 	hpriv->signal[idx].amps = tmp & 0x700;	/* bits 10:8 */
 	hpriv->signal[idx].pre = tmp & 0xe0;	/* bits 7:5 */
