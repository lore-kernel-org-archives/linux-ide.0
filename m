From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 05/18] ahci-platform: Add support for an
 optional regulator for sata-target power
Date: Wed, 19 Feb 2014 13:01:47 +0100
Message-ID: <1392811320-3132-6-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBW52SKMAKGQEWZS5WRQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1392811320-3132-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
 drivers/ata/ahci_platform.c                        | 35 ++++++++++++++++++++--
 include/linux/ahci.h                               |  2 ++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 3ced07d..1ac807f 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -11,6 +11,7 @@ Required properties:
 Optional properties:
 - dma-coherent      : Present if dma operations are coherent
 - clocks            : a list of phandle + clock specifier pairs
+- target-supply     : regulator for SATA target power
 
 Example:
         sata@ffe08000 {
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index aaa0c08..2f319e9 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -167,6 +167,13 @@ static int ahci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	hpriv->target_pwr = devm_regulator_get_optional(dev, "target");
+	if (IS_ERR(hpriv->target_pwr)) {
+		if (PTR_ERR(hpriv->target_pwr) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		hpriv->target_pwr = NULL;
+	}
+
 	max_clk = dev->of_node ? AHCI_MAX_CLKS : 1;
 	for (i = 0; i < max_clk; i++) {
 		if (i == 0)
@@ -183,9 +190,15 @@ static int ahci_probe(struct platform_device *pdev)
 		hpriv->clks[i] = clk;
 	}
 
+	if (hpriv->target_pwr) {
+		rc = regulator_enable(hpriv->target_pwr);
+		if (rc)
+			goto free_clk;
+	}
+
 	rc = ahci_enable_clks(dev, hpriv);
 	if (rc)
-		goto free_clk;
+		goto disable_regulator;
 
 	/*
 	 * Some platforms might need to prepare for mmio region access,
@@ -268,6 +281,9 @@ pdata_exit:
 		pdata->exit(dev);
 disable_unprepare_clk:
 	ahci_disable_clks(hpriv);
+disable_regulator:
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
 free_clk:
 	ahci_put_clks(hpriv);
 	return rc;
@@ -284,6 +300,9 @@ static void ahci_host_stop(struct ata_host *host)
 
 	ahci_disable_clks(hpriv);
 	ahci_put_clks(hpriv);
+
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -320,6 +339,9 @@ static int ahci_suspend(struct device *dev)
 
 	ahci_disable_clks(hpriv);
 
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
+
 	return 0;
 }
 
@@ -330,9 +352,15 @@ static int ahci_resume(struct device *dev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	int rc;
 
+	if (hpriv->target_pwr) {
+		rc = regulator_enable(hpriv->target_pwr);
+		if (rc)
+			return rc;
+	}
+
 	rc = ahci_enable_clks(dev, hpriv);
 	if (rc)
-		return rc;
+		goto disable_regulator;
 
 	if (pdata && pdata->resume) {
 		rc = pdata->resume(dev);
@@ -354,6 +382,9 @@ static int ahci_resume(struct device *dev)
 
 disable_unprepare_clk:
 	ahci_disable_clks(hpriv);
+disable_regulator:
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
 
 	return rc;
 }
diff --git a/include/linux/ahci.h b/include/linux/ahci.h
index 19970b0..ac69cdc 100644
--- a/include/linux/ahci.h
+++ b/include/linux/ahci.h
@@ -22,6 +22,7 @@
 #define __LINUX_AHCI_H__
 
 #include <linux/clk.h>
+#include <linux/regulator/consumer.h>
 
 #define AHCI_MAX_CLKS		3
 
@@ -40,6 +41,7 @@ struct ahci_host_priv {
 	u32			em_buf_sz;	/* EM buffer size in byte */
 	u32			em_msg_type;	/* EM message type */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
+	struct regulator	*target_pwr;	/* Optional */
 	void			*plat_data;	/* Other platform data */
 	/* Optional ahci_start_engine override */
 	void			(*start_engine)(struct ata_port *ap);
-- 
1.8.5.3
