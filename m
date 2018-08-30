From: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 02/13] ata: ahci_platform: add support for
 AHCI controller regulator
Date: Thu, 30 Aug 2018 21:01:09 +0200
Message-ID: <20180830190120.722-3-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Reply-To: clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBD7YLCN32UNBBDH6UDOAKGQEQET75ZI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180830190120.722-1-clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

The SoC R40 AHCI controller need a regulator to work.
So this patch add a way to add an optional regulator on AHCI controller.

Signed-off-by: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/ata/ahci.h             |  1 +
 drivers/ata/libahci_platform.c | 26 ++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 6a1515f0da40..1415f1012de5 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -352,6 +352,7 @@ struct ahci_host_priv {
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	struct reset_control	*rsts;		/* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
+	struct regulator	*ahci_regulator;/* Optional */
 	/*
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
 	 * the PHY position in this array.
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index c92c10d55374..a886b61476a3 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -139,7 +139,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
  * ahci_platform_enable_regulators - Enable regulators
  * @hpriv: host private area to store config values
  *
- * This function enables all the regulators found in
+ * This function enables all the regulators found in controller and
  * hpriv->target_pwrs, if any.  If a regulator fails to be enabled, it
  * disables all the regulators already enabled in reverse order and
  * returns an error.
@@ -151,6 +151,12 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 {
 	int rc, i;
 
+	if (hpriv->ahci_regulator) {
+		rc = regulator_enable(hpriv->ahci_regulator);
+		if (rc)
+			return rc;
+	}
+
 	for (i = 0; i < hpriv->nports; i++) {
 		if (!hpriv->target_pwrs[i])
 			continue;
@@ -167,6 +173,8 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 		if (hpriv->target_pwrs[i])
 			regulator_disable(hpriv->target_pwrs[i]);
 
+	if (hpriv->ahci_regulator)
+		regulator_disable(hpriv->ahci_regulator);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_platform_enable_regulators);
@@ -175,7 +183,8 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_regulators);
  * ahci_platform_disable_regulators - Disable regulators
  * @hpriv: host private area to store config values
  *
- * This function disables all regulators found in hpriv->target_pwrs.
+ * This function disables all regulators found in hpriv->target_pwrs and
+ * AHCI controller.
  */
 void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 {
@@ -186,6 +195,9 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 			continue;
 		regulator_disable(hpriv->target_pwrs[i]);
 	}
+
+	if (hpriv->ahci_regulator)
+		regulator_disable(hpriv->ahci_regulator);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
 /**
@@ -351,6 +363,7 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
  *
  * 1) mmio registers (IORESOURCE_MEM 0, mandatory)
  * 2) regulator for controlling the targets power (optional)
+ *    regulator for controlling the AHCI controller (optional)
  * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
  *    or for non devicetree enabled platforms a single clock
  * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
@@ -408,6 +421,15 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		hpriv->clks[i] = clk;
 	}
 
+	hpriv->ahci_regulator = devm_regulator_get_optional(dev, "ahci");
+	if (IS_ERR(hpriv->ahci_regulator)) {
+		rc = PTR_ERR(hpriv->ahci_regulator);
+		if (rc == -EPROBE_DEFER)
+			goto err_out;
+		rc = 0;
+		hpriv->ahci_regulator = NULL;
+	}
+
 	if (flags & AHCI_PLATFORM_GET_RESETS) {
 		hpriv->rsts = devm_reset_control_array_get_optional_shared(dev);
 		if (IS_ERR(hpriv->rsts)) {
-- 
2.16.4
