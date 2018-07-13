From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 1/9] ata: ahci_platform: add support for AHCI controller regulator
Date: Fri, 13 Jul 2018 11:02:58 +0000
Message-ID: <1531479786-4911-2-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, thierry.reding@gmail.com, icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

The SoC R40 AHCI controller need a regulator to work.
So this patch add a way to add an optional regulator on AHCI controller.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/ahci.h             |  1 +
 drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 1609ebab4e23..633d3ec5c1df 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -351,6 +351,7 @@ struct ahci_host_priv {
 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
+	struct regulator	*ahci_regulator;/* Optional */
 	/*
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
 	 * the PHY position in this array.
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index fe8939e161ea..d997a30ce793 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -138,7 +138,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
  * ahci_platform_enable_regulators - Enable regulators
  * @hpriv: host private area to store config values
  *
- * This function enables all the regulators found in
+ * This function enables all the regulators found in controller and
  * hpriv->target_pwrs, if any.  If a regulator fails to be enabled, it
  * disables all the regulators already enabled in reverse order and
  * returns an error.
@@ -150,6 +150,12 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
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
@@ -166,6 +172,8 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 		if (hpriv->target_pwrs[i])
 			regulator_disable(hpriv->target_pwrs[i]);
 
+	if (hpriv->ahci_regulator)
+		regulator_disable(hpriv->ahci_regulator);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_platform_enable_regulators);
@@ -174,7 +182,8 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_regulators);
  * ahci_platform_disable_regulators - Disable regulators
  * @hpriv: host private area to store config values
  *
- * This function disables all regulators found in hpriv->target_pwrs.
+ * This function disables all regulators found in hpriv->target_pwrs and
+ * AHCI controller.
  */
 void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 {
@@ -185,6 +194,9 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 			continue;
 		regulator_disable(hpriv->target_pwrs[i]);
 	}
+
+	if (hpriv->ahci_regulator)
+		regulator_disable(hpriv->ahci_regulator);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
 /**
@@ -336,6 +348,7 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
  *
  * 1) mmio registers (IORESOURCE_MEM 0, mandatory)
  * 2) regulator for controlling the targets power (optional)
+ *    regulator for controlling the AHCI controller (optional)
  * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
  *    or for non devicetree enabled platforms a single clock
  * 4) phys (optional)
@@ -391,6 +404,16 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		hpriv->clks[i] = clk;
 	}
 
+	hpriv->ahci_regulator = devm_regulator_get_optional(dev, "ahci");
+
+	if (IS_ERR(hpriv->ahci_regulator)) {
+		rc = PTR_ERR(hpriv->ahci_regulator);
+		if (rc == -EPROBE_DEFER)
+			goto err_out;
+		rc = 0;
+		hpriv->ahci_regulator = NULL;
+	}
+
 	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
 
 	/*
-- 
2.16.4
