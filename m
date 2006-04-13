From: Brian King <brking@us.ibm.com>
Subject: [PATCH 2/4] libata: Add host lock to struct ata_port (resend)
Date: Thu, 13 Apr 2006 14:52:11 -0500
Message-ID: <200604131952.k3DJqB6V004769@d03av02.boulder.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:53425 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964956AbWDMTwP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Apr 2006 15:52:15 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3DJqESP012204
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 15:52:14 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3DJtVVw191198
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 13:55:33 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3DJqBwj004804
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 13:52:12 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, brking@us.ibm.com


Prepare for changes required to support SATA devices
attached to SAS HBAs. For these devices we don't want to
use host_set at all, since libata will not be the owner
of struct scsi_host.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 libata-dev-bjking1/drivers/scsi/libata-core.c |   25 +++++++++++++------------
 libata-dev-bjking1/drivers/scsi/libata-eh.c   |   15 +++++++--------
 libata-dev-bjking1/drivers/scsi/libata-scsi.c |    5 ++---
 libata-dev-bjking1/include/linux/libata.h     |    1 +
 4 files changed, 23 insertions(+), 23 deletions(-)

diff -puN include/linux/libata.h~libata_port_lock include/linux/libata.h
--- libata-dev/include/linux/libata.h~libata_port_lock	2006-04-13 14:45:55.000000000 -0500
+++ libata-dev-bjking1/include/linux/libata.h	2006-04-13 14:45:55.000000000 -0500
@@ -385,6 +385,7 @@ struct ata_device {
 struct ata_port {
 	struct Scsi_Host	*host;	/* our co-allocated scsi host */
 	const struct ata_port_operations *ops;
+	spinlock_t		*lock;
 	unsigned long		flags;	/* ATA_FLAG_xxx */
 	unsigned int		id;	/* unique id req'd by scsi midlyr */
 	unsigned int		port_no; /* unique port #; from zero */
diff -puN drivers/scsi/libata-core.c~libata_port_lock drivers/scsi/libata-core.c
--- libata-dev/drivers/scsi/libata-core.c~libata_port_lock	2006-04-13 14:45:55.000000000 -0500
+++ libata-dev-bjking1/drivers/scsi/libata-core.c	2006-04-13 14:45:55.000000000 -0500
@@ -927,9 +927,9 @@ void ata_port_flush_task(struct ata_port
 
 	DPRINTK("ENTER\n");
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
+	spin_lock_irqsave(ap->lock, flags);
 	ap->flags |= ATA_FLAG_FLUSH_PORT_TASK;
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	spin_unlock_irqrestore(ap->lock, flags);
 
 	DPRINTK("flush #1\n");
 	flush_workqueue(ata_wq);
@@ -944,9 +944,9 @@ void ata_port_flush_task(struct ata_port
 		flush_workqueue(ata_wq);
 	}
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
+	spin_lock_irqsave(ap->lock, flags);
 	ap->flags &= ~ATA_FLAG_FLUSH_PORT_TASK;
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	spin_unlock_irqrestore(ap->lock, flags);
 
 	DPRINTK("EXIT\n");
 }
@@ -989,7 +989,7 @@ unsigned ata_exec_internal(struct ata_po
 	unsigned long flags;
 	unsigned int err_mask;
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
+	spin_lock_irqsave(ap->lock, flags);
 
 	qc = ata_qc_new_init(ap, dev);
 	BUG_ON(qc == NULL);
@@ -1008,12 +1008,12 @@ unsigned ata_exec_internal(struct ata_po
 
 	ata_qc_issue(qc);
 
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	spin_unlock_irqrestore(ap->lock, flags);
 
 	if (!wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL)) {
 		ata_port_flush_task(ap);
 
-		spin_lock_irqsave(&ap->host_set->lock, flags);
+		spin_lock_irqsave(ap->lock, flags);
 
 		/* We're racing with irq here.  If we lose, the
 		 * following test prevents us from completing the qc
@@ -1028,7 +1028,7 @@ unsigned ata_exec_internal(struct ata_po
 			       ap->id, command);
 		}
 
-		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		spin_unlock_irqrestore(ap->lock, flags);
 	}
 
 	*tf = qc->tf;
@@ -3405,11 +3405,11 @@ void ata_poll_qc_complete(struct ata_que
 	struct ata_port *ap = qc->ap;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
+	spin_lock_irqsave(ap->lock, flags);
 	ap->flags &= ~ATA_FLAG_NOINTR;
 	ata_irq_on(ap);
 	ata_qc_complete(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	spin_unlock_irqrestore(ap->lock, flags);
 }
 
 /**
@@ -3990,12 +3990,12 @@ static void atapi_packet_task(void *_dat
 		 * interrupt handler shouldn't be invoked before we're
 		 * finished.  Hence, the following locking.
 		 */
-		spin_lock_irqsave(&ap->host_set->lock, flags);
+		spin_lock_irqsave(ap->lock, flags);
 		ap->flags &= ~ATA_FLAG_NOINTR;
 		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
 		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
 			ap->ops->bmdma_start(qc);	/* initiate bmdma */
-		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		spin_unlock_irqrestore(ap->lock, flags);
 	} else {
 		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
 
@@ -4576,6 +4576,7 @@ static void ata_host_init(struct ata_por
 	host->unique_id = ata_unique_id++;
 	host->max_cmd_len = 12;
 
+	ap->lock = &host_set->lock;
 	ap->flags = ATA_FLAG_DISABLED;
 	ap->id = host->unique_id;
 	ap->host = host;
diff -puN drivers/scsi/libata-scsi.c~libata_port_lock drivers/scsi/libata-scsi.c
--- libata-dev/drivers/scsi/libata-scsi.c~libata_port_lock	2006-04-13 14:45:55.000000000 -0500
+++ libata-dev-bjking1/drivers/scsi/libata-scsi.c	2006-04-13 14:45:55.000000000 -0500
@@ -2481,7 +2481,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 	ap = ata_shost_to_port(shost);
 
 	spin_unlock(shost->host_lock);
-	spin_lock(&ap->host_set->lock);
+	spin_lock(ap->lock);
 
 	ata_scsi_dump_cdb(ap, cmd);
 
@@ -2493,7 +2493,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 		done(cmd);
 	}
 
-	spin_unlock(&ap->host_set->lock);
+	spin_unlock(ap->lock);
 	spin_lock(shost->host_lock);
 	return 0;
 }
@@ -2604,4 +2604,3 @@ void ata_scsi_scan_host(struct ata_port 
 			scsi_scan_target(&ap->host->shost_gendev, 0, i, 0, 0);
 	}
 }
-
diff -puN drivers/scsi/libata-eh.c~libata_port_lock drivers/scsi/libata-eh.c
--- libata-dev/drivers/scsi/libata-eh.c~libata_port_lock	2006-04-13 14:45:55.000000000 -0500
+++ libata-dev-bjking1/drivers/scsi/libata-eh.c	2006-04-13 14:45:55.000000000 -0500
@@ -71,7 +71,7 @@ enum scsi_eh_timer_return ata_scsi_timed
 
 	DPRINTK("ENTER\n");
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
+	spin_lock_irqsave(ap->lock, flags);
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	if (qc) {
 		WARN_ON(qc->scsicmd != cmd);
@@ -79,7 +79,7 @@ enum scsi_eh_timer_return ata_scsi_timed
 		qc->err_mask |= AC_ERR_TIMEOUT;
 		ret = EH_NOT_HANDLED;
 	}
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	spin_unlock_irqrestore(ap->lock, flags);
 
 	DPRINTK("EXIT, ret=%d\n", ret);
 	return ret;
@@ -104,7 +104,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 	DPRINTK("ENTER\n");
 
 	/* synchronize with IRQ handler and port task */
-	spin_unlock_wait(&ap->host_set->lock);
+	spin_unlock_wait(ap->lock);
 	ata_port_flush_task(ap);
 
 	WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
@@ -139,7 +139,6 @@ void ata_scsi_error(struct Scsi_Host *ho
 static void ata_qc_timeout(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct ata_host_set *host_set = ap->host_set;
 	u8 host_stat = 0, drv_stat;
 	unsigned long flags;
 
@@ -147,7 +146,7 @@ static void ata_qc_timeout(struct ata_qu
 
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	spin_lock_irqsave(&host_set->lock, flags);
+	spin_lock_irqsave(ap->lock, flags);
 
 	switch (qc->tf.protocol) {
 
@@ -175,7 +174,7 @@ static void ata_qc_timeout(struct ata_qu
 		break;
 	}
 
-	spin_unlock_irqrestore(&host_set->lock, flags);
+	spin_unlock_irqrestore(ap->lock, flags);
 
 	ata_eh_qc_complete(qc);
 
@@ -220,11 +219,11 @@ static void __ata_eh_qc_complete(struct 
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
+	spin_lock_irqsave(ap->lock, flags);
 	qc->scsidone = ata_eh_scsidone;
 	__ata_qc_complete(qc);
 	WARN_ON(ata_tag_valid(qc->tag));
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	spin_unlock_irqrestore(ap->lock, flags);
 
 	scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
 }
_
