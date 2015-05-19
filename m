From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] libata: Fix regression when the NCQ Send and Receive log page is absent
Date: Tue, 19 May 2015 19:44:17 -0400
Message-ID: <1432079057-11262-1-git-send-email-martin.petersen@oracle.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:30406 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbESXo1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2015 19:44:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, sergey.senozhatsky@gmail.com, "Martin K. Petersen" <martin.petersen@oracle.com>

Commit 5d3abf8ff67f allowed us to fall back to the unqueued READ LOG
variant if the queued version failed. However, if the device did not
support the page at all we would end up looping due to a merge snafu.

Ensure we only take the fallback path once.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/ata/libata-eh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2893563d0537..2b370ee0ae86 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1521,6 +1521,7 @@ retry:
 	} else {
 		tf.command = ATA_CMD_READ_LOG_EXT;
 		tf.protocol = ATA_PROT_PIO;
+		dma = false;
 	}
 	tf.lbal = log;
 	tf.lbam = page;
-- 
1.9.3

