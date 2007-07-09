From: akpm@linux-foundation.org
Subject: [patch 03/11] libata-core: convert to use cancel_rearming_delayed_work()
Date: Mon, 09 Jul 2007 11:46:13 -0700
Message-ID: <200707091846.l69IkDHc001371@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51131 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754723AbXGISrC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 14:47:02 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, oleg@tv-sign.ru

From: Oleg Nesterov <oleg@tv-sign.ru>

We should not use cancel_work_sync(delayed_work->work). This works, but not
good. We can use cancel_rearming_delayed_work(), this also simplifies the
code.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |   44 +++---------------------------------
 include/linux/libata.h    |    1 
 2 files changed, 4 insertions(+), 41 deletions(-)

diff -puN drivers/ata/libata-core.c~libata-core-convert-to-use-cancel_rearming_delayed_work drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-core-convert-to-use-cancel_rearming_delayed_work
+++ a/drivers/ata/libata-core.c
@@ -1283,18 +1283,11 @@ static unsigned int ata_id_xfermask(cons
 void ata_port_queue_task(struct ata_port *ap, work_func_t fn, void *data,
 			 unsigned long delay)
 {
-	int rc;
-
-	if (ap->pflags & ATA_PFLAG_FLUSH_PORT_TASK)
-		return;
-
 	PREPARE_DELAYED_WORK(&ap->port_task, fn);
 	ap->port_task_data = data;
 
-	rc = queue_delayed_work(ata_wq, &ap->port_task, delay);
-
-	/* rc == 0 means that another user is using port task */
-	WARN_ON(rc == 0);
+	/* may fail if ata_port_flush_task() in progress */
+	queue_delayed_work(ata_wq, &ap->port_task, delay);
 }
 
 /**
@@ -1309,32 +1302,9 @@ void ata_port_queue_task(struct ata_port
  */
 void ata_port_flush_task(struct ata_port *ap)
 {
-	unsigned long flags;
-
 	DPRINTK("ENTER\n");
 
-	spin_lock_irqsave(ap->lock, flags);
-	ap->pflags |= ATA_PFLAG_FLUSH_PORT_TASK;
-	spin_unlock_irqrestore(ap->lock, flags);
-
-	DPRINTK("flush #1\n");
-	cancel_work_sync(&ap->port_task.work); /* akpm: seems unneeded */
-
-	/*
-	 * At this point, if a task is running, it's guaranteed to see
-	 * the FLUSH flag; thus, it will never queue pio tasks again.
-	 * Cancel and flush.
-	 */
-	if (!cancel_delayed_work(&ap->port_task)) {
-		if (ata_msg_ctl(ap))
-			ata_port_printk(ap, KERN_DEBUG, "%s: flush #2\n",
-					__FUNCTION__);
-		cancel_work_sync(&ap->port_task.work);
-	}
-
-	spin_lock_irqsave(ap->lock, flags);
-	ap->pflags &= ~ATA_PFLAG_FLUSH_PORT_TASK;
-	spin_unlock_irqrestore(ap->lock, flags);
+	cancel_rearming_delayed_work(&ap->port_task);
 
 	if (ata_msg_ctl(ap))
 		ata_port_printk(ap, KERN_DEBUG, "%s: EXIT\n", __FUNCTION__);
@@ -6557,13 +6527,7 @@ void ata_port_detach(struct ata_port *ap
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	ata_port_wait_eh(ap);
-
-	/* Flush hotplug task.  The sequence is similar to
-	 * ata_port_flush_task().
-	 */
-	cancel_work_sync(&ap->hotplug_task.work); /* akpm: why? */
-	cancel_delayed_work(&ap->hotplug_task);
-	cancel_work_sync(&ap->hotplug_task.work);
+	cancel_rearming_delayed_work(&ap->hotplug_task);
 
  skip_eh:
 	/* remove the associated SCSI host */
diff -puN include/linux/libata.h~libata-core-convert-to-use-cancel_rearming_delayed_work include/linux/libata.h
--- a/include/linux/libata.h~libata-core-convert-to-use-cancel_rearming_delayed_work
+++ a/include/linux/libata.h
@@ -196,7 +196,6 @@ enum {
 	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 6), /* SCSI hotplug scheduled */
 	ATA_PFLAG_INITIALIZING	= (1 << 7), /* being initialized, don't touch */
 
-	ATA_PFLAG_FLUSH_PORT_TASK = (1 << 16), /* flush port task */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
 	ATA_PFLAG_GTM_VALID	= (1 << 19), /* acpi_gtm data valid */
_
