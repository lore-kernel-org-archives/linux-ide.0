From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v3 06/10] phy: phy_brcmstb_sata: add data for phy version
Date: Fri, 30 Oct 2015 22:38:55 +0900
Message-ID: <1446212339-1210-7-git-send-email-jaedon.shin@gmail.com>
References: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34074 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758784AbbJ3Njs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 09:39:48 -0400
In-Reply-To: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

Add data of device for phy version. and 28nm version is default.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/phy/phy-brcmstb-sata.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
index 0be55dafe9ea..5de394f589c8 100644
--- a/drivers/phy/phy-brcmstb-sata.c
+++ b/drivers/phy/phy-brcmstb-sata.c
@@ -30,7 +30,11 @@
 #define MAX_PORTS					2
 
 /* Register offset between PHYs in PCB space */
-#define SATA_MDIO_REG_SPACE_SIZE			0x1000
+#define SATA_MDIO_REG_28NM_SPACE_SIZE			0x1000
+
+enum brcm_sata_phy_version {
+	BRCM_SATA_PHY_28NM,
+};
 
 struct brcm_sata_port {
 	int portnum;
@@ -42,6 +46,7 @@ struct brcm_sata_port {
 struct brcm_sata_phy {
 	struct device *dev;
 	void __iomem *phy_base;
+	enum brcm_sata_phy_version version;
 
 	struct brcm_sata_port phys[MAX_PORTS];
 };
@@ -64,8 +69,12 @@ enum sata_mdio_phy_regs_28nm {
 static inline void __iomem *brcm_sata_phy_base(struct brcm_sata_port *port)
 {
 	struct brcm_sata_phy *priv = port->phy_priv;
+	u32 offset;
 
-	return priv->phy_base + (port->portnum * SATA_MDIO_REG_SPACE_SIZE);
+	if (priv->version == BRCM_SATA_PHY_28NM)
+		offset = SATA_MDIO_REG_28NM_SPACE_SIZE;
+
+	return priv->phy_base + (port->portnum * offset);
 }
 
 static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
@@ -126,7 +135,8 @@ static const struct phy_ops phy_ops_28nm = {
 };
 
 static const struct of_device_id brcm_sata_phy_of_match[] = {
-	{ .compatible	= "brcm,bcm7445-sata-phy" },
+	{ .compatible	= "brcm,bcm7445-sata-phy",
+	  .data = (void *)BRCM_SATA_PHY_28NM },
 	{},
 };
 MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
@@ -135,6 +145,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node, *child;
+	const struct of_device_id *of_id;
 	struct brcm_sata_phy *priv;
 	struct resource *res;
 	struct phy_provider *provider;
@@ -154,6 +165,12 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->phy_base))
 		return PTR_ERR(priv->phy_base);
 
+	of_id = of_match_node(brcm_sata_phy_of_match, dn);
+	if (of_id)
+		priv->version = (enum brcm_sata_phy_version)of_id->data;
+	else
+		priv->version = BRCM_SATA_PHY_28NM;
+
 	for_each_available_child_of_node(dn, child) {
 		unsigned int id;
 		struct brcm_sata_port *port;
-- 
2.6.2

