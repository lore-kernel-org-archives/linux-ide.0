From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] Revert "ata: sata_mv: Convert to devm_ioremap_resource()"
Date: Tue, 30 May 2017 15:52:56 +0200
Message-ID: <20170530135256.9966-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35143 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdE3Nxj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2017 09:53:39 -0400
Received: by mail-lf0-f47.google.com with SMTP id a5so49586867lfh.2
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2017 06:53:38 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This reverts commit 368e5fbdfc60732643f34f538823ed4bc8829827.

My NAS stopped to mount root when I went from some v4.10-rc1
to v4.12-rc3. Investigation of the bootlog yields this:

sata_mv f1080000.sata: can't request region for resource [mem 0xf1080000-0xf1084fff]
sata_mv: probe of f1080000.sata failed with error -16

Reverting this offending patch makes the sata_mv probe and
my SATA drive can mount root again, hooray!

Cc: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
The problem is probably caused by overlapping resources in
the device tree, for which ioremap() and ioremap_resource()
have different semantics: the former allows it, the latter
does not.

A proper fix probably includes amending the device tree to
not have overlapping resources.
---
 drivers/ata/sata_mv.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index b66bcda88320..3b2246dded74 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4067,7 +4067,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 	struct ata_host *host;
 	struct mv_host_priv *hpriv;
 	struct resource *res;
-	void __iomem *mmio;
 	int n_ports = 0, irq = 0;
 	int rc;
 	int port;
@@ -4086,9 +4085,8 @@ static int mv_platform_probe(struct platform_device *pdev)
 	 * Get the register base first
 	 */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mmio = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mmio))
-		return PTR_ERR(mmio);
+	if (res == NULL)
+		return -EINVAL;
 
 	/* allocate host */
 	if (pdev->dev.of_node) {
@@ -4132,7 +4130,12 @@ static int mv_platform_probe(struct platform_device *pdev)
 	hpriv->board_idx = chip_soc;
 
 	host->iomap = NULL;
-	hpriv->base = mmio - SATAHC0_REG_BASE;
+	hpriv->base = devm_ioremap(&pdev->dev, res->start,
+				   resource_size(res));
+	if (!hpriv->base)
+		return -ENOMEM;
+
+	hpriv->base -= SATAHC0_REG_BASE;
 
 	hpriv->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hpriv->clk))
-- 
2.9.4

