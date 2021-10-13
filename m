Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE72C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 13 Oct 2021 06:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923FF6008E
	for <linux-ide@archiver.kernel.org>; Wed, 13 Oct 2021 06:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhJMGTn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Oct 2021 02:19:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14341 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbhJMGTc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Oct 2021 02:19:32 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HThyn6Wthz90CG;
        Wed, 13 Oct 2021 14:12:33 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 14:17:23 +0800
Received: from huawei.com (10.175.104.82) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 14:17:23 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <hdegoede@redhat.com>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ata: ahci_platform: fix null-ptr-deref in ahci_platform_enable_regulators()
Date:   Wed, 13 Oct 2021 14:16:31 +0800
Message-ID: <20211013061631.2958938-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

I got a null-ptr-deref report:

KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
...
RIP: 0010:regulator_enable+0x84/0x260
...
Call Trace:
 ahci_platform_enable_regulators+0xae/0x320
 ahci_platform_enable_resources+0x1a/0x120
 ahci_probe+0x4f/0x1b9
 platform_probe+0x10b/0x280
...
 entry_SYSCALL_64_after_hwframe+0x44/0xae

If devm_regulator_get() in ahci_platform_get_resources() fails,
hpriv->phy_regulator will point to NULL, when enabling or disabling it,
null-ptr-deref will occur.

ahci_probe()
	ahci_platform_get_resources()
		devm_regulator_get(, "phy") // failed, let phy_regulator = NULL
	ahci_platform_enable_resources()
		ahci_platform_enable_regulators()
			regulator_enable(hpriv->phy_regulator) // null-ptr-deref

commit 962399bb7fbf ("ata: libahci_platform: Fix regulator_get_optional()
misuse") replaces devm_regulator_get_optional() with devm_regulator_get(),
but PHY regulator omits to delete "hpriv->phy_regulator = NULL;" like AHCI.
Delete it like AHCI regulator to fix this bug.

Fixes: commit 962399bb7fbf ("ata: libahci_platform: Fix regulator_get_optional() misuse")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/ata/libahci_platform.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index b2f552088291..0910441321f7 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -440,10 +440,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	hpriv->phy_regulator = devm_regulator_get(dev, "phy");
 	if (IS_ERR(hpriv->phy_regulator)) {
 		rc = PTR_ERR(hpriv->phy_regulator);
-		if (rc == -EPROBE_DEFER)
-			goto err_out;
-		rc = 0;
-		hpriv->phy_regulator = NULL;
+		goto err_out;
 	}
 
 	if (flags & AHCI_PLATFORM_GET_RESETS) {
-- 
2.17.1

