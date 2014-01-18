From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v3 08/13] ahci-platform: Allow specifying
 platform_data through of_device_id
Date: Sun, 19 Jan 2014 00:48:50 +0100
Message-ID: <1390088935-7193-9-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBAVG5SLAKGQEZN72PAA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/ata/ahci_platform.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 3bc2dab..0676d72 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
@@ -87,6 +88,30 @@ static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT("ahci_platform"),
 };
 
+static const struct of_device_id ahci_of_match[] = {
+	{ .compatible = "snps,spear-ahci", },
+	{ .compatible = "snps,exynos5440-ahci", },
+	{ .compatible = "ibm,476gtr-ahci", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ahci_of_match);
+
+static const struct ahci_platform_data *ahci_get_pdata(struct device *dev)
+{
+	struct ahci_platform_data *pdata;
+	const struct of_device_id *of_id;
+
+	pdata = dev_get_platdata(dev);
+	if (pdata)
+		return pdata;
+
+	of_id = of_match_device(ahci_of_match, dev);
+	if (of_id)
+		return of_id->data;
+
+	return NULL;
+}
+
 static int ahci_enable_clks(struct device *dev, struct ahci_host_priv *hpriv)
 {
 	int c, rc;
@@ -126,7 +151,7 @@ static void ahci_put_clks(struct ahci_host_priv *hpriv)
 static int ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct ahci_platform_data *pdata = dev_get_platdata(dev);
+	const struct ahci_platform_data *pdata = ahci_get_pdata(dev);
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct ata_port_info pi = ahci_port_info[id ? id->driver_data : 0];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
@@ -290,7 +315,7 @@ free_clk:
 static void ahci_host_stop(struct ata_host *host)
 {
 	struct device *dev = host->dev;
-	struct ahci_platform_data *pdata = dev_get_platdata(dev);
+	const struct ahci_platform_data *pdata = ahci_get_pdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 
 	if (hpriv->target_pwr)
@@ -306,7 +331,7 @@ static void ahci_host_stop(struct ata_host *host)
 #ifdef CONFIG_PM_SLEEP
 static int ahci_suspend(struct device *dev)
 {
-	struct ahci_platform_data *pdata = dev_get_platdata(dev);
+	const struct ahci_platform_data *pdata = ahci_get_pdata(dev);
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
@@ -345,7 +370,7 @@ static int ahci_suspend(struct device *dev)
 
 static int ahci_resume(struct device *dev)
 {
-	struct ahci_platform_data *pdata = dev_get_platdata(dev);
+	const struct ahci_platform_data *pdata = ahci_get_pdata(dev);
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	int rc;
@@ -393,14 +418,6 @@ disable_unprepare_clk:
 
 static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
 
-static const struct of_device_id ahci_of_match[] = {
-	{ .compatible = "snps,spear-ahci", },
-	{ .compatible = "snps,exynos5440-ahci", },
-	{ .compatible = "ibm,476gtr-ahci", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, ahci_of_match);
-
 static struct platform_driver ahci_driver = {
 	.probe = ahci_probe,
 	.remove = ata_platform_remove_one,
-- 
1.8.4.2
