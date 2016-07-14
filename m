From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/10] libata-scsi: Fix ZBC management out command translation
Date: Thu, 14 Jul 2016 09:05:50 +0900
Message-ID: <1468454751-12466-10-git-send-email-hch@lst.de>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55810 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcGNAGW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 20:06:22 -0400
In-Reply-To: <1468454751-12466-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org

From: Damien Le Moal <damien.lemoal@hgst.com>

The subcommand for NCQ NON-DATA must be specified in the feature
(low byte), not the high-order count byte.  Also make sure to properly
cast the all bit to a u16 before shiting it by 8 to avoid undefined
behavior.

Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
[hch: split the original patch into two, updated changelog]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 45d8ae63..d978153 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3553,9 +3553,9 @@ static unsigned int ata_scsi_zbc_out_xlat(struct ata_queued_cmd *qc)
 	    ata_fpdma_zac_mgmt_out_supported(qc->dev)) {
 		tf->protocol = ATA_PROT_NCQ_NODATA;
 		tf->command = ATA_CMD_NCQ_NON_DATA;
-		tf->hob_nsect = ATA_SUBCMD_NCQ_NON_DATA_ZAC_MGMT_OUT;
+		tf->feature = ATA_SUBCMD_NCQ_NON_DATA_ZAC_MGMT_OUT;
 		tf->nsect = qc->tag << 3;
-		tf->auxiliary = sa | (reset_all & 0x1) << 8;
+		tf->auxiliary = sa | ((u16)(reset_all & 0x1) << 8);
 	} else {
 		tf->protocol = ATA_PROT_NODATA;
 		tf->command = ATA_CMD_ZAC_MGMT_OUT;
-- 
2.1.4

