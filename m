Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C85C4320A
	for <linux-ide@archiver.kernel.org>; Tue, 27 Jul 2021 12:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BC4615A4
	for <linux-ide@archiver.kernel.org>; Tue, 27 Jul 2021 12:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhG0MvJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 27 Jul 2021 08:51:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:53479 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhG0MvI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 27 Jul 2021 08:51:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="212156607"
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="212156607"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 05:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="434720344"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Jul 2021 05:51:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2962EDE; Tue, 27 Jul 2021 15:51:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v1 1/1] ata: sata_dwc_460ex: No need to call phy_exit() befre phy_init()
Date:   Tue, 27 Jul 2021 15:51:30 +0300
Message-Id: <20210727125130.19977-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Last change to device managed APIs cleaned up error path to simple phy_exit()
call, which in some cases has been executed with NULL parameter. This per se
is not a problem, but rather logical misconception: no need to free resource
when it's for sure has not been allocated yet. Fix the driver accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index f0ef844428bb..338c2e50f759 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1259,24 +1259,20 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq == NO_IRQ) {
 		dev_err(&ofdev->dev, "no SATA DMA irq\n");
-		err = -ENODEV;
-		goto error_out;
+		return -ENODEV;
 	}
 
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	if (!of_find_property(np, "dmas", NULL)) {
 		err = sata_dwc_dma_init_old(ofdev, hsdev);
 		if (err)
-			goto error_out;
+			return err;
 	}
 #endif
 
 	hsdev->phy = devm_phy_optional_get(hsdev->dev, "sata-phy");
-	if (IS_ERR(hsdev->phy)) {
-		err = PTR_ERR(hsdev->phy);
-		hsdev->phy = NULL;
-		goto error_out;
-	}
+	if (IS_ERR(hsdev->phy))
+		return PTR_ERR(hsdev->phy);
 
 	err = phy_init(hsdev->phy);
 	if (err)
-- 
2.30.2

