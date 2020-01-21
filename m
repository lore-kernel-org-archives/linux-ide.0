Return-Path: <SRS0=H5qQ=3K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B75C32771
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 01:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A60C22527
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 01:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgAUBda (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Jan 2020 20:33:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbgAUBd3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 20 Jan 2020 20:33:29 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DF10D2200792A4E24220;
        Tue, 21 Jan 2020 09:33:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 21 Jan 2020 09:33:18 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <b.zolnierkie@samsung.com>, <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next] ata: pata_macio: fix comparing pointer to 0
Date:   Tue, 21 Jan 2020 09:28:27 +0800
Message-ID: <20200121012827.1036-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes coccicheck warning:

./drivers/ata/pata_macio.c:982:31-32:
	WARNING comparing pointer to 0, suggest !E

Compare pointer-typed values to NULL rather than 0.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/ata/pata_macio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 1bfd015..e47a282 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -979,7 +979,7 @@ static void pata_macio_invariants(struct pata_macio_priv *priv)
 	priv->aapl_bus_id =  bidp ? *bidp : 0;
 
 	/* Fixup missing Apple bus ID in case of media-bay */
-	if (priv->mediabay && bidp == 0)
+	if (priv->mediabay && !bidp)
 		priv->aapl_bus_id = 1;
 }
 
-- 
2.7.4

