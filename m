Return-Path: <SRS0=E8D3=C3=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1B8C43466
	for <linux-ide@archiver.kernel.org>; Fri, 18 Sep 2020 09:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F4A23600
	for <linux-ide@archiver.kernel.org>; Fri, 18 Sep 2020 09:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIRJhE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Sep 2020 05:37:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbgIRJhE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 18 Sep 2020 05:37:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE6456E85A48B8230523;
        Fri, 18 Sep 2020 17:36:58 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 17:36:56 +0800
From:   Qilong Zhang <zhangqilong3@huawei.com>
To:     <b.zolnierkie@samsung.com>, <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>
Subject: [PATCH -next] ata: pata_octeon_cf: indicate correct error reason in octeon_cf_probe
Date:   Fri, 18 Sep 2020 17:43:48 +0800
Message-ID: <20200918094348.110476-1-zhangqilong3@huawei.com>
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

It maybe call devm_ioremap to map device IO address to memory. When
devm_ioremap operation failed, we should return '-ENOMEM' instead of
'-EINVAL' to alert callers in this case, callers may have different
operation later. Moreover, '-EINVAL' will be confused with the
previous error code when getting resource failed.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/ata/pata_octeon_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index bd87476ab481..513998eaf15e 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -895,7 +895,7 @@ static int octeon_cf_probe(struct platform_device *pdev)
 									 resource_size(res_dma));
 				if (!cf_port->dma_base) {
 					of_node_put(dma_node);
-					return -EINVAL;
+					return -ENOMEM;
 				}
 
 				irq_handler = octeon_cf_interrupt;
-- 
2.17.1

