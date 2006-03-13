From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 4/5] libata-dev: Convert ata_pio_task() to use the new ata_hsm_move()
Date: Mon, 13 Mar 2006 15:47:42 +0800
Message-ID: <4415239E.7020508@tw.ibm.com>
References: <440FEA4B.10500@tw.ibm.com> <44136D61.4020007@pobox.com> <4415203F.4070103@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:50914 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932326AbWCMHrx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Mar 2006 02:47:53 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2D7lkJU026971
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 02:47:46 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2D7oefw149236
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:50:40 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2D7lkTs021193
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:47:46 -0700
In-Reply-To: <4415203F.4070103@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Convert ata_pio_task() to use the new ata_hsm_move().

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Changes:

- refactor ata_pio_task() to poll device status register and
- call the new ata_hsm_move() when device indicates it is not BSY.

--- 03_support_wq/drivers/scsi/libata-core.c	2006-03-13 13:28:05.000000000 +0800
+++ 04_pio_task/drivers/scsi/libata-core.c	2006-03-13 13:28:42.000000000 +0800
@@ -3951,44 +3951,40 @@ fsm_start:
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
-
-	switch (ap->hsm_task_state) {
-	case HSM_ST_FIRST:
-		has_next = ata_pio_first_block(ap);
-		break;
-
-	case HSM_ST:
-		ata_pio_block(ap);
-		break;
-
-	case HSM_ST_LAST:
-		has_next = ata_pio_complete(ap);
-		break;
+	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
 
-	case HSM_ST_POLL:
-	case HSM_ST_LAST_POLL:
-		timeout = ata_pio_poll(ap);
-		break;
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	WARN_ON(qc == NULL);
 
-	case HSM_ST_TMOUT:
-	case HSM_ST_ERR:
-		ata_pio_error(ap);
-		return;
-
-	default:
-		BUG();
-		return;
+	/*
+	 * This is purely heuristic.  This is a fast path.
+	 * Sometimes when we enter, BSY will be cleared in
+	 * a chk-status or two.  If not, the drive is probably seeking
+	 * or something.  Snooze for a couple msecs, then
+	 * chk-status again.  If still busy, queue delayed work.
+	 */
+	status = ata_busy_wait(ap, ATA_BUSY, 5);
+	if (status & ATA_BUSY) {
+		msleep(2);
+		status = ata_busy_wait(ap, ATA_BUSY, 10);
+		if (status & ATA_BUSY) {
+			ata_port_queue_task(ap, ata_pio_task, ap, ATA_SHORT_PAUSE);
+			return;
+		}
 	}
 
-	if (timeout)
-		ata_port_queue_task(ap, ata_pio_task, ap, timeout);
-	else if (has_next)
+	/* move the HSM */
+	poll_next = ata_hsm_move(ap, qc, status, 1);
+
+	/* another command or interrupt handler
+	 * may be running at this point.
+	 */
+	if (poll_next)
 		goto fsm_start;
 }
 


