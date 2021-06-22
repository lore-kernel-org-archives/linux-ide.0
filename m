Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BABC48BDF
	for <linux-ide@archiver.kernel.org>; Tue, 22 Jun 2021 11:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562F8613B2
	for <linux-ide@archiver.kernel.org>; Tue, 22 Jun 2021 11:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhFVL6z (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Jun 2021 07:58:55 -0400
Received: from m12-15.163.com ([220.181.12.15]:55750 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhFVL6y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 22 Jun 2021 07:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Jgksr
        hAdBjr9MyPioSmjSvk6KV8xAoO8ZdxqqdqY+1E=; b=CLTohQGVHBgR15DWCRLR2
        rFo93knj94oP9ciYxljZ8spv67ZUz4UFdarN03BwOLckDALsx14thUrBfZpZKl+K
        pxLaPFXU1egta6oyKJF6SAHbSJIyPNIrWfHKVMmlTVKRRcFZuFGmBWE55qQ5n4Px
        wluxPfnbFbwIUu6RssyMFg=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp11 (Coremail) with SMTP id D8CowABXq9ydz9FgGq2kAA--.119S2;
        Tue, 22 Jun 2021 19:56:13 +0800 (CST)
From:   13145886936@163.com
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ata: rb532_cf: remove redundant codes
Date:   Tue, 22 Jun 2021 04:55:07 -0700
Message-Id: <20210622115507.359017-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowABXq9ydz9FgGq2kAA--.119S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr18JFy7JF13tF15WFyxAFb_yoW3CFX_XF
        4UuryfWrWFyr1xXa4Ut3Wavry2k3Z5WFn09FyvyFyftry5Jr43tayqqrs3Gr4vgw18tF9I
        grWYy3yfCF1ayjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU55CztUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBRxm5g1PADJltYQAAsu
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

The codes "dev_err(&pdev->dev, "no IRQ resource found\n");" is
redundant because platform_get_irq() already prints an error.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 drivers/ata/pata_rb532_cf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 303f8c375b3a..2e110aefe59b 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -115,10 +115,8 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ resource found\n");
+	if (irq < 0)
 		return irq;
-	}
 	if (!irq)
 		return -EINVAL;
 
-- 
2.25.1

