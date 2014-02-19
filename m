From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 08/18] ahci-platform: "Library-ise" suspend /
 resume functionality
Date: Wed, 19 Feb 2014 13:01:50 +0100
Message-ID: <1392811320-3132-9-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB2N2SKMAKGQED74E63A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Split suspend / resume code into host suspend / resume functionality and
resource enable / disabling phases, and export the new suspend_ / resume_host
functions.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci_platform.c   | 55 +++++++++++++++++++++++++++++++------------
 include/linux/ahci_platform.h |  5 ++++
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index b260ebe..ba93930 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -353,14 +353,12 @@ static void ahci_host_stop(struct ata_host *host)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int ahci_suspend(struct device *dev)
+int ahci_platform_suspend_host(struct device *dev)
 {
-	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 	u32 ctl;
-	int rc;
 
 	if (hpriv->flags & AHCI_HFLAG_NO_SUSPEND) {
 		dev_err(dev, "firmware update required for suspend/resume\n");
@@ -377,7 +375,37 @@ static int ahci_suspend(struct device *dev)
 	writel(ctl, mmio + HOST_CTL);
 	readl(mmio + HOST_CTL); /* flush */
 
-	rc = ata_host_suspend(host, PMSG_SUSPEND);
+	return ata_host_suspend(host, PMSG_SUSPEND);
+}
+EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
+
+int ahci_platform_resume_host(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	int rc;
+
+	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
+		rc = ahci_reset_controller(host);
+		if (rc)
+			return rc;
+
+		ahci_init_controller(host);
+	}
+
+	ata_host_resume(host);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ahci_platform_resume_host);
+
+int ahci_platform_suspend(struct device *dev)
+{
+	struct ahci_platform_data *pdata = dev_get_platdata(dev);
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	int rc;
+
+	rc = ahci_platform_suspend_host(dev);
 	if (rc)
 		return rc;
 
@@ -388,8 +416,9 @@ static int ahci_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ahci_platform_suspend);
 
-static int ahci_resume(struct device *dev)
+int ahci_platform_resume(struct device *dev)
 {
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ata_host *host = dev_get_drvdata(dev);
@@ -406,15 +435,9 @@ static int ahci_resume(struct device *dev)
 			goto disable_resources;
 	}
 
-	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
-		rc = ahci_reset_controller(host);
-		if (rc)
-			goto disable_resources;
-
-		ahci_init_controller(host);
-	}
-
-	ata_host_resume(host);
+	rc = ahci_platform_resume_host(dev);
+	if (rc)
+		goto disable_resources;
 
 	return 0;
 
@@ -423,9 +446,11 @@ disable_resources:
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ahci_platform_resume);
 #endif
 
-static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
+static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
+			 ahci_platform_resume);
 
 static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,spear-ahci", },
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 1dc7602..7c683c7 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -50,4 +50,9 @@ int ahci_platform_init_host(struct platform_device *pdev,
 			    unsigned int force_port_map,
 			    unsigned int mask_port_map);
 
+int ahci_platform_suspend_host(struct device *dev);
+int ahci_platform_resume_host(struct device *dev);
+int ahci_platform_suspend(struct device *dev);
+int ahci_platform_resume(struct device *dev);
+
 #endif /* _AHCI_PLATFORM_H */
-- 
1.8.5.3
