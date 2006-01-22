From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/12] libata: EH / pio tasks synchronization
Date: Sun, 22 Jan 2006 16:58:31 +0900
Message-ID: <11379167111043-git-send-email-htejun@gmail.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:3982 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932147AbWAVH7K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:59:10 -0500
Received: by wproxy.gmail.com with SMTP id i3so715425wra
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:59:09 -0800 (PST)
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

This patch makes sure that pio tasks are flushed before proceeding
with EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   80 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/libata.h     |    3 +-
 2 files changed, 76 insertions(+), 7 deletions(-)

ea84319b67f28b01f8b09d0151755b890dfff7dc
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9556100..183bc26 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1072,6 +1072,72 @@ static unsigned int ata_pio_modes(const 
 	   timing API will get this right anyway */
 }
 
+static inline void
+ata_queue_packet_task(struct ata_port *ap)
+{
+	if (!(ap->flags & ATA_FLAG_FLUSH_PIO_TASK))
+		queue_work(ata_wq, &ap->packet_task);
+}
+
+static inline void
+ata_queue_pio_task(struct ata_port *ap)
+{
+	if (!(ap->flags & ATA_FLAG_FLUSH_PIO_TASK))
+		queue_work(ata_wq, &ap->pio_task);
+}
+
+static inline void
+ata_queue_delayed_pio_task(struct ata_port *ap, unsigned long delay)
+{
+	if (!(ap->flags & ATA_FLAG_FLUSH_PIO_TASK))
+		queue_delayed_work(ata_wq, &ap->pio_task, delay);
+}
+
+/**
+ *	ata_flush_pio_tasks - Flush pio_task and packet_task
+ *	@ap: the target ata_port
+ *
+ *	After this function completes, pio_task and packet_task are
+ *	guranteed not to be running or scheduled.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+
+static void ata_flush_pio_tasks(struct ata_port *ap)
+{
+	int tmp = 0;
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
+	tmp |= cancel_delayed_work(&ap->pio_task);
+	tmp |= cancel_delayed_work(&ap->packet_task);
+	if (!tmp) {
+		DPRINTK("flush #2\n");
+		flush_workqueue(ata_wq);
+	}
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->flags &= ~ATA_FLAG_FLUSH_PIO_TASK;
+	ap->hsm_task_state = HSM_ST_IDLE;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	DPRINTK("EXIT\n");
+}
+
 void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 {
 	struct completion *waiting = qc->private_data;
@@ -3414,7 +3480,7 @@ fsm_start:
 	}
 
 	if (timeout)
-		queue_delayed_work(ata_wq, &ap->pio_task, timeout);
+		ata_queue_delayed_pio_task(ap, timeout);
 	else if (!qc_completed)
 		goto fsm_start;
 }
@@ -3447,6 +3513,8 @@ static void ata_qc_timeout(struct ata_qu
 
 	DPRINTK("ENTER\n");
 
+	ata_flush_pio_tasks(ap);
+
 	spin_lock_irqsave(&host_set->lock, flags);
 
 	switch (qc->tf.protocol) {
@@ -3733,26 +3801,26 @@ unsigned int ata_qc_issue_prot(struct at
 		ata_qc_set_polling(qc);
 		ata_tf_to_host(ap, &qc->tf);
 		ap->hsm_task_state = HSM_ST;
-		queue_work(ata_wq, &ap->pio_task);
+		ata_queue_pio_task(ap);
 		break;
 
 	case ATA_PROT_ATAPI:
 		ata_qc_set_polling(qc);
 		ata_tf_to_host(ap, &qc->tf);
-		queue_work(ata_wq, &ap->packet_task);
+		ata_queue_packet_task(ap);
 		break;
 
 	case ATA_PROT_ATAPI_NODATA:
 		ap->flags |= ATA_FLAG_NOINTR;
 		ata_tf_to_host(ap, &qc->tf);
-		queue_work(ata_wq, &ap->packet_task);
+		ata_queue_packet_task(ap);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
 		ap->flags |= ATA_FLAG_NOINTR;
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		queue_work(ata_wq, &ap->packet_task);
+		ata_queue_packet_task(ap);
 		break;
 
 	default:
@@ -4183,7 +4251,7 @@ static void atapi_packet_task(void *_dat
 
 		/* PIO commands are handled by polling */
 		ap->hsm_task_state = HSM_ST;
-		queue_work(ata_wq, &ap->pio_task);
+		ata_queue_pio_task(ap);
 	}
 
 	return;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 063221d..7837ba3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -162,7 +162,8 @@ enum {
 	ATA_FLAG_PIO_LBA48	= (1 << 13), /* Host DMA engine is LBA28 only */
 	ATA_FLAG_IRQ_MASK	= (1 << 14), /* Mask IRQ in PIO xfers */
 
-	ATA_FLAG_IN_EH		= (1 << 15), /* EH in progress */
+	ATA_FLAG_FLUSH_PIO_TASK	= (1 << 15), /* Flush PIO task */
+	ATA_FLAG_IN_EH		= (1 << 16), /* EH in progress */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
-- 
1.0.8


