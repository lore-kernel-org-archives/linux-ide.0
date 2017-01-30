From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v7 04/14] sata: ahci-da850: get the sata clock using a connection id
Date: Mon, 30 Jan 2017 11:02:01 +0100
Message-ID: <1485770531-6772-5-git-send-email-bgolaszewski@baylibre.com>
References: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485770531-6772-1-git-send-email-bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

In preparation for using two clocks in the driver (the sysclk2-based
clock and the external REFCLK), check if we got the functional clock
after calling ahci_platform_get_resources(). If not, retry calling
clk_get() with con_id specified.

Signed-off-by: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Acked-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/ata/ahci_da850.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 267a3d3..e397bab 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -71,12 +71,28 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
 	void __iomem *pwrdn_reg;
+	struct clk *clk;
 	int rc;
 
 	hpriv = ahci_platform_get_resources(pdev);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
+	/*
+	 * Internally ahci_platform_get_resources() calls clk_get(dev, NULL)
+	 * when trying to obtain the functional clock. This SATA controller
+	 * uses two clocks for which we specify two connection ids. If we don't
+	 * have the functional clock at this point - call clk_get() again with
+	 * con_id = "fck".
+	 */
+	if (!hpriv->clks[0]) {
+		clk = clk_get(dev, "fck");
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		hpriv->clks[0] = clk;
+	}
+
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
