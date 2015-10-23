From: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/10] ata: ahch_brcmstb: add data for port offset
Date: Fri, 23 Oct 2015 10:44:15 +0900
Message-ID: <1445564663-66824-3-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Add data of device node for port offset.

Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/ata/ahci_brcmstb.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 14b7305d2ba0..8cf6f7d4798f 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -72,6 +72,7 @@
 struct brcm_ahci_priv {
 	struct device *dev;
 	void __iomem *top_ctrl;
+	u32 port_offset;
 	u32 port_mask;
 };
 
@@ -110,7 +111,7 @@ static inline void brcm_sata_writereg(u32 val, void __iomem *addr)
 static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
 {
 	void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
-				(port * SATA_TOP_CTRL_PHY_OFFS);
+				(port * priv->port_offset);
 	void __iomem *p;
 	u32 reg;
 
@@ -139,7 +140,7 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
 static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
 {
 	void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
-				(port * SATA_TOP_CTRL_PHY_OFFS);
+				(port * priv->port_offset);
 	void __iomem *p;
 	u32 reg;
 
@@ -234,6 +235,13 @@ static int brcm_ahci_resume(struct device *dev)
 }
 #endif
 
+static const struct of_device_id ahci_of_match[] = {
+	{.compatible = "brcm,bcm7445-ahci",
+			.data = (void *)SATA_TOP_CTRL_PHY_OFFS},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ahci_of_match);
+
 static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT(DRV_NAME),
 };
@@ -241,6 +249,7 @@ static struct scsi_host_template ahci_platform_sht = {
 static int brcm_ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id = NULL;
 	struct brcm_ahci_priv *priv;
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
@@ -256,6 +265,12 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
+	of_id = of_match_node(ahci_of_match, dev->of_node);
+	if (!of_id)
+		return -EINVAL;
+
+	priv->port_offset = (u32)of_id->data;
+
 	brcm_sata_init(priv);
 
 	priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
@@ -299,12 +314,6 @@ static int brcm_ahci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ahci_of_match[] = {
-	{.compatible = "brcm,bcm7445-ahci"},
-	{},
-};
-MODULE_DEVICE_TABLE(of, ahci_of_match);
-
 static SIMPLE_DEV_PM_OPS(ahci_brcm_pm_ops, brcm_ahci_suspend, brcm_ahci_resume);
 
 static struct platform_driver brcm_ahci_driver = {
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
