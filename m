Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF082C47082
	for <linux-ide@archiver.kernel.org>; Sat, 29 May 2021 06:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5449613B4
	for <linux-ide@archiver.kernel.org>; Sat, 29 May 2021 06:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhE2GJt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 29 May 2021 02:09:49 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2344 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhE2GJs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 29 May 2021 02:09:48 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FsWFZ33pqz1BFgV;
        Sat, 29 May 2021 14:03:30 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 14:08:04 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 29 May
 2021 14:08:03 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <davem@davemloft.net>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] ide-cd: fix warning: variable 'stat' set but not used
Date:   Sat, 29 May 2021 14:17:29 +0800
Message-ID: <20210529061729.2824082-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/ide/ide-cd_ioctl.c: In function 'ide_cdrom_select_speed':
drivers/ide/ide-cd_ioctl.c:212:6: warning:
 variable ‘stat’ set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/ide/ide-cd_ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 011eab9c69b7..8d0a52123349 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -231,6 +231,8 @@ int ide_cdrom_select_speed(struct cdrom_device_info *cdi, int speed)
 	}
 
 	stat = ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, NULL, 0, 0);
+	if (stat)
+		return stat;
 
 	if (!ide_cdrom_get_capabilities(drive, buf)) {
 		ide_cdrom_update_speed(drive, buf);
-- 
2.25.4

