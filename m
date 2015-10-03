From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] libata: cleanup ata_scsi_qc_complete
Date: Sat,  3 Oct 2015 19:21:11 +0200
Message-ID: <1443892871-10413-3-git-send-email-hch@lst.de>
References: <1443892871-10413-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44353 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbbJCRY7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Oct 2015 13:24:59 -0400
Received: from [83.175.99.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1ZiQYM-0001fV-HL
	for linux-ide@vger.kernel.org; Sat, 03 Oct 2015 17:24:58 +0000
In-Reply-To: <1443892871-10413-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Remove an incorrect comment and untangle an if statement in
ata_scsi_qc_complete.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-scsi.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8445620..7feceec 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1783,21 +1783,12 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
 	 */
 	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
-	    ((cdb[2] & 0x20) || need_sense)) {
+	    ((cdb[2] & 0x20) || need_sense))
 		ata_gen_passthru_sense(qc);
-	} else {
-		if (!need_sense) {
-			cmd->result = SAM_STAT_GOOD;
-		} else {
-			/* TODO: decide which descriptor format to use
-			 * for 48b LBA devices and call that here
-			 * instead of the fixed desc, which is only
-			 * good for smaller LBA (and maybe CHS?)
-			 * devices.
-			 */
-			ata_gen_ata_sense(qc);
-		}
-	}
+	else if (need_sense)
+		ata_gen_ata_sense(qc);
+	else
+		cmd->result = SAM_STAT_GOOD;
 
 	if (need_sense && !ap->ops->error_handler)
 		ata_dump_status(ap->print_id, &qc->result_tf);
-- 
1.9.1

