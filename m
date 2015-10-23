From: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 06/10] phy: phy_brcmstb_sata: add data for phy offset
Date: Fri, 23 Oct 2015 10:44:19 +0900
Message-ID: <1445564663-66824-7-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Add data of device node for phy offset.

Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/phy/phy-brcmstb-sata.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
index 0be55dafe9ea..41c7535d706b 100644
--- a/drivers/phy/phy-brcmstb-sata.c
+++ b/drivers/phy/phy-brcmstb-sata.c
@@ -42,6 +42,7 @@ struct brcm_sata_port {
 struct brcm_sata_phy {
 	struct device *dev;
 	void __iomem *phy_base;
+	u32 phy_offset;
 
 	struct brcm_sata_port phys[MAX_PORTS];
 };
@@ -65,7 +66,7 @@ static inline void __iomem *brcm_sata_phy_base(struct brcm_sata_port *port)
 {
 	struct brcm_sata_phy *priv = port->phy_priv;
 
-	return priv->phy_base + (port->portnum * SATA_MDIO_REG_SPACE_SIZE);
+	return priv->phy_base + (port->portnum * priv->phy_offset);
 }
 
 static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
@@ -126,7 +127,8 @@ static const struct phy_ops phy_ops_28nm = {
 };
 
 static const struct of_device_id brcm_sata_phy_of_match[] = {
-	{ .compatible	= "brcm,bcm7445-sata-phy" },
+	{ .compatible	= "brcm,bcm7445-sata-phy",
+			.data = (void *)SATA_MDIO_REG_SPACE_SIZE },
 	{},
 };
 MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
@@ -135,6 +137,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node, *child;
+	const struct of_device_id *of_id = NULL;
 	struct brcm_sata_phy *priv;
 	struct resource *res;
 	struct phy_provider *provider;
@@ -154,6 +157,12 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->phy_base))
 		return PTR_ERR(priv->phy_base);
 
+	of_id = of_match_node(brcm_sata_phy_of_match, dn);
+	if (!of_id)
+		return -EINVAL;
+
+	priv->phy_offset = (u32)of_id->data;
+
 	for_each_available_child_of_node(dn, child) {
 		unsigned int id;
 		struct brcm_sata_port *port;
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
