From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 11/15] ata: ahci_platform: Manage SATA PHY
Date: Sat, 22 Feb 2014 16:53:40 +0100
Message-ID: <1393084424-31099-12-git-send-email-hdegoede@redhat.com>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBLUQUOMAKGQEITPCF5I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1393084424-31099-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Some platforms have a PHY hooked up to the
SATA controller. The PHY needs to be initialized
and powered up for SATA to work. We do that
using the PHY framework.

CC: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci.h          |  2 ++
 drivers/ata/ahci_platform.c | 47 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index bf8100c..3ab7ac9 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -37,6 +37,7 @@
 
 #include <linux/clk.h>
 #include <linux/libata.h>
+#include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
 
 /* Enclosure Management Control */
@@ -325,6 +326,7 @@ struct ahci_host_priv {
 	u32			em_msg_type;	/* EM message type */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	struct regulator	*target_pwr;	/* Optional */
+	struct phy		*phy;		/* If platform uses phy */
 	void			*plat_data;	/* Other platform data */
 	/*
 	 * Optional ahci_start_engine override, if not set this gets set to the
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index d7e55ba..99d38c1 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
+#include <linux/phy/phy.h>
 #include "ahci.h"
 
 static void ahci_host_stop(struct ata_host *host);
@@ -147,6 +148,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
  *	the following order:
  *	1) Regulator
  *	2) Clocks (through ahci_platform_enable_clks)
+ *	3) Phy
  *
  *	If resource enabling fails at any point the previous enabled
  *	resources are disabled in reverse order.
@@ -171,8 +173,23 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 	if (rc)
 		goto disable_regulator;
 
+	if (hpriv->phy) {
+		rc = phy_init(hpriv->phy);
+		if (rc)
+			goto disable_clks;
+
+		rc = phy_power_on(hpriv->phy);
+		if (rc) {
+			phy_exit(hpriv->phy);
+			goto disable_clks;
+		}
+	}
+
 	return 0;
 
+disable_clks:
+	ahci_platform_disable_clks(hpriv);
+
 disable_regulator:
 	if (hpriv->target_pwr)
 		regulator_disable(hpriv->target_pwr);
@@ -186,14 +203,20 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_resources);
  *
  *	This function disables all ahci_platform managed resources in
  *	the following order:
- *	1) Clocks (through ahci_platform_disable_clks)
- *	2) Regulator
+ *	1) Phy
+ *	2) Clocks (through ahci_platform_disable_clks)
+ *	3) Regulator
  *
  *	LOCKING:
  *	None.
  */
 void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
 {
+	if (hpriv->phy) {
+		phy_power_off(hpriv->phy);
+		phy_exit(hpriv->phy);
+	}
+
 	ahci_platform_disable_clks(hpriv);
 
 	if (hpriv->target_pwr)
@@ -222,6 +245,7 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
  *	2) regulator for controlling the targets power (optional)
  *	3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
  *	   or for non devicetree enabled platforms a single clock
+ *	4) phy (optional)
  *
  *	LOCKING:
  *	None.
@@ -283,6 +307,25 @@ struct ahci_host_priv *ahci_platform_get_resources(
 		hpriv->clks[i] = clk;
 	}
 
+	hpriv->phy = devm_phy_get(dev, "sata-phy");
+	if (IS_ERR(hpriv->phy)) {
+		rc = PTR_ERR(hpriv->phy);
+		switch (rc) {
+		case -ENODEV:
+		case -ENOSYS:
+			/* continue normally */
+			hpriv->phy = NULL;
+			break;
+
+		case -EPROBE_DEFER:
+			goto err_out;
+
+		default:
+			dev_err(dev, "couldn't get sata-phy\n");
+			goto err_out;
+		}
+	}
+
 	devres_remove_group(dev, NULL);
 	return hpriv;
 
-- 
1.9.0
