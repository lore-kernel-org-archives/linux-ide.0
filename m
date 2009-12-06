From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH 3/6] sata_mv: add power management support for the platform driver
Date: Sun,  6 Dec 2009 18:26:19 +0200
Message-ID: <1260116782-31714-3-git-send-email-saeed@marvell.com>
References: <1260116782-31714-1-git-send-email-saeed@marvell.com>
 <1260116782-31714-2-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:50730 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250AbZLFQ0X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Dec 2009 11:26:23 -0500
In-Reply-To: <1260116782-31714-2-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org
Cc: liml@rtr.ca, nico@fluxnic.net, buytenh@wantstofly.org, Saeed Bishara <saeed@marvell.com>

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 drivers/ata/sata_mv.c

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
old mode 100644
new mode 100755
index 0906df4..17a138b
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4112,9 +4112,52 @@ static int __devexit mv_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int mv_platform_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	if (host)
+		return ata_host_suspend(host, state);
+	else
+		return 0;
+}
+
+static int mv_platform_resume(struct platform_device *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	if (host) {
+		struct mv_host_priv *hpriv = host->private_data;
+		const struct mv_sata_platform_data *mv_platform_data = \
+			pdev->dev.platform_data;
+		/*
+		 * (Re-)program MBUS remapping windows if we are asked to.
+		 */
+		if (mv_platform_data->dram != NULL)
+			mv_conf_mbus_windows(hpriv, mv_platform_data->dram);
+
+		/* initialize adapter */
+		ret = mv_init_host(host, chip_soc);
+		if (ret) {
+			printk(KERN_ERR DRV_NAME ": Error during HW init\n");
+			return ret;
+		}
+		ata_host_resume(host);
+	}
+
+	return 0;
+}
+#else
+#define mv_platform_suspend NULL
+#define mv_platform_resume NULL
+#endif
+
 static struct platform_driver mv_platform_driver = {
 	.probe			= mv_platform_probe,
 	.remove			= __devexit_p(mv_platform_remove),
+	.suspend		= mv_platform_suspend,
+	.resume			= mv_platform_resume,
 	.driver			= {
 				   .name = DRV_NAME,
 				   .owner = THIS_MODULE,
-- 
1.6.0.4

