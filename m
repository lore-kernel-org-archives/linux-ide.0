From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v3 06/13] ahci-platform: Add support for devices
 with more then 1 clock
Date: Sun, 19 Jan 2014 00:48:48 +0100
Message-ID: <1390088935-7193-7-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB7NF5SLAKGQEIEOKL4Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1390088935-7193-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

The allwinner-sun4i AHCI controller needs 2 clocks to be enabled and the
imx AHCI controller needs 3 clocks to be enabled.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
 drivers/ata/ahci.h                                 |  3 +-
 drivers/ata/ahci_platform.c                        | 95 +++++++++++++++-------
 3 files changed, 67 insertions(+), 32 deletions(-)

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
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 8f60f33..7950b3a 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -52,6 +52,7 @@
 enum {
 	AHCI_MAX_PORTS		= 32,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
+	AHCI_MAX_CLKS		= 3,
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_MAX_CMDS		= 32,
 	AHCI_CMD_SZ		= 32,
@@ -321,7 +322,7 @@ struct ahci_host_priv {
 	u32 			em_loc; /* enclosure management location */
 	u32			em_buf_sz;	/* EM buffer size in byte */
 	u32			em_msg_type;	/* EM message type */
-	struct clk		*clk;		/* Only for platforms supporting clk */
+	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	void			*plat_data;	/* Other platform data */
 	/* Optional ahci_start_engine override */
 	void			(*start_engine)(struct ata_port *ap);
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 33ac7a4..75a3d47 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -87,6 +87,42 @@ static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT("ahci_platform"),
 };
 
+static int ahci_enable_clks(struct device *dev, struct ahci_host_priv *hpriv)
+{
+	int c, rc;
+
+	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++) {
+		rc = clk_prepare_enable(hpriv->clks[c]);
+		if (rc) {
+			dev_err(dev, "clock prepare enable failed");
+			goto disable_unprepare_clk;
+		}
+	}
+	return 0;
+
+disable_unprepare_clk:
+	while (--c >= 0)
+		clk_disable_unprepare(hpriv->clks[c]);
+	return rc;
+}
+
+static void ahci_disable_clks(struct ahci_host_priv *hpriv)
+{
+	int c;
+
+	for (c = AHCI_MAX_CLKS - 1; c >= 0; c--)
+		if (hpriv->clks[c])
+			clk_disable_unprepare(hpriv->clks[c]);
+}
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
@@ -97,10 +133,8 @@ static int ahci_probe(struct platform_device *pdev)
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
@@ -131,17 +165,26 @@ static int ahci_probe(struct platform_device *pdev)
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
@@ -222,11 +265,9 @@ pdata_exit:
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
 
@@ -239,10 +280,8 @@ static void ahci_host_stop(struct ata_host *host)
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
@@ -277,8 +316,7 @@ static int ahci_suspend(struct device *dev)
 	if (pdata && pdata->suspend)
 		pdata->suspend(dev);
 
-	if (!IS_ERR(hpriv->clk))
-		clk_disable_unprepare(hpriv->clk);
+	ahci_disable_clks(hpriv);
 
 	return 0;
 }
@@ -290,13 +328,9 @@ static int ahci_resume(struct device *dev)
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
@@ -320,8 +354,7 @@ pdata_suspend:
 	if (pdata && pdata->suspend)
 		pdata->suspend(dev);
 disable_unprepare_clk:
-	if (!IS_ERR(hpriv->clk))
-		clk_disable_unprepare(hpriv->clk);
+	ahci_disable_clks(hpriv);
 
 	return rc;
 }
-- 
1.8.4.2
