Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C00C433E0
	for <linux-ide@archiver.kernel.org>; Wed,  3 Feb 2021 02:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E22F64F59
	for <linux-ide@archiver.kernel.org>; Wed,  3 Feb 2021 02:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhBCC0e (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Feb 2021 21:26:34 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48737 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231641AbhBCC0d (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2021 21:26:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UNiztUM_1612319149;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNiztUM_1612319149)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Feb 2021 10:25:50 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] ide: remove unneeded semicolon
Date:   Wed,  3 Feb 2021 10:25:48 +0800
Message-Id: <1612319148-110936-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/ide/ide-taskfile.c:167:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ide/ide-taskfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index d016cbe..60d8fa1 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -164,7 +164,7 @@ static ide_startstop_t task_no_data_intr(ide_drive_t *drive)
 		if ((stat & ATA_BUSY) == 0 || retries-- == 0)
 			break;
 		udelay(10);
-	};
+	}
 
 	if (!OK_STAT(stat, ATA_DRDY, BAD_STAT)) {
 		if (custom && tf->command == ATA_CMD_SET_MULTI) {
-- 
1.8.3.1

