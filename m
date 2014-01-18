From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v3 07/13] ahci-platform: Add support for an
 optional regulator for sata-target power
Date: Sun, 19 Jan 2014 00:48:49 +0100
Message-ID: <1390088935-7193-8-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB75F5SLAKGQEFN7NC7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
 drivers/ata/ahci.h                                 |  2 ++
 drivers/ata/ahci_platform.c                        | 39 +++++++++++++++++++---
 3 files changed, 38 insertions(+), 4 deletions(-)

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
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 7950b3a..c3e0c49 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -36,6 +36,7 @@
 #define _AHCI_H
 
 #include <linux/clk.h>
+#include <linux/regulator/consumer.h>
 #include <linux/libata.h>
 
 /* Enclosure Management Control */
@@ -323,6 +324,7 @@ struct ahci_host_priv {
 	u32			em_buf_sz;	/* EM buffer size in byte */
 	u32			em_msg_type;	/* EM message type */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
+	struct regulator	*target_pwr;	/* Optional */
 	void			*plat_data;	/* Other platform data */
 	/* Optional ahci_start_engine override */
 	void			(*start_engine)(struct ata_port *ap);
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 75a3d47..3bc2dab 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -181,6 +181,13 @@ static int ahci_probe(struct platform_device *pdev)
 		hpriv->clks[i] = clk;
 	}
 
+	hpriv->target_pwr = devm_regulator_get_optional(dev, "target");
+	if (IS_ERR(hpriv->target_pwr)) {
+		if (PTR_ERR(hpriv->target_pwr) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		hpriv->target_pwr = NULL;
+	}
+
 	rc = ahci_enable_clks(dev, hpriv);
 	if (rc)
 		goto free_clk;
@@ -197,6 +204,12 @@ static int ahci_probe(struct platform_device *pdev)
 			goto disable_unprepare_clk;
 	}
 
+	if (hpriv->target_pwr) {
+		rc = regulator_enable(hpriv->target_pwr);
+		if (rc)
+			goto pdata_exit;
+	}
+
 	ahci_save_initial_config(dev, hpriv,
 		pdata ? pdata->force_port_map : 0,
 		pdata ? pdata->mask_port_map  : 0);
@@ -220,7 +233,7 @@ static int ahci_probe(struct platform_device *pdev)
 	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
 	if (!host) {
 		rc = -ENOMEM;
-		goto pdata_exit;
+		goto disable_regulator;
 	}
 
 	host->private_data = hpriv;
@@ -250,7 +263,7 @@ static int ahci_probe(struct platform_device *pdev)
 
 	rc = ahci_reset_controller(host);
 	if (rc)
-		goto pdata_exit;
+		goto disable_regulator;
 
 	ahci_init_controller(host);
 	ahci_print_info(host, "platform");
@@ -258,9 +271,12 @@ static int ahci_probe(struct platform_device *pdev)
 	rc = ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
 			       &ahci_platform_sht);
 	if (rc)
-		goto pdata_exit;
+		goto disable_regulator;
 
 	return 0;
+disable_regulator:
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
 pdata_exit:
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
@@ -277,6 +293,9 @@ static void ahci_host_stop(struct ata_host *host)
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
+
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
 
@@ -313,6 +332,9 @@ static int ahci_suspend(struct device *dev)
 	if (rc)
 		return rc;
 
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
+
 	if (pdata && pdata->suspend)
 		pdata->suspend(dev);
 
@@ -338,10 +360,16 @@ static int ahci_resume(struct device *dev)
 			goto disable_unprepare_clk;
 	}
 
+	if (hpriv->target_pwr) {
+		rc = regulator_enable(hpriv->target_pwr);
+		if (rc)
+			goto pdata_suspend;
+	}
+
 	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = ahci_reset_controller(host);
 		if (rc)
-			goto pdata_suspend;
+			goto disable_regulator;
 
 		ahci_init_controller(host);
 	}
@@ -350,6 +378,9 @@ static int ahci_resume(struct device *dev)
 
 	return 0;
 
+disable_regulator:
+	if (hpriv->target_pwr)
+		regulator_disable(hpriv->target_pwr);
 pdata_suspend:
 	if (pdata && pdata->suspend)
 		pdata->suspend(dev);
-- 
1.8.4.2
