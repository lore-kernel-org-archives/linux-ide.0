From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/6] ata: samsung_cf: cut drvdata assignment
Date: Tue, 30 May 2017 11:46:43 +0200
Message-ID: <20170530094644.15566-5-linus.walleij@linaro.org>
References: <20170530094644.15566-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34344 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdE3JrD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2017 05:47:03 -0400
Received: by mail-lf0-f54.google.com with SMTP id 99so46055890lfu.1
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2017 02:47:03 -0700 (PDT)
In-Reply-To: <20170530094644.15566-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

ata_host_alloc_pinfo() assigns the host pointer to the
struct device * drvdata, do not assign it a second time.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/pata_samsung_cf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 431c7de30ce6..50801c40b029 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -582,8 +582,6 @@ static int __init pata_s3c_probe(struct platform_device *pdev)
 	/* Set endianness and enable the interface */
 	pata_s3c_hwinit(info, pdata);
 
-	platform_set_drvdata(pdev, host);
-
 	ret = ata_host_activate(host, info->irq,
 				info->irq ? pata_s3c_irq : NULL,
 				0, &pata_s3c_sht);
-- 
2.9.4

