From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 12/15] ata: ahci_platform: runtime resume the
 device before use
Date: Sat, 22 Feb 2014 16:53:41 +0100
Message-ID: <1393084424-31099-13-git-send-email-hdegoede@redhat.com>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBMMQUOMAKGQEYZFT53A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

On OMAP platforms the device needs to be runtime resumed before
it can be accessed. The OMAP HWMOD framework takes care of
enabling the module and its resources based on the
device's runtime PM state.

In this patch we runtime resume during .probe() and runtime suspend
after .remove().

We also update the runtime PM state during .resume().

CC: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci.h          |  1 +
 drivers/ata/ahci_platform.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 3ab7ac9..51af275 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -324,6 +324,7 @@ struct ahci_host_priv {
 	u32 			em_loc; /* enclosure management location */
 	u32			em_buf_sz;	/* EM buffer size in byte */
 	u32			em_msg_type;	/* EM message type */
+	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	struct regulator	*target_pwr;	/* Optional */
 	struct phy		*phy;		/* If platform uses phy */
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 99d38c1..75698a4 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -24,6 +24,7 @@
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
 #include "ahci.h"
 
 static void ahci_host_stop(struct ata_host *host);
@@ -229,6 +230,11 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
 	struct ahci_host_priv *hpriv = res;
 	int c;
 
+	if (hpriv->got_runtime_pm) {
+		pm_runtime_put_sync(dev);
+		pm_runtime_disable(dev);
+	}
+
 	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
 		clk_put(hpriv->clks[c]);
 }
@@ -326,6 +332,10 @@ struct ahci_host_priv *ahci_platform_get_resources(
 		}
 	}
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+	hpriv->got_runtime_pm = true;
+
 	devres_remove_group(dev, NULL);
 	return hpriv;
 
@@ -635,6 +645,11 @@ int ahci_platform_resume(struct device *dev)
 	if (rc)
 		goto disable_resources;
 
+	/* We resumed so update PM runtime state */
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return 0;
 
 disable_resources:
-- 
1.9.0
