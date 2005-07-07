From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:ncq 01/11] libata: implement ata_qc_exec_special()
Date: Thu,  7 Jul 2005 22:09:18 +0900 (KST)
Message-ID: <20050707130840.08D28E71@htj.dyndns.org>
References: <20050707130840.5046338C@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.200]:15708 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261462AbVGGNJX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 09:09:23 -0400
Received: by wproxy.gmail.com with SMTP id i22so190930wra
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 06:09:23 -0700 (PDT)
In-Reply-To: <20050707130840.5046338C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

01_libata_implement-ata_qc_exec_special.patch

	This patch implements ata_qc_exec_special() function which
	generalizes libata internal special command execution and adds
	timeout.  All internal commands are converted.  Timeout
	constants are added to libata.h and, while at it, removed
	unused ATA_TMOUT_EDD.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/libata-core.c |  170 +++++++++++++++++++++++++++++----------------
 include/linux/libata.h     |    7 +
 2 files changed, 117 insertions(+), 60 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-07-07 22:08:35.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-07-07 22:08:35.000000000 +0900
@@ -59,7 +59,6 @@ static int fgb(u32 bitmap);
 static int ata_choose_xfer_mode(struct ata_port *ap,
 				u8 *xfer_mode_out,
 				unsigned int *xfer_shift_out);
-static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
 static void __ata_qc_complete(struct ata_queued_cmd *qc);
 
 static unsigned int ata_unique_id = 1;
@@ -70,6 +69,87 @@ MODULE_DESCRIPTION("Library module for A
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
+static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	return 0;
+}
+
+static void ata_qc_exec_special_timeout(unsigned long data)
+{
+	struct completion *wait = (void *)data;
+	complete(wait);
+}
+
+/**
+ *	ata_qc_exec_special - execute libata internal special command
+ *	@qc: Command to execute
+ *	@tmout: timeout in jiffies
+ *
+ *	Executes libata internal command with timeout.  Timeout and
+ *	error conditions are reported via return value.  No recovery
+ *	action is taken after a command times out.  It's caller's duto
+ *	to clean up after timeout.
+ *
+ *	Also, note that error condition is checked after the qc is
+ *	completed, meaning that if another command is issued before
+ *	checking the condition, we get the wrong values.  As special
+ *	cmds are used only for initialization and recovery, this
+ *	won't cause any problem currently.
+ *
+ *	LOCKING:
+ *	None.  Should be called with kernel context, might sleep.
+ */
+
+static int ata_qc_exec_special(struct ata_queued_cmd *qc, unsigned long tmout)
+{
+	struct ata_port *ap = qc->ap;
+	DECLARE_COMPLETION(wait);
+	struct timer_list timer;
+	int rc;
+
+	might_sleep();
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_SPECIAL_QUICK, ATA_TMOUT_SPECIAL))
+		return -ETIMEDOUT;
+
+	qc->complete_fn = ata_qc_complete_noop;
+	qc->waiting = &wait;
+
+	if (tmout) {
+		init_timer(&timer);
+		timer.function = ata_qc_exec_special_timeout;
+		timer.data = (unsigned long)&wait;
+		timer.expires = jiffies + tmout;
+		add_timer(&timer);
+	}
+
+	spin_lock_irq(&ap->host_set->lock);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irq(&ap->host_set->lock);
+
+	if (rc) {
+		if (tmout)
+			del_timer(&timer);
+		return -EAGAIN;	/* any better value for issue failure? */
+	}
+
+	wait_for_completion(&wait);
+
+	if (tmout && !del_timer(&timer)) {
+		spin_lock_irq(&ap->host_set->lock);
+		if (qc->waiting == &wait) {
+			ata_qc_complete(qc, 0);
+			rc = -ETIMEDOUT;
+		}
+		spin_unlock_irq(&ap->host_set->lock);
+	}
+
+	if (rc == 0 && !ata_ok(ata_chk_status(ap)))
+		rc = -EIO;
+
+	return rc;
+}
+
 /**
  *	ata_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
@@ -1126,9 +1206,7 @@ static void ata_dev_identify(struct ata_
 	unsigned long xfer_modes;
 	u8 status;
 	unsigned int using_edd;
-	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
-	unsigned long flags;
 	int rc;
 
 	if (!ata_dev_present(dev)) {
@@ -1166,20 +1244,19 @@ retry:
 		DPRINTK("do ATAPI identify\n");
 	}
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
+	rc = ata_qc_exec_special(qc, ATA_TMOUT_IDENTIFY);
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	switch (rc) {
+	case 0:
+		break;
+	case -EIO:
+		/* Device failed the command */
+		status = ata_chk_status(ap);
 
-	if (rc)
-		goto err_out;
-	else
-		wait_for_completion(&wait);
+		if (!(status & ATA_ERR))
+			/* Weird error condition, give up */
+			goto err_out;
 
-	status = ata_chk_status(ap);
-	if (status & ATA_ERR) {
 		/*
 		 * arg!  EDD works for all test cases, but seems to return
 		 * the ATA signature for some ATAPI devices.  Until the
@@ -1202,6 +1279,9 @@ retry:
 				goto retry;
 			}
 		}
+		/* Fall through */
+	default:
+		/* Issue failed or some other error */
 		goto err_out;
 	}
 
@@ -1326,10 +1406,7 @@ int ata_read_log_page(struct ata_port *a
 		      char *buffer, unsigned int sectors)
 {
 	struct ata_device *dev = &ap->device[device];
-	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
-	unsigned long flags;
-	int rc;
 
 	assert(dev->class == ATA_DEV_ATA);
 
@@ -1347,18 +1424,7 @@ int ata_read_log_page(struct ata_port *a
 	qc->tf.lbal = page;
 	qc->flags |= ATA_QCFLAG_PREEMPT;
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	if (rc)
-		return -EIO;
-
-	wait_for_completion(&wait);
-	return 0;
+	return ata_qc_exec_special(qc, ATA_TMOUT_READLOG);
 }
 
 /**
@@ -2133,10 +2199,8 @@ static int ata_choose_xfer_mode(struct a
 
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
 {
-	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
 	int rc;
-	unsigned long flags;
 
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
@@ -2150,17 +2214,13 @@ static void ata_dev_set_xfermode(struct 
 	qc->tf.protocol = ATA_PROT_NODATA;
 	qc->tf.nsect = dev->xfer_mode;
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	if (rc)
+	rc = ata_qc_exec_special(qc, ATA_TMOUT_SET_XFERMODE);
+	if (rc) {
+		printk(KERN_ERR "ata%u: failed to set xfermode, disabling... "
+		       "(rc=%d stat=0x%x err=0x%x)\n",
+		       ap->id, rc, ata_chk_status(ap), ata_chk_err(ap));
 		ata_port_disable(ap);
-	else
-		wait_for_completion(&wait);
+	}
 
 	DPRINTK("EXIT\n");
 }
@@ -2828,9 +2888,7 @@ static void ata_pio_task(void *_data)
 static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
 				struct scsi_cmnd *cmd)
 {
-	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
-	unsigned long flags;
 	int rc;
 
 	DPRINTK("ATAPI request sense\n");
@@ -2856,17 +2914,16 @@ static void atapi_request_sense(struct a
 	qc->tf.lbah = (8 * 1024) >> 8;
 	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
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
+	rc = ata_qc_exec_special(qc, ATA_TMOUT_REQUEST_SENSE);
+	if (rc) {
+		printk(KERN_WARNING "ata%u: failed to read sense data "
+		       "(rc=%d stat=0x%x err=0x%x)\n",
+		       ap->id, rc, ata_chk_status(ap), ata_chk_err(ap));
+		/*
+		 * If this happens, we're returning w/ NULL sense
+		 * data.  Upper layer can handle it.
+		 */
+	}
 
 	DPRINTK("EXIT\n");
 }
@@ -3049,11 +3106,6 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
-{
-	return 0;
-}
-
 static void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-07-07 22:08:35.000000000 +0900
+++ work/include/linux/libata.h	2005-07-07 22:08:35.000000000 +0900
@@ -129,12 +129,17 @@ enum {
 	ATA_QC_ISSUE_FATAL	= -1,
 
 	/* various lengths of time */
-	ATA_TMOUT_EDD		= 5 * HZ,	/* hueristic */
 	ATA_TMOUT_PIO		= 30 * HZ,
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* hueristic */
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* hueristic */
 	ATA_TMOUT_CDB		= 30 * HZ,
 	ATA_TMOUT_CDB_QUICK	= 5 * HZ,
+	ATA_TMOUT_SPECIAL	= 30 * HZ,
+	ATA_TMOUT_SPECIAL_QUICK	= 5 * HZ,
+	ATA_TMOUT_IDENTIFY	= 5 * HZ,	/* hueristic */
+	ATA_TMOUT_READLOG	= 5 * HZ,	/* hueristic */
+	ATA_TMOUT_SET_XFERMODE	= 5 * HZ,	/* hueristic */
+	ATA_TMOUT_REQUEST_SENSE	= 5 * HZ,	/* hueristic */
 
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,

