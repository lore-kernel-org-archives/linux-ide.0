Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807ABCCA47A
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jun 2022 20:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiFPUwG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiFPUwF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jun 2022 16:52:05 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368485FF0B
        for <linux-ide@vger.kernel.org>; Thu, 16 Jun 2022 13:52:00 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 56C06229B7CB
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 2/2] ata: make ata_port::fastdrain_cnt *unsigned int*
Date:   Thu, 16 Jun 2022 23:51:49 +0300
Message-ID: <20220616205149.16157-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220616205149.16157-1-s.shtylyov@omp.ru>
References: <20220616205149.16157-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1902.lancloud.ru (fd00:f066::72)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

*unsigned long* ata_port::fastdrain_cnt (64-bit value in a 64-bit kernel)
is always assigned from the 32-bit *unsigned int* variables, thus could
also be made just *unsigned int*...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 include/linux/libata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0f2a59c9c735..d214aa988168 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -850,7 +850,7 @@ struct ata_port {
 	enum ata_lpm_policy	target_lpm_policy;
 
 	struct timer_list	fastdrain_timer;
-	unsigned long		fastdrain_cnt;
+	unsigned int		fastdrain_cnt;
 
 	async_cookie_t		cookie;
 
-- 
2.26.3
