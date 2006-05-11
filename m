From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/11] libata-eh-fw: update ata_scsi_error() for new EH
Date: Thu, 11 May 2006 21:27:24 +0900
Message-ID: <11473504443148-git-send-email-htejun@gmail.com>
References: <11473504433328-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:12770 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751655AbWEKM1f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:27:35 -0400
Received: by wr-out-0506.google.com with SMTP id i32so120724wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:27:34 -0700 (PDT)
In-Reply-To: <11473504433328-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_scsi_error() for new EH.  ata_scsi_error() is responsible
for claiming timed out qcs and invoking ->error_handler in safe and
synchronized manner.  As the state of the controller is unknown if a
qc has timed out, the port is frozen in such cases.

Note that ata_scsi_timed_out() isn't used for new EH.  This is because
a timed out qc cannot be claimed by EH without freezing the port and
freezing the port in ata_scsi_timed_out() results in unnecessary
abortion of other active qcs.  ata_scsi_timed_out() can be removed
once all drivers are converted to new EH.

While at it, add 'TODO: kill' comments to old EH functions.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |  136 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/libata.h   |    3 +
 2 files changed, 134 insertions(+), 5 deletions(-)

610d1ef7cf0e6a147bc190ebb2f55afabf764df4
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index cb4e2b8..0803231 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -44,6 +44,8 @@
 
 #include "libata.h"
 
+static void __ata_port_freeze(struct ata_port *ap);
+
 /**
  *	ata_scsi_timed_out - SCSI layer time out callback
  *	@cmd: timed out SCSI command
@@ -55,6 +57,8 @@
  *	from finishing it by setting EH_SCHEDULED and return
  *	EH_NOT_HANDLED.
  *
+ *	TODO: kill this function once old EH is gone.
+ *
  *	LOCKING:
  *	Called from timer context
  *
@@ -67,10 +71,16 @@ enum scsi_eh_timer_return ata_scsi_timed
 	struct ata_port *ap = ata_shost_to_port(host);
 	unsigned long flags;
 	struct ata_queued_cmd *qc;
-	enum scsi_eh_timer_return ret = EH_HANDLED;
+	enum scsi_eh_timer_return ret;
 
 	DPRINTK("ENTER\n");
 
+	if (ap->ops->error_handler) {
+		ret = EH_NOT_HANDLED;
+		goto out;
+	}
+
+	ret = EH_HANDLED;
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	if (qc) {
@@ -81,6 +91,7 @@ enum scsi_eh_timer_return ata_scsi_timed
 	}
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
+ out:
 	DPRINTK("EXIT, ret=%d\n", ret);
 	return ret;
 }
@@ -100,21 +111,132 @@ enum scsi_eh_timer_return ata_scsi_timed
 void ata_scsi_error(struct Scsi_Host *host)
 {
 	struct ata_port *ap = ata_shost_to_port(host);
+	spinlock_t *hs_lock = &ap->host_set->lock;
+	int i, repeat_cnt = ATA_EH_MAX_REPEAT;
+	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
-	/* synchronize with IRQ handler and port task */
-	spin_unlock_wait(&ap->host_set->lock);
+	/* synchronize with port task */
 	ata_port_flush_task(ap);
 
-	WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
+	/* synchronize with host_set lock and sort out timeouts */
 
-	ap->ops->eng_timeout(ap);
+	/* For new EH, all qcs are finished in one of three ways -
+	 * normal completion, error completion, and SCSI timeout.
+	 * Both cmpletions can race against SCSI timeout.  When normal
+	 * completion wins, the qc never reaches EH.  When error
+	 * completion wins, the qc has ATA_QCFLAG_FAILED set.
+	 *
+	 * When SCSI timeout wins, things are a bit more complex.
+	 * Normal or error completion can occur after the timeout but
+	 * before this point.  In such cases, both types of
+	 * completions are honored.  A scmd is determined to have
+	 * timed out iff its associated qc is active and not failed.
+	 */
+	if (ap->ops->error_handler) {
+		struct scsi_cmnd *scmd, *tmp;
+		int nr_timedout = 0;
+
+		spin_lock_irqsave(hs_lock, flags);
+
+		list_for_each_entry_safe(scmd, tmp, &host->eh_cmd_q, eh_entry) {
+			struct ata_queued_cmd *qc;
+
+			for (i = 0; i < ATA_MAX_QUEUE; i++) {
+				qc = __ata_qc_from_tag(ap, i);
+				if (qc->flags & ATA_QCFLAG_ACTIVE &&
+				    qc->scsicmd == scmd)
+					break;
+			}
+
+			if (i < ATA_MAX_QUEUE) {
+				/* the scmd has an associated qc */
+				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
+					/* which hasn't failed yet, timeout */
+					qc->err_mask |= AC_ERR_TIMEOUT;
+					qc->flags |= ATA_QCFLAG_FAILED;
+					nr_timedout++;
+				}
+			} else {
+				/* Normal completion occurred after
+				 * SCSI timeout but before this point.
+				 * Successfully complete it.
+				 */
+				scmd->retries = scmd->allowed;
+				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
+			}
+		}
 
+		/* If we have timed out qcs.  They belong to EH from
+		 * this point but the state of the controller is
+		 * unknown.  Freeze the port to make sure the IRQ
+		 * handler doesn't diddle with those qcs.  This must
+		 * be done atomically w.r.t. setting QCFLAG_FAILED.
+		 */
+		if (nr_timedout)
+			__ata_port_freeze(ap);
+
+		spin_unlock_irqrestore(hs_lock, flags);
+	} else
+		spin_unlock_wait(hs_lock);
+
+ repeat:
+	/* invoke error handler */
+	if (ap->ops->error_handler) {
+		/* clear EH pending */
+		spin_lock_irqsave(hs_lock, flags);
+		ap->flags &= ~ATA_FLAG_EH_PENDING;
+		spin_unlock_irqrestore(hs_lock, flags);
+
+		/* invoke EH */
+		ap->ops->error_handler(ap);
+
+		/* Exception might have happend after ->error_handler
+		 * recovered the port but before this point.  Repeat
+		 * EH in such case.
+		 */
+		spin_lock_irqsave(hs_lock, flags);
+
+		if (ap->flags & ATA_FLAG_EH_PENDING) {
+			if (--repeat_cnt) {
+				ata_port_printk(ap, KERN_INFO,
+					"EH pending after completion, "
+					"repeating EH (cnt=%d)\n", repeat_cnt);
+				spin_unlock_irqrestore(hs_lock, flags);
+				goto repeat;
+			}
+			ata_port_printk(ap, KERN_ERR, "EH pending after %d "
+					"tries, giving up\n", ATA_EH_MAX_REPEAT);
+		}
+
+		/* Clear host_eh_scheduled while holding hs_lock such
+		 * that if exception occurs after this point but
+		 * before EH completion, SCSI midlayer will
+		 * re-initiate EH.
+		 */
+		host->host_eh_scheduled = 0;
+
+		spin_unlock_irqrestore(hs_lock, flags);
+	} else {
+		WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
+		ap->ops->eng_timeout(ap);
+	}
+
+	/* finish or retry handled scmd's and clean up */
 	WARN_ON(host->host_failed || !list_empty(&host->eh_cmd_q));
 
 	scsi_eh_flush_done_q(&ap->eh_done_q);
 
+	/* clean up */
+	spin_lock_irqsave(hs_lock, flags);
+
+	if (ap->flags & ATA_FLAG_RECOVERED)
+		ata_port_printk(ap, KERN_INFO, "EH complete\n");
+	ap->flags &= ~ATA_FLAG_RECOVERED;
+
+	spin_unlock_irqrestore(hs_lock, flags);
+
 	DPRINTK("EXIT\n");
 }
 
@@ -133,6 +255,8 @@ void ata_scsi_error(struct Scsi_Host *ho
  *	an interrupt was not delivered to the driver, even though the
  *	transaction completed successfully.
  *
+ *	TODO: kill this function once old EH is gone.
+ *
  *	LOCKING:
  *	Inherited from SCSI layer (none, can sleep)
  */
@@ -198,6 +322,8 @@ static void ata_qc_timeout(struct ata_qu
  *	an interrupt was not delivered to the driver, even though the
  *	transaction completed successfully.
  *
+ *	TODO: kill this function once old EH is gone.
+ *
  *	LOCKING:
  *	Inherited from SCSI layer (none, can sleep)
  */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3f22eff..e4353cf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -225,6 +225,9 @@ enum {
 	ATA_PORT_PRIMARY	= (1 << 0),
 	ATA_PORT_SECONDARY	= (1 << 1),
 
+	/* max repeat if error condition is still set after ->error_handler */
+	ATA_EH_MAX_REPEAT	= 5,
+
 	/* how hard are we gonna try to probe/recover devices */
 	ATA_PROBE_MAX_TRIES	= 3,
 };
-- 
1.2.4


