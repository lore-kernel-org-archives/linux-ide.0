From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 3/4] irq-pio: integrate ata_pio_first_block() with ata_pio_task()
Date: Mon, 03 Oct 2005 21:18:09 +0800
Message-ID: <43412F91.4040305@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000403010209070301040600"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:57491 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932071AbVJCNSY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Oct 2005 09:18:24 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j93DH0qD003647
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 09:17:00 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j93DJ0Qm500408
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 07:19:00 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j93DIIh7017849
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 07:18:19 -0600
In-Reply-To: <43411A1A.8050901@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

This is a multi-part message in MIME format.
--------------000403010209070301040600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 3/4: integrate ata_pio_first_block() with ata_pio_task()

Changes:
    - change the return value of ata_pio_complete()
    - add return value for ata_pio_first_block() to avoid queuing 
another ata_pio_task()
    - rename variable "qc_completed" to "has_next" in ata_pio_task()

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------000403010209070301040600
Content-Type: text/plain;
 name="idpio3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio3.diff"

--- id6/drivers/scsi/libata-core.c	2005-10-03 11:07:01.000000000 +0800
+++ id7/drivers/scsi/libata-core.c	2005-10-03 12:39:03.000000000 +0800
@@ -2469,7 +2469,8 @@ static unsigned long ata_pio_poll(struct
  *	None.  (executing in kernel thread context)
  *
  *	RETURNS:
- *	Non-zero if qc completed, zero otherwise.
+ *	Zero if qc completed.
+ *	Non-zero if has next.
  */
 
 static int ata_pio_complete (struct ata_port *ap)
@@ -2491,14 +2492,14 @@ static int ata_pio_complete (struct ata_
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
@@ -2510,7 +2511,7 @@ static int ata_pio_complete (struct ata_
 
 	/* another command may start at this point */
 
-	return 1;
+	return 0;
 }
 
 
@@ -2744,27 +2745,39 @@ static void atapi_send_cdb(struct ata_po
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
@@ -2788,18 +2801,15 @@ static void ata_pio_first_block(struct a
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
+	return 1;
 }
 
 /**
@@ -3010,23 +3020,23 @@ static void ata_pio_task(void *_data)
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
@@ -3045,7 +3055,7 @@ fsm_start:
 
 	if (timeout)
 		queue_delayed_work(ata_wq, &ap->pio_task, timeout);
-	else if (!qc_completed)
+	else if (has_next)
 		goto fsm_start;
 }
 

--------------000403010209070301040600--

