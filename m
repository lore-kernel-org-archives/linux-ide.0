Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2961C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 13 May 2022 20:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384554AbiEMUuZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 May 2022 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384555AbiEMUuX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 May 2022 16:50:23 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6205C6554
        for <linux-ide@vger.kernel.org>; Fri, 13 May 2022 13:50:18 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 9FA792093BF0
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: libata-core: fix sloppy typing in ata_id_n_sectors()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <a15e1894-8be2-70f8-26b4-be62de8055d9@omp.ru>
Date:   Fri, 13 May 2022 23:50:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The code multiplying the # of cylinders/heads/sectors in ata_id_n_sectors()
to get a disk capacity implicitly uses the *int* type for that calculation
and casting the result to 'u64' before returning ensues a sign extension.
Explicitly casting the 'u16' typed multipliers to 'u32' results in avoiding
a sign extension instruction and so in a more compact code...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien's 'libata.git' repo.

 drivers/ata/libata-core.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: libata/drivers/ata/libata-core.c
===================================================================
--- libata.orig/drivers/ata/libata-core.c
+++ libata/drivers/ata/libata-core.c
@@ -1107,11 +1107,13 @@ static u64 ata_id_n_sectors(const u16 *i
 			return ata_id_u32(id, ATA_ID_LBA_CAPACITY);
 	} else {
 		if (ata_id_current_chs_valid(id))
-			return id[ATA_ID_CUR_CYLS] * id[ATA_ID_CUR_HEADS] *
-			       id[ATA_ID_CUR_SECTORS];
+			return (u32)id[ATA_ID_CUR_CYLS] *
+			       (u32)id[ATA_ID_CUR_HEADS] *
+			       (u32)id[ATA_ID_CUR_SECTORS];
 		else
-			return id[ATA_ID_CYLS] * id[ATA_ID_HEADS] *
-			       id[ATA_ID_SECTORS];
+			return (u32)id[ATA_ID_CYLS] *
+			       (u32)id[ATA_ID_HEADS] *
+			       (u32)id[ATA_ID_SECTORS];
 	}
 }
 
