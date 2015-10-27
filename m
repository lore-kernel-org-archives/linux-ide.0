From: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [v2 01/10] ata: ahci_brcmstb: add quick for broken ncq
Date: Tue, 27 Oct 2015 15:48:02 +0900
Message-ID: <1445928491-7320-2-git-send-email-jaedon.shin@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445928491-7320-1-git-send-email-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dragan Stancevic <dragan.stancevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Add quick for bronken ncq. The chipsets (eg. BCM7439A0, BCM7445A0 and
BCM7445B0) need a workaround disabling NCQ. and it may need the
MIPS-based set-top box platforms.

Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  3 ++
 drivers/ata/ahci_brcmstb.c                         | 42 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
index 20ac9bbfa1fd..4650c0aff6b3 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
@@ -10,6 +10,9 @@ Required properties:
 - reg-names          : "ahci" and "top-ctrl"
 - interrupts         : interrupt mapping for SATA IRQ
 
+Optional properties:
+- brcm,broken-ncq    : if present, NCQ is unusable
+
 Also see ahci-platform.txt.
 
 Example:
diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 14b7305d2ba0..a2df76698adb 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -69,10 +69,15 @@
 	(DATA_ENDIAN << DMADESC_ENDIAN_SHIFT) |		\
 	(MMIO_ENDIAN << MMIO_ENDIAN_SHIFT))
 
+enum brcm_ahci_quicks {
+	BRCM_AHCI_QUICK_NONCQ		= BIT(0),
+};
+
 struct brcm_ahci_priv {
 	struct device *dev;
 	void __iomem *top_ctrl;
 	u32 port_mask;
+	u32 quicks;
 };
 
 static const struct ata_port_info ahci_brcm_port_info = {
@@ -209,6 +214,39 @@ static void brcm_sata_init(struct brcm_ahci_priv *priv)
 			   priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
 }
 
+static void brcm_sata_quick(struct platform_device *pdev,
+			    struct brcm_ahci_priv *priv)
+{
+	void __iomem *ahci;
+	struct resource *res;
+	u32 reg;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci");
+	ahci = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ahci))
+		return;
+
+	if (priv->quicks & BRCM_AHCI_QUICK_NONCQ) {
+		reg  = readl(priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
+		reg |= OVERRIDE_HWINIT;
+		writel(reg, priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
+
+		/* Clear out the NCQ bit so the AHCI driver will not issue
+		 * FPDMA/NCQ commands.
+		 */
+		reg = readl(ahci + HOST_CAP);
+		reg &= ~HOST_CAP_NCQ;
+		writel(reg, ahci + HOST_CAP);
+
+		reg = readl(priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
+		reg &= ~OVERRIDE_HWINIT;
+		writel(reg, priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
+	}
+
+	devm_iounmap(&pdev->dev, ahci);
+	devm_release_mem_region(&pdev->dev, res->start, resource_size(res));
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int brcm_ahci_suspend(struct device *dev)
 {
@@ -256,7 +294,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
+	if (of_property_read_bool(dev->of_node, "brcm,broken-ncq"))
+		priv->quicks |= BRCM_AHCI_QUICK_NONCQ;
+
 	brcm_sata_init(priv);
+	brcm_sata_quick(pdev, priv);
 
 	priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
 	if (!priv->port_mask)
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
