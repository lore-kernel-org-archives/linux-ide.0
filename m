From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 21/21] libata: implement EH fast drain
Date: Mon, 16 Jul 2007 14:29:41 +0900
Message-ID: <11845637812760-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:11877 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763955AbXGPF3y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:54 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736627nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:54 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

In most cases, when EH is scheduled, all in-flight commands are
aborted causing EH to kick in immediately.  However, in some cases
(especially with PMP), it's unclear which commands are affected by the
error condition and although aborting all in-flight commands work, it
isn't optimal and may cause unnecessary disruption.  On the other
hand, waiting for in-flight commands to drain themselves can take up
to 30seconds.

This patch implements EH fast drain to handle such situations.  It
gives in-flight commands some time to finish up but doesn't wait for
too long.  After EH is scheduled, fast drain timer is started and if
no other completion occurs in ATA_EH_FASTDRAIN_INTERVAL all in-flight
commands are aborted.  If any completion occurred in the interval, the
port is given another interval to finish up itself.

Currently ATA_EH_FASTDRAIN_INTERVAL is 3 secs which should be enough
for finishing up most commands.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    3 +
 drivers/ata/libata-eh.c   |   99 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h      |    1 +
 include/linux/libata.h    |    3 +
 4 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 155061e..9b1d179 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6076,6 +6076,9 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
+	init_timer_deferrable(&ap->fastdrain_timer);
+	ap->fastdrain_timer.function = ata_eh_fastdrain_timerfn;
+	ap->fastdrain_timer.data = (unsigned long)ap;
 
 	ap->cbl = ATA_CBL_NONE;
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index e7e2ba2..ac6ceed 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -56,6 +56,7 @@ enum {
  */
 enum {
 	ATA_EH_PRERESET_TIMEOUT		= 10 * HZ,
+	ATA_EH_FASTDRAIN_INTERVAL	= 3 * HZ,
 };
 
 /* The following table determines how we sequence resets.  Each entry
@@ -361,6 +362,9 @@ void ata_scsi_error(struct Scsi_Host *host)
  repeat:
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
+		/* kill fast drain timer */
+		del_timer_sync(&ap->fastdrain_timer);
+
 		/* process port resume request */
 		ata_eh_handle_port_resume(ap);
 
@@ -576,6 +580,94 @@ void ata_eng_timeout(struct ata_port *ap)
 	DPRINTK("EXIT\n");
 }
 
+static int ata_eh_nr_in_flight(struct ata_port *ap)
+{
+	unsigned int tag;
+	int nr = 0;
+
+	/* count only non-internal commands */
+	for (tag = 0; tag < ATA_MAX_QUEUE - 1; tag++)
+		if (ata_qc_from_tag(ap, tag))
+			nr++;
+
+	return nr;
+}
+
+void ata_eh_fastdrain_timerfn(unsigned long arg)
+{
+	struct ata_port *ap = (void *)arg;
+	unsigned long flags;
+	int cnt;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	cnt = ata_eh_nr_in_flight(ap);
+
+	/* are we done? */
+	if (!cnt)
+		goto out_unlock;
+
+	if (cnt == ap->fastdrain_cnt) {
+		unsigned int tag;
+
+		/* No progress during the last interval, tag all
+		 * in-flight qcs as timed out and freeze the port.
+		 */
+		for (tag = 0; tag < ATA_MAX_QUEUE - 1; tag++) {
+			struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
+			if (qc)
+				qc->err_mask |= AC_ERR_TIMEOUT;
+		}
+
+		ata_port_freeze(ap);
+	} else {
+		/* some qcs have finished, give it another chance */
+		ap->fastdrain_cnt = cnt;
+		ap->fastdrain_timer.expires =
+			jiffies + ATA_EH_FASTDRAIN_INTERVAL;
+		add_timer(&ap->fastdrain_timer);
+	}
+
+ out_unlock:
+	spin_unlock_irqrestore(ap->lock, flags);
+}
+
+/**
+ *	ata_eh_set_pending - set ATA_PFLAG_EH_PENDING and activate fast drain
+ *	@ap: target ATA port
+ *	@fastdrain: activate fast drain
+ *
+ *	Set ATA_PFLAG_EH_PENDING and activate fast drain if @fastdrain
+ *	is non-zero and EH wasn't pending before.  Fast drain ensures
+ *	that EH kicks in in timely manner.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+static void ata_eh_set_pending(struct ata_port *ap, int fastdrain)
+{
+	int cnt;
+
+	/* already scheduled? */
+	if (ap->pflags & ATA_PFLAG_EH_PENDING)
+		return;
+
+	ap->pflags |= ATA_PFLAG_EH_PENDING;
+
+	if (!fastdrain)
+		return;
+
+	/* do we have in-flight qcs? */
+	cnt = ata_eh_nr_in_flight(ap);
+	if (!cnt)
+		return;
+
+	/* activate fast drain */
+	ap->fastdrain_cnt = cnt;
+	ap->fastdrain_timer.expires = jiffies + ATA_EH_FASTDRAIN_INTERVAL;
+	add_timer(&ap->fastdrain_timer);
+}
+
 /**
  *	ata_qc_schedule_eh - schedule qc for error handling
  *	@qc: command to schedule error handling for
@@ -593,7 +685,7 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 	WARN_ON(!ap->ops->error_handler);
 
 	qc->flags |= ATA_QCFLAG_FAILED;
-	qc->ap->pflags |= ATA_PFLAG_EH_PENDING;
+	ata_eh_set_pending(ap, 1);
 
 	/* The following will fail if timeout has already expired.
 	 * ata_scsi_error() takes care of such scmds on EH entry.
@@ -620,7 +712,7 @@ void ata_port_schedule_eh(struct ata_port *ap)
 	if (ap->pflags & ATA_PFLAG_INITIALIZING)
 		return;
 
-	ap->pflags |= ATA_PFLAG_EH_PENDING;
+	ata_eh_set_pending(ap, 1);
 	scsi_schedule_eh(ap->scsi_host);
 
 	DPRINTK("port EH scheduled\n");
@@ -644,6 +736,9 @@ int ata_port_abort(struct ata_port *ap)
 
 	WARN_ON(!ap->ops->error_handler);
 
+	/* we're gonna abort all commands, no need for fast drain */
+	ata_eh_set_pending(ap, 0);
+
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 48836b2..564cd23 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -151,6 +151,7 @@ extern int ata_bus_probe(struct ata_port *ap);
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_port_wait_eh(struct ata_port *ap);
+extern void ata_eh_fastdrain_timerfn(unsigned long arg);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
 
 /* libata-sff.c */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 74800ad..be5a439 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -565,6 +565,9 @@ struct ata_port {
 	pm_message_t		pm_mesg;
 	int			*pm_result;
 
+	struct timer_list	fastdrain_timer;
+	unsigned long		fastdrain_cnt;
+
 	void			*private_data;
 
 #ifdef CONFIG_ATA_ACPI
-- 
1.5.0.3


