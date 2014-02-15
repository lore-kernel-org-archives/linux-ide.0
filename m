From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/3] pata_imx: Check the return value from clk_prepare_enable()
Date: Sat, 15 Feb 2014 10:50:35 -0200
Message-ID: <1392468635-13373-3-git-send-email-festevam@gmail.com>
References: <1392468635-13373-1-git-send-email-festevam@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:51345 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbaBOMvO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Feb 2014 07:51:14 -0500
Received: by mail-yh0-f52.google.com with SMTP id a41so12685946yho.11
        for <linux-ide@vger.kernel.org>; Sat, 15 Feb 2014 04:51:13 -0800 (PST)
In-Reply-To: <1392468635-13373-1-git-send-email-festevam@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so let's check its return value and propagate it
in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/ata/pata_imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 1af71b7..7b669f6 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -114,7 +114,9 @@ static int pata_imx_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->clk);
 	}
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	host = ata_host_alloc(&pdev->dev, 1);
 	if (!host) {
-- 
1.8.1.2

