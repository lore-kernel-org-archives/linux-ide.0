Return-Path: <SRS0=Rzt2=6V=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254B8C38A2A
	for <linux-ide@archiver.kernel.org>; Thu,  7 May 2020 11:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09009208CA
	for <linux-ide@archiver.kernel.org>; Thu,  7 May 2020 11:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgEGLH3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 7 May 2020 07:07:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbgEGLH3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 7 May 2020 07:07:29 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A3436C3DCBDDF1752CA0;
        Thu,  7 May 2020 19:07:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 19:07:16 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <axboe@kernel.dk>, <b.zolnierkie@samsung.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ata: return true in ata_is_host_link()
Date:   Thu, 7 May 2020 19:06:37 +0800
Message-ID: <20200507110637.37341-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the following coccicheck warning:

include/linux/libata.h:1446:8-9: WARNING: return of 0/1 in function
'ata_is_host_link' with return type bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 include/linux/libata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8bf5e59a7859..e05a8ed2e31e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1443,7 +1443,7 @@ static inline bool sata_pmp_attached(struct ata_port *ap)
 
 static inline bool ata_is_host_link(const struct ata_link *link)
 {
-	return 1;
+	return true;
 }
 #endif /* CONFIG_SATA_PMP */
 
-- 
2.21.1

