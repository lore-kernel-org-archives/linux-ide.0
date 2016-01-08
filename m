From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/4] ata: ahci_brcmstb: enable support for ALPM
Date: Thu,  7 Jan 2016 16:03:30 -0800
Message-ID: <1452211413-1350-2-git-send-email-f.fainelli@gmail.com>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-ide@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, Danesh Petigara <dpetigara@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, gregory.0xf0@gmail.com, computersforpeace@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

From: Danesh Petigara <dpetigara@broadcom.com>

Enable support for ALPM in the host controller's capabilities
register. Also adjust the PLL  timeout to give it enough time
to lock when the port exits slumber mode.

Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index a4a0940307bc..f38a07ea59f4 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -53,6 +53,10 @@
  #define SATA_TOP_CTRL_PHY_OFFS				0x8
  #define SATA_TOP_MAX_PHYS				2
 
+#define SATA_FIRST_PORT_CTRL				0x700
+#define SATA_NEXT_PORT_CTRL_OFFSET			0x80
+#define SATA_PORT_PCTRL6(reg_base)			(reg_base + 0x18)
+
 /* On big-endian MIPS, buses are reversed to big endian, so switch them back */
 #if defined(CONFIG_MIPS) && defined(__BIG_ENDIAN)
 #define DATA_ENDIAN			 2 /* AHCI->DDR inbound accesses */
@@ -111,6 +115,35 @@ static inline void brcm_sata_writereg(u32 val, void __iomem *addr)
 		writel_relaxed(val, addr);
 }
 
+static void brcm_sata_alpm_init(struct ahci_host_priv *hpriv)
+{
+	int i;
+	u32 bus_ctrl, port_ctrl, host_caps;
+	struct brcm_ahci_priv *priv = hpriv->plat_data;
+
+	/*Enable support for ALPM */
+	bus_ctrl = brcm_sata_readreg(priv->top_ctrl
+			+ SATA_TOP_CTRL_BUS_CTRL);
+	brcm_sata_writereg(bus_ctrl | OVERRIDE_HWINIT,
+		priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
+	host_caps = readl(hpriv->mmio + HOST_CAP);
+	writel(host_caps | HOST_CAP_ALPM, hpriv->mmio);
+	brcm_sata_writereg(bus_ctrl,
+		priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
+
+	/*
+	 * Adjust timeout to allow PLL sufficient time to lock while waking
+	 * up from slumber mode.
+	 */
+	for (i = 0, port_ctrl = SATA_FIRST_PORT_CTRL;
+	     i < SATA_TOP_MAX_PHYS;
+	     i++, port_ctrl += SATA_NEXT_PORT_CTRL_OFFSET) {
+		if (priv->port_mask & BIT(i))
+			writel(0xff1003fc,
+			       hpriv->mmio + SATA_PORT_PCTRL6(port_ctrl));
+	}
+}
+
 static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
 {
 	void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
@@ -240,6 +273,7 @@ static int brcm_ahci_resume(struct device *dev)
 
 	brcm_sata_init(priv);
 	brcm_sata_phys_enable(priv);
+	brcm_sata_alpm_init(hpriv);
 	return ahci_platform_resume(dev);
 }
 #endif
@@ -284,6 +318,8 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		return PTR_ERR(hpriv);
 	hpriv->plat_data = priv;
 
+	brcm_sata_alpm_init(hpriv);
+
 	ret = ahci_platform_enable_resources(hpriv);
 	if (ret)
 		return ret;
-- 
2.1.0
