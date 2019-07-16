Return-Path: <SRS0=eAlM=VN=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC43C76188
	for <linux-ide@archiver.kernel.org>; Tue, 16 Jul 2019 10:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B51B20665
	for <linux-ide@archiver.kernel.org>; Tue, 16 Jul 2019 10:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfGPKE3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 Jul 2019 06:04:29 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:2534 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfGPKE3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jul 2019 06:04:29 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jul 2019 06:04:28 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95d2d9ec7b16-70d88; Tue, 16 Jul 2019 17:54:15 +0800 (CST)
X-RM-TRANSID: 2ee95d2d9ec7b16-70d88
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15d2d9ec64dd-4d454;
        Tue, 16 Jul 2019 17:54:15 +0800 (CST)
X-RM-TRANSID: 2ee15d2d9ec64dd-4d454
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     hdegoede@redhat.com, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: libahci_platform: remove redundant dev_err message
Date:   Tue, 16 Jul 2019 17:54:08 +0800
Message-Id: <1563270848-11223-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/ata/libahci_platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 72312ad..3a36e76 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -408,7 +408,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	hpriv->mmio = devm_ioremap_resource(dev,
 			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
 	if (IS_ERR(hpriv->mmio)) {
-		dev_err(dev, "no mmio space\n");
 		rc = PTR_ERR(hpriv->mmio);
 		goto err_out;
 	}
-- 
1.9.1



