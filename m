Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41324C433F5
	for <linux-ide@archiver.kernel.org>; Sun,  8 May 2022 20:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiEHUpl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 8 May 2022 16:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiEHUph (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 8 May 2022 16:45:37 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E62DAE5A
        for <linux-ide@vger.kernel.org>; Sun,  8 May 2022 13:41:43 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru DCC7A209A449
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Subject: [PATCH 3/3] ata: make ata_port_info::{pio|mwdma|udma}_mask *unsigned int*
Date:   Sun, 8 May 2022 23:41:39 +0300
Message-ID: <20220508204139.4961-4-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220508204139.4961-1-s.shtylyov@omp.ru>
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The {pio|mwdma|udma}_mask fields of the *struct* ata_port_info are declared
as *unsigned long* (which is a 64-bit type on 64-bit architectures) while
the actual masks should easily fit into just 8 bits. The alike fields in
the *struct* ata_port are declared as *unsigned int*, so there are silent
truncations going on in ata_host_alloc_pinfo() anyway... Using *unsigned*
*int* fields instead saves some object code in many LLDDs too...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 include/linux/libata.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index f6fc482d767a..6417f1fd4852 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -979,9 +979,9 @@ struct ata_port_operations {
 struct ata_port_info {
 	unsigned long		flags;
 	unsigned long		link_flags;
-	unsigned long		pio_mask;
-	unsigned long		mwdma_mask;
-	unsigned long		udma_mask;
+	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
+	unsigned int		udma_mask;
 	struct ata_port_operations *port_ops;
 	void 			*private_data;
 };
-- 
2.26.3

