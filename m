From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 4/5] libata-dev: Convert ata_pio_task() to use the new
 ata_hsm_move()
Date: Thu, 09 Mar 2006 16:54:52 +0800
Message-ID: <440FED5C.1010503@tw.ibm.com>
References: <440FEA4B.10500@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:6832 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751260AbWCIIyv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Mar 2006 03:54:51 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k298shub000740
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 03:54:43 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k298vYR7187188
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 01:57:34 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k298shVi012399
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 01:54:43 -0700
In-Reply-To: <440FEA4B.10500@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Convert ata_pio_task() to use the new ata_hsm_move().

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Changes:
- initialize ap->pio_task_timeout() in ata_queue_pio_task()
- refactor ata_pio_task() to poll device status register and call the new ata_hsm_move()
  when device indicates it is not BSY.

--- 03_support_wq/drivers/scsi/libata-core.c	2006-03-09 15:14:00.000000000 +0800
+++ 04_pio_task/drivers/scsi/libata-core.c	2006-03-09 15:14:41.000000000 +0800
@@ -725,6 +725,8 @@ static unsigned int ata_pio_modes(const 
 static inline void
 ata_queue_pio_task(struct ata_port *ap)
 {
+	ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
+
 	if (!(ap->flags & ATA_FLAG_FLUSH_PIO_TASK))
 		queue_work(ata_wq, &ap->pio_task);
 }
@@ -3804,44 +3806,55 @@ fsm_start:
 static void ata_pio_task(void *_data)
 {
 	struct ata_port *ap = _data;
-	unsigned long timeout;
-	int has_next;
+	struct ata_queued_cmd *qc;
+	u8 status;
+	int poll_next;
 
 fsm_start:
-	timeout = 0;
-	has_next = 1;
+	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
 
-	switch (ap->hsm_task_state) {
-	case HSM_ST_FIRST:
-		has_next = ata_pio_first_block(ap);
-		break;
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	WARN_ON(qc == NULL);
 
-	case HSM_ST:
-		ata_pio_block(ap);
-		break;
+	/*
+	 * This is purely heuristic.  This is a fast path.
+	 * Sometimes when we enter, BSY will be cleared in
+	 * a chk-status or two.  If not, the drive is probably seeking
+	 * or something.  Snooze for a couple msecs, then
+	 * chk-status again.  If still busy, timeout or queue delayed work.
+	 */
+	status = ata_busy_wait(ap, ATA_BUSY, 5);
+	if (status & ATA_BUSY) {
+		msleep(2);
+		status = ata_busy_wait(ap, ATA_BUSY, 10);
+		if (status & ATA_BUSY) {
+			if (time_before(jiffies, ap->pio_task_timeout)) {
+				ata_queue_delayed_pio_task(ap, ATA_SHORT_PAUSE);
+				return;
+			}
 
-	case HSM_ST_LAST:
-		has_next = ata_pio_complete(ap);
-		break;
+			/* timeout. Let EH handle it later. 
+			 * FIXME: should we remove ap->pio_task_timeout?
+			 */
+			printk(KERN_ERR "ata%u: polling time out\n", ap->id);
+			qc->err_mask |= AC_ERR_TIMEOUT;
+			ap->hsm_task_state = HSM_ST_TMOUT;
+			return; 
+		}
+	}
 
-	case HSM_ST_POLL:
-	case HSM_ST_LAST_POLL:
-		timeout = ata_pio_poll(ap);
-		break;
+	/* FIXME: check if EH is active */
 
-	case HSM_ST_TMOUT:
-	case HSM_ST_ERR:
-		ata_pio_error(ap);
-		return;
+	/* reset the pio task timeout */
+	ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
 
-	default:
-		BUG();
-		return;
-	}
+	/* move the HSM */
+	poll_next = ata_hsm_move(ap, qc, status, 1);
 
-	if (timeout)
-		ata_queue_delayed_pio_task(ap, timeout);
-	else if (has_next)
+	/* another command or interrupt handler
+	 * may be running at this point.
+	 */
+	if (poll_next)
 		goto fsm_start;
 }
 


