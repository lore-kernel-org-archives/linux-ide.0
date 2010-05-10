From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/23] libata-sff: port_task is SFF specific
Date: Mon, 10 May 2010 21:41:38 +0200
Message-ID: <1273520507-32459-15-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44957 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756136Ab0EJTm3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:29 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

port_task is tightly bound to the standard SFF PIO HSM implementation.
Using it for any other purpose would be error-prone and there's no
such user and if some drivers need such feature, it would be much
better off using its own.  Move it inside CONFIG_ATA_SFF and rename it
to sff_pio_task.

The only function which is exposed to the core layer is
ata_sff_flush_pio_task() which is renamed from ata_port_flush_task()
and now also takes care of resetting hsm_task_state to HSM_ST_IDLE,
which is possible as it's now specific to PIO HSM.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |   69 +------------------------------------------
 drivers/ata/libata-eh.c   |    4 +-
 drivers/ata/libata-sff.c  |   72 +++++++++++++++++++++++++++++++++-----------
 drivers/ata/libata.h      |    5 ++-
 drivers/ata/sata_mv.c     |    2 +-
 include/linux/libata.h    |    7 +---
 6 files changed, 63 insertions(+), 96 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bf6ffc1..c47373f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -97,7 +97,6 @@ static void ata_dev_xfermask(struct ata_device *dev);
 static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
 
 unsigned int ata_print_id = 1;
-static struct workqueue_struct *ata_wq;
 
 struct workqueue_struct *ata_aux_wq;
 
@@ -1686,52 +1685,6 @@ unsigned long ata_id_xfermask(const u16 *id)
 	return ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
 }
 
-/**
- *	ata_pio_queue_task - Queue port_task
- *	@ap: The ata_port to queue port_task for
- *	@data: data for @fn to use
- *	@delay: delay time in msecs for workqueue function
- *
- *	Schedule @fn(@data) for execution after @delay jiffies using
- *	port_task.  There is one port_task per port and it's the
- *	user(low level driver)'s responsibility to make sure that only
- *	one task is active at any given time.
- *
- *	libata core layer takes care of synchronization between
- *	port_task and EH.  ata_pio_queue_task() may be ignored for EH
- *	synchronization.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-void ata_pio_queue_task(struct ata_port *ap, void *data, unsigned long delay)
-{
-	ap->port_task_data = data;
-
-	/* may fail if ata_port_flush_task() in progress */
-	queue_delayed_work(ata_wq, &ap->port_task, msecs_to_jiffies(delay));
-}
-
-/**
- *	ata_port_flush_task - Flush port_task
- *	@ap: The ata_port to flush port_task for
- *
- *	After this function completes, port_task is guranteed not to
- *	be running or scheduled.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- */
-void ata_port_flush_task(struct ata_port *ap)
-{
-	DPRINTK("ENTER\n");
-
-	cancel_rearming_delayed_work(&ap->port_task);
-
-	if (ata_msg_ctl(ap))
-		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT\n", __func__);
-}
-
 static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 {
 	struct completion *waiting = qc->private_data;
@@ -1853,7 +1806,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 
 	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
 
-	ata_port_flush_task(ap);
+	ata_sff_flush_pio_task(ap);
 
 	if (!rc) {
 		spin_lock_irqsave(ap->lock, flags);
@@ -5646,11 +5599,6 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
 #endif
 
-#ifdef CONFIG_ATA_SFF
-	INIT_DELAYED_WORK(&ap->port_task, ata_pio_task);
-#else
-	INIT_DELAYED_WORK(&ap->port_task, NULL);
-#endif
 	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
 	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
 	INIT_LIST_HEAD(&ap->eh_done_q);
@@ -6588,17 +6536,6 @@ static int __init ata_init(void)
 
 	ata_parse_force_param();
 
-	/*
-	 * FIXME: In UP case, there is only one workqueue thread and if you
-	 * have more than one PIO device, latency is bloody awful, with
-	 * occasional multi-second "hiccups" as one PIO device waits for
-	 * another.  It's an ugly wart that users DO occasionally complain
-	 * about; luckily most users have at most one PIO polled device.
-	 */
-	ata_wq = create_workqueue("ata");
-	if (!ata_wq)
-		goto fail;
-
 	ata_aux_wq = create_singlethread_workqueue("ata_aux");
 	if (!ata_aux_wq)
 		goto fail;
@@ -6612,8 +6549,6 @@ static int __init ata_init(void)
 
 fail:
 	kfree(ata_force_tbl);
-	if (ata_wq)
-		destroy_workqueue(ata_wq);
 	if (ata_aux_wq)
 		destroy_workqueue(ata_aux_wq);
 	return rc;
@@ -6623,7 +6558,6 @@ static void __exit ata_exit(void)
 {
 	ata_sff_exit();
 	kfree(ata_force_tbl);
-	destroy_workqueue(ata_wq);
 	destroy_workqueue(ata_aux_wq);
 }
 
@@ -6777,7 +6711,6 @@ EXPORT_SYMBOL_GPL(ata_id_c_string);
 EXPORT_SYMBOL_GPL(ata_do_dev_read_id);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
-EXPORT_SYMBOL_GPL(ata_pio_queue_task);
 EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
 EXPORT_SYMBOL_GPL(ata_timing_find_mode);
 EXPORT_SYMBOL_GPL(ata_timing_compute);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 228740f..d6e6748 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -550,8 +550,8 @@ void ata_scsi_error(struct Scsi_Host *host)
 
 	DPRINTK("ENTER\n");
 
-	/* synchronize with port task */
-	ata_port_flush_task(ap);
+	/* make sure sff pio task is not running */
+	ata_sff_flush_pio_task(ap);
 
 	/* synchronize with host lock and sort out timeouts */
 
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 0d55440..9a40b6e 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -40,6 +40,8 @@
 
 #include "libata.h"
 
+static struct workqueue_struct *ata_sff_wq;
+
 const struct ata_port_operations ata_sff_port_ops = {
 	.inherits		= &ata_base_port_ops,
 
@@ -1271,7 +1273,7 @@ fsm_start:
 		if (in_wq)
 			spin_unlock_irqrestore(ap->lock, flags);
 
-		/* if polling, ata_pio_task() handles the rest.
+		/* if polling, ata_sff_pio_task() handles the rest.
 		 * otherwise, interrupt handler takes over from here.
 		 */
 		break;
@@ -1436,14 +1438,38 @@ fsm_start:
 }
 EXPORT_SYMBOL_GPL(ata_sff_hsm_move);
 
-void ata_pio_task(struct work_struct *work)
+void ata_sff_queue_pio_task(struct ata_port *ap, unsigned long delay)
+{
+	/* may fail if ata_sff_flush_pio_task() in progress */
+	queue_delayed_work(ata_sff_wq, &ap->sff_pio_task,
+			   msecs_to_jiffies(delay));
+}
+EXPORT_SYMBOL_GPL(ata_sff_queue_pio_task);
+
+void ata_sff_flush_pio_task(struct ata_port *ap)
+{
+	DPRINTK("ENTER\n");
+
+	cancel_rearming_delayed_work(&ap->sff_pio_task);
+	ap->hsm_task_state = HSM_ST_IDLE;
+
+	if (ata_msg_ctl(ap))
+		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT\n", __func__);
+}
+
+static void ata_sff_pio_task(struct work_struct *work)
 {
 	struct ata_port *ap =
-		container_of(work, struct ata_port, port_task.work);
-	struct ata_queued_cmd *qc = ap->port_task_data;
+		container_of(work, struct ata_port, sff_pio_task.work);
+	struct ata_queued_cmd *qc;
 	u8 status;
 	int poll_next;
 
+	/* qc can be NULL if timeout occurred */
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
+	if (!qc)
+		return;
+
 fsm_start:
 	WARN_ON_ONCE(ap->hsm_task_state == HSM_ST_IDLE);
 
@@ -1459,7 +1485,7 @@ fsm_start:
 		msleep(2);
 		status = ata_sff_busy_wait(ap, ATA_BUSY, 10);
 		if (status & ATA_BUSY) {
-			ata_pio_queue_task(ap, qc, ATA_SHORT_PAUSE);
+			ata_sff_queue_pio_task(ap, ATA_SHORT_PAUSE);
 			return;
 		}
 	}
@@ -1529,7 +1555,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		ap->hsm_task_state = HSM_ST_LAST;
 
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_pio_queue_task(ap, qc, 0);
+			ata_sff_queue_pio_task(ap, 0);
 
 		break;
 
@@ -1551,20 +1577,21 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
 			/* PIO data out protocol */
 			ap->hsm_task_state = HSM_ST_FIRST;
-			ata_pio_queue_task(ap, qc, 0);
+			ata_sff_queue_pio_task(ap, 0);
 
-			/* always send first data block using
-			 * the ata_pio_task() codepath.
+			/* always send first data block using the
+			 * ata_sff_pio_task() codepath.
 			 */
 		} else {
 			/* PIO data in protocol */
 			ap->hsm_task_state = HSM_ST;
 
 			if (qc->tf.flags & ATA_TFLAG_POLLING)
-				ata_pio_queue_task(ap, qc, 0);
+				ata_sff_queue_pio_task(ap, 0);
 
-			/* if polling, ata_pio_task() handles the rest.
-			 * otherwise, interrupt handler takes over from here.
+			/* if polling, ata_sff_pio_task() handles the
+			 * rest.  otherwise, interrupt handler takes
+			 * over from here.
 			 */
 		}
 
@@ -1582,7 +1609,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		/* send cdb by polling if no cdb interrupt */
 		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
 		    (qc->tf.flags & ATA_TFLAG_POLLING))
-			ata_pio_queue_task(ap, qc, 0);
+			ata_sff_queue_pio_task(ap, 0);
 		break;
 
 	case ATAPI_PROT_DMA:
@@ -1594,7 +1621,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 
 		/* send cdb by polling if no cdb interrupt */
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			ata_pio_queue_task(ap, qc, 0);
+			ata_sff_queue_pio_task(ap, 0);
 		break;
 
 	default:
@@ -2340,8 +2367,6 @@ void ata_sff_error_handler(struct ata_port *ap)
 	/* reset PIO HSM and stop DMA engine */
 	spin_lock_irqsave(ap->lock, flags);
 
-	ap->hsm_task_state = HSM_ST_IDLE;
-
 	if (ap->ioaddr.bmdma_addr &&
 	    qc && (qc->tf.protocol == ATA_PROT_DMA ||
 		   qc->tf.protocol == ATAPI_PROT_DMA)) {
@@ -2412,8 +2437,6 @@ void ata_sff_post_internal_cmd(struct ata_queued_cmd *qc)
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	ap->hsm_task_state = HSM_ST_IDLE;
-
 	if (ap->ioaddr.bmdma_addr)
 		ap->ops->bmdma_stop(qc);
 
@@ -3054,15 +3077,28 @@ EXPORT_SYMBOL_GPL(ata_pci_bmdma_init);
  */
 void ata_sff_port_init(struct ata_port *ap)
 {
+	INIT_DELAYED_WORK(&ap->sff_pio_task, ata_sff_pio_task);
 	ap->ctl = ATA_DEVCTL_OBS;
 	ap->last_ctl = 0xFF;
 }
 
 int __init ata_sff_init(void)
 {
+	/*
+	 * FIXME: In UP case, there is only one workqueue thread and if you
+	 * have more than one PIO device, latency is bloody awful, with
+	 * occasional multi-second "hiccups" as one PIO device waits for
+	 * another.  It's an ugly wart that users DO occasionally complain
+	 * about; luckily most users have at most one PIO polled device.
+	 */
+	ata_sff_wq = create_workqueue("ata_sff");
+	if (!ata_sff_wq)
+		return -ENOMEM;
+
 	return 0;
 }
 
 void __exit ata_sff_exit(void)
 {
+	destroy_workqueue(ata_sff_wq);
 }
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index d89502f..002390c 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -79,7 +79,6 @@ extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
 			   unsigned int tag);
 extern u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev);
-extern void ata_port_flush_task(struct ata_port *ap);
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen,
@@ -202,11 +201,13 @@ static inline int sata_pmp_attach(struct ata_device *dev)
 
 /* libata-sff.c */
 #ifdef CONFIG_ATA_SFF
-extern void ata_pio_task(struct work_struct *work);
+extern void ata_sff_flush_pio_task(struct ata_port *ap);
 extern void ata_sff_port_init(struct ata_port *ap);
 extern int ata_sff_init(void);
 extern void ata_sff_exit(void);
 #else /* CONFIG_ATA_SFF */
+static inline void ata_sff_flush_pio_task(struct ata_port *ap)
+{ }
 static inline void ata_sff_port_init(struct ata_port *ap)
 { }
 static inline int ata_sff_init(void)
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 8349186..fb0d2c1 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2262,7 +2262,7 @@ static unsigned int mv_qc_issue_fis(struct ata_queued_cmd *qc)
 	}
 
 	if (qc->tf.flags & ATA_TFLAG_POLLING)
-		ata_pio_queue_task(ap, qc, 0);
+		ata_sff_queue_pio_task(ap, 0);
 	return 0;
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 88c4cc9..1c12f6a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -723,6 +723,7 @@ struct ata_port {
 	struct ata_ioports	ioaddr;	/* ATA cmd/ctl/dma register blocks */
 	u8			ctl;	/* cache of ATA control register */
 	u8			last_ctl;	/* Cache last written value */
+	struct delayed_work	sff_pio_task;
 #endif /* CONFIG_ATA_SFF */
 
 	unsigned int		pio_mask;
@@ -746,8 +747,6 @@ struct ata_port {
 	struct ata_host		*host;
 	struct device 		*dev;
 
-	void			*port_task_data;
-	struct delayed_work	port_task;
 	struct delayed_work	hotplug_task;
 	struct work_struct	scsi_rescan_task;
 
@@ -1030,9 +1029,6 @@ extern int ata_cable_sata(struct ata_port *ap);
 extern int ata_cable_ignore(struct ata_port *ap);
 extern int ata_cable_unknown(struct ata_port *ap);
 
-extern void ata_pio_queue_task(struct ata_port *ap, void *data,
-			       unsigned long delay);
-
 /* Timing helpers */
 extern unsigned int ata_pio_need_iordy(const struct ata_device *);
 extern const struct ata_timing *ata_timing_find_mode(u8 xfer_mode);
@@ -1596,6 +1592,7 @@ extern u8 ata_sff_irq_on(struct ata_port *ap);
 extern void ata_sff_irq_clear(struct ata_port *ap);
 extern int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 			    u8 status, int in_wq);
+extern void ata_sff_queue_pio_task(struct ata_port *ap, unsigned long delay);
 extern unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc);
 extern bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc);
 extern unsigned int ata_sff_host_intr(struct ata_port *ap,
-- 
1.6.4.2

