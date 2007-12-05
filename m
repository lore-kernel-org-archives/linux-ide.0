From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/15] libata: make atapi_request_sense() use sg
Date: Wed,  5 Dec 2007 16:43:01 +0900
Message-ID: <11968405951137-git-send-email-htejun@gmail.com>
References: <11968405951262-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:33171 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbXLEHni (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 02:43:38 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6895624wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 23:43:38 -0800 (PST)
In-Reply-To: <11968405951262-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>, Rusty Russel <rusty@rustcorp.com.au>

atapi_request_sense() is now the only left user of ata_sg_init_one().
Convert it to use sg interface.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Rusty Russel <rusty@rustcorp.com.au>
---
 drivers/ata/libata-scsi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a1ec970..29e8336 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2340,7 +2340,9 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 
 	ata_qc_reinit(qc);
 
-	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
+	/* setup sg table and init transfer direction */
+	sg_init_one(&qc->sgent, cmd->sense_buffer, sizeof(cmd->sense_buffer));
+	ata_sg_init(qc, &qc->sgent, 1);
 	qc->dma_dir = DMA_FROM_DEVICE;
 
 	memset(&qc->cdb, 0, qc->dev->cdb_len);
-- 
1.5.2.4

