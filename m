From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] pata_imx: Use devm_ioremap_resource() to simplify code
Date: Sat, 15 Feb 2014 10:50:33 -0200
Message-ID: <1392468635-13373-1-git-send-email-festevam@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:32802 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbaBOMvL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Feb 2014 07:51:11 -0500
Received: by mail-yh0-f51.google.com with SMTP id t59so12659949yho.38
        for <linux-ide@vger.kernel.org>; Sat, 15 Feb 2014 04:51:10 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_ioremap_resource() can lead to code simplication, as we don't need
to explicitily check for error returned by platform_get_resource().

Also, no need to print an error message when devm_ioremap_resource() fails,
as the OOM code code will shout loudly on such condition.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/ata/pata_imx.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 97417d5..50e2cf2 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -99,10 +99,6 @@ static int pata_imx_probe(struct platform_device *pdev)
 	struct resource *io_res;
 	int ret;
 
-	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (io_res == NULL)
-		return -EINVAL;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0)
 		return -EINVAL;
@@ -133,10 +129,9 @@ static int pata_imx_probe(struct platform_device *pdev)
 	ap->pio_mask = ATA_PIO0;
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 
-	priv->host_regs = devm_ioremap(&pdev->dev, io_res->start,
-		resource_size(io_res));
+	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->host_regs = devm_ioremap_resource(&pdev->dev, io_res);
 	if (!priv->host_regs) {
-		dev_err(&pdev->dev, "failed to map IO/CTL base\n");
 		ret = -EBUSY;
 		goto err;
 	}
-- 
1.8.1.2

