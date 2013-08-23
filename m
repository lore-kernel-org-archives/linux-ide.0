From: Marc C <marc.ceeeee@gmail.com>
Subject: [PATCH v4 3/3] libata: Add support for queued DSM TRIM
Date: Fri, 23 Aug 2013 02:40:47 -0700
Message-ID: <1377250847-24132-4-git-send-email-marc.ceeeee@gmail.com>
References: <1377250847-24132-1-git-send-email-marc.ceeeee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:45409 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab3HWJmT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Aug 2013 05:42:19 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so454913obb.32
        for <linux-ide@vger.kernel.org>; Fri, 23 Aug 2013 02:42:19 -0700 (PDT)
In-Reply-To: <1377250847-24132-1-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Marc Carino <marc.ceeeee@gmail.com>

From: Marc Carino <marc.ceeeee@gmail.com>

Some new SSDs support the queued version of the DSM TRIM command.
Let the driver use the new command if supported.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 drivers/ata/libata-scsi.c | 25 +++++++++++++++++++------
 include/linux/libata.h    | 11 +++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 83c0890..0c807a9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3098,12 +3098,25 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	buf = page_address(sg_page(scsi_sglist(scmd)));
 	size = ata_set_lba_range_entries(buf, 512, block, n_block);
 
-	tf->protocol = ATA_PROT_DMA;
-	tf->hob_feature = 0;
-	tf->feature = ATA_DSM_TRIM;
-	tf->hob_nsect = (size / 512) >> 8;
-	tf->nsect = size / 512;
-	tf->command = ATA_CMD_DSM;
+	if (ata_ncq_enabled(dev) && ata_fpdma_dsm_supported(dev)) {
+		/* Newer devices support queued TRIM commands */
+		tf->protocol = ATA_PROT_NCQ;
+		tf->command = ATA_CMD_FPDMA_SEND;
+		tf->hob_nsect = ATA_SUBCMD_FPDMA_SEND_DSM & 0x1f;
+		tf->nsect = qc->tag << 3;
+		tf->hob_feature = (size / 512) >> 8;
+		tf->feature = size / 512;
+
+		tf->auxiliary = 1;
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
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b925504..69d1b8b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1608,6 +1608,17 @@ static inline int ata_ncq_enabled(struct ata_device *dev)
 			      ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ;
 }
 
+static inline int ata_fpdma_dsm_supported(struct ata_device *dev)
+{
+	if ((dev->flags & ATA_DFLAG_NCQ_SEND_RECV) &&
+	    (dev->ncq_send_recv_cmds[ATA_LOG_NCQ_SEND_RECV_DSM_OFFSET] &
+	     ATA_LOG_NCQ_SEND_RECV_DSM_TRIM)) {
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
 static inline void ata_qc_set_polling(struct ata_queued_cmd *qc)
 {
 	qc->tf.ctl |= ATA_NIEN;
-- 
1.8.1.2

