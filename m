Return-Path: <SRS0=E8D3=C3=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C13C43463
	for <linux-ide@archiver.kernel.org>; Fri, 18 Sep 2020 12:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01B12311A
	for <linux-ide@archiver.kernel.org>; Fri, 18 Sep 2020 12:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIRMt5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Sep 2020 08:49:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgIRMt5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 18 Sep 2020 08:49:57 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1535C833ACD271E2DAB4;
        Fri, 18 Sep 2020 20:49:55 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 20:49:51 +0800
From:   Qilong Zhang <zhangqilong3@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-ide@vger.kernel.org>
Subject: [PATCH -next] ide: add the return pointer check for plat_ide_probe
Date:   Fri, 18 Sep 2020 20:56:45 +0800
Message-ID: <20200918125645.17309-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Zhang Qilong <zhangqilong3@huawei.com>

If io map failed in devm_ioremap/devm_ioport_map, base
or alt_base will be null, it will cause setup port error
later but it won't be found out in plat_ide_setup_ports.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/ide/ide_platform.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
index 91639fd6c276..fdbc565ef142 100644
--- a/drivers/ide/ide_platform.c
+++ b/drivers/ide/ide_platform.c
@@ -86,6 +86,11 @@ static int plat_ide_probe(struct platform_device *pdev)
 			res_alt->start, resource_size(res_alt));
 	}
 
+	if (!base || !alt_base) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	memset(&hw, 0, sizeof(hw));
 	plat_ide_setup_ports(&hw, base, alt_base, pdata, res_irq->start);
 	hw.dev = &pdev->dev;
-- 
2.17.1

