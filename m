Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75C4C433EF
	for <linux-ide@archiver.kernel.org>; Sun, 24 Apr 2022 09:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbiDXJZS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Apr 2022 05:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiDXJZR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2022 05:25:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97021906AD;
        Sun, 24 Apr 2022 02:22:15 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KmMzb5MlGzGnxb;
        Sun, 24 Apr 2022 17:19:39 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Apr 2022 17:22:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 17:22:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
CC:     <damien.lemoal@opensource.wdc.com>, <arnd@arndb.de>,
        <b.zolnierkie@samsung.com>, <robert.jarzmik@free.fr>
Subject: [PATCH -next] ata: palmld: fix return value check in palmld_pata_probe()
Date:   Sun, 24 Apr 2022 17:34:20 +0800
Message-ID: <20220424093420.2129779-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

If devm_platform_ioremap_resource() fails, it never return
NULL pointer, replace the check with IS_ERR().

Fixes: 57bf0f5a162d ("ARM: pxa: use pdev resource for palmld mmio")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
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

