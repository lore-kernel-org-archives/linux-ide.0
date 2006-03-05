From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: convert pio_task and packet_task to port_task
Date: Sun, 5 Mar 2006 15:29:09 +0900
Message-ID: <114154014972-git-send-email-htejun@gmail.com>
References: <1141540149886-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:10992 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752066AbWCEG3Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 01:29:16 -0500
Received: by pproxy.gmail.com with SMTP id e30so582267pya
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 22:29:13 -0800 (PST)
In-Reply-To: <1141540149886-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make pio_task and atapi_packet_task use port_task.
atapi_packet_task() is moved upward such that it's right after
ata_pio_task().  This position is more natural and makes adding
prototype for ata_qc_issue_prot() unnecessary.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  154 ++++++++++++++++++++++----------------------
 1 files changed, 77 insertions(+), 77 deletions(-)

b5b1469010fc9cd99e149f0503cbf6e6f1ac17b2
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3575d68..ebd4072 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3570,12 +3570,84 @@ fsm_start:
 	}
 
 	if (timeout)
-		ata_queue_delayed_pio_task(ap, timeout);
+		ata_port_queue_task(ap, ata_pio_task, ap, timeout);
 	else if (!qc_completed)
 		goto fsm_start;
 }
 
 /**
+ *	atapi_packet_task - Write CDB bytes to hardware
+ *	@_data: Port to which ATAPI device is attached.
+ *
+ *	When device has indicated its readiness to accept
+ *	a CDB, this function is called.  Send the CDB.
+ *	If DMA is to be performed, exit immediately.
+ *	Otherwise, we are in polling mode, so poll
+ *	status under operation succeeds or fails.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+
+static void atapi_packet_task(void *_data)
+{
+	struct ata_port *ap = _data;
+	struct ata_queued_cmd *qc;
+	u8 status;
+
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	WARN_ON(qc == NULL);
+	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
+
+	/* sleep-wait for BSY to clear */
+	DPRINTK("busy wait\n");
+	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB)) {
+		qc->err_mask |= AC_ERR_TIMEOUT;
+		goto err_out;
+	}
+
+	/* make sure DRQ is set */
+	status = ata_chk_status(ap);
+	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
+		qc->err_mask |= AC_ERR_HSM;
+		goto err_out;
+	}
+
+	/* send SCSI cdb */
+	DPRINTK("send cdb\n");
+	WARN_ON(qc->dev->cdb_len < 12);
+
+	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA ||
+	    qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {
+		unsigned long flags;
+
+		/* Once we're done issuing command and kicking bmdma,
+		 * irq handler takes over.  To not lose irq, we need
+		 * to clear NOINTR flag before sending cdb, but
+		 * interrupt handler shouldn't be invoked before we're
+		 * finished.  Hence, the following locking.
+		 */
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		ap->flags &= ~ATA_FLAG_NOINTR;
+		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
+		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
+			ap->ops->bmdma_start(qc);	/* initiate bmdma */
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	} else {
+		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
+
+		/* PIO commands are handled by polling */
+		ap->hsm_task_state = HSM_ST;
+		ata_port_queue_task(ap, ata_pio_task, ap, 0);
+	}
+
+	return;
+
+err_out:
+	ata_poll_qc_complete(qc);
+}
+
+/**
  *	ata_qc_timeout - Handle timeout of queued command
  *	@qc: Command that timed out
  *
@@ -3874,26 +3946,26 @@ unsigned int ata_qc_issue_prot(struct at
 		ata_qc_set_polling(qc);
 		ata_tf_to_host(ap, &qc->tf);
 		ap->hsm_task_state = HSM_ST;
-		ata_queue_pio_task(ap);
+		ata_port_queue_task(ap, ata_pio_task, ap, 0);
 		break;
 
 	case ATA_PROT_ATAPI:
 		ata_qc_set_polling(qc);
 		ata_tf_to_host(ap, &qc->tf);
-		ata_queue_packet_task(ap);
+		ata_port_queue_task(ap, atapi_packet_task, ap, 0);
 		break;
 
 	case ATA_PROT_ATAPI_NODATA:
 		ap->flags |= ATA_FLAG_NOINTR;
 		ata_tf_to_host(ap, &qc->tf);
-		ata_queue_packet_task(ap);
+		ata_port_queue_task(ap, atapi_packet_task, ap, 0);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
 		ap->flags |= ATA_FLAG_NOINTR;
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		ata_queue_packet_task(ap);
+		ata_port_queue_task(ap, atapi_packet_task, ap, 0);
 		break;
 
 	default:
@@ -4261,78 +4333,6 @@ irqreturn_t ata_interrupt (int irq, void
 	return IRQ_RETVAL(handled);
 }
 
-/**
- *	atapi_packet_task - Write CDB bytes to hardware
- *	@_data: Port to which ATAPI device is attached.
- *
- *	When device has indicated its readiness to accept
- *	a CDB, this function is called.  Send the CDB.
- *	If DMA is to be performed, exit immediately.
- *	Otherwise, we are in polling mode, so poll
- *	status under operation succeeds or fails.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- */
-
-static void atapi_packet_task(void *_data)
-{
-	struct ata_port *ap = _data;
-	struct ata_queued_cmd *qc;
-	u8 status;
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
-	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
-
-	/* sleep-wait for BSY to clear */
-	DPRINTK("busy wait\n");
-	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB)) {
-		qc->err_mask |= AC_ERR_TIMEOUT;
-		goto err_out;
-	}
-
-	/* make sure DRQ is set */
-	status = ata_chk_status(ap);
-	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
-		qc->err_mask |= AC_ERR_HSM;
-		goto err_out;
-	}
-
-	/* send SCSI cdb */
-	DPRINTK("send cdb\n");
-	WARN_ON(qc->dev->cdb_len < 12);
-
-	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA ||
-	    qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {
-		unsigned long flags;
-
-		/* Once we're done issuing command and kicking bmdma,
-		 * irq handler takes over.  To not lose irq, we need
-		 * to clear NOINTR flag before sending cdb, but
-		 * interrupt handler shouldn't be invoked before we're
-		 * finished.  Hence, the following locking.
-		 */
-		spin_lock_irqsave(&ap->host_set->lock, flags);
-		ap->flags &= ~ATA_FLAG_NOINTR;
-		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
-		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
-			ap->ops->bmdma_start(qc);	/* initiate bmdma */
-		spin_unlock_irqrestore(&ap->host_set->lock, flags);
-	} else {
-		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
-
-		/* PIO commands are handled by polling */
-		ap->hsm_task_state = HSM_ST;
-		ata_queue_pio_task(ap);
-	}
-
-	return;
-
-err_out:
-	ata_poll_qc_complete(qc);
-}
-
 
 /*
  * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
-- 
1.2.1


