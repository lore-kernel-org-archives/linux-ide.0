From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add ap->pflags and move core dynamic flags to it
Date: Thu, 29 Jun 2006 01:29:30 +0900
Message-ID: <20060628162930.GA23844@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:1989 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751332AbWF1Q3R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 12:29:17 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3193832ugf
        for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 09:29:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, "Zhao, Forrest" <forrest.zhao@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>

ap->flags is way too clamped.  Separate out core dynamic flags to
ap->pflags.  ATA_FLAG_DISABLED is a dynamic flag but left alone as
it's referenced by a lot of LLDs and it's gonna be removed once all
LLDs are converted to new EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

I spent half an hour staring at the port flag constants trying to
figure out a way to add new flags for PMP and realized how silly it
was.  Most LLDs shouldn't be affected and compile will fail if
something isn't converted, so I guess this conversion is fairly safe.

If this gets ACK'ed, I'll regenerate PM patches on top of it.  Thanks.

 drivers/scsi/ahci.c        |    2 +-
 drivers/scsi/libata-core.c |   24 +++++++++++----------
 drivers/scsi/libata-eh.c   |   50 ++++++++++++++++++++++----------------------
 drivers/scsi/libata-scsi.c |    2 +-
 drivers/scsi/sata_sil.c    |    2 +-
 include/linux/libata.h     |   30 ++++++++++++++++----------
 6 files changed, 58 insertions(+), 52 deletions(-)

2e4dd6206d1396b904241ff60b9762aeffb58b32
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index f059467..54f01b2 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1052,7 +1052,7 @@ static void ahci_thaw(struct ata_port *a
 
 static void ahci_error_handler(struct ata_port *ap)
 {
-	if (!(ap->flags & ATA_FLAG_FROZEN)) {
+	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
 		ahci_stop_engine(ap);
 		ahci_start_engine(ap);
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 47fff7b..11f2257 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -908,7 +908,7 @@ void ata_port_queue_task(struct ata_port
 {
 	int rc;
 
-	if (ap->flags & ATA_FLAG_FLUSH_PORT_TASK)
+	if (ap->pflags & ATA_PFLAG_FLUSH_PORT_TASK)
 		return;
 
 	PREPARE_WORK(&ap->port_task, fn, data);
@@ -939,7 +939,7 @@ void ata_port_flush_task(struct ata_port
 	DPRINTK("ENTER\n");
 
 	spin_lock_irqsave(ap->lock, flags);
-	ap->flags |= ATA_FLAG_FLUSH_PORT_TASK;
+	ap->pflags |= ATA_PFLAG_FLUSH_PORT_TASK;
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	DPRINTK("flush #1\n");
@@ -958,7 +958,7 @@ void ata_port_flush_task(struct ata_port
 	}
 
 	spin_lock_irqsave(ap->lock, flags);
-	ap->flags &= ~ATA_FLAG_FLUSH_PORT_TASK;
+	ap->pflags &= ~ATA_PFLAG_FLUSH_PORT_TASK;
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	if (ata_msg_ctl(ap))
@@ -1010,7 +1010,7 @@ unsigned ata_exec_internal(struct ata_de
 	spin_lock_irqsave(ap->lock, flags);
 
 	/* no internal command while frozen */
-	if (ap->flags & ATA_FLAG_FROZEN) {
+	if (ap->pflags & ATA_PFLAG_FROZEN) {
 		spin_unlock_irqrestore(ap->lock, flags);
 		return AC_ERR_SYSTEM;
 	}
@@ -2633,7 +2633,7 @@ int ata_std_prereset(struct ata_port *ap
 
 	/* if SATA, resume phy */
 	if (ap->cbl == ATA_CBL_SATA) {
-		if (ap->flags & ATA_FLAG_LOADING)
+		if (ap->pflags & ATA_PFLAG_LOADING)
 			timing = sata_deb_timing_boot;
 		else
 			timing = sata_deb_timing_eh;
@@ -4286,7 +4286,7 @@ static struct ata_queued_cmd *ata_qc_new
 	unsigned int i;
 
 	/* no command while frozen */
-	if (unlikely(ap->flags & ATA_FLAG_FROZEN))
+	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
 		return NULL;
 
 	/* the last tag is reserved for internal command. */
@@ -4408,7 +4408,7 @@ void ata_qc_complete(struct ata_queued_c
 	 * taken care of.
 	 */
 	if (ap->ops->error_handler) {
-		WARN_ON(ap->flags & ATA_FLAG_FROZEN);
+		WARN_ON(ap->pflags & ATA_PFLAG_FROZEN);
 
 		if (unlikely(qc->err_mask))
 			qc->flags |= ATA_QCFLAG_FAILED;
@@ -5043,13 +5043,13 @@ int ata_device_resume(struct ata_device 
 {
 	struct ata_port *ap = dev->ap;
 
-	if (ap->flags & ATA_FLAG_SUSPENDED) {
+	if (ap->pflags & ATA_PFLAG_SUSPENDED) {
 		struct ata_device *failed_dev;
 
 		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 		ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
 
-		ap->flags &= ~ATA_FLAG_SUSPENDED;
+		ap->pflags &= ~ATA_PFLAG_SUSPENDED;
 		while (ata_set_mode(ap, &failed_dev))
 			ata_dev_disable(failed_dev);
 	}
@@ -5080,7 +5080,7 @@ int ata_device_suspend(struct ata_device
 
 	if (state.event != PM_EVENT_FREEZE)
 		ata_standby_drive(dev);
-	ap->flags |= ATA_FLAG_SUSPENDED;
+	ap->pflags |= ATA_PFLAG_SUSPENDED;
 	return 0;
 }
 
@@ -5451,7 +5451,7 @@ int ata_device_add(const struct ata_prob
 			ap->eh_info.probe_mask = (1 << ATA_MAX_DEVICES) - 1;
 			ap->eh_info.action |= ATA_EH_SOFTRESET;
 
-			ap->flags |= ATA_FLAG_LOADING;
+			ap->pflags |= ATA_PFLAG_LOADING;
 			ata_port_schedule_eh(ap);
 
 			spin_unlock_irqrestore(ap->lock, flags);
@@ -5519,7 +5519,7 @@ void ata_port_detach(struct ata_port *ap
 
 	/* tell EH we're leaving & flush EH */
 	spin_lock_irqsave(ap->lock, flags);
-	ap->flags |= ATA_FLAG_UNLOADING;
+	ap->pflags |= ATA_PFLAG_UNLOADING;
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	ata_port_wait_eh(ap);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index bf5a72a..f2f29a8 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -270,13 +270,13 @@ void ata_scsi_error(struct Scsi_Host *ho
 		ap->eh_context.i = ap->eh_info;
 		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
 
-		ap->flags |= ATA_FLAG_EH_IN_PROGRESS;
-		ap->flags &= ~ATA_FLAG_EH_PENDING;
+		ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
+		ap->pflags &= ~ATA_PFLAG_EH_PENDING;
 
 		spin_unlock_irqrestore(ap_lock, flags);
 
 		/* invoke EH.  if unloading, just finish failed qcs */
-		if (!(ap->flags & ATA_FLAG_UNLOADING))
+		if (!(ap->pflags & ATA_PFLAG_UNLOADING))
 			ap->ops->error_handler(ap);
 		else
 			ata_eh_finish(ap);
@@ -287,7 +287,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 		 */
 		spin_lock_irqsave(ap_lock, flags);
 
-		if (ap->flags & ATA_FLAG_EH_PENDING) {
+		if (ap->pflags & ATA_PFLAG_EH_PENDING) {
 			if (--repeat_cnt) {
 				ata_port_printk(ap, KERN_INFO,
 					"EH pending after completion, "
@@ -323,19 +323,19 @@ void ata_scsi_error(struct Scsi_Host *ho
 	/* clean up */
 	spin_lock_irqsave(ap_lock, flags);
 
-	if (ap->flags & ATA_FLAG_LOADING) {
-		ap->flags &= ~ATA_FLAG_LOADING;
+	if (ap->pflags & ATA_PFLAG_LOADING) {
+		ap->pflags &= ~ATA_PFLAG_LOADING;
 	} else {
-		if (ap->flags & ATA_FLAG_SCSI_HOTPLUG)
+		if (ap->pflags & ATA_PFLAG_SCSI_HOTPLUG)
 			queue_work(ata_aux_wq, &ap->hotplug_task);
-		if (ap->flags & ATA_FLAG_RECOVERED)
+		if (ap->pflags & ATA_PFLAG_RECOVERED)
 			ata_port_printk(ap, KERN_INFO, "EH complete\n");
 	}
 
-	ap->flags &= ~(ATA_FLAG_SCSI_HOTPLUG | ATA_FLAG_RECOVERED);
+	ap->pflags &= ~(ATA_PFLAG_SCSI_HOTPLUG | ATA_PFLAG_RECOVERED);
 
 	/* tell wait_eh that we're done */
-	ap->flags &= ~ATA_FLAG_EH_IN_PROGRESS;
+	ap->pflags &= ~ATA_PFLAG_EH_IN_PROGRESS;
 	wake_up_all(&ap->eh_wait_q);
 
 	spin_unlock_irqrestore(ap_lock, flags);
@@ -360,7 +360,7 @@ void ata_port_wait_eh(struct ata_port *a
  retry:
 	spin_lock_irqsave(ap->lock, flags);
 
-	while (ap->flags & (ATA_FLAG_EH_PENDING | ATA_FLAG_EH_IN_PROGRESS)) {
+	while (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS)) {
 		prepare_to_wait(&ap->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
 		spin_unlock_irqrestore(ap->lock, flags);
 		schedule();
@@ -489,7 +489,7 @@ void ata_qc_schedule_eh(struct ata_queue
 	WARN_ON(!ap->ops->error_handler);
 
 	qc->flags |= ATA_QCFLAG_FAILED;
-	qc->ap->flags |= ATA_FLAG_EH_PENDING;
+	qc->ap->pflags |= ATA_PFLAG_EH_PENDING;
 
 	/* The following will fail if timeout has already expired.
 	 * ata_scsi_error() takes care of such scmds on EH entry.
@@ -513,7 +513,7 @@ void ata_port_schedule_eh(struct ata_por
 {
 	WARN_ON(!ap->ops->error_handler);
 
-	ap->flags |= ATA_FLAG_EH_PENDING;
+	ap->pflags |= ATA_PFLAG_EH_PENDING;
 	scsi_schedule_eh(ap->host);
 
 	DPRINTK("port EH scheduled\n");
@@ -578,7 +578,7 @@ static void __ata_port_freeze(struct ata
 	if (ap->ops->freeze)
 		ap->ops->freeze(ap);
 
-	ap->flags |= ATA_FLAG_FROZEN;
+	ap->pflags |= ATA_PFLAG_FROZEN;
 
 	DPRINTK("ata%u port frozen\n", ap->id);
 }
@@ -646,7 +646,7 @@ void ata_eh_thaw_port(struct ata_port *a
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	ap->flags &= ~ATA_FLAG_FROZEN;
+	ap->pflags &= ~ATA_PFLAG_FROZEN;
 
 	if (ap->ops->thaw)
 		ap->ops->thaw(ap);
@@ -731,7 +731,7 @@ static void ata_eh_detach_dev(struct ata
 
 	if (ata_scsi_offline_dev(dev)) {
 		dev->flags |= ATA_DFLAG_DETACHED;
-		ap->flags |= ATA_FLAG_SCSI_HOTPLUG;
+		ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
 	}
 
 	/* clear per-dev EH actions */
@@ -761,7 +761,7 @@ static void ata_eh_about_to_do(struct at
 
 	spin_lock_irqsave(ap->lock, flags);
 	ata_eh_clear_action(dev, &ap->eh_info, action);
-	ap->flags |= ATA_FLAG_RECOVERED;
+	ap->pflags |= ATA_PFLAG_RECOVERED;
 	spin_unlock_irqrestore(ap->lock, flags);
 }
 
@@ -1027,7 +1027,7 @@ static void ata_eh_analyze_ncq_error(str
 	int tag, rc;
 
 	/* if frozen, we can't do much */
-	if (ap->flags & ATA_FLAG_FROZEN)
+	if (ap->pflags & ATA_PFLAG_FROZEN)
 		return;
 
 	/* is it NCQ device error? */
@@ -1327,7 +1327,7 @@ static void ata_eh_autopsy(struct ata_po
 	}
 
 	/* enforce default EH actions */
-	if (ap->flags & ATA_FLAG_FROZEN ||
+	if (ap->pflags & ATA_PFLAG_FROZEN ||
 	    all_err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT))
 		action |= ATA_EH_SOFTRESET;
 	else if (all_err_mask)
@@ -1385,7 +1385,7 @@ static void ata_eh_report(struct ata_por
 		return;
 
 	frozen = "";
-	if (ap->flags & ATA_FLAG_FROZEN)
+	if (ap->pflags & ATA_PFLAG_FROZEN)
 		frozen = " frozen";
 
 	if (ehc->i.dev) {
@@ -1465,7 +1465,7 @@ static int ata_eh_reset(struct ata_port 
 	struct ata_eh_context *ehc = &ap->eh_context;
 	unsigned int *classes = ehc->classes;
 	int tries = ATA_EH_RESET_TRIES;
-	int verbose = !(ap->flags & ATA_FLAG_LOADING);
+	int verbose = !(ap->pflags & ATA_PFLAG_LOADING);
 	unsigned int action;
 	ata_reset_fn_t reset;
 	int i, did_followup_srst, rc;
@@ -1636,7 +1636,7 @@ static int ata_eh_revalidate_and_attach(
 			}
 
 			spin_lock_irqsave(ap->lock, flags);
-			ap->flags |= ATA_FLAG_SCSI_HOTPLUG;
+			ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
 			spin_unlock_irqrestore(ap->lock, flags);
 		}
 	}
@@ -1673,7 +1673,7 @@ static int ata_eh_skip_recovery(struct a
 	struct ata_eh_context *ehc = &ap->eh_context;
 	int i;
 
-	if (ap->flags & ATA_FLAG_FROZEN || ata_port_nr_enabled(ap))
+	if (ap->pflags & ATA_PFLAG_FROZEN || ata_port_nr_enabled(ap))
 		return 0;
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
@@ -1744,7 +1744,7 @@ static int ata_eh_recover(struct ata_por
 	rc = 0;
 
 	/* if UNLOADING, finish immediately */
-	if (ap->flags & ATA_FLAG_UNLOADING)
+	if (ap->pflags & ATA_PFLAG_UNLOADING)
 		goto out;
 
 	/* skip EH if possible. */
@@ -1908,7 +1908,7 @@ void ata_do_eh(struct ata_port *ap, ata_
 	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 	       ata_postreset_fn_t postreset)
 {
-	if (!(ap->flags & ATA_FLAG_LOADING)) {
+	if (!(ap->pflags & ATA_PFLAG_LOADING)) {
 		ata_eh_autopsy(ap);
 		ata_eh_report(ap);
 	}
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 93d18a7..1946979 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2932,7 +2932,7 @@ void ata_scsi_hotplug(void *data)
 	struct ata_port *ap = data;
 	int i;
 
-	if (ap->flags & ATA_FLAG_UNLOADING) {
+	if (ap->pflags & ATA_PFLAG_UNLOADING) {
 		DPRINTK("ENTER/EXIT - unloading\n");
 		return;
 	}
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 51d86d7..5d52705 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -370,7 +370,7 @@ static void sil_host_intr(struct ata_por
 		 * during hardreset makes controllers with broken SIEN
 		 * repeat probing needlessly.
 		 */
-		if (!(ap->flags & ATA_FLAG_FROZEN)) {
+		if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 			ata_ehi_hotplugged(&ap->eh_info);
 			ap->eh_info.serror |= serror;
 		}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f4284bf..b5d247d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -160,22 +160,27 @@ enum {
 	ATA_FLAG_HRST_TO_RESUME	= (1 << 11), /* hardreset to resume phy */
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
-
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
-	ATA_FLAG_FLUSH_PORT_TASK = (1 << 14), /* flush port task */
 
-	ATA_FLAG_EH_PENDING	= (1 << 15), /* EH pending */
-	ATA_FLAG_EH_IN_PROGRESS	= (1 << 16), /* EH in progress */
-	ATA_FLAG_FROZEN		= (1 << 17), /* port is frozen */
-	ATA_FLAG_RECOVERED	= (1 << 18), /* recovery action performed */
-	ATA_FLAG_LOADING	= (1 << 19), /* boot/loading probe */
-	ATA_FLAG_UNLOADING	= (1 << 20), /* module is unloading */
-	ATA_FLAG_SCSI_HOTPLUG	= (1 << 21), /* SCSI hotplug scheduled */
+	/* The following flag belongs to ap->pflags but is kept in
+	 * ap->flags because it's referenced in many LLDs and will be
+	 * removed in not-too-distant future.
+	 */
+	ATA_FLAG_DISABLED	= (1 << 23), /* port is disabled, ignore it */
+
+	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
-	ATA_FLAG_DISABLED	= (1 << 22), /* port is disabled, ignore it */
-	ATA_FLAG_SUSPENDED	= (1 << 23), /* port is suspended (power) */
+	/* struct ata_port pflags */
+	ATA_PFLAG_EH_PENDING	= (1 << 0), /* EH pending */
+	ATA_PFLAG_EH_IN_PROGRESS = (1 << 1), /* EH in progress */
+	ATA_PFLAG_FROZEN	= (1 << 2), /* port is frozen */
+	ATA_PFLAG_RECOVERED	= (1 << 3), /* recovery action performed */
+	ATA_PFLAG_LOADING	= (1 << 4), /* boot/loading probe */
+	ATA_PFLAG_UNLOADING	= (1 << 5), /* module is unloading */
+	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 6), /* SCSI hotplug scheduled */
 
-	/* bits 24:31 of ap->flags are reserved for LLDD specific flags */
+	ATA_PFLAG_FLUSH_PORT_TASK = (1 << 16), /* flush port task */
+	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
@@ -486,6 +491,7 @@ struct ata_port {
 	const struct ata_port_operations *ops;
 	spinlock_t		*lock;
 	unsigned long		flags;	/* ATA_FLAG_xxx */
+	unsigned int		pflags; /* ATA_PFLAG_xxx */
 	unsigned int		id;	/* unique id req'd by scsi midlyr */
 	unsigned int		port_no; /* unique port #; from zero */
 	unsigned int		hard_port_no;	/* hardware port #; from zero */
-- 
1.3.2

