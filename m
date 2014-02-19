From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 04/18] ahci-platform: Add support for devices
 with more then 1 clock
Date: Wed, 19 Feb 2014 13:01:46 +0100
Message-ID: <1392811320-3132-5-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBV52SKMAKGQEVDTMAFI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

The allwinner-sun4i AHCI controller needs 2 clocks to be enabled and the
imx AHCI controller needs 3 clocks to be enabled.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
 drivers/ata/ahci_platform.c                        | 97 +++++++++++++++-------
 include/linux/ahci.h                               |  4 +-
 include/linux/ahci_platform.h                      |  3 +
 4 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 89de156..3ced07d 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -10,6 +10,7 @@ Required properties:
 
 Optional properties:
 - dma-coherent      : Present if dma operations are coherent
+- clocks            : a list of phandle + clock specifier pairs
 
 Example:
         sata@ffe08000 {
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 434ab89..aaa0c08 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -87,6 +87,44 @@ static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT("ahci_platform"),
 };
 
+
+int ahci_platform_enable_clks(struct ahci_host_priv *hpriv)
+{
+	int c, rc;
+
+	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++) {
+		rc = clk_prepare_enable(hpriv->clks[c]);
+		if (rc)
+			goto disable_unprepare_clk;
+	}
+	return 0;
+
+disable_unprepare_clk:
+	while (--c >= 0)
+		clk_disable_unprepare(hpriv->clks[c]);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ahci_platform_enable_clks);
+
+void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
+{
+	int c;
+
+	for (c = AHCI_MAX_CLKS - 1; c >= 0; c--)
+		if (hpriv->clks[c])
+			clk_disable_unprepare(hpriv->clks[c]);
+}
+EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
+
+
+static void ahci_put_clks(struct ahci_host_priv *hpriv)
+{
+	int c;
+
+	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
+		clk_put(hpriv->clks[c]);
+}
+
 static int ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -97,10 +135,8 @@ static int ahci_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	struct ata_host *host;
 	struct resource *mem;
-	int irq;
-	int n_ports;
-	int i;
-	int rc;
+	struct clk *clk;
+	int i, irq, max_clk, n_ports, rc;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -131,17 +167,26 @@ static int ahci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	hpriv->clk = clk_get(dev, NULL);
-	if (IS_ERR(hpriv->clk)) {
-		dev_err(dev, "can't get clock\n");
-	} else {
-		rc = clk_prepare_enable(hpriv->clk);
-		if (rc) {
-			dev_err(dev, "clock prepare enable failed");
-			goto free_clk;
+	max_clk = dev->of_node ? AHCI_MAX_CLKS : 1;
+	for (i = 0; i < max_clk; i++) {
+		if (i == 0)
+			clk = clk_get(dev, NULL); /* For old platform init */
+		else
+			clk = of_clk_get(dev->of_node, i);
+
+		if (IS_ERR(clk)) {
+			rc = PTR_ERR(clk);
+			if (rc == -EPROBE_DEFER)
+				goto free_clk;
+			break;
 		}
+		hpriv->clks[i] = clk;
 	}
 
+	rc = ahci_enable_clks(dev, hpriv);
+	if (rc)
+		goto free_clk;
+
 	/*
 	 * Some platforms might need to prepare for mmio region access,
 	 * which could be done in the following init call. So, the mmio
@@ -222,11 +267,9 @@ pdata_exit:
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
 disable_unprepare_clk:
-	if (!IS_ERR(hpriv->clk))
-		clk_disable_unprepare(hpriv->clk);
+	ahci_disable_clks(hpriv);
 free_clk:
-	if (!IS_ERR(hpriv->clk))
-		clk_put(hpriv->clk);
+	ahci_put_clks(hpriv);
 	return rc;
 }
 
@@ -239,10 +282,8 @@ static void ahci_host_stop(struct ata_host *host)
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
 
-	if (!IS_ERR(hpriv->clk)) {
-		clk_disable_unprepare(hpriv->clk);
-		clk_put(hpriv->clk);
-	}
+	ahci_disable_clks(hpriv);
+	ahci_put_clks(hpriv);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -277,8 +318,7 @@ static int ahci_suspend(struct device *dev)
 	if (pdata && pdata->suspend)
 		return pdata->suspend(dev);
 
-	if (!IS_ERR(hpriv->clk))
-		clk_disable_unprepare(hpriv->clk);
+	ahci_disable_clks(hpriv);
 
 	return 0;
 }
@@ -290,13 +330,9 @@ static int ahci_resume(struct device *dev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	int rc;
 
-	if (!IS_ERR(hpriv->clk)) {
-		rc = clk_prepare_enable(hpriv->clk);
-		if (rc) {
-			dev_err(dev, "clock prepare enable failed");
-			return rc;
-		}
-	}
+	rc = ahci_enable_clks(dev, hpriv);
+	if (rc)
+		return rc;
 
 	if (pdata && pdata->resume) {
 		rc = pdata->resume(dev);
@@ -317,8 +353,7 @@ static int ahci_resume(struct device *dev)
 	return 0;
 
 disable_unprepare_clk:
-	if (!IS_ERR(hpriv->clk))
-		clk_disable_unprepare(hpriv->clk);
+	ahci_disable_clks(hpriv);
 
 	return rc;
 }
diff --git a/include/linux/ahci.h b/include/linux/ahci.h
index 3499d44..19970b0 100644
--- a/include/linux/ahci.h
+++ b/include/linux/ahci.h
@@ -23,6 +23,8 @@
 
 #include <linux/clk.h>
 
+#define AHCI_MAX_CLKS		3
+
 struct ata_port;
 
 struct ahci_host_priv {
@@ -37,7 +39,7 @@ struct ahci_host_priv {
 	u32			em_loc; /* enclosure management location */
 	u32			em_buf_sz;	/* EM buffer size in byte */
 	u32			em_msg_type;	/* EM message type */
-	struct clk		*clk;		/* Optional */
+	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	void			*plat_data;	/* Other platform data */
 	/* Optional ahci_start_engine override */
 	void			(*start_engine)(struct ata_port *ap);
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 737fe38..0071d0b 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -31,4 +31,7 @@ struct ahci_platform_data {
 	unsigned int mask_port_map;
 };
 
+int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
+void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
+
 #endif /* _AHCI_PLATFORM_H */
-- 
1.8.5.3
