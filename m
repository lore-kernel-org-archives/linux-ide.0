From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 3/4] irq-pio: eliminate unnecessary queuing in ata_pio_first_block()
Date: Tue, 01 Nov 2005 19:30:05 +0800
Message-ID: <436751BD.2010405@tw.ibm.com>
References: <43674D9A.9010007@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:50600 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750728AbVKALaI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Nov 2005 06:30:08 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jA1BU3Hv007579
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 06:30:03 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id jA1BU3fJ512876
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 04:30:03 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jA1BU2J0027958
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 04:30:03 -0700
In-Reply-To: <43674D9A.9010007@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <mlord@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

patch 3/4: 
  eliminate unnecessary queuing in ata_pio_first_block()

Changes:
   - change the return value of ata_pio_complete() 0 <-> 1
   - add return value for ata_pio_first_block()
   - rename variable "qc_completed" to "has_next" in ata_pio_task()
   - use has_next to eliminate unnecessary queuing in ata_pio_first_block()

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

==========

--- id2/drivers/scsi/libata-core.c	2005-11-01 18:45:35.000000000 +0800
+++ id3/drivers/scsi/libata-core.c	2005-11-01 18:45:50.000000000 +0800
@@ -2697,7 +2697,8 @@ static unsigned long ata_pio_poll(struct
  *	None.  (executing in kernel thread context)
  *
  *	RETURNS:
- *	Non-zero if qc completed, zero otherwise.
+ *	Zero if qc completed.
+ *	Non-zero if has next.
  */
 
 static int ata_pio_complete (struct ata_port *ap)
@@ -2719,14 +2720,14 @@ static int ata_pio_complete (struct ata_
 		if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
 			ap->hsm_task_state = HSM_ST_LAST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
-			return 0;
+			return 1;
 		}
 	}
 
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
 		ap->hsm_task_state = HSM_ST_ERR;
-		return 0;
+		return 1;
 	}
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -2738,7 +2739,7 @@ static int ata_pio_complete (struct ata_
 
 	/* another command may start at this point */
 
-	return 1;
+	return 0;
 }
 
 
@@ -2975,27 +2976,42 @@ static void atapi_send_cdb(struct ata_po
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	Zero if irq handler takes over
+ *	Non-zero if has next (polling).
  */
 
-static void ata_pio_first_block(struct ata_port *ap)
+static int ata_pio_first_block(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	u8 status;
 	unsigned long flags;
+	int has_next;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
 
+	/* if polling, we will stay in the work queue after sending the data.
+	 * otherwise, interrupt handler takes over after sending the data.
+	 */
+	has_next = (qc->tf.flags & ATA_TFLAG_POLLING);
+
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
-	if (ata_busy_sleep(ap, ATA_TMOUT_DATAOUT_QUICK, ATA_TMOUT_DATAOUT))
+	if (ata_busy_sleep(ap, ATA_TMOUT_DATAOUT_QUICK, ATA_TMOUT_DATAOUT)) {
+		ap->hsm_task_state = HSM_ST_TMOUT;
 		goto err_out;
+	}
 
 	/* make sure DRQ is set */
 	status = ata_chk_status(ap);
-	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
+	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
+		/* device status error */
+		ap->hsm_task_state = HSM_ST_ERR;
 		goto err_out;
+	}
 
 	/* Send the CDB (atapi) or the first data block (ata pio out).
 	 * During the state transition, interrupt handler shouldn't
@@ -3019,18 +3035,15 @@ static void ata_pio_first_block(struct a
 		/* send CDB */
 		atapi_send_cdb(ap, qc);
 
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	/* if polling, ata_pio_task() handles the rest.
 	 * otherwise, interrupt handler takes over from here.
 	 */
-	if (qc->tf.flags & ATA_TFLAG_POLLING)
-		queue_work(ata_wq, &ap->pio_task);
-
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	return;
+	return has_next;
 
 err_out:
-	ata_pio_error(ap);
+	return 1; /* has next */
 }
 
 /**
@@ -3245,23 +3258,23 @@ static void ata_pio_task(void *_data)
 {
 	struct ata_port *ap = _data;
 	unsigned long timeout;
-	int qc_completed;
+	int has_next;
 
 fsm_start:
 	timeout = 0;
-	qc_completed = 0;
+	has_next = 1;
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
-		ata_pio_first_block(ap);
-		return;
+		has_next = ata_pio_first_block(ap);
+		break;
 
 	case HSM_ST:
 		ata_pio_block(ap);
 		break;
 
 	case HSM_ST_LAST:
-		qc_completed = ata_pio_complete(ap);
+		has_next = ata_pio_complete(ap);
 		break;
 
 	case HSM_ST_POLL:
@@ -3281,7 +3294,7 @@ fsm_start:
 
 	if (timeout)
 		queue_delayed_work(ata_wq, &ap->pio_task, timeout);
-	else if (!qc_completed)
+	else if (has_next)
 		goto fsm_start;
 }
 


