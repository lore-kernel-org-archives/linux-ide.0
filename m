Return-Path: <SRS0=jz0E=C7=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B63C4727E
	for <linux-ide@archiver.kernel.org>; Tue, 22 Sep 2020 11:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B27F221EB
	for <linux-ide@archiver.kernel.org>; Tue, 22 Sep 2020 11:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgIVLS5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Sep 2020 07:18:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbgIVLS4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 22 Sep 2020 07:18:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33E77EE2DB2D97553BC3;
        Tue, 22 Sep 2020 19:18:53 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 22 Sep 2020
 19:18:50 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ide: Remove set but not used variable
Date:   Tue, 22 Sep 2020 19:18:49 +0800
Message-ID: <1600773529-45805-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This addresses the following gcc warning with "make W=1":

drivers/ide/ide-proc.c:457:37: warning:
‘ide_media_proc_fops’ defined but not used [-Wunused-const-variable=]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/ide/ide-proc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 15c17f3..2fad809 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -454,14 +454,6 @@ static int ide_media_proc_open(struct inode *inode, struct file *file)
 	return single_open(file, ide_media_proc_show, PDE_DATA(inode));
 }

-static const struct file_operations ide_media_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_media_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static ide_proc_entry_t generic_drive_entries[] = {
 	{ "driver",	S_IFREG|S_IRUGO,	 ide_driver_proc_show	},
 	{ "identify",	S_IFREG|S_IRUSR,	 ide_identify_proc_show	},
--
2.7.4

