From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v3 03/10] ata: ahci_brcmstb: add quirk for different phy
Date: Fri, 30 Oct 2015 22:38:52 +0900
Message-ID: <1446212339-1210-4-git-send-email-jaedon.shin@gmail.com>
References: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33122 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966055AbbJ3Njh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 09:39:37 -0400
In-Reply-To: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>

Add quirk for phy interface of MIPS-based chipsets. The ARM-based
chipsets have four phy interface control registers and each port has two
registers but the MIPS-based chipsets have three. There are no
information and documentation.

The Broadcom strict-ahci based BSP of legacy version did not control
these registers.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 194aeda8f14d..5098e6c041ac 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -71,6 +71,7 @@
 
 enum brcm_ahci_quirks {
 	BRCM_AHCI_QUIRK_NONCQ		= BIT(0),
+	BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE	= BIT(1),
 };
 
 struct brcm_ahci_priv {
@@ -119,6 +120,9 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
 	void __iomem *p;
 	u32 reg;
 
+	if (priv->quirks & BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE)
+		return;
+
 	/* clear PHY_DEFAULT_POWER_STATE */
 	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
 	reg = brcm_sata_readreg(p);
@@ -148,6 +152,9 @@ static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
 	void __iomem *p;
 	u32 reg;
 
+	if (priv->quirks & BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE)
+		return;
+
 	/* power-off the PHY digital logic */
 	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_2;
 	reg = brcm_sata_readreg(p);
@@ -297,8 +304,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
-	if (of_device_is_compatible(dev->of_node, "brcm,bcm7425-ahci"))
+	if (of_device_is_compatible(dev->of_node, "brcm,bcm7425-ahci")) {
 		priv->quirks |= BRCM_AHCI_QUIRK_NONCQ;
+		priv->quirks |= BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE;
+	}
 
 	brcm_sata_quirks(pdev, priv);
 
-- 
2.6.2

