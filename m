From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH v2] ata: pata_samsung_cf: Use devm_clk_get()
Date: Thu, 10 Jan 2013 11:05:06 +0900
Message-ID: <007401cdeed6$e9095f50$bb1c1df0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:10505 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758113Ab3AJCFH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2013 21:05:07 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MGE00D4N0FXUKI0@mailout3.samsung.com> for
 linux-ide@vger.kernel.org; Thu, 10 Jan 2013 11:05:06 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MGE006PF0GIIT30@mmp1.samsung.com> for
 linux-ide@vger.kernel.org; Thu, 10 Jan 2013 11:05:06 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Jeff Garzik' <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use devm_clk_get() rather than clk_get() to make cleanup paths
more simple.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Changes since v1:
- modified the commit message

 drivers/ata/pata_samsung_cf.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 63ffb00..70b0e01 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -512,7 +512,7 @@ static int __init pata_s3c_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	info->clk = clk_get(&pdev->dev, "cfcon");
+	info->clk = devm_clk_get(&pdev->dev, "cfcon");
 	if (IS_ERR(info->clk)) {
 		dev_err(dev, "failed to get access to cf controller clock\n");
 		ret = PTR_ERR(info->clk);
@@ -589,7 +589,6 @@ static int __init pata_s3c_probe(struct platform_device *pdev)
 
 stop_clk:
 	clk_disable(info->clk);
-	clk_put(info->clk);
 	return ret;
 }
 
@@ -601,7 +600,6 @@ static int __exit pata_s3c_remove(struct platform_device *pdev)
 	ata_host_detach(host);
 
 	clk_disable(info->clk);
-	clk_put(info->clk);
 
 	return 0;
 }
-- 
1.7.2.5


