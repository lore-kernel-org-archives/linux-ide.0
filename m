From: Andy Warner <andyw@pobox.com>
Subject: [PATCH] libata-dev-2.6 pass-thru CDB check condition support.
Date: Thu, 14 Oct 2004 10:51:31 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041014105131.B21475@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/WwmFnJnmDyWGHa4"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:56303 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S266236AbUJNPxQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Oct 2004 11:53:16 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Patch to add CC support for ATA pass-thru CDB processing.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634

--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cc.patch"

===== drivers/scsi/libata-scsi.c 1.55 vs edited =====
--- 1.55/drivers/scsi/libata-scsi.c	2004-09-30 23:12:35 -05:00
+++ edited/drivers/scsi/libata-scsi.c	2004-10-14 10:38:43 -05:00
@@ -468,6 +468,85 @@
 	}
 }
 
+/*
+ *	ata_pass_thru_cc - Generate check condition sense block.
+ *	@qc: Command that completed.
+ *
+ *	Regardless of whether the command errored or not, return
+ *	a sense block. Copy all controller registers into
+ *	the sense block. Clear sense key, ASC & ASCQ if
+ *	there is no error.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_pass_thru_cc(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_taskfile *tf = &qc->tf;
+	unsigned char *sb = cmd->sense_buffer;
+	unsigned char *desc = sb + 8 ;
+
+	cmd->result = SAM_STAT_CHECK_CONDITION;
+
+	/*
+	 * Use ata_to_sense_error() to map status register bits
+	 * onto sense key, asc & ascq. We will overwrite some
+	 * (many) of the fields later.
+	 *
+	 * TODO: reorganise better, by splitting ata_to_sense_error()
+	 */
+	if (unlikely(drv_stat & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+		ata_to_sense_error(qc, drv_stat) ;
+	} else {
+		sb[3] = sb[2] = sb[1] = 0x00 ;
+	}
+
+	/*
+	 * Sense data is current and format is
+	 * descriptor.
+	 */
+	sb[0] = 0x72 ;
+
+	desc[0] = 0x8e ;	/* TODO: replace with official value. */
+
+	/*
+	 * Set length of additional sense data.
+	 * Since we only populate descriptor 0, the total
+	 * length is the same (fixed) length as descriptor 0.
+	 */
+	desc[1] = sb[7] = 14 ;
+
+	/*
+	 * Read the controller registers.
+	 */
+	qc->ap->ops->tf_read(qc->ap, tf);
+
+	/*
+	 * Copy registers into sense buffer.
+	 */
+	desc[2] = 0x00 ;
+	desc[3] = tf->feature ;	/* Note: becomes error register when read. */
+	desc[5] = tf->nsect ;
+	desc[7] = tf->lbal ;
+	desc[9] = tf->lbam ;
+	desc[11] = tf->lbah ;
+	desc[12] = tf->device ;
+	desc[13] = drv_stat ;
+
+	/*
+	 * Fill in Extend bit, and the high order bytes
+	 * if applicable.
+	 */
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		desc[2] |= 0x01 ;
+		desc[4] = tf->hob_nsect ;
+		desc[6] = tf->hob_lbal ;
+		desc[8] = tf->hob_lbam ;
+		desc[10] = tf->hob_lbah ;
+	}
+}
+
 /**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
@@ -784,8 +863,9 @@
 	 * successfully or not. If there was no error, SK, ASC and
 	 * ASCQ will all be zero.
 	 */
-	if ((cmd->cmnd[0] == ATA_16) && (cmd->cmnd[2] & 0x20)) {
-/*DWD*/		printk("XX  0x%0lx/0x%0x\n", qc->tf.flags, qc->tf.protocol);
+	if (((cmd->cmnd[0] == ATA_16) || (cmd->cmnd[0] == ATA_12)) &&
+						(cmd->cmnd[2] & 0x20)) {
+		ata_pass_thru_cc(qc, drv_stat) ;
 	} else {
 		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
 			ata_to_sense_error(qc, drv_stat);

--/WwmFnJnmDyWGHa4--
