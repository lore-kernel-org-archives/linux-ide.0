From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/10] libata-scsi: minor cleanup for ata_scsi_zbc_out_xlat
Date: Thu, 14 Jul 2016 09:05:51 +0900
Message-ID: <1468454751-12466-11-git-send-email-hch@lst.de>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55822 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcGNAGY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 20:06:24 -0400
In-Reply-To: <1468454751-12466-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org

From: Damien Le Moal <damien.lemoal@hgst.com>

The reset_all variable name is misleading as this bit is also applicable to
open, close, and finish actions. So rename that variable to "all" and remove
the unnecessary mask operation that's already done earlier.

Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
[hch: split from the previous patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-scsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d978153..7d0e60b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3520,7 +3520,7 @@ static unsigned int ata_scsi_zbc_out_xlat(struct ata_queued_cmd *qc)
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
 	const u8 *cdb = scmd->cmnd;
-	u8 reset_all, sa;
+	u8 all, sa;
 	u64 block;
 	u32 n_block;
 	u16 fp = (u16)-1;
@@ -3547,7 +3547,7 @@ static unsigned int ata_scsi_zbc_out_xlat(struct ata_queued_cmd *qc)
 	if (block > dev->n_sectors)
 		goto out_of_range;
 
-	reset_all = cdb[14] & 0x1;
+	all = cdb[14] & 0x1;
 
 	if (ata_ncq_enabled(qc->dev) &&
 	    ata_fpdma_zac_mgmt_out_supported(qc->dev)) {
@@ -3555,12 +3555,12 @@ static unsigned int ata_scsi_zbc_out_xlat(struct ata_queued_cmd *qc)
 		tf->command = ATA_CMD_NCQ_NON_DATA;
 		tf->feature = ATA_SUBCMD_NCQ_NON_DATA_ZAC_MGMT_OUT;
 		tf->nsect = qc->tag << 3;
-		tf->auxiliary = sa | ((u16)(reset_all & 0x1) << 8);
+		tf->auxiliary = sa | ((u16)all << 8);
 	} else {
 		tf->protocol = ATA_PROT_NODATA;
 		tf->command = ATA_CMD_ZAC_MGMT_OUT;
 		tf->feature = sa;
-		tf->hob_feature = reset_all & 0x1;
+		tf->hob_feature = all;
 	}
 	tf->lbah = (block >> 16) & 0xff;
 	tf->lbam = (block >> 8) & 0xff;
-- 
2.1.4

