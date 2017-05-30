From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/6] ata: ep93xx: cut drvdata assignment
Date: Tue, 30 May 2017 11:46:40 +0200
Message-ID: <20170530094644.15566-2-linus.walleij@linaro.org>
References: <20170530094644.15566-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34291 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdE3Jqy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2017 05:46:54 -0400
Received: by mail-lf0-f43.google.com with SMTP id 99so46053652lfu.1
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2017 02:46:54 -0700 (PDT)
In-Reply-To: <20170530094644.15566-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

ata_host_alloc_pinfo() assigns the host pointer to the
struct device * drvdata, do not assign drv_data like this.
Since ata_host_alloc_pinfo() is called after this site, the
correct value is set eventually, but this assignment is just
plain pointless.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/pata_ep93xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index bf1b910c5d69..0a550190955a 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -944,7 +944,6 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 		goto err_rel_gpio;
 	}
 
-	platform_set_drvdata(pdev, drv_data);
 	drv_data->pdev = pdev;
 	drv_data->ide_base = ide_base;
 	drv_data->udma_in_phys = mem_res->start + IDEUDMADATAIN;
-- 
2.9.4

