From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/6] ata: dwc_460ex: cut drvdata assignment
Date: Tue, 30 May 2017 11:46:41 +0200
Message-ID: <20170530094644.15566-3-linus.walleij@linaro.org>
References: <20170530094644.15566-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36624 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdE3Jq5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2017 05:46:57 -0400
Received: by mail-lf0-f43.google.com with SMTP id h4so46049615lfj.3
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2017 02:46:56 -0700 (PDT)
In-Reply-To: <20170530094644.15566-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

ata_host_alloc_pinfo() assigns the host pointer to the
struct device * drvdata, do not assign it a second time.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/sata_dwc_460ex.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index e0939bd5ea73..ce128d5a6ded 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1285,7 +1285,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	if (err)
 		dev_err(&ofdev->dev, "failed to activate host");
 
-	dev_set_drvdata(&ofdev->dev, host);
 	return 0;
 
 error_out:
-- 
2.9.4

