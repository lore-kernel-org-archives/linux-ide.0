From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: implement port_task
Date: Sun, 5 Mar 2006 15:29:09 +0900
Message-ID: <11415401491000-git-send-email-htejun@gmail.com>
References: <1141540149886-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:11549 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751988AbWCEG3N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 01:29:13 -0500
Received: by zproxy.gmail.com with SMTP id 13so1006968nzn
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 22:29:12 -0800 (PST)
In-Reply-To: <1141540149886-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement port_task.  LLDD's can schedule a function to be executed
with context after specified delay.  libata core takes care of
synchronization against EH.  This is generalized form of pio_task and
packet_task which are tied to PIO hsm implementation.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   77 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-scsi.c |    2 +
 drivers/scsi/libata.h      |    1 +
 include/linux/libata.h     |    4 ++
 4 files changed, 84 insertions(+), 0 deletions(-)

4d83950873856672ed469f25c6421de1eb98ba97
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b710fc4..3575d68 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -721,6 +721,81 @@ static unsigned int ata_pio_modes(const 
 	   timing API will get this right anyway */
 }
 
+/**
+ *	ata_port_queue_task - Queue port_task
+ *	@ap: The ata_port to queue port_task for
+ *
+ *	Schedule @fn(@data) for execution after @delay jiffies using
+ *	port_task.  There is one port_task per port and it's the
+ *	user(low level driver)'s responsibility to make sure that only
+ *	one task is active at any given time.
+ *
+ *	libata core layer takes care of synchronization between
+ *	port_task and EH.  ata_port_queue_task() may be ignored for EH
+ *	synchronization.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *), void *data,
+			 unsigned long delay)
+{
+	int rc;
+
+	if (ap->flags & ATA_FLAG_FLUSH_PIO_TASK)
+		return;
+
+	PREPARE_WORK(&ap->port_task, fn, data);
+
+	if (!delay)
+		rc = queue_work(ata_wq, &ap->port_task);
+	else
+		rc = queue_delayed_work(ata_wq, &ap->port_task, delay);
+
+	/* rc == 0 means that another user is using port task */
+	WARN_ON(rc == 0);
+}
+
+/**
+ *	ata_port_flush_task - Flush port_task
+ *	@ap: The ata_port to flush port_task for
+ *
+ *	After this function completes, port_task is guranteed not to
+ *	be running or scheduled.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+void ata_port_flush_task(struct ata_port *ap)
+{
+	unsigned long flags;
+
+	DPRINTK("ENTER\n");
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->flags |= ATA_FLAG_FLUSH_PIO_TASK;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	DPRINTK("flush #1\n");
+	flush_workqueue(ata_wq);
+
+	/*
+	 * At this point, if a task is running, it's guaranteed to see
+	 * the FLUSH flag; thus, it will never queue pio tasks again.
+	 * Cancel and flush.
+	 */
+	if (!cancel_delayed_work(&ap->port_task)) {
+		DPRINTK("flush #2\n");
+		flush_workqueue(ata_wq);
+	}
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->flags &= ~ATA_FLAG_FLUSH_PIO_TASK;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	DPRINTK("EXIT\n");
+}
+
 static inline void
 ata_queue_packet_task(struct ata_port *ap)
 {
@@ -4478,6 +4553,7 @@ static void ata_host_init(struct ata_por
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
+	INIT_WORK(&ap->port_task, NULL, NULL);
 	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
 	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
 	INIT_LIST_HEAD(&ap->eh_done_q);
@@ -4948,6 +5024,7 @@ EXPORT_SYMBOL_GPL(ata_drive_probe_reset)
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
 EXPORT_SYMBOL_GPL(ata_busy_sleep);
+EXPORT_SYMBOL_GPL(ata_port_queue_task);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_timed_out);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index d0bd94a..ccedb45 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -785,6 +785,8 @@ int ata_scsi_error(struct Scsi_Host *hos
 	WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
+	ata_port_flush_task(ap);
+
 	ap->ops->eng_timeout(ap);
 
 	WARN_ON(host->host_failed || !list_empty(&host->eh_cmd_q));
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index d822eba..f4c48c9 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -45,6 +45,7 @@ extern int libata_fua;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
+extern void ata_port_flush_task(struct ata_port *ap);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern unsigned int ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 86a504f..abc5c6e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -388,6 +388,8 @@ struct ata_port {
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
 
+	struct work_struct	port_task;
+
 	struct work_struct	packet_task;
 
 	struct work_struct	pio_task;
@@ -513,6 +515,8 @@ extern int ata_ratelimit(void);
 extern unsigned int ata_busy_sleep(struct ata_port *ap,
 				   unsigned long timeout_pat,
 				   unsigned long timeout);
+extern void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *),
+				void *data, unsigned long delay);
 
 /*
  * Default driver ops implementations
-- 
1.2.1


