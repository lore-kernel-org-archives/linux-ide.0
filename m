From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2 v2] libata: only call ->done once all per-tag
	ressources are released
Date: Thu, 8 Oct 2015 10:25:41 +0200
Message-ID: <20151008082541.GA8969@lst.de>
References: <1443892871-10413-1-git-send-email-hch@lst.de> <1443892871-10413-2-git-send-email-hch@lst.de> <20151004173429.GD19652@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:37583 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753780AbbJHIZn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Oct 2015 04:25:43 -0400
Content-Disposition: inline
In-Reply-To: <20151004173429.GD19652@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

When calling ->done before releasing resources we could run into a
race where the SCSI midlayer sends another command and races with
the resources beeing manipulated.  For libata this can't currently
happen as synchronization happens at a higher level, but I'd still
like to fix it to future proof libata and to avoid copy & paste
into SCSI drivers where this pattern has led to reproducible crashes.

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

