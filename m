From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 3/9] ata: ahci_platform: add support for AHCI controller reset
Date: Fri, 13 Jul 2018 11:03:00 +0000
Message-ID: <1531479786-4911-4-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, thierry.reding@gmail.com, icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

The SoC R40 AHCI controller need a reset to work.
So this patch add a way to add an optional reset on AHCI controller.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/ahci.h             |  2 ++
 drivers/ata/libahci_platform.c | 28 ++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 633d3ec5c1df..274c1885a5ad 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -40,6 +40,7 @@
 #include <linux/libata.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 
 /* Enclosure Management Control */
 #define EM_CTRL_MSG_TYPE              0x000f0000
@@ -352,6 +353,7 @@ struct ahci_host_priv {
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
 	struct regulator	*ahci_regulator;/* Optional */
+	struct reset_control	*ahci_reset;	/* Optional */
 	/*
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
 	 * the PHY position in this array.
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index d997a30ce793..1199ba411c15 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -207,7 +207,8 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
  * following order:
  * 1) Regulator
  * 2) Clocks (through ahci_platform_enable_clks)
- * 3) Phys
+ * 3) reset
+ * 4) Phys
  *
  * If resource enabling fails at any point the previous enabled resources
  * are disabled in reverse order.
@@ -227,12 +228,19 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 	if (rc)
 		goto disable_regulator;
 
-	rc = ahci_platform_enable_phys(hpriv);
+	rc = reset_control_assert(hpriv->ahci_reset);
 	if (rc)
 		goto disable_clks;
 
+	rc = ahci_platform_enable_phys(hpriv);
+	if (rc)
+		goto disable_reset;
+
 	return 0;
 
+disable_reset:
+	reset_control_deassert(hpriv->ahci_reset);
+
 disable_clks:
 	ahci_platform_disable_clks(hpriv);
 
@@ -250,13 +258,16 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_resources);
  * This function disables all ahci_platform managed resources in the
  * following order:
  * 1) Phys
- * 2) Clocks (through ahci_platform_disable_clks)
- * 3) Regulator
+ * 2) reset
+ * 3) Clocks (through ahci_platform_disable_clks)
+ * 4) Regulator
  */
 void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
 {
 	ahci_platform_disable_phys(hpriv);
 
+	reset_control_deassert(hpriv->ahci_reset);
+
 	ahci_platform_disable_clks(hpriv);
 
 	ahci_platform_disable_regulators(hpriv);
@@ -414,6 +425,15 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		hpriv->ahci_regulator = NULL;
 	}
 
+	hpriv->ahci_reset = devm_reset_control_get_optional(dev, "ahci");
+	if (IS_ERR(hpriv->ahci_reset)) {
+		rc = PTR_ERR(hpriv->ahci_reset);
+		if (rc == -EPROBE_DEFER)
+			goto err_out;
+		rc = 0;
+		hpriv->ahci_reset = NULL;
+	}
+
 	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
 
 	/*
-- 
2.16.4
