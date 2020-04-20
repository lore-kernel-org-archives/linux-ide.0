Return-Path: <SRS0=Ota/=6E=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A597EC3815B
	for <linux-ide@archiver.kernel.org>; Mon, 20 Apr 2020 13:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7E720B1F
	for <linux-ide@archiver.kernel.org>; Mon, 20 Apr 2020 13:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgDTNwR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:52:17 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:4378 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgDTNwQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Apr 2020 09:52:16 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25e9da8f9a32-d6d3e; Mon, 20 Apr 2020 21:51:54 +0800 (CST)
X-RM-TRANSID: 2ee25e9da8f9a32-d6d3e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.173.179])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95e9da8f73fc-c6f20;
        Mon, 20 Apr 2020 21:51:54 +0800 (CST)
X-RM-TRANSID: 2ee95e9da8f73fc-c6f20
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     axboe@kernel.dk, b.zolnierkie@samsung.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ata: omit superfluous error message
Date:   Mon, 20 Apr 2020 21:53:42 +0800
Message-Id: <20200420135342.11984-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In the probe function, when get irq failed, the function
platform_get_irq() logs an error message, so remove
redundant message here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/ata/pata_rb532_cf.c | 4 +---
 drivers/ata/sata_highbank.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 479c4b29b..dcde84f57 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -115,10 +115,8 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "no IRQ resource found\n");
+	if (irq <= 0)
 		return -ENOENT;
-	}
 
 	gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_IN);
 	if (IS_ERR(gpiod)) {
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index ad3893c62..efd1925a9 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -469,10 +469,8 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "no irq\n");
+	if (irq <= 0)
 		return -EINVAL;
-	}
 
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv) {
-- 
2.20.1.windows.1



