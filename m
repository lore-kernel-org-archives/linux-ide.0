From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 2/3] ahci_platform: Drop support for imx53-ahci
 platform device type
Date: Sat, 22 Feb 2014 17:22:54 +0100
Message-ID: <1393086175-6383-3-git-send-email-hdegoede@redhat.com>
References: <1393086175-6383-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB445UOMAKGQEZ263KBQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1393086175-6383-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Since the 3.13 release the ahci_imx driver has proper devicetree enabled
support for ahci on imx53 and that is used instead of the old board file
created imx53-ahci platform device.

Note this patch also complete drops the id-table, an id-table is not needed
for a single id platform driver, the name field in the driver struct suffices.

And the code already has an explicit "MODULE_ALIAS("platform:ahci");" so the
id-table is not needed for that either.

Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci_platform.c | 46 ++++++---------------------------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 9fb99cf..d48ca8a 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -29,49 +29,17 @@
 
 static void ahci_host_stop(struct ata_host *host);
 
-enum ahci_type {
-	AHCI,		/* standard platform ahci */
-	IMX53_AHCI,	/* ahci on i.mx53 */
-};
-
-static struct platform_device_id ahci_devtype[] = {
-	{
-		.name = "ahci",
-		.driver_data = AHCI,
-	}, {
-		.name = "imx53-ahci",
-		.driver_data = IMX53_AHCI,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(platform, ahci_devtype);
-
 struct ata_port_operations ahci_platform_ops = {
 	.inherits	= &ahci_ops,
 	.host_stop	= ahci_host_stop,
 };
 EXPORT_SYMBOL_GPL(ahci_platform_ops);
 
-static struct ata_port_operations ahci_platform_retry_srst_ops = {
-	.inherits	= &ahci_pmp_retry_srst_ops,
-	.host_stop	= ahci_host_stop,
-};
-
-static const struct ata_port_info ahci_port_info[] = {
-	/* by features */
-	[AHCI] = {
-		.flags		= AHCI_FLAG_COMMON,
-		.pio_mask	= ATA_PIO4,
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_platform_ops,
-	},
-	[IMX53_AHCI] = {
-		.flags		= AHCI_FLAG_COMMON,
-		.pio_mask	= ATA_PIO4,
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_platform_retry_srst_ops,
-	},
+static const struct ata_port_info ahci_port_info = {
+	.flags		= AHCI_FLAG_COMMON,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &ahci_platform_ops,
 };
 
 static struct scsi_host_template ahci_platform_sht = {
@@ -436,7 +404,6 @@ static int ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
-	const struct platform_device_id *id = platform_get_device_id(pdev);
 	const struct ata_port_info *pi_template;
 	struct ahci_host_priv *hpriv;
 	int rc;
@@ -464,7 +431,7 @@ static int ahci_probe(struct platform_device *pdev)
 	if (pdata && pdata->ata_port_info)
 		pi_template = pdata->ata_port_info;
 	else
-		pi_template = &ahci_port_info[id ? id->driver_data : 0];
+		pi_template = &ahci_port_info;
 
 	rc = ahci_platform_init_host(pdev, hpriv, pi_template,
 				     pdata ? pdata->force_port_map : 0,
@@ -670,7 +637,6 @@ static struct platform_driver ahci_driver = {
 		.of_match_table = ahci_of_match,
 		.pm = &ahci_pm_ops,
 	},
-	.id_table	= ahci_devtype,
 };
 module_platform_driver(ahci_driver);
 
-- 
1.9.0
