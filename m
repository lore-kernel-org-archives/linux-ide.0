From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] ATAPI error handling work
Date: Wed, 05 Oct 2005 16:51:19 -0400
Message-ID: <43443CC7.5040706@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030408040003030601010201"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:46811 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751087AbVJEUvZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 16:51:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Douglas Gilbert <dougg@torque.net>

This is a multi-part message in MIME format.
--------------030408040003030601010201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a work-in-progress, attempting to fix the death of libata 
whenever there is a SCSI error thrown to us...   IOW this fixes libata 
EH to properly fake autosensing, rather than kicking over to the SCSI EH 
thread for that purpose.


--------------030408040003030601010201
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"


 drivers/scsi/libata-core.c |   90 ++++++++++-----------------------------------
 drivers/scsi/libata-scsi.c |   84 ++++++++++++++++++++++++++++++++++--------
 drivers/scsi/libata.h      |    0 
 include/linux/libata.h     |    1 
 4 files changed, 90 insertions(+), 85 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3015,52 +3015,6 @@ fsm_start:
 		goto fsm_start;
 }
 
-static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
-				struct scsi_cmnd *cmd)
-{
-	DECLARE_COMPLETION(wait);
-	struct ata_queued_cmd *qc;
-	unsigned long flags;
-	int rc;
-
-	DPRINTK("ATAPI request sense\n");
-
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
-
-	/* FIXME: is this needed? */
-	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
-
-	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
-	qc->dma_dir = DMA_FROM_DEVICE;
-
-	memset(&qc->cdb, 0, ap->cdb_len);
-	qc->cdb[0] = REQUEST_SENSE;
-	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
-
-	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	qc->tf.command = ATA_CMD_PACKET;
-
-	qc->tf.protocol = ATA_PROT_ATAPI;
-	qc->tf.lbam = (8 * 1024) & 0xff;
-	qc->tf.lbah = (8 * 1024) >> 8;
-	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
-
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	if (rc)
-		ata_port_disable(ap);
-	else
-		wait_for_completion(&wait);
-
-	DPRINTK("EXIT\n");
-}
-
 /**
  *	ata_qc_timeout - Handle timeout of queued command
  *	@qc: Command that timed out
@@ -3084,32 +3038,11 @@ static void ata_qc_timeout(struct ata_qu
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_host_set *host_set = ap->host_set;
-	struct ata_device *dev = qc->dev;
 	u8 host_stat = 0, drv_stat;
 	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
-	/* FIXME: doesn't this conflict with timeout handling? */
-	if (qc->dev->class == ATA_DEV_ATAPI && qc->scsicmd) {
-		struct scsi_cmnd *cmd = qc->scsicmd;
-
-		if (!(cmd->eh_eflags & SCSI_EH_CANCEL_CMD)) {
-
-			/* finish completing original command */
-			spin_lock_irqsave(&host_set->lock, flags);
-			__ata_qc_complete(qc);
-			spin_unlock_irqrestore(&host_set->lock, flags);
-
-			atapi_request_sense(ap, dev, cmd);
-
-			cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
-			scsi_finish_command(cmd);
-
-			goto out;
-		}
-	}
-
 	spin_lock_irqsave(&host_set->lock, flags);
 
 	/* hack alert!  We cannot use the supplied completion
@@ -3148,7 +3081,6 @@ static void ata_qc_timeout(struct ata_qu
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
-out:
 	DPRINTK("EXIT\n");
 }
 
@@ -3174,17 +3106,35 @@ out:
 void ata_eng_timeout(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
+	struct ata_host_set *host_set = ap->host_set;
+	unsigned long flags;
+	int printed_message = 0;
 
 	DPRINTK("ENTER\n");
 
+	spin_lock_irqsave(&host_set->lock, flags);
+	while (ap->flags & ATA_FLAG_IN_EH) {
+		spin_unlock_irqrestore(&host_set->lock, flags);
+
+		if (!printed_message++)
+			printk(KERN_INFO "ata%u: waiting in timeout handler for EH\n",
+				ap->id);
+
+		msleep(250);
+
+		spin_lock_irqsave(&host_set->lock, flags);
+	}
+	spin_unlock_irqrestore(&host_set->lock, flags);
+
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (!qc) {
+	if (qc)
+		ata_qc_timeout(qc);
+	else {
 		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
 		       ap->id);
 		goto out;
 	}
 
-	ata_qc_timeout(qc);
 
 out:
 	DPRINTK("EXIT\n");
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -225,7 +225,7 @@ void ata_to_sense_error(struct ata_queue
 	};
 	int i = 0;
 
-	cmd->result = SAM_STAT_CHECK_CONDITION;
+	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
 
 	/*
 	 *	Is this an error we can process/parse
@@ -1468,7 +1468,7 @@ unsigned int ata_scsiop_report_luns(stru
 void ata_scsi_badcmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *), u8 asc, u8 ascq)
 {
 	DPRINTK("ENTER\n");
-	cmd->result = SAM_STAT_CHECK_CONDITION;
+	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
 
 	cmd->sense_buffer[0] = 0x70;
 	cmd->sense_buffer[2] = ILLEGAL_REQUEST;
@@ -1479,28 +1479,81 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
 	done(cmd);
 }
 
+static int atapi_qc_complete_sense(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+
+	if (ata_ok(drv_stat))
+		cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
+	else
+		ata_to_sense_error(qc, drv_stat);
+
+	qc->ap->flags &= ~ATA_FLAG_IN_EH;
+	qc->scsidone(cmd);
+	return 0;
+}
+
+static void atapi_request_sense(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	int rc;
+
+	DPRINTK("ATAPI request sense\n");
+
+	/* FIXME: is this needed? */
+	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
+
+	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
+	qc->dma_dir = DMA_FROM_DEVICE;
+
+	memset(&qc->cdb, 0, ap->cdb_len);
+	qc->cdb[0] = REQUEST_SENSE;
+	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
+
+	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	qc->tf.command = ATA_CMD_PACKET;
+
+	qc->tf.protocol = ATA_PROT_ATAPI;
+	qc->tf.lbam = (8 * 1024) & 0xff;
+	qc->tf.lbah = (8 * 1024) >> 8;
+	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
+
+	qc->complete_fn = atapi_qc_complete_sense;
+
+	rc = ata_qc_issue(qc);
+
+	if (rc) {
+		/* FIXME: complete failing command with an error */
+		ata_port_disable(ap);
+	}
+
+	/* FIXME: add timer for timeout of this command */
+	/* control flow continues in atapi_qc_complete_sense() */
+
+	DPRINTK("EXIT\n");
+}
+
 static int atapi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
 {
+	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
+	rmb();
+	if (ap->host->eh_active)
+		return 1;
+
 	if (unlikely(drv_stat & (ATA_BUSY | ATA_DRQ)))
 		ata_to_sense_error(qc, drv_stat);
+
 	else if (unlikely(drv_stat & ATA_ERR)) {
 		DPRINTK("request check condition\n");
-
-		/* FIXME: command completion with check condition
-		 * but no sense causes the error handler to run,
-		 * which then issues REQUEST SENSE, fills in the sense 
-		 * buffer, and completes the command (for the second
-		 * time).  We need to issue REQUEST SENSE some other
-		 * way, to avoid completing the command twice.
-		 */
-		cmd->result = SAM_STAT_CHECK_CONDITION;
-
-		qc->scsidone(cmd);
-
+		ap->flags |= ATA_FLAG_IN_EH;
+		atapi_request_sense(qc);
 		return 1;
-	} else {
+	}
+
+	else {
 		u8 *scsicmd = cmd->cmnd;
 
 		if (scsicmd[0] == INQUIRY) {
@@ -1535,6 +1588,7 @@ static int atapi_qc_complete(struct ata_
 
 	return 0;
 }
+
 /**
  *	atapi_xlat - Initialize PACKET taskfile
  *	@qc: command structure to be initialized
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -118,6 +118,7 @@ enum {
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
 					     * proper HSM is in place. */
+	ATA_FLAG_IN_EH		= (1 << 10),
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */

--------------030408040003030601010201--
