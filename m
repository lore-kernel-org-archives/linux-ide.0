From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 07/10] phy: phy_brcmstb_sata: add support MIPS-based platforms
Date: Fri, 30 Oct 2015 23:01:21 +0900
Message-ID: <1446213684-2625-8-git-send-email-jaedon.shin@gmail.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35368 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031325AbbJ3OCA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 10:02:00 -0400
In-Reply-To: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

The BCM7xxx ARM-based and MIPS-based platforms share a similar hardware
block for AHCI SATA3.

The BCM7425 is main chipset of MIPS-based 40nm class. The others have
same PHY of AHCI block. The compatible string may use
brcm,bcm7425-sata-phy.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
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
index 47da573d0bab..c83e48661fd7 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -364,11 +364,11 @@ config PHY_TUSB1210
 
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
 
 endmenu
diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
index 5de394f589c8..c8243581f196 100644
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
+		dev_err(priv->dev, "should not happen\n");
 
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
2.6.2

