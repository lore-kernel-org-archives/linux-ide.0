From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] sata_rcar: fix error return code in sata_rcar_probe()
Date: Fri, 30 Jun 2017 00:22:10 -0500
Message-ID: <20170630052210.GA19186@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway20.websitewelcome.com ([192.185.58.11]:13622 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751333AbdF3FoN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2017 01:44:13 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 727A340C2D0CD
        for <linux-ide@vger.kernel.org>; Fri, 30 Jun 2017 00:22:11 -0500 (CDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Print error message and propagate the return value of
platform_get_irq on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/ata/sata_rcar.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index ee98447..c936b2a 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -872,8 +872,10 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	int ret = 0;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -EINVAL;
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ\n");
+		return irq;
+	}
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct sata_rcar_priv),
 			   GFP_KERNEL);
-- 
2.5.0

