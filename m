From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH v3 3/3] libata: Add support for queued DSM TRIM
Date: Thu,  8 Aug 2013 21:49:12 -0700
Message-ID: <1376023752-3105-4-git-send-email-marc.ceeeee@gmail.com>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:61939 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932792Ab3HIEvD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 00:51:03 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so1720200oag.40
        for <linux-ide@vger.kernel.org>; Thu, 08 Aug 2013 21:51:03 -0700 (PDT)
In-Reply-To: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com
Cc: Marc Carino <marc.ceeeee@gmail.com>

From: Marc Carino <marc.ceeeee@gmail.com>

Some new SSDs support the queued version of the DSM TRIM command.
Let the driver use the new command if supported.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 drivers/ata/libata-scsi.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 83c0890..1605ffc 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3098,12 +3098,27 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	buf = page_address(sg_page(scsi_sglist(scmd)));
 	size = ata_set_lba_range_entries(buf, 512, block, n_block);
 
-	tf->protocol = ATA_PROT_DMA;
-	tf->hob_feature = 0;
-	tf->feature = ATA_DSM_TRIM;
-	tf->hob_nsect = (size / 512) >> 8;
-	tf->nsect = size / 512;
-	tf->command = ATA_CMD_DSM;
+	if (ata_ncq_enabled(dev) &&
+	    (dev->ncq_send_recv_cmds[ATA_LOG_NCQ_SEND_RECV_DSM_OFFSET] &
+	     ATA_LOG_NCQ_SEND_RECV_DSM_TRIM)) {
+		/* Newer devices support queued TRIM commands */
+		tf->protocol = ATA_PROT_NCQ;
+		tf->command = ATA_CMD_FPDMA_SEND;
+		tf->hob_nsect = ATA_SUBCMD_FPDMA_SEND_DSM & 0x1f;
+		tf->nsect = qc->tag << 3;
+		tf->hob_feature = (size / 512) >> 8;
+		tf->feature = size / 512;
+
+		qc->auxiliary = 1;
+	} else {
+		tf->protocol = ATA_PROT_DMA;
+		tf->hob_feature = 0;
+		tf->feature = ATA_DSM_TRIM;
+		tf->hob_nsect = (size / 512) >> 8;
+		tf->nsect = size / 512;
+		tf->command = ATA_CMD_DSM;
+	}
+
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48 |
 		     ATA_TFLAG_WRITE;
 
-- 
1.8.1.2

