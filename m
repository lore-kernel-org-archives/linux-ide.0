From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] Revert "ata: sata_mv: Convert to devm_ioremap_resource()"
Date: Wed, 24 May 2017 01:39:35 +0200
Message-ID: <1495582775-3717-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42293 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753927AbdEWXkD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 23 May 2017 19:40:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

This reverts commit 368e5fbdfc60732643f34f538823ed4bc8829827.

devm_ioremap_resource() enforces that there are no overlapping
resources, where as devm_ioremap() does not. The sata phy driver needs
a subset of the sata IO address space, so maps some of the sata
address space. As a result, sata_mv now fails to probe, reporting it
cannot get its resources, and so we don't have any SATA disks.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
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
2.11.0

