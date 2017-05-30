From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6/6] ata: sata_fsl: cut drvdata assignment
Date: Tue, 30 May 2017 11:46:44 +0200
Message-ID: <20170530094644.15566-6-linus.walleij@linaro.org>
References: <20170530094644.15566-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36695 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdE3JrJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2017 05:47:09 -0400
Received: by mail-lf0-f43.google.com with SMTP id h4so46052630lfj.3
        for <linux-ide@vger.kernel.org>; Tue, 30 May 2017 02:47:08 -0700 (PDT)
In-Reply-To: <20170530094644.15566-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

ata_host_alloc_pinfo() assigns the host pointer to the
struct device * drvdata, do not assign it a second time.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/ata/sata_fsl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 01734d54c69c..95bf3abda6f6 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1523,8 +1523,6 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	ata_host_activate(host, irq, sata_fsl_interrupt, SATA_FSL_IRQ_FLAG,
 			  &sata_fsl_sht);
 
-	platform_set_drvdata(ofdev, host);
-
 	host_priv->intr_coalescing.show = fsl_sata_intr_coalescing_show;
 	host_priv->intr_coalescing.store = fsl_sata_intr_coalescing_store;
 	sysfs_attr_init(&host_priv->intr_coalescing.attr);
-- 
2.9.4

