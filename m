From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH 3/3] sata_mv: add power management support for the platform driver
Date: Tue, 23 Jun 2009 18:43:58 +0300
Message-ID: <1245771838-1332-3-git-send-email-saeed@marvell.com>
References: <1245771838-1332-1-git-send-email-saeed@marvell.com>
 <1245771838-1332-2-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:6287 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758940AbZFWPoB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Jun 2009 11:44:01 -0400
In-Reply-To: <1245771838-1332-2-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, liml@rtr.ca
Cc: saeed.bishara@gmail.com, Saeed Bishara <saeed@marvell.com>


Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index ca9157d..6723a9a 100755
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4087,9 +4087,51 @@ static int __devexit mv_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int mv_platform_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	if (host)
+		return ata_host_suspend(host, state);
+	return 0;
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

