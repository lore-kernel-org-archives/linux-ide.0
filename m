From: Richard Zhu <richard.zhu@linaro.org>
Subject: [PATCH V7 2/5] ahci_plt Add the board_ids and pi refer to different features
Date: Tue, 30 Aug 2011 17:56:07 +0800
Message-ID: <1314698171-7937-2-git-send-email-richard.zhu@linaro.org>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:24360
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768Ab1H3J4e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2011 05:56:34 -0400
In-Reply-To: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org, Richard Zhu <richard.zhu@linaro.org>

On imx53 AHCI, soft reset fails with IPMS set when PMP
is enabled but SATA HDD/ODD is connected to SATA port,
do soft reset again to port 0.
So the 'ahci_pmp_retry_srst_ops' is required when imx53
ahci is present.

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 drivers/ata/ahci_platform.c |   44 +++++++++++++++++++++++++++++++++++++-----
 1 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 6fef1fa..c03277d 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -23,6 +23,41 @@
 #include <linux/ahci_platform.h>
 #include "ahci.h"
 
+enum ahci_type {
+	AHCI,		/* standard platform ahci */
+	IMX53_AHCI,	/* ahci on i.mx53 */
+};
+
+static struct platform_device_id ahci_devtype[] = {
+	{
+		.name = "ahci",
+		.driver_data = AHCI,
+	}, {
+		.name = "imx53-ahci",
+		.driver_data = IMX53_AHCI,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, ahci_devtype);
+
+
+static const struct ata_port_info ahci_port_info[] = {
+	/* by features */
+	[AHCI] = {
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
+	[IMX53_AHCI] = {
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_pmp_retry_srst_ops,
+	},
+};
+
 static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT("ahci_platform"),
 };
@@ -31,12 +66,8 @@ static int __init ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_platform_data *pdata = dev->platform_data;
-	struct ata_port_info pi = {
-		.flags		= AHCI_FLAG_COMMON,
-		.pio_mask	= ATA_PIO4,
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
-	};
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct ata_port_info pi = ahci_port_info[id->driver_data];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
 	struct ahci_host_priv *hpriv;
 	struct ata_host *host;
@@ -177,6 +208,7 @@ static struct platform_driver ahci_driver = {
 		.name = "ahci",
 		.owner = THIS_MODULE,
 	},
+	.id_table	= ahci_devtype,
 };
 
 static int __init ahci_init(void)
-- 
1.7.1


