From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/13] libata: update atapi_eh_request_sense() such that lbam/lbah contains buffer size
Date: Wed, 28 Nov 2007 00:13:47 +0900
Message-ID: <11961764393741-git-send-email-htejun@gmail.com>
References: <11961764391983-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.182]:60821 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708AbXK0POH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 10:14:07 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1688059roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 07:14:06 -0800 (PST)
In-Reply-To: <11961764391983-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>

While updating lbam/h for ATAPI commands, atapi_eh_request_sense() was
left out.  Update it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 77083b5..2e3d3a2 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1302,8 +1302,8 @@ static unsigned int atapi_eh_request_sense(struct ata_queued_cmd *qc)
 		tf.feature |= ATAPI_PKT_DMA;
 	} else {
 		tf.protocol = ATA_PROT_ATAPI;
-		tf.lbam = (8 * 1024) & 0xff;
-		tf.lbah = (8 * 1024) >> 8;
+		tf.lbam = SCSI_SENSE_BUFFERSIZE;
+		tf.lbah = 0;
 	}
 
 	return ata_exec_internal(dev, &tf, cdb, DMA_FROM_DEVICE,
-- 
1.5.2.4

