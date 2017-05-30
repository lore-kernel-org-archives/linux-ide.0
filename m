From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/6] ata: bf54x: cut drvdata assignment
Date: Tue, 30 May 2017 11:46:39 +0200
Message-ID: <20170530094644.15566-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36592 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdE3Jqw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2017 05:46:52 -0400
Received: by mail-lf0-f42.google.com with SMTP id h4so46048252lfj.3
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2017 02:46:51 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

ata_host_alloc_pinfo() assigns the host pointer to the
struct device * drvdata, do not assign it a second time.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/pata_bf54x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 9c5780a7e1b9..0e55a8da2748 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1597,8 +1597,6 @@ static int bfin_atapi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	platform_set_drvdata(pdev, host);
-
 	return 0;
 }
 
-- 
2.9.4

