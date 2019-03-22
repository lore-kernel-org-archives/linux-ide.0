From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 05/10] ata: ahci: mvebu: Add a parameter to a platform data
 callback
Date: Fri, 22 Mar 2019 14:39:58 +0100
Message-ID: <20190322134003.4893-6-miquel.raynal@bootlin.com>
References: <20190322134003.4893-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190322134003.4893-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
Cc: devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Before using the ahci_mvebu.c driver with Armada 8k hardware (right
now it is using the ahci_platform.c generic driver), let's add a
'struct device' pointer to the argument list of the
->plat_config() callback. This parameter will be used by the A8k's
callback.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 43bb2db59698..507ee7c5437c 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -29,7 +29,7 @@
 #define AHCI_WINDOW_SIZE(win)	(0x68 + ((win) << 4))
 
 struct ahci_mvebu_plat_data {
-	int (*plat_config)(struct ahci_host_priv *hpriv);
+	int (*plat_config)(struct ahci_host_priv *hpriv, struct device *dev);
 	unsigned int host_flags;
 };
 
@@ -67,7 +67,8 @@ static void ahci_mvebu_regret_option(struct ahci_host_priv *hpriv)
 	writel(0x80, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
 }
 
-static int ahci_mvebu_armada_380_config(struct ahci_host_priv *hpriv)
+static int ahci_mvebu_armada_380_config(struct ahci_host_priv *hpriv,
+					struct device *dev)
 {
 	const struct mbus_dram_target_info *dram;
 	int rc = 0;
@@ -83,7 +84,8 @@ static int ahci_mvebu_armada_380_config(struct ahci_host_priv *hpriv)
 	return rc;
 }
 
-static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
+static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv,
+					 struct device *dev)
 {
 	u32 reg;
 
@@ -162,7 +164,7 @@ static int ahci_mvebu_resume(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	const struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
 
-	pdata->plat_config(hpriv);
+	pdata->plat_config(hpriv, &pdev->dev);
 
 	return ahci_platform_resume_host(&pdev->dev);
 }
@@ -205,7 +207,7 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 
 	hpriv->stop_engine = ahci_mvebu_stop_engine;
 
-	rc = pdata->plat_config(hpriv);
+	rc = pdata->plat_config(hpriv, &pdev->dev);
 	if (rc)
 		goto disable_resources;
 
-- 
2.19.1
