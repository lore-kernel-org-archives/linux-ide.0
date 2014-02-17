From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/2] pata_imx: Use devm_ioremap_resource() to simplify code
Date: Mon, 17 Feb 2014 19:05:56 -0300
Message-ID: <1392674757-1788-1-git-send-email-festevam@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36104 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbaBQWGu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Feb 2014 17:06:50 -0500
Received: by mail-yk0-f170.google.com with SMTP id 9so31206683ykp.1
        for <linux-ide@vger.kernel.org>; Mon, 17 Feb 2014 14:06:50 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_ioremap_resource() can lead to code simplication, as we don't need
to explicitily check for error returned by platform_get_resource().

Also, no need to print an error message when devm_ioremap_resource() fails,
as the OOM code code will shout loudly on such condition.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 drivers/ata/pata_imx.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 7e69797..3668e78 100644
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
@@ -135,10 +131,9 @@ static int pata_imx_probe(struct platform_device *pdev)
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

