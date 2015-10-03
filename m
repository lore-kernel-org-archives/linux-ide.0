From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] libata: only call ->done once all per-tag ressources are released
Date: Sat,  3 Oct 2015 19:21:10 +0200
Message-ID: <1443892871-10413-2-git-send-email-hch@lst.de>
References: <1443892871-10413-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44349 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbbJCRZG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Oct 2015 13:25:06 -0400
Received: from [83.175.99.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1ZiQYJ-0001fM-Lv
	for linux-ide@vger.kernel.org; Sat, 03 Oct 2015 17:24:56 +0000
In-Reply-To: <1443892871-10413-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Without this the SCSI midlayer can race and queue another command
before the tag data has been released, which could lead to incorrect
manipulation of the ata command state.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-scsi.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0d7f0da..8445620 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1757,6 +1757,15 @@ nothing_to_do:
 	return 1;
 }
 
+static void ata_qc_done(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	void (*done)(struct scsi_cmnd *) = qc->scsidone;
+
+	ata_qc_free(qc);
+	done(cmd);
+}
+
 static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -1793,9 +1802,7 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	if (need_sense && !ap->ops->error_handler)
 		ata_dump_status(ap->print_id, &qc->result_tf);
 
-	qc->scsidone(cmd);
-
-	ata_qc_free(qc);
+	ata_qc_done(qc);
 }
 
 /**
@@ -2594,8 +2601,7 @@ static void atapi_sense_complete(struct ata_queued_cmd *qc)
 		ata_gen_passthru_sense(qc);
 	}
 
-	qc->scsidone(qc->scsicmd);
-	ata_qc_free(qc);
+	ata_qc_done(qc);
 }
 
 /* is it pointless to prefer PIO for "safety reasons"? */
@@ -2690,8 +2696,7 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 			qc->dev->sdev->locked = 0;
 
 		qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
-		qc->scsidone(cmd);
-		ata_qc_free(qc);
+		ata_qc_done(qc);
 		return;
 	}
 
@@ -2735,8 +2740,7 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 		cmd->result = SAM_STAT_GOOD;
 	}
 
-	qc->scsidone(cmd);
-	ata_qc_free(qc);
+	ata_qc_done(qc);
 }
 /**
  *	atapi_xlat - Initialize PACKET taskfile
-- 
1.9.1

