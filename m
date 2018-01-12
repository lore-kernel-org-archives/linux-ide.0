From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 2/2] ata: ahci_brcm: Recover from failures to identify devices
Date: Thu, 11 Jan 2018 17:31:08 -0800
Message-ID: <1515720668-4860-3-git-send-email-f.fainelli@gmail.com>
References: <1515720668-4860-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515720668-4860-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcm-kernel-feedback-list@broadcom.com
Cc: Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Srinath Mannam <srinath.mannam@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Dan Carpenter <dan.carpenter@oracle.com>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

When powering up, the SATA controller may fail to mount the HDD. The SATA
controller will lock up, preventing it from negotiating to a lower speed or
transmitting data. Root cause is power supply noise creating resonance at 6 Ghz
and 3 GHz frequencies, which causes instability in the Clock-Data Recovery
(CDR) frontend module, resulting in false acquisition of the clock at SATA
6G/3G speeds.

The SATA controller may fail to mount the HDD and lock up, requiring a power
cycle. Broadcom chips suspected of being susceptible to this issue include
BCM7445, BCM7439, and BCM7366.

The Kernel implements an error recovery mechanism that resets the SATA PHY and
digital controller when the controller locks up. During this error recovery
process, typically there is less activity on the board and Broadcom STB chip,
so that the power supply is less noisy, thus allowing the SATA controller to
lock correctly.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 95 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index ad3b8826ec79..ea430819c80b 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -96,14 +96,6 @@ struct brcm_ahci_priv {
 	enum brcm_ahci_version version;
 };
 
-static const struct ata_port_info ahci_brcm_port_info = {
-	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
-	.link_flags	= ATA_LFLAG_NO_DB_DELAY,
-	.pio_mask	= ATA_PIO4,
-	.udma_mask	= ATA_UDMA6,
-	.port_ops	= &ahci_platform_ops,
-};
-
 static inline u32 brcm_sata_readreg(void __iomem *addr)
 {
 	/*
@@ -269,6 +261,93 @@ static void brcm_sata_init(struct brcm_ahci_priv *priv)
 	brcm_sata_writereg(data, ctrl);
 }
 
+static unsigned int brcm_ahci_read_id(struct ata_device *dev,
+				      struct ata_taskfile *tf, u16 *id)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct ata_host *host = ap->host;
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct brcm_ahci_priv *priv = hpriv->plat_data;
+	void __iomem *mmio = hpriv->mmio;
+	unsigned int err_mask;
+	unsigned long flags;
+	int i, rc;
+	u32 ctl;
+
+	/* Try to read the device ID and, if this fails, proceed with the
+	 * recovery sequence below
+	 */
+	err_mask = ata_do_dev_read_id(dev, tf, id);
+	if (likely(!err_mask))
+		return err_mask;
+
+	/* Disable host interrupts */
+	spin_lock_irqsave(&host->lock, flags);
+	ctl = readl(mmio + HOST_CTL);
+	ctl &= ~HOST_IRQ_EN;
+	writel(ctl, mmio + HOST_CTL);
+	readl(mmio + HOST_CTL); /* flush */
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	/* Perform the SATA PHY reset sequence */
+	brcm_sata_phy_disable(priv, ap->port_no);
+
+	/* Bring the PHY back on */
+	brcm_sata_phy_enable(priv, ap->port_no);
+
+	/* Re-initialize and calibrate the PHY */
+	for (i = 0; i < hpriv->nports; i++) {
+		rc = phy_init(hpriv->phys[i]);
+		if (rc)
+			goto disable_phys;
+
+		rc = phy_calibrate(hpriv->phys[i]);
+		if (rc) {
+			phy_exit(hpriv->phys[i]);
+			goto disable_phys;
+		}
+	}
+
+	/* Re-enable host interrupts */
+	spin_lock_irqsave(&host->lock, flags);
+	ctl = readl(mmio + HOST_CTL);
+	ctl |= HOST_IRQ_EN;
+	writel(ctl, mmio + HOST_CTL);
+	readl(mmio + HOST_CTL); /* flush */
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return ata_do_dev_read_id(dev, tf, id);
+
+disable_phys:
+	while (--i >= 0) {
+		phy_power_off(hpriv->phys[i]);
+		phy_exit(hpriv->phys[i]);
+	}
+
+	return AC_ERR_OTHER;
+}
+
+static void brcm_ahci_host_stop(struct ata_host *host)
+{
+	struct ahci_host_priv *hpriv = host->private_data;
+
+	ahci_platform_disable_resources(hpriv);
+}
+
+static struct ata_port_operations ahci_brcm_platform_ops = {
+	.inherits	= &ahci_ops,
+	.host_stop	= brcm_ahci_host_stop,
+	.read_id	= brcm_ahci_read_id,
+};
+
+static const struct ata_port_info ahci_brcm_port_info = {
+	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
+	.link_flags	= ATA_LFLAG_NO_DB_DELAY,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &ahci_brcm_platform_ops,
+};
+
 #ifdef CONFIG_PM_SLEEP
 static int brcm_ahci_suspend(struct device *dev)
 {
-- 
2.7.4
