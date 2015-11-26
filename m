From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v6 7/7] phy: phy_brcmstb_sata: add support for MIPS-based platforms
Date: Thu, 26 Nov 2015 11:56:35 +0900
Message-ID: <1448506595-4981-8-git-send-email-jaedon.shin@gmail.com>
References: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33075 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbbKZC5J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2015 21:57:09 -0500
Received: by pabfh17 with SMTP id fh17so77915597pab.0
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2015 18:57:09 -0800 (PST)
In-Reply-To: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-ide@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>

The BCM7xxx ARM-based and MIPS-based platforms share a similar hardware
block for AHCI SATA3.

This new compatible string, "brcm,bcm7425-sata-phy", may be used for
most MIPS-based platforms of 40nm process technology.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
 .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
 drivers/phy/Kconfig                                |  4 ++--
 drivers/phy/phy-brcmstb-sata.c                     | 24 ++++++++++++++++------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt b/Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt
index 7f81ef90146a..d87ab7c127b8 100644
--- a/Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt
+++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible: should be one or more of
+     "brcm,bcm7425-sata-phy"
      "brcm,bcm7445-sata-phy"
      "brcm,phy-sata3"
 - address-cells: should be 1
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 7eb5859dd035..c6f4798ed3af 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -373,11 +373,11 @@ config PHY_TUSB1210
 
 config PHY_BRCMSTB_SATA
 	tristate "Broadcom STB SATA PHY driver"
-	depends on ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
 	depends on OF
 	select GENERIC_PHY
 	help
-	  Enable this to support the SATA3 PHY on 28nm Broadcom STB SoCs.
+	  Enable this to support the SATA3 PHY on 28nm or 40nm Broadcom STB SoCs.
 	  Likely useful only with CONFIG_SATA_BRCMSTB enabled.
 
 config PHY_CYGNUS_PCIE
diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
index 5de394f589c8..35809dc2bb99 100644
--- a/drivers/phy/phy-brcmstb-sata.c
+++ b/drivers/phy/phy-brcmstb-sata.c
@@ -32,8 +32,14 @@
 /* Register offset between PHYs in PCB space */
 #define SATA_MDIO_REG_28NM_SPACE_SIZE			0x1000
 
+/* The older SATA PHY registers duplicated per port registers within the map,
+ * rather than having a separate map per port.
+ */
+#define SATA_MDIO_REG_40NM_SPACE_SIZE			0x10
+
 enum brcm_sata_phy_version {
 	BRCM_SATA_PHY_28NM,
+	BRCM_SATA_PHY_40NM,
 };
 
 struct brcm_sata_port {
@@ -51,7 +57,7 @@ struct brcm_sata_phy {
 	struct brcm_sata_port phys[MAX_PORTS];
 };
 
-enum sata_mdio_phy_regs_28nm {
+enum sata_mdio_phy_regs {
 	PLL_REG_BANK_0				= 0x50,
 	PLL_REG_BANK_0_PLLCONTROL_0		= 0x81,
 
@@ -69,10 +75,14 @@ enum sata_mdio_phy_regs_28nm {
 static inline void __iomem *brcm_sata_phy_base(struct brcm_sata_port *port)
 {
 	struct brcm_sata_phy *priv = port->phy_priv;
-	u32 offset;
+	u32 offset = 0;
 
 	if (priv->version == BRCM_SATA_PHY_28NM)
 		offset = SATA_MDIO_REG_28NM_SPACE_SIZE;
+	else if (priv->version == BRCM_SATA_PHY_40NM)
+		offset = SATA_MDIO_REG_40NM_SPACE_SIZE;
+	else
+		dev_err(priv->dev, "invalid phy version\n");
 
 	return priv->phy_base + (port->portnum * offset);
 }
@@ -93,7 +103,7 @@ static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
 #define FMAX_VAL_DEFAULT	0x3df
 #define FMAX_VAL_SSC		0x83
 
-static void brcm_sata_cfg_ssc_28nm(struct brcm_sata_port *port)
+static void brcm_sata_cfg_ssc(struct brcm_sata_port *port)
 {
 	void __iomem *base = brcm_sata_phy_base(port);
 	struct brcm_sata_phy *priv = port->phy_priv;
@@ -124,12 +134,12 @@ static int brcm_sata_phy_init(struct phy *phy)
 {
 	struct brcm_sata_port *port = phy_get_drvdata(phy);
 
-	brcm_sata_cfg_ssc_28nm(port);
+	brcm_sata_cfg_ssc(port);
 
 	return 0;
 }
 
-static const struct phy_ops phy_ops_28nm = {
+static const struct phy_ops phy_ops = {
 	.init		= brcm_sata_phy_init,
 	.owner		= THIS_MODULE,
 };
@@ -137,6 +147,8 @@ static const struct phy_ops phy_ops_28nm = {
 static const struct of_device_id brcm_sata_phy_of_match[] = {
 	{ .compatible	= "brcm,bcm7445-sata-phy",
 	  .data = (void *)BRCM_SATA_PHY_28NM },
+	{ .compatible	= "brcm,bcm7425-sata-phy",
+	  .data = (void *)BRCM_SATA_PHY_40NM },
 	{},
 };
 MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
@@ -193,7 +205,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 		port = &priv->phys[id];
 		port->portnum = id;
 		port->phy_priv = priv;
-		port->phy = devm_phy_create(dev, child, &phy_ops_28nm);
+		port->phy = devm_phy_create(dev, child, &phy_ops);
 		port->ssc_en = of_property_read_bool(child, "brcm,enable-ssc");
 		if (IS_ERR(port->phy)) {
 			dev_err(dev, "failed to create PHY\n");
-- 
2.6.3

