From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ATAPI error handling work
Date: Thu, 06 Oct 2005 06:09:04 -0400
Message-ID: <4344F7C0.4030803@pobox.com>
References: <43443CC7.5040706@pobox.com> <20051006053529.GA25976@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080800030403000409010808"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:2017 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750787AbVJFKJI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 06:09:08 -0400
In-Reply-To: <20051006053529.GA25976@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Douglas Gilbert <dougg@torque.net>

This is a multi-part message in MIME format.
--------------080800030403000409010808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
>  Hello, Jeff.
> 
> On Wed, Oct 05, 2005 at 04:51:19PM -0400, Jeff Garzik wrote:
> 
>>This is a work-in-progress, attempting to fix the death of libata 
>>whenever there is a SCSI error thrown to us...   IOW this fixes libata 
>>EH to properly fake autosensing, rather than kicking over to the SCSI EH 
>>thread for that purpose.
>>
> 
> 
>  Great.  I just have a few questions.  Oh.. BTW, against which head is
> the patch generated?  I couldn't get it applied cleanly to either
> upstream or ALL.

I applied fragments of the patch to 'upstream' branch, so you probably 
caught me after I had done that, which invalidated the patch.  I've 
attached the latest patch.


>>@@ -3174,17 +3106,35 @@ out:
>> void ata_eng_timeout(struct ata_port *ap)
>> {
>> 	struct ata_queued_cmd *qc;
>>+	struct ata_host_set *host_set = ap->host_set;
>>+	unsigned long flags;
>>+	int printed_message = 0;
>> 
>> 	DPRINTK("ENTER\n");
>> 
>>+	spin_lock_irqsave(&host_set->lock, flags);
>>+	while (ap->flags & ATA_FLAG_IN_EH) {
>>+		spin_unlock_irqrestore(&host_set->lock, flags);
>>+
>>+		if (!printed_message++)
>>+			printk(KERN_INFO "ata%u: waiting in timeout handler for EH\n",
>>+				ap->id);
>>+
>>+		msleep(250);
>>+
>>+		spin_lock_irqsave(&host_set->lock, flags);
>>+	}
>>+	spin_unlock_irqrestore(&host_set->lock, flags);
>>+
> 
> 
> 
>  I'm not really sure if synchronization around reqsense with
> ATA_FLAG_IN_EH is such a good idea for the following reasons.
> 
> * IMHO, tugging in request sense into the timeout window of the
>   original command is okay (or even better).

Not really:  we have to assume that time passed, so by relying on the 
SCSI EH timeout rather than a timer, the timeout is suddenly effectively 
random.  I want a definitive time length, since its likely REQUEST SENSE 
may need a longer timeout for some devices.

Second, the timeout for READ/WRITE commands is often smaller than it is 
for non-READ/WRITE commands.  We want much to ensure that we have 
sufficient time to handle REQUEST SENSE.


> * As long as we grab host_set lock while submitting request sense,
>   which we already does, the synchronization can be done safely in EH
>   proper.  libata EH isn't currently ready for this but other commands
>   are dealt the same way and fixing EH is the correct way, IMHO.

We grab the lock submitting request sense, but then we release it. 
ata_eng_timeout() could get called before the entire REQUEST SENSE 
process is completed.


>  Note that we really don't have to do anything special for timing out
> during request sense.  Once we fix EH/interrupt handler race, it can
> be handled the same way without any speical casing.

Yes, this is feasible.  We can simply wait for the timer (which doesn't 
exist yet) or atapi_qc_complete_sense() to clear the ATA_FLAG_IN_EH bit, 
at which point the EH timer takes over, or will do so shortly.


>> 	qc = ata_qc_from_tag(ap, ap->active_tag);
>>-	if (!qc) {
>>+	if (qc)
>>+		ata_qc_timeout(qc);
>>+	else {
>> 		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
>> 		       ap->id);
>> 		goto out;
>> 	}
>> 
>>-	ata_qc_timeout(qc);
>> 
>> out:
>> 	DPRINTK("EXIT\n");
> 
> 
> 
>  I think you were trying to kill goto out and the label by moving
> ata_qc_timeout() into if condition, no?  Currently, the goto out seem
> a bit funny.

The goto is gone in the most recent version :)


>>diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
>>--- a/drivers/scsi/libata-scsi.c
>>+++ b/drivers/scsi/libata-scsi.c
>>@@ -225,7 +225,7 @@ void ata_to_sense_error(struct ata_queue
>> 	};
>> 	int i = 0;
>> 
>>-	cmd->result = SAM_STAT_CHECK_CONDITION;
>>+	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
>> 
>> 	/*
>> 	 *	Is this an error we can process/parse
>>@@ -1468,7 +1468,7 @@ unsigned int ata_scsiop_report_luns(stru
>> void ata_scsi_badcmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *), u8 asc, u8 ascq)
>> {
>> 	DPRINTK("ENTER\n");
>>-	cmd->result = SAM_STAT_CHECK_CONDITION;
>>+	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
>> 
>> 	cmd->sense_buffer[0] = 0x70;
>> 	cmd->sense_buffer[2] = ILLEGAL_REQUEST;
>>@@ -1479,28 +1479,81 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
>> 	done(cmd);
>> }
>> 
>>+static int atapi_qc_complete_sense(struct ata_queued_cmd *qc, u8 drv_stat)
>>+{
>>+	struct scsi_cmnd *cmd = qc->scsicmd;
>>+
>>+	if (ata_ok(drv_stat))
>>+		cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
>>+	else
>>+		ata_to_sense_error(qc, drv_stat);
>>+
>>+	qc->ap->flags &= ~ATA_FLAG_IN_EH;
>>+	qc->scsidone(cmd);
>>+	return 0;
>>+}
>>+
>>+static void atapi_request_sense(struct ata_queued_cmd *qc)
>>+{
>>+	struct ata_port *ap = qc->ap;
>>+	struct scsi_cmnd *cmd = qc->scsicmd;
>>+	int rc;
>>+
>>+	DPRINTK("ATAPI request sense\n");
>>+
>>+	/* FIXME: is this needed? */
>>+	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
> 
> 
> 
>  This is just a side note as this part seems to be just copied from
> the original request_sense function.  Anyways, I think this isn't
> needed anymore.  SCSI ML seems to clear things pretty thoroughly these
> days.

Well, until I have the line of code pointed to me, its not important. 
Its not the hot path, so we can afford to do possibly-redundant work.


>>+	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
>>+	qc->dma_dir = DMA_FROM_DEVICE;
>>+
>>+	memset(&qc->cdb, 0, ap->cdb_len);
>>+	qc->cdb[0] = REQUEST_SENSE;
>>+	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
>>+
>>+	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>>+	qc->tf.command = ATA_CMD_PACKET;
>>+
>>+	qc->tf.protocol = ATA_PROT_ATAPI;
>>+	qc->tf.lbam = (8 * 1024) & 0xff;
>>+	qc->tf.lbah = (8 * 1024) >> 8;
>>+	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
>>+
>>+	qc->complete_fn = atapi_qc_complete_sense;
>>+
>>+	rc = ata_qc_issue(qc);
>>+
>>+	if (rc) {
>>+		/* FIXME: complete failing command with an error */
>>+		ata_port_disable(ap);
>>+	}
>>+
>>+	/* FIXME: add timer for timeout of this command */
>>+	/* control flow continues in atapi_qc_complete_sense() */
>>+
>>+	DPRINTK("EXIT\n");
>>+}
>>+
>> static int atapi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
>> {
>>+	struct ata_port *ap = qc->ap;
>> 	struct scsi_cmnd *cmd = qc->scsicmd;
>> 
>>+	rmb();
> 
> 
> 
>  I'm having difficult time understanding this rmb().  What is it
> protecting against?

Just paranoia, before reading ap->host->eh_active, which is tweaked by 
scsi_error.c.

	Jeff



--------------080800030403000409010808
Content-Type: text/plain;
 name="patch.atapi-autosense"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.atapi-autosense"

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -71,6 +71,7 @@ static int fgb(u32 bitmap);
 static int ata_choose_xfer_mode(struct ata_port *ap,
 				u8 *xfer_mode_out,
 				unsigned int *xfer_shift_out);
+static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
 static void __ata_qc_complete(struct ata_queued_cmd *qc);
 
 static unsigned int ata_unique_id = 1;
@@ -3037,32 +3038,11 @@ static void ata_qc_timeout(struct ata_qu
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
@@ -3101,7 +3081,6 @@ static void ata_qc_timeout(struct ata_qu
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
-out:
 	DPRINTK("EXIT\n");
 }
 
@@ -3127,19 +3106,33 @@ out:
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
 	if (qc)
 		ata_qc_timeout(qc);
-	else {
+	else
 		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
 		       ap->id);
-		goto out;
-	}
 
-out:
 	DPRINTK("EXIT\n");
 }
 
@@ -3207,7 +3200,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
+static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
 {
 	return 0;
 }
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1479,19 +1479,33 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
 	done(cmd);
 }
 
-void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
-			 struct scsi_cmnd *cmd)
+static int atapi_qc_complete_sense(struct ata_queued_cmd *qc, u8 drv_stat)
 {
-	DECLARE_COMPLETION(wait);
-	struct ata_queued_cmd *qc;
-	unsigned long flags;
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	int ok;
+
+	ok = ata_ok(drv_stat);
+	if (ok)
+		cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
+	else
+		ata_to_sense_error(qc, drv_stat);
+
+	DPRINTK("ATAPI request sense completion (sense %sretrieved)\n",
+		ok ? "" : "not ");
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
 	int rc;
 
 	DPRINTK("ATAPI request sense\n");
 
-	qc = ata_qc_new_init(ap, dev);
-	BUG_ON(qc == NULL);
-
 	/* FIXME: is this needed? */
 	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
 
@@ -1510,44 +1524,39 @@ void atapi_request_sense(struct ata_port
 	qc->tf.lbah = (8 * 1024) >> 8;
 	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
+	qc->complete_fn = atapi_qc_complete_sense;
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
 	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
-	if (rc)
+	if (rc) {
+		/* FIXME: complete failing command with an error */
 		ata_port_disable(ap);
-	else
-		wait_for_completion(&wait);
+	}
+
+	/* FIXME: add timer for timeout of this command */
+	/* control flow continues in atapi_qc_complete_sense() */
 
 	DPRINTK("EXIT\n");
 }
 
 static int atapi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
 {
+	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
 	VPRINTK("ENTER, drv_stat == 0x%x\n", drv_stat);
 
+	rmb();
+	if (ap->host->eh_active)
+		return 1;
+
 	if (unlikely(drv_stat & (ATA_BUSY | ATA_DRQ)))
 		ata_to_sense_error(qc, drv_stat);
 
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
 	}
 
@@ -1585,6 +1594,7 @@ static int atapi_qc_complete(struct ata_
 	qc->scsidone(cmd);
 	return 0;
 }
+
 /**
  *	atapi_xlat - Initialize PACKET taskfile
  *	@qc: command structure to be initialized
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -39,7 +39,6 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
-extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
@@ -52,8 +51,6 @@ extern void swap_buf_le16(u16 *buf, unsi
 
 
 /* libata-scsi.c */
-extern void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
-			 struct scsi_cmnd *cmd);
 extern void ata_scsi_scan_host(struct ata_port *ap);
 extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat);
 extern int ata_scsi_error(struct Scsi_Host *host);
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

--------------080800030403000409010808--
