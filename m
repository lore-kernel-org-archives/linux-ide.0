Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DE4C433B4
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 09:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6CE613A7
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 09:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbhDGJ1k (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 05:27:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16374 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbhDGJ1k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2021 05:27:40 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFfBs24RjzlVmk;
        Wed,  7 Apr 2021 17:25:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 17:27:21 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "David S . Miller" <davem@davemloft.net>,
        linux-ide <linux-ide@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/1] ide: remove unused static variable 'ide_media_proc_fops'
Date:   Wed, 7 Apr 2021 17:27:02 +0800
Message-ID: <20210407092702.2868-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning:

drivers/ide/ide-proc.c:457:37: warning: ‘ide_media_proc_fops’ defined but not used [-Wunused-const-variable=]

The reference to the variable 'ide_media_proc_fops' is deleted by
commit ec7d9c9ce897 ("ide: replace ->proc_fops with ->proc_show").

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/ide/ide-proc.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 15c17f3781ee917..34bed14f88c78b3 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -449,19 +449,6 @@ static int ide_media_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ide_media_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ide_media_proc_show, PDE_DATA(inode));
-}
-
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
1.8.3


