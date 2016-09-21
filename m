From: Harman Kalra <harman4linux@gmail.com>
Subject: [PATCH] Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR. Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR.
Date: Thu, 22 Sep 2016 01:18:31 +0530
Message-ID: <1474487311-3897-1-git-send-email-harman4linux@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Harman Kalra <harman4linux@gmail.com>
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Harman Kalra <harman4linux@gmail.com>
---
 drivers/ata/pata_at91.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index 9f27b14..1611e0e 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -347,10 +347,8 @@ static int at91sam9_smc_fields_init(struct device *dev)
 
 	field.reg = AT91SAM9_SMC_MODE(AT91SAM9_SMC_GENERIC);
 	fields.mode = devm_regmap_field_alloc(dev, smc, field);
-	if (IS_ERR(fields.mode))
-		return PTR_ERR(fields.mode);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(fields.mode);
 }
 
 static int pata_at91_probe(struct platform_device *pdev)
-- 
1.7.9.5
