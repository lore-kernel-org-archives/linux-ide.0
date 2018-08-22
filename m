From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 01/14] ata: ahci-platform: add reset control support and the flag to specify using reset
Date: Wed, 22 Aug 2018 16:36:57 +0900
Message-ID: <1534923430-9692-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-ide@vger.kernel.org

Add support to get and control a list of resets for the device
as optional and shared. These resets must be kept de-asserted until
the device is enabled.

This is specified as shared because some SoCs like UniPhier series
have common reset controls with all ahci controller instances.

However, according to Thierry's view,
https://www.spinics.net/lists/linux-ide/msg55357.html
some hardware-specific drivers already use their own resets,
and the common reset make a path to occur double controls of resets.

Now this add the flag to ahci_platform_get_resources() indicating
whether to use the resources, currently resets only, and existing
drivers set 0 to this flags.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
 drivers/ata/ahci.h                                 |  1 +
 drivers/ata/ahci_platform.c                        |  3 +-
 drivers/ata/libahci_platform.c                     | 35 ++++++++++++++++++----
 include/linux/ahci_platform.h                      |  4 ++-
 5 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 6637666..5d5bd45 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -29,6 +29,7 @@ compatible:
 Optional properties:
 - dma-coherent      : Present if dma operations are coherent
 - clocks            : a list of phandle + clock specifier pairs
+- resets            : a list of phandle + reset specifier pairs
 - target-supply     : regulator for SATA target power
 - phys              : reference to the SATA PHY node
 - phy-names         : must be "sata-phy"
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 1609eba..6a1515f 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -350,6 +350,7 @@ struct ahci_host_priv {
 	u32			em_msg_type;	/* EM message type */
 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
+	struct reset_control	*rsts;		/* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
 	/*
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 564570e..46f0bd7 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -43,7 +43,8 @@ static int ahci_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev,
+					    AHCI_PLATFORM_GET_RESETS);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 8fbb532..c92c10d 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -25,6 +25,7 @@
 #include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_platform.h>
+#include <linux/reset.h>
 #include "ahci.h"
 
 static void ahci_host_stop(struct ata_host *host);
@@ -195,7 +196,8 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
  * following order:
  * 1) Regulator
  * 2) Clocks (through ahci_platform_enable_clks)
- * 3) Phys
+ * 3) Resets
+ * 4) Phys
  *
  * If resource enabling fails at any point the previous enabled resources
  * are disabled in reverse order.
@@ -215,12 +217,19 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 	if (rc)
 		goto disable_regulator;
 
-	rc = ahci_platform_enable_phys(hpriv);
+	rc = reset_control_deassert(hpriv->rsts);
 	if (rc)
 		goto disable_clks;
 
+	rc = ahci_platform_enable_phys(hpriv);
+	if (rc)
+		goto disable_resets;
+
 	return 0;
 
+disable_resets:
+	reset_control_assert(hpriv->rsts);
+
 disable_clks:
 	ahci_platform_disable_clks(hpriv);
 
@@ -238,13 +247,16 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_resources);
  * This function disables all ahci_platform managed resources in the
  * following order:
  * 1) Phys
- * 2) Clocks (through ahci_platform_disable_clks)
- * 3) Regulator
+ * 2) Resets
+ * 3) Clocks (through ahci_platform_disable_clks)
+ * 4) Regulator
  */
 void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
 {
 	ahci_platform_disable_phys(hpriv);
 
+	reset_control_assert(hpriv->rsts);
+
 	ahci_platform_disable_clks(hpriv);
 
 	ahci_platform_disable_regulators(hpriv);
@@ -332,6 +344,7 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
 /**
  * ahci_platform_get_resources - Get platform resources
  * @pdev: platform device to get resources for
+ * @flags: bitmap representing the resource to get
  *
  * This function allocates an ahci_host_priv struct, and gets the following
  * resources, storing a reference to them inside the returned struct:
@@ -340,12 +353,14 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
  * 2) regulator for controlling the targets power (optional)
  * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
  *    or for non devicetree enabled platforms a single clock
- * 4) phys (optional)
+ * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
+ * 5) phys (optional)
  *
  * RETURNS:
  * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
  */
-struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
+struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
+						   unsigned int flags)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
@@ -393,6 +408,14 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		hpriv->clks[i] = clk;
 	}
 
+	if (flags & AHCI_PLATFORM_GET_RESETS) {
+		hpriv->rsts = devm_reset_control_array_get_optional_shared(dev);
+		if (IS_ERR(hpriv->rsts)) {
+			rc = PTR_ERR(hpriv->rsts);
+			goto err_out;
+		}
+	}
+
 	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
 
 	/*
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 1b0a17b..eaedca5f 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -30,7 +30,7 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
 struct ahci_host_priv *ahci_platform_get_resources(
-	struct platform_device *pdev);
+	struct platform_device *pdev, unsigned int flags);
 int ahci_platform_init_host(struct platform_device *pdev,
 			    struct ahci_host_priv *hpriv,
 			    const struct ata_port_info *pi_template,
@@ -43,4 +43,6 @@ int ahci_platform_resume_host(struct device *dev);
 int ahci_platform_suspend(struct device *dev);
 int ahci_platform_resume(struct device *dev);
 
+#define AHCI_PLATFORM_GET_RESETS	0x01
+
 #endif /* _AHCI_PLATFORM_H */
-- 
2.7.4
