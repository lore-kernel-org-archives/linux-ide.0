From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/5] libata: cosmetic changes to sense generation functions
Date: Tue, 14 Nov 2006 22:37:35 +0900
Message-ID: <11635114552321-git-send-email-htejun@gmail.com>
References: <11635114553453-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:1937 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965734AbWKNNhr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:37:47 -0500
Received: by nz-out-0102.google.com with SMTP id l1so971449nzf
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:37:46 -0800 (PST)
In-Reply-To: <11635114553453-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* s/ata_gen_ata_desc_sense/ata_gen_passthru_sense/

* s/ata_gen_fixed_sense/ata_gen_ata_sense/

* make both functions static

* neither function has locking requirement, change it to None.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8c9fa9e..2004a76 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -671,7 +671,7 @@ void ata_to_sense_error(unsigned id, u8
 }
 
 /*
- *	ata_gen_ata_desc_sense - Generate check condition sense block.
+ *	ata_gen_passthru_sense - Generate check condition sense block.
  *	@qc: Command that completed.
  *
  *	This function is specific to the ATA descriptor format sense
@@ -681,9 +681,9 @@ void ata_to_sense_error(unsigned id, u8
  *	block. Clear sense key, ASC & ASCQ if there is no error.
  *
  *	LOCKING:
- *	spin_lock_irqsave(host lock)
+ *	None.
  */
-void ata_gen_ata_desc_sense(struct ata_queued_cmd *qc)
+static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
@@ -743,16 +743,16 @@ void ata_gen_ata_desc_sense(struct ata_q
 }
 
 /**
- *	ata_gen_fixed_sense - generate a SCSI fixed sense block
+ *	ata_gen_ata_sense - generate a SCSI fixed sense block
  *	@qc: Command that we are erroring out
  *
  *	Leverage ata_to_sense_error() to give us the codes.  Fit our
  *	LBA in here if there's room.
  *
  *	LOCKING:
- *	inherited from caller
+ *	None.
  */
-void ata_gen_fixed_sense(struct ata_queued_cmd *qc)
+static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
@@ -1459,7 +1459,7 @@ static void ata_scsi_qc_complete(struct
 	 */
 	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
  	    ((cdb[2] & 0x20) || need_sense)) {
- 		ata_gen_ata_desc_sense(qc);
+		ata_gen_passthru_sense(qc);
 	} else {
 		if (!need_sense) {
 			cmd->result = SAM_STAT_GOOD;
@@ -1470,7 +1470,7 @@ static void ata_scsi_qc_complete(struct
 			 * good for smaller LBA (and maybe CHS?)
 			 * devices.
 			 */
-			ata_gen_fixed_sense(qc);
+			ata_gen_ata_sense(qc);
 		}
 	}
 
@@ -2301,7 +2301,7 @@ static void atapi_sense_complete(struct
 		 * a sense descriptors, since that's only
 		 * correct for ATA, not ATAPI
 		 */
-		ata_gen_ata_desc_sense(qc);
+		ata_gen_passthru_sense(qc);
 	}
 
 	qc->scsidone(qc->scsicmd);
@@ -2376,7 +2376,7 @@ static void atapi_qc_complete(struct ata
 			 * sense descriptors, since that's only
 			 * correct for ATA, not ATAPI
 			 */
-			ata_gen_ata_desc_sense(qc);
+			ata_gen_passthru_sense(qc);
 		}
 
 		/* SCSI EH automatically locks door if sdev->locked is
@@ -2409,7 +2409,7 @@ static void atapi_qc_complete(struct ata
 		 * a sense descriptors, since that's only
 		 * correct for ATA, not ATAPI
 		 */
-		ata_gen_ata_desc_sense(qc);
+		ata_gen_passthru_sense(qc);
 	} else {
 		u8 *scsicmd = cmd->cmnd;
 
-- 
1.4.3.3


