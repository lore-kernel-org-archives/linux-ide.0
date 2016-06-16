From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: [PATCH 6/7] phy: Add SATA3 PHY support for Broadcom NSP SoC
Date: Thu, 16 Jun 2016 09:53:34 -0400
Message-ID: <1466085215-10246-7-git-send-email-yendapally.reddy@broadcom.com>
References: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35388 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925AbcFPNyR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jun 2016 09:54:17 -0400
Received: by mail-pf0-f178.google.com with SMTP id c2so20378280pfa.2
        for <linux-ide@vger.kernel.org>; Thu, 16 Jun 2016 06:54:16 -0700 (PDT)
In-Reply-To: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Jaedon Shin <jaedon.shin@gmail.com>, Anup Patel <anup.patel@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-ide@vger.kernel.org, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

This patch adds support for Broadcom NSP SATA3 PHY in existing
Broadcom SATA PHY driver.

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 drivers/phy/phy-brcm-sata.c | 81 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/phy/phy-brcm-sata.c b/drivers/phy/phy-brcm-sata.c
index 6c4c5cb..18d6626 100644
--- a/drivers/phy/phy-brcm-sata.c
+++ b/drivers/phy/phy-brcm-sata.c
@@ -45,6 +45,7 @@ enum brcm_sata_phy_version {
 	BRCM_SATA_PHY_STB_28NM,
 	BRCM_SATA_PHY_STB_40NM,
 	BRCM_SATA_PHY_IPROC_NS2,
+	BRCM_SATA_PHY_IPROC_NSP,
 };
 
 struct brcm_sata_port {
@@ -73,6 +74,13 @@ enum sata_phy_regs {
 
 	PLL_REG_BANK_0				= 0x050,
 	PLL_REG_BANK_0_PLLCONTROL_0		= 0x81,
+	PLLCONTROL_0_FREQ_DET_RESTART		= BIT(13),
+	PLLCONTROL_0_FREQ_MONITOR		= BIT(12),
+	PLLCONTROL_0_SEQ_START			= BIT(15),
+	PLL_CAP_CONTROL				= 0x85,
+	PLL_ACTRL2				= 0x8b,
+	PLL_ACTRL2_SELDIV_MASK			= 0x1f,
+	PLL_ACTRL2_SELDIV_SHIFT			= 9,
 
 	PLL1_REG_BANK				= 0x060,
 	PLL1_ACTRL2				= 0x82,
@@ -80,6 +88,7 @@ enum sata_phy_regs {
 	PLL1_ACTRL4				= 0x84,
 
 	OOB_REG_BANK				= 0x150,
+	OOB1_REG_BANK				= 0x160,
 	OOB_CTRL1				= 0x80,
 	OOB_CTRL1_BURST_MAX_MASK		= 0xf,
 	OOB_CTRL1_BURST_MAX_SHIFT		= 12,
@@ -271,6 +280,73 @@ static int brcm_ns2_sata_init(struct brcm_sata_port *port)
 	return 0;
 }
 
+static int brcm_nsp_sata_init(struct brcm_sata_port *port)
+{
+	struct brcm_sata_phy *priv = port->phy_priv;
+	struct device *dev = port->phy_priv->dev;
+	void __iomem *base = priv->phy_base;
+	unsigned int oob_bank;
+	unsigned int val, try;
+
+	/* Configure OOB control */
+	if (port->portnum == 0)
+		oob_bank = OOB_REG_BANK;
+	else if (port->portnum == 1)
+		oob_bank = OOB1_REG_BANK;
+	else
+		return -EINVAL;
+
+	val = 0x0;
+	val |= (0x0f << OOB_CTRL1_BURST_MAX_SHIFT);
+	val |= (0x06 << OOB_CTRL1_BURST_MIN_SHIFT);
+	val |= (0x0f << OOB_CTRL1_WAKE_IDLE_MAX_SHIFT);
+	val |= (0x06 << OOB_CTRL1_WAKE_IDLE_MIN_SHIFT);
+	brcm_sata_phy_wr(base, oob_bank, OOB_CTRL1, 0x0, val);
+
+	val = 0x0;
+	val |= (0x2e << OOB_CTRL2_RESET_IDLE_MAX_SHIFT);
+	val |= (0x02 << OOB_CTRL2_BURST_CNT_SHIFT);
+	val |= (0x16 << OOB_CTRL2_RESET_IDLE_MIN_SHIFT);
+	brcm_sata_phy_wr(base, oob_bank, OOB_CTRL2, 0x0, val);
+
+
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_ACTRL2,
+		~(PLL_ACTRL2_SELDIV_MASK << PLL_ACTRL2_SELDIV_SHIFT),
+		0x0c << PLL_ACTRL2_SELDIV_SHIFT);
+
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_CAP_CONTROL,
+						0xff0, 0x4f0);
+
+	val = PLLCONTROL_0_FREQ_DET_RESTART | PLLCONTROL_0_FREQ_MONITOR;
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
+								~val, val);
+	val = PLLCONTROL_0_SEQ_START;
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
+								~val, 0);
+	mdelay(10);
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
+								~val, val);
+
+	/* Wait for pll_seq_done bit */
+	try = 50;
+	while (try--) {
+		val = brcm_sata_phy_rd(base, BLOCK0_REG_BANK,
+					BLOCK0_XGXSSTATUS);
+		if (val & BLOCK0_XGXSSTATUS_PLL_LOCK)
+			break;
+		msleep(20);
+	}
+	if (!try) {
+		/* PLL did not lock; give up */
+		dev_err(dev, "port%d PLL did not lock\n", port->portnum);
+		return -ETIMEDOUT;
+	}
+
+	dev_dbg(dev, "port%d initialized\n", port->portnum);
+
+	return 0;
+}
+
 static int brcm_sata_phy_init(struct phy *phy)
 {
 	int rc;
@@ -284,6 +360,9 @@ static int brcm_sata_phy_init(struct phy *phy)
 	case BRCM_SATA_PHY_IPROC_NS2:
 		rc = brcm_ns2_sata_init(port);
 		break;
+	case BRCM_SATA_PHY_IPROC_NSP:
+		rc = brcm_nsp_sata_init(port);
+		break;
 	default:
 		rc = -ENODEV;
 	};
@@ -303,6 +382,8 @@ static const struct of_device_id brcm_sata_phy_of_match[] = {
 	  .data = (void *)BRCM_SATA_PHY_STB_40NM },
 	{ .compatible	= "brcm,iproc-ns2-sata-phy",
 	  .data = (void *)BRCM_SATA_PHY_IPROC_NS2 },
+	{ .compatible = "brcm,iproc-nsp-sata-phy",
+	  .data = (void *)BRCM_SATA_PHY_IPROC_NSP },
 	{},
 };
 MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
-- 
2.1.0

