From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/15] libata: zero xfer length on ATAPI data xfer IRQ is HSM violation
Date: Wed,  5 Dec 2007 16:43:02 +0900
Message-ID: <11968405953773-git-send-email-htejun@gmail.com>
References: <11968405951262-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:33171 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbXLEHnb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 02:43:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6895624wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 23:43:30 -0800 (PST)
In-Reply-To: <11968405951262-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Albert Lee <albertcc@tw.ibm.com>, Tejun Heo <htejun@gmail.com>

From: Albert Lee <albertcc@tw.ibm.com>

Treat zero xfer length as HSM violation.  While at it, add
unlikely()'s to ATAPI ireason and transfer length checks.

tj: Formatted patch and added unlikely()'s.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 597e07c..88f7637 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5280,12 +5280,15 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 	bytes = (bc_hi << 8) | bc_lo;
 
 	/* shall be cleared to zero, indicating xfer of data */
-	if (ireason & (1 << 0))
+	if (unlikely(ireason & (1 << 0)))
 		goto err_out;
 
 	/* make sure transfer direction matches expected */
 	i_write = ((ireason & (1 << 1)) == 0) ? 1 : 0;
-	if (do_write != i_write)
+	if (unlikely(do_write != i_write))
+		goto err_out;
+
+	if (unlikely(!bytes))
 		goto err_out;
 
 	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
-- 
1.5.2.4

