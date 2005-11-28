From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: implement ata_qc_exec_internal()
Date: Tue, 29 Nov 2005 01:42:01 +0900
Message-ID: <20051128164201.GA7530@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:7221 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751274AbVK1QmI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Nov 2005 11:42:08 -0500
Received: by zproxy.gmail.com with SMTP id 13so2514382nzn
        for <linux-ide@vger.kernel.org>; Mon, 28 Nov 2005 08:42:07 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Each user libata internal commands initializes a qc, issues it, waits
for its completion and checks for errors.  This patch factors internal
command execution sequence into ata_qc_exec_internal().  The function
also removes race condition between irq and timeout handling.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f1047a0..40c488e 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1047,28 +1047,73 @@ static unsigned int ata_pio_modes(const 
 	return modes;
 }
 
-static int ata_qc_wait_err(struct ata_queued_cmd *qc,
-			   struct completion *wait)
+/**
+ *	ata_qc_exec_internal - execute libata internal command
+ *	@qc: Command to execute
+ *
+ *	Executes libata internal command with timeout.  Timeout and
+ *	error conditions are reported via return value.  No recovery
+ *	action is taken after a command times out.  It's caller's duty
+ *	to clean up after timeout.
+ *
+ *	Also, note that error condition is checked after the qc is
+ *	completed, meaning that if another command is issued before
+ *	checking the condition, we get the wrong values.  As internal
+ *	cmds are used only for initialization and recovery, this
+ *	shouldn't cause any problem.
+ *
+ *	LOCKING:
+ *	None.  Should be called with kernel context, might sleep.
+ */
+
+static unsigned ata_qc_exec_internal(struct ata_queued_cmd *qc)
 {
-	int rc = 0;
+	struct ata_port *ap = qc->ap;
+	DECLARE_COMPLETION(wait);
+	unsigned long tmout_left;
+	unsigned int err_mask;
+	int rc;
 
-	if (wait_for_completion_timeout(wait, 30 * HZ) < 1) {
-		/* timeout handling */
-		unsigned int err_mask = ac_err_mask(ata_chk_status(qc->ap));
+	if (ata_busy_sleep(ap, ATA_TMOUT_INTERNAL_QUICK, ATA_TMOUT_INTERNAL))
+		return -ETIMEDOUT;
 
-		if (!err_mask) {
+	qc->complete_fn = ata_qc_complete_noop;
+	qc->waiting = &wait;
+
+	spin_lock_irq(&ap->host_set->lock);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irq(&ap->host_set->lock);
+
+	if (rc)
+		return AC_ERR_OTHER;
+
+	tmout_left = wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL);
+	err_mask = ac_err_mask(ata_chk_status(qc->ap));
+
+	if (!tmout_left) {
+		/* timeout handling */
+		if (!err_mask)
 			printk(KERN_WARNING "ata%u: slow completion (cmd %x)\n",
 			       qc->ap->id, qc->tf.command);
-		} else {
+		else
 			printk(KERN_WARNING "ata%u: qc timeout (cmd %x)\n",
 			       qc->ap->id, qc->tf.command);
-			rc = -EIO;
-		}
 
-		ata_qc_complete(qc, err_mask);
+		spin_lock_irq(&ap->host_set->lock);
+
+		/* We're racing with irq here.  If we lose, the
+		 * following test prevents us from completing the qc
+		 * again.  If completion irq occurs after here but
+		 * before the caller cleans up, it will result in a
+		 * spurious interrupt.  We can live with that.
+		 */
+		if (qc->flags & ATA_QCFLAG_ACTIVE)
+			ata_qc_complete(qc, err_mask);
+
+		spin_unlock_irq(&ap->host_set->lock);
 	}
 
-	return rc;
+	return err_mask;
 }
 
 /**
@@ -1100,9 +1145,8 @@ static void ata_dev_identify(struct ata_
 	u16 tmp;
 	unsigned long xfer_modes;
 	unsigned int using_edd;
-	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
-	unsigned long flags;
+	unsigned int err_mask;
 	int rc;
 
 	if (!ata_dev_present(dev)) {
@@ -1140,23 +1184,18 @@ retry:
 		DPRINTK("do ATAPI identify\n");
 	}
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
+	err_mask = ata_qc_exec_internal(qc);
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	if (err_mask) {
+		unsigned long flags;
 
-	if (rc)
-		goto err_out;
-	else
-		ata_qc_wait_err(qc, &wait);
+		if (err_mask & ~AC_ERR_DEV)
+			goto err_out;
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->ops->tf_read(ap, &qc->tf);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		ap->ops->tf_read(ap, &qc->tf);
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
-	if (qc->tf.command & ATA_ERR) {
 		/*
 		 * arg!  EDD works for all test cases, but seems to return
 		 * the ATA signature for some ATAPI devices.  Until the
@@ -2288,10 +2327,7 @@ static int ata_choose_xfer_mode(const st
 
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
 {
-	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
-	int rc;
-	unsigned long flags;
 
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
@@ -2305,17 +2341,11 @@ static void ata_dev_set_xfermode(struct 
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
+	if (ata_qc_exec_internal(qc)) {
+		printk(KERN_ERR "ata%u: failed to set xfermode, disabled\n",
+		       ap->id);
 		ata_port_disable(ap);
-	else
-		ata_qc_wait_err(qc, &wait);
+	}
 
 	DPRINTK("EXIT\n");
 }
@@ -2330,10 +2360,7 @@ static void ata_dev_set_xfermode(struct 
 
 static void ata_dev_reread_id(struct ata_port *ap, struct ata_device *dev)
 {
-	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
-	unsigned long flags;
-	int rc;
 
 	qc = ata_qc_new_init(ap, dev);
 	BUG_ON(qc == NULL);
@@ -2353,18 +2380,9 @@ static void ata_dev_reread_id(struct ata
 	qc->tf.protocol = ATA_PROT_PIO;
 	qc->nsect = 1;
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	if (rc)
+	if (ata_qc_exec_internal(qc))
 		goto err_out;
 
-	ata_qc_wait_err(qc, &wait);
-
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
 	ata_dump_id(dev);
@@ -2373,6 +2391,7 @@ static void ata_dev_reread_id(struct ata
 
 	return;
 err_out:
+	printk(KERN_ERR "ata%u: failed to reread ID, disabled\n", ap->id);
 	ata_port_disable(ap);
 }
 
@@ -2386,10 +2405,7 @@ err_out:
 
 static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev)
 {
-	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
-	int rc;
-	unsigned long flags;
 	u16 sectors = dev->id[6];
 	u16 heads   = dev->id[3];
 
@@ -2409,17 +2425,11 @@ static void ata_dev_init_params(struct a
 	qc->tf.nsect = sectors;
 	qc->tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
 
-	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	rc = ata_qc_issue(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	if (rc)
+	if (ata_qc_exec_internal(qc)) {
+		printk(KERN_ERR "ata%u: failed to init parameters, disabled\n",
+		       ap->id);
 		ata_port_disable(ap);
-	else
-		ata_qc_wait_err(qc, &wait);
+	}
 
 	DPRINTK("EXIT\n");
 }
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9aa10df..2fe64f6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -136,6 +136,8 @@ enum {
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* hueristic */
 	ATA_TMOUT_DATAOUT	= 30 * HZ,
 	ATA_TMOUT_DATAOUT_QUICK	= 5 * HZ,
+	ATA_TMOUT_INTERNAL	= 30 * HZ,
+	ATA_TMOUT_INTERNAL_QUICK = 5 * HZ,
 
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
