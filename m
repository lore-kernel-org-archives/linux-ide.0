From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 06/18] ahci-platform: Add enable_ /
 disable_resources helper functions
Date: Wed, 19 Feb 2014 13:01:48 +0100
Message-ID: <1392811320-3132-7-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBYF2SKMAKGQELC3HOKY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/ata/ahci_platform.c   | 83 ++++++++++++++++++++++++-------------------
 include/linux/ahci_platform.h |  2 ++
 2 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 2f319e9..1cce7a2 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -117,6 +117,39 @@ void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
 EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
 
 
+int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
+{
+	int rc;
+
+	if (hpriv->target_pwr) {
+		rc = regulator_enable(hpriv->target_pwr);
+		if (rc)
+			return rc;
+	}
+
+	rc = ahci_platform_enable_clks(hpriv);
+	if (rc)
+		goto disable_regulator;
+
+	return 0;
+
+disable_regulator:
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ahci_platform_enable_resources);
+
+void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
+{
+	ahci_platform_disable_clks(hpriv);
+
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
+}
+EXPORT_SYMBOL_GPL(ahci_platform_disable_resources);
+
+
 static void ahci_put_clks(struct ahci_host_priv *hpriv)
 {
 	int c;
@@ -190,15 +223,9 @@ static int ahci_probe(struct platform_device *pdev)
 		hpriv->clks[i] = clk;
 	}
 
-	if (hpriv->target_pwr) {
-		rc = regulator_enable(hpriv->target_pwr);
-		if (rc)
-			goto free_clk;
-	}
-
-	rc = ahci_enable_clks(dev, hpriv);
+	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
-		goto disable_regulator;
+		goto free_clk;
 
 	/*
 	 * Some platforms might need to prepare for mmio region access,
@@ -209,7 +236,7 @@ static int ahci_probe(struct platform_device *pdev)
 	if (pdata && pdata->init) {
 		rc = pdata->init(dev, hpriv);
 		if (rc)
-			goto disable_unprepare_clk;
+			goto disable_resources;
 	}
 
 	ahci_save_initial_config(dev, hpriv,
@@ -279,11 +306,8 @@ static int ahci_probe(struct platform_device *pdev)
 pdata_exit:
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
-disable_unprepare_clk:
-	ahci_disable_clks(hpriv);
-disable_regulator:
-	if (hpriv->target_pwr)
-		regulator_disable(hpriv->target_pwr);
+disable_resources:
+	ahci_platform_disable_resources(hpriv);
 free_clk:
 	ahci_put_clks(hpriv);
 	return rc;
@@ -298,11 +322,8 @@ static void ahci_host_stop(struct ata_host *host)
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
 
-	ahci_disable_clks(hpriv);
+	ahci_platform_disable_resources(hpriv);
 	ahci_put_clks(hpriv);
-
-	if (hpriv->target_pwr)
-		regulator_disable(hpriv->target_pwr);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -337,10 +358,7 @@ static int ahci_suspend(struct device *dev)
 	if (pdata && pdata->suspend)
 		return pdata->suspend(dev);
 
-	ahci_disable_clks(hpriv);
-
-	if (hpriv->target_pwr)
-		regulator_disable(hpriv->target_pwr);
+	ahci_platform_disable_resources(hpriv);
 
 	return 0;
 }
@@ -352,26 +370,20 @@ static int ahci_resume(struct device *dev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	int rc;
 
-	if (hpriv->target_pwr) {
-		rc = regulator_enable(hpriv->target_pwr);
-		if (rc)
-			return rc;
-	}
-
-	rc = ahci_enable_clks(dev, hpriv);
+	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
-		goto disable_regulator;
+		return rc;
 
 	if (pdata && pdata->resume) {
 		rc = pdata->resume(dev);
 		if (rc)
-			goto disable_unprepare_clk;
+			goto disable_resources;
 	}
 
 	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = ahci_reset_controller(host);
 		if (rc)
-			goto disable_unprepare_clk;
+			goto disable_resources;
 
 		ahci_init_controller(host);
 	}
@@ -380,11 +392,8 @@ static int ahci_resume(struct device *dev)
 
 	return 0;
 
-disable_unprepare_clk:
-	ahci_disable_clks(hpriv);
-disable_regulator:
-	if (hpriv->target_pwr)
-		regulator_disable(hpriv->target_pwr);
+disable_resources:
+	ahci_platform_disable_resources(hpriv);
 
 	return rc;
 }
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 0071d0b..5e5f85e 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -33,5 +33,7 @@ struct ahci_platform_data {
 
 int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
+int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
+void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
 
 #endif /* _AHCI_PLATFORM_H */
-- 
1.8.5.3
