Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B171FC433E6
	for <linux-ide@archiver.kernel.org>; Mon, 15 Mar 2021 02:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757F964E5C
	for <linux-ide@archiver.kernel.org>; Mon, 15 Mar 2021 02:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCOCZU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 14 Mar 2021 22:25:20 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:57398 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhCOCY7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 14 Mar 2021 22:24:59 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.228])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 91A5F4001C7;
        Mon, 15 Mar 2021 10:24:55 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH V2] ata: sata_highbank: delete redundant print and fix return value
Date:   Mon, 15 Mar 2021 10:24:49 +0800
Message-Id: <1615775089-31211-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHx9IHktMQ0lNTR1DVkpNSk5MTE5LQk5DTU5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6My46GBw6Sj8QH1Y2FwMLPwFN
        Kj4wFBBVSlVKTUpOTExOS0JNTEpPVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUNZV1kIAVlBSk5JSjcG
X-HM-Tid: 0a7833b35becd991kuws91a5f4001c7
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

platform_get_irq() has already checked and printed the return value, 
the printing here is nothing special, and should corrected to < 0.

Also, thhe return value should return a real error.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/ata/sata_highbank.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 64b2ef1..a43d42a
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -469,10 +469,8 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "no irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv) {
-- 
2.7.4

