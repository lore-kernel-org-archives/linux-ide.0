Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C5BC3DA7A
	for <linux-ide@archiver.kernel.org>; Wed, 28 Dec 2022 08:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiL1I4t (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Dec 2022 03:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiL1I4s (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Dec 2022 03:56:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3DDBCB8;
        Wed, 28 Dec 2022 00:56:47 -0800 (PST)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NhljF1P8vzmWr7;
        Wed, 28 Dec 2022 16:55:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 28 Dec
 2022 16:56:46 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <qiuchangqi.qiu@huawei.com>, <wubo40@huawei.com>
Subject: [RFC PATCH] ata: libata-eh: Retry the cmnd when normal complete occurrd after scsi timeout
Date:   Wed, 28 Dec 2022 17:36:56 +0800
Message-ID: <1672220216-46938-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: wubo <wubo40@huawei.com>

Hi,

Now SCSI middle layer EH and normal IO handler can only choose one of them,
after the SCSI command is completed normally after scsi timeout period,
Should this scenario be given a chance to retry?

Signed-off-by: wubo <wubo40@huawei.com>
---
 drivers/ata/libata-eh.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 34303ce..8d1856f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -617,14 +617,8 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 					qc->flags |= ATA_QCFLAG_FAILED;
 					nr_timedout++;
 				}
-			} else {
-				/* Normal completion occurred after
-				 * SCSI timeout but before this point.
-				 * Successfully complete it.
-				 */
-				scmd->retries = scmd->allowed;
+			} else
 				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
-			}
 		}
 
 		/* If we have timed out qcs.  They belong to EH from
-- 
1.8.3.1

