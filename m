From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] ata: pata_samsung_cf: Use devm_clk_get()
Date: Wed, 09 Jan 2013 10:22:41 +0900
Message-ID: <002c01cdee07$d1ddacc0$75990640$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35587 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860Ab3AIBWx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2013 20:22:53 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MGC00H763STJV80@mailout4.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 09 Jan 2013 10:22:41 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MGC0042W3TTX360@mmp2.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 09 Jan 2013 10:22:41 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Jeff Garzik' <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

The devm_ functions allocate memory that is released when a driver
detaches. This patch uses devm_clk_get() for these functions.
These make the code smaller and a bit simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
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


