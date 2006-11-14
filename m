From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] libata: improve SCSI sense data generation
Date: Tue, 14 Nov 2006 22:37:35 +0900
Message-ID: <1163511455161-git-send-email-htejun@gmail.com>
References: <11635114553453-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:44439 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965747AbWKNNhr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:37:47 -0500
Received: by nz-out-0102.google.com with SMTP id l1so971476nzf
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:37:47 -0800 (PST)
In-Reply-To: <11635114553453-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_gen_ata_sense() to use desc format sense data to report the
first failed block.  The first failed block is read from result_tf
using ata_tf_read_block() which can handle all three address formats.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |   46 ++++++++++++++++++++++----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 2004a76..9b0d59d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -746,53 +746,53 @@ static void ata_gen_passthru_sense(struc
  *	ata_gen_ata_sense - generate a SCSI fixed sense block
  *	@qc: Command that we are erroring out
  *
- *	Leverage ata_to_sense_error() to give us the codes.  Fit our
- *	LBA in here if there's room.
+ *	Generate sense block for a failed ATA command @qc.  Descriptor
+ *	format is used to accomodate LBA48 block address.
  *
  *	LOCKING:
  *	None.
  */
 static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 {
+	struct ata_device *dev = qc->dev;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
+	unsigned char *desc = sb + 8;
 	int verbose = qc->ap->ops->error_handler == NULL;
+	u64 block;
 
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
 
 	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
 
-	/*
-	 * Use ata_to_sense_error() to map status register bits
+	/* sense data is current and format is descriptor */
+	sb[0] = 0x72;
+
+	/* Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
 	if (qc->err_mask ||
 	    tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
-				   &sb[2], &sb[12], &sb[13], verbose);
-		sb[2] &= 0x0f;
+				   &sb[1], &sb[2], &sb[3], verbose);
+		sb[1] &= 0x0f;
 	}
 
-	sb[0] = 0x70;
-	sb[7] = 0x0a;
+	block = ata_tf_read_block(&qc->result_tf, dev);
 
-	if (tf->flags & ATA_TFLAG_LBA48) {
-		/* TODO: find solution for LBA48 descriptors */
-	}
+	/* information sense data descriptor */
+	sb[7] = 12;
+	desc[0] = 0x00;
+	desc[1] = 10;
 
-	else if (tf->flags & ATA_TFLAG_LBA) {
-		/* A small (28b) LBA will fit in the 32b info field */
-		sb[0] |= 0x80;		/* set valid bit */
-		sb[3] = tf->device & 0x0f;
-		sb[4] = tf->lbah;
-		sb[5] = tf->lbam;
-		sb[6] = tf->lbal;
-	}
-
-	else {
-		/* TODO: C/H/S */
-	}
+	desc[2] |= 0x80;	/* valid */
+	desc[6] = block >> 40;
+	desc[7] = block >> 32;
+	desc[8] = block >> 24;
+	desc[9] = block >> 16;
+	desc[10] = block >> 8;
+	desc[11] = block;
 }
 
 static void ata_scsi_sdev_config(struct scsi_device *sdev)
-- 
1.4.3.3


