From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/9] phy: brcm-sata: Add BCM63138 (DSL) PHY init sequence
Date: Thu, 20 Sep 2018 12:16:38 -0700
Message-ID: <20180920191646.18198-5-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>, Al Cooper <alcooperx@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

The BCM63138 SATA PHY requires a special initialization sequence in
order to operate correctly, mostly tuning incorrect default values.
Implement that sequence and match the documented compatible string as an
entry point into that sequence.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-sata.c | 70 ++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index 8708ea3b4d6d..218735305d85 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -47,6 +47,7 @@ enum brcm_sata_phy_version {
 	BRCM_SATA_PHY_IPROC_NS2,
 	BRCM_SATA_PHY_IPROC_NSP,
 	BRCM_SATA_PHY_IPROC_SR,
+	BRCM_SATA_PHY_DSL_28NM,
 };
 
 enum brcm_sata_phy_rxaeq_mode {
@@ -96,7 +97,10 @@ enum sata_phy_regs {
 	PLLCONTROL_0_FREQ_DET_RESTART		= BIT(13),
 	PLLCONTROL_0_FREQ_MONITOR		= BIT(12),
 	PLLCONTROL_0_SEQ_START			= BIT(15),
+	PLL_CAP_CHARGE_TIME			= 0x83,
+	PLL_VCO_CAL_THRESH			= 0x84,
 	PLL_CAP_CONTROL				= 0x85,
+	PLL_FREQ_DET_TIME			= 0x86,
 	PLL_ACTRL2				= 0x8b,
 	PLL_ACTRL2_SELDIV_MASK			= 0x1f,
 	PLL_ACTRL2_SELDIV_SHIFT			= 9,
@@ -106,6 +110,9 @@ enum sata_phy_regs {
 	PLL1_ACTRL2				= 0x82,
 	PLL1_ACTRL3				= 0x83,
 	PLL1_ACTRL4				= 0x84,
+	PLL1_ACTRL5				= 0x85,
+	PLL1_ACTRL6				= 0x86,
+	PLL1_ACTRL7				= 0x87,
 
 	TX_REG_BANK				= 0x070,
 	TX_ACTRL0				= 0x80,
@@ -119,6 +126,8 @@ enum sata_phy_regs {
 	AEQ_FRC_EQ_FORCE			= BIT(0),
 	AEQ_FRC_EQ_FORCE_VAL			= BIT(1),
 	AEQRX_REG_BANK_1			= 0xe0,
+	AEQRX_SLCAL0_CTRL0			= 0x82,
+	AEQRX_SLCAL1_CTRL0			= 0x86,
 
 	OOB_REG_BANK				= 0x150,
 	OOB1_REG_BANK				= 0x160,
@@ -168,6 +177,7 @@ static inline void __iomem *brcm_sata_pcb_base(struct brcm_sata_port *port)
 	switch (priv->version) {
 	case BRCM_SATA_PHY_STB_28NM:
 	case BRCM_SATA_PHY_IPROC_NS2:
+	case BRCM_SATA_PHY_DSL_28NM:
 		size = SATA_PCB_REG_28NM_SPACE_SIZE;
 		break;
 	case BRCM_SATA_PHY_STB_40NM:
@@ -482,6 +492,61 @@ static int brcm_sr_sata_init(struct brcm_sata_port *port)
 	return 0;
 }
 
+static int brcm_dsl_sata_init(struct brcm_sata_port *port)
+{
+	void __iomem *base = brcm_sata_pcb_base(port);
+	struct device *dev = port->phy_priv->dev;
+	unsigned int try;
+	u32 tmp;
+
+	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL7, 0, 0x873);
+
+	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL6, 0, 0xc000);
+
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
+			 0, 0x3089);
+	usleep_range(1000, 2000);
+
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
+			 0, 0x3088);
+	usleep_range(1000, 2000);
+
+	brcm_sata_phy_wr(base, AEQRX_REG_BANK_1, AEQRX_SLCAL0_CTRL0,
+			 0, 0x3000);
+
+	brcm_sata_phy_wr(base, AEQRX_REG_BANK_1, AEQRX_SLCAL1_CTRL0,
+			 0, 0x3000);
+	usleep_range(1000, 2000);
+
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_CAP_CHARGE_TIME, 0, 0x32);
+
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_VCO_CAL_THRESH, 0, 0xa);
+
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_FREQ_DET_TIME, 0, 0x64);
+	usleep_range(1000, 2000);
+
+	/* Acquire PLL lock */
+	try = 50;
+	while (try) {
+		tmp = brcm_sata_phy_rd(base, BLOCK0_REG_BANK,
+				       BLOCK0_XGXSSTATUS);
+		if (tmp & BLOCK0_XGXSSTATUS_PLL_LOCK)
+			break;
+		msleep(20);
+		try--;
+	};
+
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
@@ -501,6 +566,9 @@ static int brcm_sata_phy_init(struct phy *phy)
 	case BRCM_SATA_PHY_IPROC_SR:
 		rc = brcm_sr_sata_init(port);
 		break;
+	case BRCM_SATA_PHY_DSL_28NM:
+		rc = brcm_dsl_sata_init(port);
+		break;
 	default:
 		rc = -ENODEV;
 	}
@@ -552,6 +620,8 @@ static const struct of_device_id brcm_sata_phy_of_match[] = {
 	  .data = (void *)BRCM_SATA_PHY_IPROC_NSP },
 	{ .compatible	= "brcm,iproc-sr-sata-phy",
 	  .data = (void *)BRCM_SATA_PHY_IPROC_SR },
+	{ .compatible	= "brcm,bcm63138-sata-phy",
+	  .data = (void *)BRCM_SATA_PHY_DSL_28NM },
 	{},
 };
 MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
-- 
2.17.1
