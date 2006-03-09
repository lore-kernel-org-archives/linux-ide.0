From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 3/5] libata-dev: Let ata_hsm_move() work with both irq-pio
 and polling pio
Date: Thu, 09 Mar 2006 16:51:36 +0800
Message-ID: <440FEC98.4010500@tw.ibm.com>
References: <440FEA4B.10500@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:2736 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751181AbWCIIv3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Mar 2006 03:51:29 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k298pSYe022061
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 03:51:28 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k298sIR7190584
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 01:54:18 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k298pRqQ007345
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 01:51:28 -0700
In-Reply-To: <440FEA4B.10500@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Let ata_hsm_move() work with both irq-pio and polling pio codepath.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Changes:
- add a new parameter "in_wq" for polling pio
- add return value "poll_next" to telling polling pio task whether the HSM is finished
- merge code from ata_pio_first_block() to the HSM_ST_FIRST state.
- call ata_poll_qc_complete() if called from the workqueue

--- 02_minor_fix/drivers/scsi/libata-core.c	2006-03-08 18:58:16.000000000 +0800
+++ 03_support_wq/drivers/scsi/libata-core.c	2006-03-09 15:14:00.000000000 +0800
@@ -3628,12 +3628,33 @@ static void ata_pio_error(struct ata_por
 	ata_poll_qc_complete(qc);
 }
 
-static void ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
-			u8 status)
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
+			u8 status, int in_wq)
 {
+	unsigned long flags = 0;
+	int poll_next;
+
 	WARN_ON(qc == NULL);
 	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
 
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
@@ -3643,6 +3664,13 @@ static void ata_hsm_move(struct ata_port
 fsm_start:
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
+		/* Send first data block or PACKET CDB */
+
+		/* if polling, we will stay in the work queue after sending the data.
+		 * otherwise, interrupt handler takes over after sending the data.
+		 */
+		poll_next = (qc->tf.flags & ATA_TFLAG_POLLING);
+
 		/* check device status */
 		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
 			/* Wrong status. Let EH handle this */
@@ -3651,8 +3679,35 @@ fsm_start:
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
+
+		if (qc->tf.protocol == ATA_PROT_PIO) {
+			/* PIO data out protocol.
+			 * send first data block.
+			 */
+
+			/* ata_pio_sectors() might change the state to HSM_ST_LAST.
+			 * so, the state is changed here before ata_pio_sectors().
+			 */
+			ap->hsm_task_state = HSM_ST;
+			ata_pio_sectors(qc);
+			ata_altstatus(ap); /* flush */
+		} else
+			/* send CDB */
+			atapi_send_cdb(ap, qc);
 
+		if (in_wq)
+			spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+		/* if polling, ata_pio_task() handles the rest.
+		 * otherwise, interrupt handler takes over from here.
+		 */
 		break;
 
 	case HSM_ST:
@@ -3692,6 +3747,7 @@ fsm_start:
 		}
 
 		ata_altstatus(ap); /* flush */
+		poll_next = 1;
 		break;
 
 	case HSM_ST_LAST:
@@ -3710,7 +3766,12 @@ fsm_start:
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
@@ -3724,12 +3785,20 @@ fsm_start:
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
@@ -4480,7 +4549,7 @@ inline unsigned int ata_host_intr (struc
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
 
-	ata_hsm_move(ap, qc, status);
+	ata_hsm_move(ap, qc, status, 0);
 	return 1;	/* irq handled */
 
 idle_irq:


