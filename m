From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [V1] ata: sata_mv:- Handle return value of devm_ioremap.
Date: Mon, 12 Dec 2016 23:13:27 +0530
Message-ID: <1481564607-9626-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36354 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbcLLRnp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Dec 2016 12:43:45 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Here, If devm_ioremap will fail. It will return NULL.
Then hpriv->base = NULL - 0x20000; Kernel can run into
a NULL-pointer dereference. This error check will avoid
NULL pointer dereference.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ata/sata_mv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index efc48bf..9d0cdad 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4119,6 +4119,9 @@ static int mv_platform_probe(struct platform_device *pdev)
 	host->iomap = NULL;
 	hpriv->base = devm_ioremap(&pdev->dev, res->start,
 				   resource_size(res));
+	if (!hpriv->base)
+		return -ENOMEM;
+
 	hpriv->base -= SATAHC0_REG_BASE;
 
 	hpriv->clk = clk_get(&pdev->dev, NULL);
-- 
2.7.4

