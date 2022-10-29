Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8C4C38A02
	for <linux-ide@archiver.kernel.org>; Sat, 29 Oct 2022 07:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ2Hui (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 29 Oct 2022 03:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJ2Huh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 29 Oct 2022 03:50:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8004BF5F
        for <linux-ide@vger.kernel.org>; Sat, 29 Oct 2022 00:50:34 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mzs0P3nMtzVjKf;
        Sat, 29 Oct 2022 15:45:41 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 15:50:33 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 29 Oct
 2022 15:50:32 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-ide@vger.kernel.org>
CC:     <s.shtylyov@omp.ru>, <damien.lemoal@opensource.wdc.com>,
        <arnd@arndb.de>, <axboe@kernel.dk>, <yangyingliang@huawei.com>
Subject: [PATCH RESEND] ata: palmld: fix return value check in palmld_pata_probe()
Date:   Sat, 29 Oct 2022 15:49:31 +0800
Message-ID: <20221029074931.3189275-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

If devm_platform_ioremap_resource() fails, it never return
NULL pointer, replace the check with IS_ERR().

Fixes: 57bf0f5a162d ("ARM: pxa: use pdev resource for palmld mmio")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
The previous patch link:
https://lore.kernel.org/lkml/15e09c18-792b-931c-11c7-5ef284490eba@huawei.com/T/#t
---
 drivers/ata/pata_palmld.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
index 400e65190904..51caa2a427dd 100644
--- a/drivers/ata/pata_palmld.c
+++ b/drivers/ata/pata_palmld.c
@@ -63,8 +63,8 @@ static int palmld_pata_probe(struct platform_device *pdev)
 
 	/* remap drive's physical memory address */
 	mem = devm_platform_ioremap_resource(pdev, 0);
-	if (!mem)
-		return -ENOMEM;
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
 
 	/* request and activate power and reset GPIOs */
 	lda->power = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);
-- 
2.25.1

