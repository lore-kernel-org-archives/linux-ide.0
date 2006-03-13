From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/5] libata-dev: Let ata_hsm_move() work with both irq-pio
 and polling pio
Date: Mon, 13 Mar 2006 15:45:31 +0800
Message-ID: <4415231B.1090906@tw.ibm.com>
References: <440FEA4B.10500@tw.ibm.com> <44136D61.4020007@pobox.com> <4415203F.4070103@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:5092 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932234AbWCMHpl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 02:45:41 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2D7jaAq025657
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 02:45:36 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2D7mUfw179150
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:48:30 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2D7jZJw019287
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:45:36 -0700
In-Reply-To: <4415203F.4070103@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Let ata_hsm_move() work with both irq-pio and polling pio codepath.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Changes:
- add a new parameter "in_wq" for polling pio
- add return value "poll_next" to tell polling pio task whether the HSM is finished
- merge code from ata_pio_first_block() to the HSM_ST_FIRST state.
- call ata_poll_qc_complete() if called from the workqueue

--- 02_minor_fix/drivers/scsi/libata-core.c	2006-03-13 12:47:13.000000000 +0800
+++ 03_support_wq/drivers/scsi/libata-core.c	2006-03-13 13:28:05.000000000 +0800
@@ -3770,11 +3770,36 @@ static void ata_pio_error(struct ata_por
 	ata_poll_qc_complete(qc);
 }
 
-static void ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
-			 u8 status)
+/**
+ *	ata_hsm_move - move the HSM to the next state.
+ *	@ap: the target ata_port
+ *	@qc: qc on going
+ *	@status: current device status
+ *	@in_wq: 1 if called from workqueue, 0 otherwise
+ *
+ *	RETURNS:
+ *	1 when poll next status needed, 0 otherwise.
+ */
+
+static int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
+			 u8 status, int in_wq)
 {
+	unsigned long flags = 0;
+	int poll_next;
+
 	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
 
+	/* Make sure ata_qc_issue_prot() does not throw things
+	 * like DMA polling into the workqueue. Notice that
+	 * in_wq is not equivalent to (qc->tf.flags & ATA_TFLAG_POLLING).
+	 */
+	WARN_ON(in_wq != ((qc->tf.flags & ATA_TFLAG_POLLING) ||
+			  (ap->hsm_task_state == HSM_ST_FIRST &&
+			   ((qc->tf.protocol == ATA_PROT_PIO &&
+			     (qc->tf.flags & ATA_TFLAG_WRITE)) ||
+			    (is_atapi_taskfile(&qc->tf) &&
+			     !(qc->dev->flags & ATA_DFLAG_CDB_INTR))))));
+
 	/* check error */
 	if (unlikely(status & (ATA_ERR | ATA_DF))) {
 		qc->err_mask |= AC_ERR_DEV;
@@ -3784,6 +3809,14 @@ static void ata_hsm_move(struct ata_port
 fsm_start:
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
+		/* Send first data block or PACKET CDB */
+
+		/* If polling, we will stay in the work queue after
+		 * sending the data. Otherwise, interrupt handler
+		 * takes over after sending the data.
+		 */
+		poll_next = (qc->tf.flags & ATA_TFLAG_POLLING);
+
 		/* check device status */
 		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
 			/* Wrong status. Let EH handle this */
@@ -3792,8 +3825,36 @@ fsm_start:
 			goto fsm_start;
 		}
 
-		atapi_send_cdb(ap, qc);
+		/* Send the CDB (atapi) or the first data block (ata pio out).
+		 * During the state transition, interrupt handler shouldn't
+		 * be invoked before the data transfer is complete and
+		 * hsm_task_state is changed. Hence, the following locking.
+		 */
+		if (in_wq)
+			spin_lock_irqsave(&ap->host_set->lock, flags);
 
+		if (qc->tf.protocol == ATA_PROT_PIO) {
+			/* PIO data out protocol.
+			 * send first data block.
+			 */
+
+			/* ata_pio_sectors() might change the state
+			 * to HSM_ST_LAST. so, the state is changed here
+			 * before ata_pio_sectors().
+			 */
+			ap->hsm_task_state = HSM_ST;
+			ata_pio_sectors(qc);
+			ata_altstatus(ap); /* flush */
+		} else
+			/* send CDB */
+			atapi_send_cdb(ap, qc);
+
+		if (in_wq)
+			spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+		/* if polling, ata_pio_task() handles the rest.
+		 * otherwise, interrupt handler takes over from here.
+		 */
 		break;
 
 	case HSM_ST:
@@ -3833,6 +3894,7 @@ fsm_start:
 		}
 
 		ata_altstatus(ap); /* flush */
+		poll_next = 1;
 		break;
 
 	case HSM_ST_LAST:
@@ -3851,7 +3913,12 @@ fsm_start:
 		ap->hsm_task_state = HSM_ST_IDLE;
 
 		/* complete taskfile transaction */
-		ata_qc_complete(qc);
+		if (in_wq)
+			ata_poll_qc_complete(qc);
+		else
+			ata_qc_complete(qc);
+
+		poll_next = 0;
 		break;
 
 	case HSM_ST_ERR:
@@ -3865,12 +3932,20 @@ fsm_start:
 		WARN_ON(qc->err_mask == 0);
 
 		ap->hsm_task_state = HSM_ST_IDLE;
-		ata_qc_complete(qc);
+
+		if (in_wq)
+			ata_poll_qc_complete(qc);
+		else
+			ata_qc_complete(qc);
+
+		poll_next = 0;
 		break;
 	default:
+		poll_next = 0;
 		BUG();
 	}
 
+	return poll_next;
 }
 
 static void ata_pio_task(void *_data)
@@ -4620,7 +4695,7 @@ inline unsigned int ata_host_intr (struc
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
 
-	ata_hsm_move(ap, qc, status);
+	ata_hsm_move(ap, qc, status, 0);
 	return 1;	/* irq handled */
 
 idle_irq:


