From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/6] ata: rb532_cf: cut drvdata assignment
Date: Tue, 30 May 2017 11:46:42 +0200
Message-ID: <20170530094644.15566-4-linus.walleij@linaro.org>
References: <20170530094644.15566-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34327 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdE3JrB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2017 05:47:01 -0400
Received: by mail-lf0-f44.google.com with SMTP id 99so46055168lfu.1
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2017 02:47:00 -0700 (PDT)
In-Reply-To: <20170530094644.15566-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

ata_host_alloc_pinfo() assigns the host pointer to the
struct device * drvdata, do not assign it a second time.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/pata_rb532_cf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index c8b6a780a290..653b9a0bf727 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -148,8 +148,6 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 	if (!ah)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, ah);
-
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.9.4

