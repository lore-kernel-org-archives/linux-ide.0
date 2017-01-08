From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ata: sata_mv: Convert to devm_ioremap_resource()
Date: Mon,  9 Jan 2017 00:49:22 +0200
Message-ID: <20170108224922.147261-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13991 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753680AbdAHWt2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 8 Jan 2017 17:49:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Convert to devm_ioremap_resource() which provides more consistent error
handling.

Note that devm_ioremap_resource() provides its own error messages.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_mv.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 2f32782cea6d..58fe0b846fed 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4067,6 +4067,7 @@ static int mv_platform_probe(struct platform_device *pdev)
 	struct ata_host *host;
 	struct mv_host_priv *hpriv;
 	struct resource *res;
+	void __iomem *mmio;
 	int n_ports = 0, irq = 0;
 	int rc;
 	int port;
@@ -4085,8 +4086,9 @@ static int mv_platform_probe(struct platform_device *pdev)
 	 * Get the register base first
 	 */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL)
-		return -EINVAL;
+	mmio = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
 
 	/* allocate host */
 	if (pdev->dev.of_node) {
@@ -4130,12 +4132,7 @@ static int mv_platform_probe(struct platform_device *pdev)
 	hpriv->board_idx = chip_soc;
 
 	host->iomap = NULL;
-	hpriv->base = devm_ioremap(&pdev->dev, res->start,
-				   resource_size(res));
-	if (!hpriv->base)
-		return -ENOMEM;
-
-	hpriv->base -= SATAHC0_REG_BASE;
+	hpriv->base = mmio - SATAHC0_REG_BASE;
 
 	hpriv->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hpriv->clk))
-- 
2.11.0

