Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47ADC433E0
	for <linux-ide@archiver.kernel.org>; Mon, 15 Mar 2021 02:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA9364E38
	for <linux-ide@archiver.kernel.org>; Mon, 15 Mar 2021 02:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCOCtF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 14 Mar 2021 22:49:05 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:38160 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhCOCtE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 14 Mar 2021 22:49:04 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Mar 2021 22:49:04 EDT
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 74C50E0203;
        Mon, 15 Mar 2021 10:39:30 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH V3] ata: sata_highbank: delete redundant print and fix return value
Date:   Mon, 15 Mar 2021 10:39:14 +0800
Message-Id: <1615775955-4400-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQx9PGUIdQkgaGR5DVkpNSk5MTE5CTEtNQk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6GDo4Hz8OTFY*PCpWMDJR
        Vk0aCjZVSlVKTUpOTExOQkxKTk9CVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTk9JNwY+
X-HM-Tid: 0a7833c0b5332c17kusn74c50e0203
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

platform_get_irq() has already checked and printed the return value, 
the printing here is nothing special, and should corrected to < 0.

Also, thhe return value should return a real error.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/ata/sata_highbank.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 64b2ef1..4438ee6
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -469,10 +469,8 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "no irq\n");
-		return -EINVAL;
-	}
+	if (irq < 0)
+		return irq;
 
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv) {
-- 
2.7.4

