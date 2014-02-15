From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] pata_imx: Propagate the real error code on platform_get_irq() failure
Date: Sat, 15 Feb 2014 10:50:34 -0200
Message-ID: <1392468635-13373-2-git-send-email-festevam@gmail.com>
References: <1392468635-13373-1-git-send-email-festevam@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:42595 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbaBOMvM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Feb 2014 07:51:12 -0500
Received: by mail-yk0-f169.google.com with SMTP id 142so26246521ykq.0
        for <linux-ide@vger.kernel.org>; Sat, 15 Feb 2014 04:51:12 -0800 (PST)
In-Reply-To: <1392468635-13373-1-git-send-email-festevam@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

No need to return a 'fake' return value on platform_get_irq() failure.

Just return the error code itself instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/ata/pata_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 50e2cf2..1af71b7 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -101,7 +101,7 @@ static int pata_imx_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0)
-		return -EINVAL;
+		return irq;
 
 	priv = devm_kzalloc(&pdev->dev,
 				sizeof(struct pata_imx_priv), GFP_KERNEL);
-- 
1.8.1.2

