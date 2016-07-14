From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/10] libata-scsi: Fix translation of REPORT ZONES command
Date: Thu, 14 Jul 2016 09:05:49 +0900
Message-ID: <1468454751-12466-9-git-send-email-hch@lst.de>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55796 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcGNAGU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 20:06:20 -0400
In-Reply-To: <1468454751-12466-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org

From: Damien Le Moal <damien.lemoal@hgst.com>

Include reporting options when translating REPORT ZONES commmand to
ATA NCQ, and make sure we only look at the actually specified bits
in the CDB for the options.

Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
[hch: update patch description]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 901b46a..45d8ae63 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3468,7 +3468,7 @@ static unsigned int ata_scsi_zbc_in_xlat(struct ata_queued_cmd *qc)
 		goto invalid_param_len;
 	}
 	sect = n_block / 512;
-	options = cdb[14];
+	options = cdb[14] & 0xbf;
 
 	if (ata_ncq_enabled(qc->dev) &&
 	    ata_fpdma_zac_mgmt_in_supported(qc->dev)) {
@@ -3478,7 +3478,7 @@ static unsigned int ata_scsi_zbc_in_xlat(struct ata_queued_cmd *qc)
 		tf->nsect = qc->tag << 3;
 		tf->feature = sect & 0xff;
 		tf->hob_feature = (sect >> 8) & 0xff;
-		tf->auxiliary = ATA_SUBCMD_ZAC_MGMT_IN_REPORT_ZONES;
+		tf->auxiliary = ATA_SUBCMD_ZAC_MGMT_IN_REPORT_ZONES | (options << 8);
 	} else {
 		tf->command = ATA_CMD_ZAC_MGMT_IN;
 		tf->feature = ATA_SUBCMD_ZAC_MGMT_IN_REPORT_ZONES;
-- 
2.1.4

