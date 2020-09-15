Return-Path: <SRS0=lv1h=CY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F60C43461
	for <linux-ide@archiver.kernel.org>; Tue, 15 Sep 2020 03:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B2920897
	for <linux-ide@archiver.kernel.org>; Tue, 15 Sep 2020 03:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgIODD5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Sep 2020 23:03:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbgIODD4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 14 Sep 2020 23:03:56 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 12998763F03EE3FFA957;
        Tue, 15 Sep 2020 11:03:54 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 11:03:43 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] ata: pata_samsung_cf: simplify the return expression of pata_s3c_wait_after_reset()
Date:   Tue, 15 Sep 2020 11:26:21 +0800
Message-ID: <20200915032621.1772254-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/ata/pata_samsung_cf.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 3da0e8e30286..5fd5c79e1543 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -340,19 +340,14 @@ static unsigned int pata_s3c_devchk(struct ata_port *ap,
 static int pata_s3c_wait_after_reset(struct ata_link *link,
 		unsigned long deadline)
 {
-	int rc;
-
 	ata_msleep(link->ap, ATA_WAIT_AFTER_RESET);
 
-	/* always check readiness of the master device */
-	rc = ata_sff_wait_ready(link, deadline);
-	/* -ENODEV means the odd clown forgot the D7 pulldown resistor
+	/*
+	 * always check readiness of the master device.
+	 * -ENODEV means the odd clown forgot the D7 pulldown resistor
 	 * and TF status is 0xff, bail out on it too.
 	 */
-	if (rc)
-		return rc;
-
-	return 0;
+	return ata_sff_wait_ready(link, deadline);
 }
 
 /*
-- 
2.25.1

