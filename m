From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: READ LOG DMA EXT failed, trying unqueued
Date: Tue, 19 May 2015 21:00:17 +0900
Message-ID: <20150519120017.GA390@swordfish>
References: <20150519113320.GA498@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33280 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbbESMAl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2015 08:00:41 -0400
Received: by padbw4 with SMTP id bw4so21497581pad.0
        for <linux-ide@vger.kernel.org>; Tue, 19 May 2015 05:00:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150519113320.GA498@swordfish>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

On (05/19/15 20:33), Sergey Senozhatsky wrote:
> my laptop doesn't boot anymore, spinning in "READ LOG DMA EXT failed, trying unqueued".
> any reason it loops forever?
> 

perhaps something like this?

8<-----8<-----

>From 826eb3644e7d4b1f66a898c63865f217fb82f1f9 Mon Sep 17 00:00:00 2001
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Tue, 19 May 2015 20:54:18 +0900
Subject: [PATCH] ata: do not retry ata_read_log_page() forever

Do not spin on failing ata_exec_internal() forever, make a one shot
ATA_HORKAGE_NO_NCQ_LOG retry.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f093174..20f1549 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1531,7 +1531,7 @@ retry:
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     buf, sectors * ATA_SECT_SIZE, 0);
 
-	if (err_mask && dma) {
+	if (err_mask && dma && !(dev->horkage & ATA_HORKAGE_NO_NCQ_LOG)) {
 		dev->horkage |= ATA_HORKAGE_NO_NCQ_LOG;
 		ata_dev_warn(dev, "READ LOG DMA EXT failed, trying unqueued\n");
 		goto retry;
-- 
2.4.1.168.g1ea28e1

