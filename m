From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] ata: pata_samsung_cf: Use devm_ioremap_resource()
Date: Thu, 02 Jan 2014 17:24:03 +0900
Message-ID: <002901cf0793$fea8dc60$fbfa9520$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:52431 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbaABIYF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jan 2014 03:24:05 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MYR00HV8M03RN90@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Thu, 02 Jan 2014 17:24:03 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use devm_ioremap_resource() in order to make the code simpler,
and remove redundant return value check of platform_get_resource()
because the value is checked by devm_ioremap_resource().

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ata/pata_samsung_cf.c |   18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index e04d70b..9a7798b 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -495,22 +495,10 @@ static int __init pata_s3c_probe(struct platform_device *pdev)
 	info->irq = platform_get_irq(pdev, 0);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(dev, "failed to get mem resource\n");
-		return -EINVAL;
-	}
-
-	if (!devm_request_mem_region(dev, res->start,
-				resource_size(res), DRV_NAME)) {
-		dev_err(dev, "error requesting register region\n");
-		return -EBUSY;
-	}
 
-	info->ide_addr = devm_ioremap(dev, res->start, resource_size(res));
-	if (!info->ide_addr) {
-		dev_err(dev, "failed to map IO base address\n");
-		return -ENOMEM;
-	}
+	info->ide_addr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(info->ide_addr))
+		return PTR_ERR(info->ide_addr);
 
 	info->clk = devm_clk_get(&pdev->dev, "cfcon");
 	if (IS_ERR(info->clk)) {
-- 
1.7.10.4


