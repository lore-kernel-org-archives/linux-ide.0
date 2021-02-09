Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B24C433DB
	for <linux-ide@archiver.kernel.org>; Tue,  9 Feb 2021 08:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC8364E50
	for <linux-ide@archiver.kernel.org>; Tue,  9 Feb 2021 08:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBIIK7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 9 Feb 2021 03:10:59 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39472 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229611AbhBIIK7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 Feb 2021 03:10:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UOHlnoG_1612858215;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UOHlnoG_1612858215)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Feb 2021 16:10:15 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, joseph.qi@linux.alibaba.com,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH] ide: set missing QUEUE_FLAG_ADD_RANDOM
Date:   Tue,  9 Feb 2021 16:10:13 +0800
Message-Id: <20210209081013.38979-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

While the whole block layer has migrated to mq framework,
QUEUE_FLAG_ADD_RANDOM is not included in QUEUE_FLAG_MQ_DEFAULT as the
default flags.

Keep 'blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, ...)' there as the
statement is self explanatory. Besides it can make the code stronger
to keep a complete if-clear-else-set statement, no matter how
QUEUE_FLAG_MQ_DEFAULT could be refactored.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 drivers/ide/ide-disk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 34b9441084f8..7f19af48a6e7 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -688,6 +688,9 @@ static void ide_disk_setup(ide_drive_t *drive)
 	if (ata_id_is_ssd(id)) {
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
+	} else {
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+		blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
 	}
 
 	/* calculate drive capacity, and select LBA if possible */
-- 
2.27.0

