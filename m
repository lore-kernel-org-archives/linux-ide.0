From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/2] pata_imx: Propagate the real error code on platform_get_irq() failure
Date: Mon, 17 Feb 2014 19:05:57 -0300
Message-ID: <1392674757-1788-2-git-send-email-festevam@gmail.com>
References: <1392674757-1788-1-git-send-email-festevam@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:65008 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbaBQWGw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Feb 2014 17:06:52 -0500
Received: by mail-yh0-f51.google.com with SMTP id t59so14569704yho.38
        for <linux-ide@vger.kernel.org>; Mon, 17 Feb 2014 14:06:51 -0800 (PST)
In-Reply-To: <1392674757-1788-1-git-send-email-festevam@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

No need to return a 'fake' return value on platform_get_irq() failure.

Just return the error code itself instead.

Also, change the error condition to irq < 0, so that only negative values
are treated as errors.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Only return error on negative values

 drivers/ata/pata_imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 3668e78..fa8e69c 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -100,8 +100,8 @@ static int pata_imx_probe(struct platform_device *pdev)
 	int ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -EINVAL;
+	if (irq < 0)
+		return irq;
 
 	priv = devm_kzalloc(&pdev->dev,
 				sizeof(struct pata_imx_priv), GFP_KERNEL);
-- 
1.8.1.2

