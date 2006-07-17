From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/12] libata: implement powersave timer
Date: Mon, 17 Jul 2006 15:52:32 +0900
Message-ID: <11531191522801-git-send-email-htejun@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:65383 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932340AbWGQGvz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:55 -0400
Received: by py-out-1112.google.com with SMTP id x31so3883143pye
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:21 -0700 (PDT)
In-Reply-To: <11531191512028-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement powersave timer.  It is primarily for OS-driven HIPS
implementation but can be used for any other PS purpose LLD sees fit.
During normal operation, PS timer is automatically started with
timeout ap->ps_timeout on port idle and stopped when the port becomes
busy.  The timer is also stopped while EH.

To minimize overhead and allow easy implementation of expected
operation model, ata_ps_timer_worker() is used as timer callback which
invokes LLD supplied ap->ps_timer_fn() if condition meets and also
helps implementing sequenced multi-step operation.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   90 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/libata-eh.c   |   19 +++++++++
 drivers/scsi/libata.h      |    1 
 include/linux/libata.h     |    8 ++++
 4 files changed, 116 insertions(+), 2 deletions(-)

aa69e4ca8379e6db85e133f8e25bba00961201c7
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b968b44..1658cd1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4425,13 +4425,15 @@ void ata_qc_complete(struct ata_queued_c
 	 * taken care of.
 	 */
 	if (ap->ops->error_handler) {
+		int internal = ata_tag_internal(qc->tag);
+
 		WARN_ON(ap->pflags & ATA_PFLAG_FROZEN);
 
 		if (unlikely(qc->err_mask))
 			qc->flags |= ATA_QCFLAG_FAILED;
 
 		if (unlikely(qc->flags & ATA_QCFLAG_FAILED)) {
-			if (!ata_tag_internal(qc->tag)) {
+			if (!internal) {
 				/* always fill result TF for failed qc */
 				ap->ops->tf_read(ap, &qc->result_tf);
 				ata_qc_schedule_eh(qc);
@@ -4444,6 +4446,13 @@ void ata_qc_complete(struct ata_queued_c
 			ap->ops->tf_read(ap, &qc->result_tf);
 
 		__ata_qc_complete(qc);
+
+		/* update PS timer */
+		if ((ap->pflags & ATA_PFLAG_PS_TIMER) &&
+		    !ap->qc_active && !internal) {
+			ap->ps_seq = 0;
+			mod_timer(&ap->ps_timer, jiffies + ap->ps_timeout);
+		}
 	} else {
 		if (qc->flags & ATA_QCFLAG_EH_SCHEDULED)
 			return;
@@ -4551,6 +4560,9 @@ void ata_qc_issue(struct ata_queued_cmd 
 	 */
 	WARN_ON(ap->ops->error_handler && ata_tag_valid(ap->active_tag));
 
+	if (ap->pflags & ATA_PFLAG_PS_TIMER)
+		del_timer(&ap->ps_timer);
+
 	if (qc->tf.protocol == ATA_PROT_NCQ) {
 		WARN_ON(ap->sactive & (1 << qc->tag));
 		ap->sactive |= 1 << qc->tag;
@@ -5207,6 +5219,77 @@ void ata_host_set_resume(struct ata_host
 }
 
 /**
+ *	ata_kill_ps_timer - kill powersave timer
+ *	@ap: ATA port of interest
+ *
+ *	Kill powersave timer.  On return from this function, powersave
+ *	timer is guaranteed to be not pending && not running.
+ *
+ *	LOCKING:
+ *	None (must be called from EH context).
+ */
+void ata_kill_ps_timer(struct ata_port *ap)
+{
+	unsigned long flags;
+	int rc;
+
+	if (ap->pflags & ATA_PFLAG_PS_TIMER) {
+		do {
+			spin_lock_irqsave(ap->lock, flags);
+			rc = try_to_del_timer_sync(&ap->ps_timer);
+			ap->pflags &= ~ATA_PFLAG_PS_TIMER;
+			spin_unlock_irqrestore(ap->lock, flags);
+			cpu_relax();
+		} while (rc < 0);
+
+		ap->ps_timer_fn = NULL;
+		ap->ps_timeout = 0;
+	} else
+		BUG_ON(timer_pending(&ap->ps_timer));
+}
+
+/**
+ *	ata_ps_timer_worker - powersave timer worker
+ *	@arg: ATA port of interest
+ *
+ *	This function is called when ap->ps_timer expires.  If the
+ *	condition is right, it calls ap->ps_timer_fn() with the
+ *	current sequence number.
+ *
+ *	libata automatically arms and cancels PS timer on port idle
+ *	and command issue respectively.  libata also initializes
+ *	sequence number to zero when it arms PS timer because of port
+ *	idle.
+ *
+ *	ap->ps_timer_fn() can request requeue of PS timer by returning
+ *	non-zero value which will be used as timeout.  Each requeue
+ *	increments PS sequence number by one.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void ata_ps_timer_worker(unsigned long arg)
+{
+	struct ata_port *ap = (void *)arg;
+	unsigned long flags;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	if (!ap->qc_active && !timer_pending(&ap->ps_timer)) {
+		unsigned long next_timeout;
+
+		next_timeout = ap->ps_timer_fn(ap, ap->ps_seq);
+		if (next_timeout) {
+			ap->ps_seq++;
+			ap->ps_timer.expires = jiffies + next_timeout;
+			add_timer(&ap->ps_timer);
+		}
+	}
+
+	spin_unlock_irqrestore(ap->lock, flags);
+}
+
+/**
  *	ata_port_start - Set port up for dma.
  *	@ap: Port to initialize
  *
@@ -5439,6 +5522,7 @@ #endif
 	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan, ap);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
+	setup_timer(&ap->ps_timer, ata_ps_timer_worker, (unsigned long)ap);
 
 	/* set cable type */
 	ap->cbl = ATA_CBL_NONE;
@@ -5749,7 +5833,9 @@ void ata_port_detach(struct ata_port *ap
 	cancel_delayed_work(&ap->hotplug_task);
 	flush_workqueue(ata_aux_wq);
 
-	/* turn it off */
+	/* kill PS timer and power off */
+	ata_kill_ps_timer(ap);
+
 	if (ap->ops->set_powersave)
 		ap->ops->set_powersave(ap, ATA_PS_STATIC);
 
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index d5126b7..b19eaae 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -261,6 +261,9 @@ void ata_scsi_error(struct Scsi_Host *ho
 	} else
 		spin_unlock_wait(ap->lock);
 
+	/* kill powersave timer before beginning EH */
+	ata_kill_ps_timer(ap);
+
  repeat:
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
@@ -340,6 +343,14 @@ void ata_scsi_error(struct Scsi_Host *ho
 
 	ap->pflags &= ~(ATA_PFLAG_SCSI_HOTPLUG | ATA_PFLAG_RECOVERED);
 
+	/* start PS timer if requested */
+	if (ap->pflags & ATA_PFLAG_PS_TIMER) {
+		BUG_ON(!ap->ps_timer_fn || !ap->ps_timeout);
+		ap->ps_seq = 0;
+		ap->ps_timer.expires = jiffies + ap->ps_timeout;
+		add_timer(&ap->ps_timer);
+	}
+
 	/* tell wait_eh that we're done */
 	ap->pflags &= ~ATA_PFLAG_EH_IN_PROGRESS;
 	wake_up_all(&ap->eh_wait_q);
@@ -1876,11 +1887,13 @@ static int ata_eh_set_powersave(struct a
 	void (*set_ps)(struct ata_port *, int) = ap->ops->set_powersave;
 	int ps_state, ps_static, ps_dynamic;
 	int dev_dips, dev_hips, i;
+	unsigned long flags;
 
 	/* power up for recovery */
 	if (r_failed_dev == NULL) {
 		if (ap->ps_state && set_ps)
 			set_ps(ap, ATA_PS_NONE);
+		WARN_ON(ap->flags & ATA_PFLAG_PS_TIMER);
 		return 0;
 	}
 
@@ -1929,9 +1942,15 @@ static int ata_eh_set_powersave(struct a
 
 		err_mask = ata_dev_set_dips(dev, is_dips);
 		if (err_mask) {
+			spin_lock_irqsave(ap->lock, flags);
+			ap->pflags &= ~ATA_PFLAG_PS_TIMER;
+			spin_unlock_irqrestore(ap->lock, flags);
+
 			if (ps_state && set_ps)
 				set_ps(ap, ATA_PS_NONE);
+
 			*r_failed_dev = dev;
+
 			return -EIO;
 		}
 	}
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index ce44e06..9e44f56 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -74,6 +74,7 @@ extern void ata_dev_select(struct ata_po
                            unsigned int wait, unsigned int can_sleep);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 extern int ata_flush_cache(struct ata_device *dev);
+extern void ata_kill_ps_timer(struct ata_port *ap);
 extern void ata_dev_init(struct ata_device *dev);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b3f56c5..0881814 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -185,6 +185,7 @@ enum {
 	ATA_PFLAG_FLUSH_PORT_TASK = (1 << 16), /* flush port task */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
+	ATA_PFLAG_PS_TIMER	= (1 << 19), /* PS timer active */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
@@ -335,6 +336,7 @@ typedef void (*ata_qc_cb_t) (struct ata_
 typedef int (*ata_prereset_fn_t)(struct ata_port *ap);
 typedef int (*ata_reset_fn_t)(struct ata_port *ap, unsigned int *classes);
 typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *classes);
+typedef unsigned long (*ata_ps_timer_fn_t)(struct ata_port *ap, int seq);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -568,6 +570,12 @@ struct ata_port {
 	/* powersave (dynamic link power management) */
 	int			target_ps_state;
 	int			ps_state;
+	/* powersave timer, protected by ap->lock */
+	ata_ps_timer_fn_t	ps_timer_fn;	/* initialized by LLD */
+	unsigned long		ps_timeout;	/* ditto */
+
+	int			ps_seq;		/* managed by libata */
+	struct timer_list	ps_timer;	/* ditto */
 
 	/* power management (host suspend and resume) */
 	pm_message_t		pm_mesg;
-- 
1.3.2


