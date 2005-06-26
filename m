From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH Linux 2.6.12 05/09] NCQ: implement NCQ helpers
Date: Mon, 27 Jun 2005 00:21:32 +0900 (KST)
Message-ID: <20050626152105.1323EE85@htj.dyndns.org>
References: <20050626152105.D86561FB@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:53269 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261317AbVFZPVn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 11:21:43 -0400
Received: by wproxy.gmail.com with SMTP id 57so220773wri
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 08:21:43 -0700 (PDT)
In-Reply-To: <20050626152105.D86561FB@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, linux-ide@vger.kernel.org

05_NCQ_add-ncq-helpers.patch

	This patch implements the following NCQ helpers to be used by
	specific drivers to implement interrupt and error handler.

	ata_ncq_complete()	: normal completion of commands
	ata_ncq_abort()		: error completion of commands
	ata_ncq_recover()	: EH recovery helper

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/libata-core.c |  186 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-scsi.c |   96 ++++++++++++++++++++++-
 drivers/scsi/libata.h      |    4 
 include/linux/libata.h     |    8 +
 4 files changed, 289 insertions(+), 5 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-06-27 00:20:29.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-06-27 00:20:30.000000000 +0900
@@ -3279,6 +3279,13 @@ static inline int ata_qc_issue_ok(struct
 {
 	if (qc->flags & ATA_QCFLAG_PREEMPT)
 		return 1;
+
+	/*
+	 * Recovery in progress.  Only PREEMPT commands allowed.
+	 */
+	if (ap->flags & (ATA_FLAG_NCQ_FAILED | ATA_FLAG_RECOVERY))
+		return 0;
+
 	/*
 	 * if people are already waiting for a queue drain, don't allow a
 	 * new 'lucky' queuer to get in there
@@ -3827,6 +3834,182 @@ irqreturn_t ata_interrupt (int irq, void
 	return IRQ_RETVAL(handled);
 }
 
+
+/*
+ * NCQ helpers
+ */
+
+/**
+ *	ata_ncq_complete - NCQ driver helper.  Complete requests normally.
+ *	@ap: port in question
+ *
+ *	Complete in-flight commands.  One device per port is assumed.
+ *	This functions is meant to be called from specific driver's
+ *	interrupt routine to complete requests normally.  On
+ *	invocation, if non-NCQ command was in-flight, it's completed
+ *	normally.  If NCQ commands were in-flight, Sactive register is
+ *	read and completed commands are processed.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+int ata_ncq_complete(struct ata_port *ap)
+{
+	int nr_done = 0;
+	unsigned long done_mask = 0;
+	unsigned tag;
+
+	if (ap->sactive) {
+		unsigned long new_sactive = scr_read(ap, SCR_ACTIVE);
+		done_mask = new_sactive ^ ap->sactive;
+
+		if (unlikely(done_mask & new_sactive)) {
+			printk(KERN_ERR "ata%u: illegal sactive transition (%08lx->%08lx)\n",
+			       ap->id, ap->sactive, new_sactive);
+			done_mask &= ~new_sactive;
+		}
+	} else if (ap->active_tag != ATA_TAG_POISON)
+		done_mask = 1 << ap->active_tag;
+
+	ata_for_each_tag(tag, done_mask) {
+		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
+		if (qc) {
+			ata_qc_complete(qc, 0);
+			nr_done++;
+		} else
+			printk(KERN_ERR "ata%u: missing tag %d\n", ap->id, tag);
+	}
+
+	return nr_done;
+}
+
+/**
+ *	ata_ncq_abort - NCQ driver helper.  Abort commands and invoke EH.
+ *	@ap: port in question.
+ *
+ *	Abort in-flight commands and invoke EH.  This function is
+ *	meant to be called from specific driver's interrupt routine to
+ *	indicate error.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+int ata_ncq_abort(struct ata_port *ap)
+{
+	int nr_aborted = 0;
+	unsigned long sactive = 0;
+	unsigned tag;
+
+	printk(KERN_WARNING "ata%u: aborting commands due to error.  "
+	       "active_tag %d, sactive %08lx\n",
+	       ap->id,
+	       ap->active_tag != ATA_TAG_POISON ? ap->active_tag : -1,
+	       ap->sactive);
+
+	if (ap->sactive) {
+		/* Complete successful requests before aborting. */
+		ata_ncq_complete(ap);
+		if (!ap->sactive)
+			printk(KERN_WARNING "ata%u: device reports successful "
+			       "completion of all NCQ commands after error\n",
+			       ap->id);
+		ap->flags |= ATA_FLAG_NCQ_FAILED;
+		sactive = ap->sactive;
+	} else if (ap->active_tag != ATA_TAG_POISON)
+		sactive = 1 << ap->active_tag;
+
+	ata_for_each_tag(tag, sactive) {
+		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
+		if (qc) {
+			ata_qc_complete_err(qc, 0xff, 0xff);
+			nr_aborted++;
+		} else
+			printk(KERN_ERR "ata%u: missing tag %d\n", ap->id, tag);
+	}
+
+	return nr_aborted;
+}
+
+static inline int ata_read_log_10h(struct ata_port *ap, unsigned *tagp,
+				   u8 *drv_statp, u8 *drv_errp)
+{
+	char *buffer;
+	int rc;
+
+	if (!(buffer = kmalloc(512, GFP_KERNEL))) {
+		printk(KERN_ERR "ata%u: unable to allocate memory for error\n",
+		       ap->id);
+		return -ENOMEM;
+	}
+
+	if ((rc = ata_read_log_page(ap, 0, READ_LOG_SATA_NCQ_PAGE,
+				    buffer, 1, ATA_READLOG_10H_TIMEOUT)) < 0) {
+		printk(KERN_ERR "ata%u: failed to read log page 10h (%d)\n",
+		       ap->id, rc);
+		goto out;
+	}
+
+	if (buffer[0] & 0x80) {
+		printk(KERN_INFO "ata%u: NQ bit set on log page 10h, timeout?\n",
+		       ap->id);
+		rc = -EIO;
+		goto out;
+	}
+
+	*tagp = buffer[0] & 0x1f;
+	*drv_statp = buffer[2] | ATA_ERR;
+	*drv_errp = buffer[3];
+	rc = 0;
+ out:
+	kfree(buffer);
+	return rc;
+}
+
+/**
+ *	ata_ncq_recover - NCQ driver helper.  Recover from error.
+ *	@ap: port in question
+ *	@did_reset: specific driver performed reset.  Log page 10h might
+ *		    be invalid.
+ *
+ *	This function is to be called from eng_timeout routine of
+ *	specific drivers.  Before calling this function, specific
+ *	drivers are required to
+ *
+ *	- Clear all in-flight requests.  Drivers only have to clear
+ *	  low-level state (like stopping DMA engine and clearing
+ *	  interrupts).  All generic command cancelling are dealt by
+ *	  libata-core layer.
+ *
+ *	- Make the controller ready for new commands.
+ *
+ *	LOCKING:
+ *	Inherited from SCSI layer (in EH context, can sleep)
+ */
+void ata_ncq_recover(struct ata_port *ap, int did_reset)
+{
+	unsigned ncq_abort_tag = ATA_TAG_POISON;
+	u8 stat = 0, err = 0;
+
+	printk(KERN_WARNING "ata%u: recovering from error\n", ap->id);
+
+	if ((ap->flags & ATA_FLAG_NCQ_FAILED) && !did_reset) {
+		if (ata_read_log_10h(ap, &ncq_abort_tag, &stat, &err) == 0)
+			printk(KERN_INFO "ata%u: log_ext_10h, tag=%d stat=%02x err=%02x\n",
+			       ap->id, ncq_abort_tag, stat, err);
+		else {
+			printk(KERN_WARNING "ata%u: resetting...\n", ap->id);
+			ap->ops->phy_reset(ap);
+		}
+	}
+
+	spin_lock_irq(&ap->host_set->lock);
+	ap->flags &= ~ATA_FLAG_NCQ_FAILED;
+	spin_unlock_irq(&ap->host_set->lock);
+
+	ata_scsi_error_abort_cmds(ap, ncq_abort_tag, stat, err);
+}
+
 /**
  *	atapi_packet_task - Write CDB bytes to hardware
  *	@_data: Port to which ATAPI device is attached.
@@ -4683,6 +4866,9 @@ EXPORT_SYMBOL_GPL(ata_scsi_block_request
 EXPORT_SYMBOL_GPL(ata_scsi_unblock_requests);
 EXPORT_SYMBOL_GPL(ata_scsi_requeue);
 EXPORT_SYMBOL_GPL(ata_read_log_page);
+EXPORT_SYMBOL_GPL(ata_ncq_complete);
+EXPORT_SYMBOL_GPL(ata_ncq_abort);
+EXPORT_SYMBOL_GPL(ata_ncq_recover);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-06-27 00:20:29.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-06-27 00:20:30.000000000 +0900
@@ -162,6 +162,8 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 	 */
 	if (ap->cmd_waiters)
 		return NULL;
+	if (ap->flags & (ATA_FLAG_NCQ_FAILED | ATA_FLAG_RECOVERY))
+		return NULL;
 	if (ap->flags & ATA_FLAG_INFLIGHT) {
 		if (!scsi_rw_ncq_request(dev, cmd))
 			return NULL;
@@ -478,19 +480,103 @@ int ata_scsi_error(struct Scsi_Host *hos
 
 	DPRINTK("ENTER\n");
 
+	spin_lock_irq(&ap->host_set->lock);
+	ap->flags |= ATA_FLAG_RECOVERY;
+	spin_unlock_irq(&ap->host_set->lock);
+
 	ap->ops->eng_timeout(ap);
 
-	/* TODO: this is per-command; when queueing is supported
-	 * this code will either change or move to a more
-	 * appropriate place
-	 */
-	host->host_failed--;
+	spin_lock_irq(&ap->host_set->lock);
+	host->host_failed = 0;
+	ap->flags &= ~ATA_FLAG_RECOVERY;
+	if (ap->cmd_waiters)
+		wake_up(&ap->cmd_wait_queue);
+	spin_unlock_irq(&ap->host_set->lock);
 
 	DPRINTK("EXIT\n");
 	return 0;
 }
 
 /**
+ *	ata_scsi_error_abort_cmds - Finish EH processing of SCSI commands
+ *	@ap: ATA port in recovery
+ *	@ncq_abort_tag: tag of the failed request in NCQ error
+ *	@ncq_abort_stat: Status register value for the failed request
+ *	@ncq_abort_err: Error register value for the failed request
+ *
+ *	Abort or retry SCSI commands after EH handling.  If
+ *	ncq_abort_tag is a valid tag value (not ATA_TAG_POISON), only
+ *	the command is failed and others are retried.  Otherwise, all
+ *	inflight commands are failed.  This function can handle both
+ *	aborted (by interrupt handler) and timedout commands.
+ *
+ *	LOCKING:
+ *	Inherited from SCSI layer (in EH context, can sleep)
+ */
+void ata_scsi_error_abort_cmds(struct ata_port *ap, unsigned ncq_abort_tag,
+			       u8 ncq_abort_stat, u8 ncq_abort_err)
+{
+	unsigned long active_mask;
+	unsigned tag;
+	struct ata_queued_cmd *qc;
+	struct Scsi_Host *shost = ap->host;
+	LIST_HEAD(cmds);
+	struct scsi_cmnd *ncq_abort_scmd = NULL, *scmd;
+	struct list_head *le, *tmp;
+
+	spin_lock_irq(&ap->host_set->lock);
+	list_splice_init(&shost->eh_cmd_q, &cmds);
+	spin_unlock_irq(&ap->host_set->lock);
+
+	if (ncq_abort_tag != ATA_TAG_POISON)
+		ncq_abort_scmd = ap->qcmd[ncq_abort_tag].scsicmd;
+
+	/*
+	 * Kill all active commands.
+	 */
+	if (ap->active_tag != ATA_TAG_POISON)
+		active_mask = 1 << ap->active_tag;
+	else
+		active_mask = ap->sactive;
+
+	ata_for_each_tag(tag, active_mask) {
+		u8 stat, err;
+		qc = &ap->qcmd[tag];
+
+		if (ncq_abort_scmd && qc->scsicmd != ncq_abort_scmd) {
+			qc->scsidone = (void *)scsi_retry_command;
+			stat = 0;
+			err = 0;
+		} else {
+			qc->scsidone = scsi_finish_command;
+			stat = ncq_abort_scmd ? ncq_abort_stat : ATA_ERR;
+			err = ncq_abort_scmd ? ncq_abort_err : 0x80;
+		}
+
+		if (qc->scsicmd)
+			list_del_init(&qc->scsicmd->eh_entry);
+		ata_qc_complete_err(qc, stat, err);
+	}
+
+	/*
+	 * Finish off commands qc-completed by interrupt handler.
+	 */
+	list_for_each_safe(le, tmp, &cmds) {
+		scmd = list_entry(le, struct scsi_cmnd, eh_entry);
+
+		if (ncq_abort_scmd && scmd != ncq_abort_scmd)
+			scsi_retry_command(scmd);
+		else {
+			u8 stat, err;
+			stat = ncq_abort_scmd ? ncq_abort_stat : ATA_ERR;
+			err = ncq_abort_scmd ? ncq_abort_err : 0x80;
+			ata_to_sense_error(scmd, ap->id, stat, err);
+			scsi_finish_command(scmd);
+		}
+	}
+}
+
+/**
  *	ata_scsi_flush_xlat - Translate SCSI SYNCHRONIZE CACHE command
  *	@qc: Storage for translated ATA taskfile
  *	@scsicmd: SCSI command to translate (ignored)
Index: work/drivers/scsi/libata.h
===================================================================
--- work.orig/drivers/scsi/libata.h	2005-06-27 00:20:28.000000000 +0900
+++ work/drivers/scsi/libata.h	2005-06-27 00:20:30.000000000 +0900
@@ -28,6 +28,10 @@
 #define DRV_NAME	"libata"
 #define DRV_VERSION	"1.11"	/* must be exactly four chars */
 
+#define ata_for_each_tag(tag, mask) \
+	for (tag = find_first_bit(&mask, ATA_MAX_CMDS); tag < ATA_MAX_CMDS; \
+	     tag = find_next_bit(&mask, ATA_MAX_CMDS, tag + 1))
+
 struct ata_scsi_args {
 	u16			*id;
 	struct scsi_cmnd	*cmd;
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-06-27 00:20:29.000000000 +0900
+++ work/include/linux/libata.h	2005-06-27 00:20:30.000000000 +0900
@@ -87,6 +87,7 @@ enum {
 	ATA_MAX_BUS		= 2,
 	ATA_DEF_BUSY_WAIT	= 10000,
 	ATA_SHORT_PAUSE		= (HZ >> 6) + 1,
+	ATA_READLOG_10H_TIMEOUT	= 5000,	/* in milliseconds */
 
 	ATA_SHT_EMULATED	= 1,
 	ATA_SHT_CMD_PER_LUN	= 1,
@@ -118,6 +119,8 @@ enum {
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 	ATA_FLAG_NCQ		= (1 << 9), /* Can do NCQ */
 	ATA_FLAG_INFLIGHT	= (1 << 10), /* Command(s) in flight */
+	ATA_FLAG_NCQ_FAILED	= (1 << 11), /* NCQ command(s) failed */
+	ATA_FLAG_RECOVERY	= (1 << 12), /* Recovery in progress */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
@@ -405,6 +408,8 @@ extern int ata_scsi_detect(Scsi_Host_Tem
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
 extern int ata_scsi_error(struct Scsi_Host *host);
+extern void ata_scsi_error_abort_cmds(struct ata_port *ap, unsigned ncq_abort_tag,
+				      u8 ncq_abort_stat, u8 ncq_abort_err);
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 /*
@@ -453,6 +458,9 @@ extern void ata_scsi_unblock_requests(st
 extern void ata_scsi_requeue(struct ata_queued_cmd *);
 extern int ata_read_log_page(struct ata_port *, unsigned int, char, char *,
 			     unsigned int, unsigned int);
+extern int ata_ncq_complete(struct ata_port *);
+extern int ata_ncq_abort(struct ata_port *);
+extern void ata_ncq_recover(struct ata_port *, int);
 
 
 #ifdef CONFIG_PCI

