Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE67C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Sep 2021 13:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2581160F6C
	for <linux-ide@archiver.kernel.org>; Thu,  9 Sep 2021 13:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353673AbhIINOJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Sep 2021 09:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358576AbhIINHm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 9 Sep 2021 09:07:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7567E632B7;
        Thu,  9 Sep 2021 12:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188848;
        bh=jPGEr1EC2+HHaLNPtUz9CSaQdO6KEsdnSX9I3vZvuc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpDTK+6xmn72jSowSx4lg+hmgm9C1tQkd9PKZcAGRix1KmBPlXeQB6lWcuovEDEmR
         yECPtLesF8Os8tHJMm4wP2YunWBQb+dXCAuXl1BbZ2Gq9QWqHI0P2GU5SzCK74ubIf
         39UvyiG2A1dCSqSbKxbVQLs5HAOtXG9OLQrigi2tTT7KcYWPgD4KjqzuUplMFDttmT
         e1oLr9Y8n2gaAB27vC0fWRBmt4433EM5leNbHtUyjLdFgsimlc/SX6Cdz7kT8tAUz1
         aXf06OemZMyXjOfXPdKFoCuKsTrMTS+dRUuOJ5L1yqD/nVd2Hs3QMobkd3B6SJ7TzH
         CiKPAwSBkIC4A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 26/48] ata: sata_dwc_460ex: No need to call phy_exit() befre phy_init()
Date:   Thu,  9 Sep 2021 07:59:53 -0400
Message-Id: <20210909120015.150411-26-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909120015.150411-1-sashal@kernel.org>
References: <20210909120015.150411-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 3ad4a31620355358316fa08fcfab37b9d6c33347 ]

Last change to device managed APIs cleaned up error path to simple phy_exit()
call, which in some cases has been executed with NULL parameter. This per se
is not a problem, but rather logical misconception: no need to free resource
when it's for sure has not been allocated yet. Fix the driver accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20210727125130.19977-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_dwc_460ex.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index e0939bd5ea73..6797871f8bc6 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1253,24 +1253,20 @@ static int sata_dwc_probe(struct platform_device *ofdev)
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

