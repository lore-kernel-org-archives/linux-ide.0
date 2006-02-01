From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: EH / pio tasks synchronization
Date: Thu, 2 Feb 2006 00:56:10 +0900
Message-ID: <11388093702671-git-send-email-htejun@gmail.com>
References: <11388093703495-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:12688 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161101AbWBAP4R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2006 10:56:17 -0500
Received: by wproxy.gmail.com with SMTP id 69so383025wri
        for <linux-ide@vger.kernel.org>; Wed, 01 Feb 2006 07:56:16 -0800 (PST)
In-Reply-To: <11388093703495-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

This patch makes sure that pio tasks are flushed before proceeding
with EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   56 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/libata.h     |    3 ++
 2 files changed, 55 insertions(+), 4 deletions(-)

8bf3455f64987bfb33a304113b98085f67e5ef62
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 249e67f..9a785cf 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1074,19 +1074,66 @@ static unsigned int ata_pio_modes(const 
 static inline void
 ata_queue_packet_task(struct ata_port *ap)
 {
-	queue_work(ata_wq, &ap->packet_task);
+	if (!(ap->flags & ATA_FLAG_FLUSH_PIO_TASK))
+		queue_work(ata_wq, &ap->packet_task);
 }
 
 static inline void
 ata_queue_pio_task(struct ata_port *ap)
 {
-	queue_work(ata_wq, &ap->pio_task);
+	if (!(ap->flags & ATA_FLAG_FLUSH_PIO_TASK))
+		queue_work(ata_wq, &ap->pio_task);
 }
 
 static inline void
 ata_queue_delayed_pio_task(struct ata_port *ap, unsigned long delay)
 {
-	queue_delayed_work(ata_wq, &ap->pio_task, delay);
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
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	DPRINTK("EXIT\n");
 }
 
 void ata_qc_complete_internal(struct ata_queued_cmd *qc)
@@ -3767,6 +3814,9 @@ static void ata_qc_timeout(struct ata_qu
 
 	DPRINTK("ENTER\n");
 
+	ata_flush_pio_tasks(ap);
+	ap->hsm_task_state = HSM_ST_IDLE;
+
 	spin_lock_irqsave(&host_set->lock, flags);
 
 	switch (qc->tf.protocol) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 55176df..f4cd1eb 100644
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
1.1.3


