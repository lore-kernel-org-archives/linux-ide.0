From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: implement ata_exec_internal()
Date: Sun, 11 Dec 2005 13:23:03 +0900
Message-ID: <20051211042303.GA29403@htj.dyndns.org>
References: <20051128164201.GA7530@htj.dyndns.org> <438C0645.3020301@tw.ibm.com> <20051129131717.GA8505@htj.dyndns.org> <43924B5A.1070904@pobox.com> <4392F78A.2040209@gmail.com> <439341C2.5090205@pobox.com> <43994F85.7040300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:8549 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751325AbVLKEXI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Dec 2005 23:23:08 -0500
Received: by zproxy.gmail.com with SMTP id 14so1276772nzn
        for <linux-ide@vger.kernel.org>; Sat, 10 Dec 2005 20:23:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <43994F85.7040300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org

This patch implements ata_exec_internal() function which performs
libata internal command execution.  Previously, this was done by each
user by manually initializing a qc, issueing it, waiting for its
completion and handling errors.  In addition to obvious code
factoring, using ata_exec_internal() fixes the following bugs.

* qc not freed on issue failure
* ap->qactive clearing could race with the next internal command
* race between timeout handling and irq
* ignoring error condition not represented in tf->status

Also, qc & hardware are not accessed anymore once it's completed,
making internal commands more conformant with general semantics.
ata_exec_internal() also makes it easy to issue internal commands from
multiple threads if that becomes necessary.

This patch only implements ata_exec_internal().  A following patch
will convert all users.

Signed-off-by: Tejun Heo <htejun@gmail.com>

--

Jeff, this is the third posting of this patchset.  Changes from the
second posting are

* adapted to late qc->err_mask change

Changes to the second posting from the first are

* no ata_busy_sleep
* no ->complete_data
* timeout is always an AC_ERR_OTHER error
* patches splitted

Thanks.


Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-12-11 12:54:06.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-12-11 12:54:07.000000000 +0900
@@ -1047,6 +1047,107 @@ static unsigned int ata_pio_modes(const 
 	return modes;
 }
 
+struct ata_exec_internal_arg {
+	unsigned int err_mask;
+	struct ata_taskfile *tf;
+	struct completion *waiting;
+};
+
+int ata_qc_complete_internal(struct ata_queued_cmd *qc)
+{
+	struct ata_exec_internal_arg *arg = qc->private_data;
+	struct completion *waiting = arg->waiting;
+
+	if (!(qc->err_mask & ~AC_ERR_DEV))
+		qc->ap->ops->tf_read(qc->ap, arg->tf);
+	arg->err_mask = qc->err_mask;
+	arg->waiting = NULL;
+	complete(waiting);
+
+	return 0;
+}
+
+/**
+ *	ata_exec_internal - execute libata internal command
+ *	@ap: Port to which the command is sent
+ *	@dev: Device to which the command is sent
+ *	@tf: Taskfile registers for the command and the result
+ *	@dma_dir: Data tranfer direction of the command
+ *	@buf: Data buffer of the command
+ *	@buflen: Length of data buffer
+ *
+ *	Executes libata internal command with timeout.  @tf contains
+ *	command on entry and result on return.  Timeout and error
+ *	conditions are reported via return value.  No recovery action
+ *	is taken after a command times out.  It's caller's duty to
+ *	clean up after timeout.
+ *
+ *	LOCKING:
+ *	None.  Should be called with kernel context, might sleep.
+ */
+
+static unsigned
+ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
+		  struct ata_taskfile *tf,
+		  int dma_dir, void *buf, unsigned int buflen)
+{
+	u8 command = tf->command;
+	struct ata_queued_cmd *qc;
+	DECLARE_COMPLETION(wait);
+	unsigned long flags;
+	struct ata_exec_internal_arg arg;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	qc = ata_qc_new_init(ap, dev);
+	BUG_ON(qc == NULL);
+
+	qc->tf = *tf;
+	qc->dma_dir = dma_dir;
+	if (dma_dir != DMA_NONE) {
+		ata_sg_init_one(qc, buf, buflen);
+		qc->nsect = buflen / ATA_SECT_SIZE;
+		printk("dma_dir=%d buflen=%u nsect=%d\n",
+		       dma_dir, buflen, qc->nsect);
+	}
+
+	arg.waiting = &wait;
+	arg.tf = tf;
+	qc->private_data = &arg;
+	qc->complete_fn = ata_qc_complete_internal;
+
+	if (ata_qc_issue(qc))
+		goto issue_fail;
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (!wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL)) {
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+
+		/* We're racing with irq here.  If we lose, the
+		 * following test prevents us from completing the qc
+		 * again.  If completion irq occurs after here but
+		 * before the caller cleans up, it will result in a
+		 * spurious interrupt.  We can live with that.
+		 */
+		if (arg.waiting) {
+			qc->err_mask = AC_ERR_OTHER;
+			ata_qc_complete(qc);
+			printk(KERN_WARNING "ata%u: qc timeout (cmd 0x%x)\n",
+			       ap->id, command);
+		}
+
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	}
+
+	return arg.err_mask;
+
+ issue_fail:
+	ata_qc_free(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	return AC_ERR_OTHER;
+}
+
 static int ata_qc_wait_err(struct ata_queued_cmd *qc,
 			   struct completion *wait)
 {
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-12-11 12:54:06.000000000 +0900
+++ work/include/linux/libata.h	2005-12-11 12:54:07.000000000 +0900
@@ -136,6 +136,8 @@ enum {
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* hueristic */
 	ATA_TMOUT_DATAOUT	= 30 * HZ,
 	ATA_TMOUT_DATAOUT_QUICK	= 5 * HZ,
+	ATA_TMOUT_INTERNAL	= 30 * HZ,
+	ATA_TMOUT_INTERNAL_QUICK = 5 * HZ,
 
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
