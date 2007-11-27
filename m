From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/13] libata: make atapi_request_sense() use sg
Date: Wed, 28 Nov 2007 00:13:52 +0900
Message-ID: <11961764403544-git-send-email-htejun@gmail.com>
References: <11961764391983-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.178]:54873 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756282AbXK0PON (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 10:14:13 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1688067roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 07:14:12 -0800 (PST)
In-Reply-To: <11961764391983-git-send-email-htejun@gmail.com>
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
index b02e1ac..6251caa 100644
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

