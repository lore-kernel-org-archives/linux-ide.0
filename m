From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 13/18] ata: ahci_platform: Manage SATA PHY
Date: Wed, 19 Feb 2014 13:01:55 +0100
Message-ID: <1392811320-3132-14-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBBF3SKMAKGQE2CJYZLQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1392811320-3132-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
 drivers/ata/Kconfig         |  1 +
 drivers/ata/ahci_platform.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/ahci.h        |  2 ++
 3 files changed, 43 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cc67cc0..96176f4 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -91,6 +91,7 @@ config SATA_AHCI
 
 config SATA_AHCI_PLATFORM
 	tristate "Platform AHCI SATA support"
+	depends on GENERIC_PHY || !GENERIC_PHY
 	help
 	  This option enables support for Platform AHCI Serial ATA
 	  controllers.
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 962ec25..073931a 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
+#include <linux/phy/phy.h>
 #include "ahci.h"
 
 static void ahci_host_stop(struct ata_host *host);
@@ -131,8 +132,23 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
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
@@ -142,6 +158,11 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_resources);
 
 void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
 {
+	if (hpriv->phy) {
+		phy_power_off(hpriv->phy);
+		phy_exit(hpriv->phy);
+	}
+
 	ahci_platform_disable_clks(hpriv);
 
 	if (hpriv->target_pwr)
@@ -194,6 +215,25 @@ struct ahci_host_priv *ahci_platform_get_resources(
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
+			goto free_clk;
+
+		default:
+			dev_err(dev, "couldn't get sata-phy\n");
+			goto free_clk;
+		}
+	}
+
 	return hpriv;
 
 free_clk:
diff --git a/include/linux/ahci.h b/include/linux/ahci.h
index ac69cdc..8fbe3d7 100644
--- a/include/linux/ahci.h
+++ b/include/linux/ahci.h
@@ -23,6 +23,7 @@
 
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
+#include <linux/phy/phy.h>
 
 #define AHCI_MAX_CLKS		3
 
@@ -42,6 +43,7 @@ struct ahci_host_priv {
 	u32			em_msg_type;	/* EM message type */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	struct regulator	*target_pwr;	/* Optional */
+	struct phy		*phy;		/* If platform uses phy */
 	void			*plat_data;	/* Other platform data */
 	/* Optional ahci_start_engine override */
 	void			(*start_engine)(struct ata_port *ap);
-- 
1.8.5.3
