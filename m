From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: kill unused pio_task and packet_task
Date: Sun, 5 Mar 2006 15:29:09 +0900
Message-ID: <11415401491126-git-send-email-htejun@gmail.com>
References: <1141540149886-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:10736 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752008AbWCEG3P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 01:29:15 -0500
Received: by pproxy.gmail.com with SMTP id o67so539049pye
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 22:29:12 -0800 (PST)
In-Reply-To: <1141540149886-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill unused pio_task and packet_task.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   68 --------------------------------------------
 include/linux/libata.h     |    3 --
 2 files changed, 0 insertions(+), 71 deletions(-)

aaf1bca7a373df0a4e301da177d6c71329b98196
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ebd4072..657b196 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -796,71 +796,6 @@ void ata_port_flush_task(struct ata_port
 	DPRINTK("EXIT\n");
 }
 
-static inline void
-ata_queue_packet_task(struct ata_port *ap)
-{
-	if (!(ap->flags & ATA_FLAG_FLUSH_PIO_TASK))
-		queue_work(ata_wq, &ap->packet_task);
-}
-
-static inline void
-ata_queue_pio_task(struct ata_port *ap)
-{
-	if (!(ap->flags & ATA_FLAG_FLUSH_PIO_TASK))
-		queue_work(ata_wq, &ap->pio_task);
-}
-
-static inline void
-ata_queue_delayed_pio_task(struct ata_port *ap, unsigned long delay)
-{
-	if (!(ap->flags & ATA_FLAG_FLUSH_PIO_TASK))
-		queue_delayed_work(ata_wq, &ap->pio_task, delay);
-}
-
-/**
- *	ata_flush_pio_tasks - Flush pio_task and packet_task
- *	@ap: the target ata_port
- *
- *	After this function completes, pio_task and packet_task are
- *	guranteed not to be running or scheduled.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- */
-
-static void ata_flush_pio_tasks(struct ata_port *ap)
-{
-	int tmp = 0;
-	unsigned long flags;
-
-	DPRINTK("ENTER\n");
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->flags |= ATA_FLAG_FLUSH_PIO_TASK;
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	DPRINTK("flush #1\n");
-	flush_workqueue(ata_wq);
-
-	/*
-	 * At this point, if a task is running, it's guaranteed to see
-	 * the FLUSH flag; thus, it will never queue pio tasks again.
-	 * Cancel and flush.
-	 */
-	tmp |= cancel_delayed_work(&ap->pio_task);
-	tmp |= cancel_delayed_work(&ap->packet_task);
-	if (!tmp) {
-		DPRINTK("flush #2\n");
-		flush_workqueue(ata_wq);
-	}
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->flags &= ~ATA_FLAG_FLUSH_PIO_TASK;
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	DPRINTK("EXIT\n");
-}
-
 void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 {
 	struct completion *waiting = qc->private_data;
@@ -3675,7 +3610,6 @@ static void ata_qc_timeout(struct ata_qu
 
 	DPRINTK("ENTER\n");
 
-	ata_flush_pio_tasks(ap);
 	ap->hsm_task_state = HSM_ST_IDLE;
 
 	spin_lock_irqsave(&host_set->lock, flags);
@@ -4554,8 +4488,6 @@ static void ata_host_init(struct ata_por
 	ap->last_ctl = 0xFF;
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
-	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
-	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index abc5c6e..d856660 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -390,9 +390,6 @@ struct ata_port {
 
 	struct work_struct	port_task;
 
-	struct work_struct	packet_task;
-
-	struct work_struct	pio_task;
 	unsigned int		hsm_task_state;
 	unsigned long		pio_task_timeout;
 
-- 
1.2.1


