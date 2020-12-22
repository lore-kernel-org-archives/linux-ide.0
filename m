Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A30BC433E0
	for <linux-ide@archiver.kernel.org>; Tue, 22 Dec 2020 12:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F24323137
	for <linux-ide@archiver.kernel.org>; Tue, 22 Dec 2020 12:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgLVMmy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Dec 2020 07:42:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9546 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgLVMmx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Dec 2020 07:42:53 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D0bYh5WXczhwlb;
        Tue, 22 Dec 2020 20:41:28 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 20:42:04 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <axboe@kernel.dk>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] ata/pata_macio: use DIV_ROUND_UP macro to do calculation
Date:   Tue, 22 Dec 2020 20:42:36 +0800
Message-ID: <20201222124236.18998-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Don't open-code DIV_ROUND_UP() kernel macro.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/ata/pata_macio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index e47a28271f5b..43f11d991df2 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -84,8 +84,8 @@ static const char* macio_ata_names[] = {
  */
 
 /* Number of IDE_SYSCLK_NS ticks, argument is in nanoseconds */
-#define SYSCLK_TICKS(t)		(((t) + IDE_SYSCLK_NS - 1) / IDE_SYSCLK_NS)
-#define SYSCLK_TICKS_66(t)	(((t) + IDE_SYSCLK_66_NS - 1) / IDE_SYSCLK_66_NS)
+#define SYSCLK_TICKS(t)		DIV_ROUND_UP(t, IDE_SYSCLK_NS)
+#define SYSCLK_TICKS_66(t)	DIV_ROUND_UP(t, IDE_SYSCLK_66_NS)
 #define IDE_SYSCLK_NS		30	/* 33Mhz cell */
 #define IDE_SYSCLK_66_NS	15	/* 66Mhz cell */
 
-- 
2.22.0

