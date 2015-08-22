From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH] ata: pata_arasam_cf: Use devm_clk_get
Date: Sat, 22 Aug 2015 09:04:50 +0530
Message-ID: <20150822033450.GA11692@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This patch introduces the use of managed resource function
devm_clk_get instead of clk_get and removes corresponding call
to clk_put in the remove function.

To be compatible with the change various gotos are replaced with
direct returns, and unneeded label is dropped.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/ata/pata_arasan_cf.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 5d9ee99..80fe0f6 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -834,7 +834,7 @@ static int arasan_cf_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	acdev->clk = clk_get(&pdev->dev, NULL);
+	acdev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(acdev->clk)) {
 		dev_warn(&pdev->dev, "Clock not found\n");
 		return PTR_ERR(acdev->clk);
@@ -843,9 +843,8 @@ static int arasan_cf_probe(struct platform_device *pdev)
 	/* allocate host */
 	host = ata_host_alloc(&pdev->dev, 1);
 	if (!host) {
-		ret = -ENOMEM;
 		dev_warn(&pdev->dev, "alloc host fail\n");
-		goto free_clk;
+		return -ENOMEM;
 	}
 
 	ap = host->ports[0];
@@ -894,7 +893,7 @@ static int arasan_cf_probe(struct platform_device *pdev)
 
 	ret = cf_init(acdev);
 	if (ret)
-		goto free_clk;
+		return ret;
 
 	cf_card_detect(acdev, 0);
 
@@ -904,8 +903,7 @@ static int arasan_cf_probe(struct platform_device *pdev)
 		return 0;
 
 	cf_exit(acdev);
-free_clk:
-	clk_put(acdev->clk);
+
 	return ret;
 }
 
@@ -916,7 +914,6 @@ static int arasan_cf_remove(struct platform_device *pdev)
 
 	ata_host_detach(host);
 	cf_exit(acdev);
-	clk_put(acdev->clk);
 
 	return 0;
 }
-- 
1.9.1
