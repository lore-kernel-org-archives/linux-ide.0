From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 2/4] irq-pio: merge the ata_dataout_task workqueue with
 ata_pio_task workqueue
Date: Tue, 01 Nov 2005 19:24:49 +0800
Message-ID: <43675081.6000700@tw.ibm.com>
References: <43674D9A.9010007@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:47049 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750749AbVKALYr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Nov 2005 06:24:47 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jA1BOl5K024294
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 06:24:47 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id jA1BOlfJ506136
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 04:24:47 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jA1BOk1s021516
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 04:24:47 -0700
In-Reply-To: <43674D9A.9010007@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <mlord@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Patch 2/4:
  merge the ata_dataout_task workqueue with ata_pio_task workqueue

Changes:
   - remove ap->dataout_task from struct ata_port
   - let ata_pio_task() handle the HSM_ST_FIRST state.
   - rename ata_dataout_task() to ata_pio_first_block()
   - replace the ata_dataout_task workqueue with ata_pio_task workqueue

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

========

--- id1/include/linux/libata.h	2005-11-01 17:39:14.000000000 +0800
+++ id2/include/linux/libata.h	2005-11-01 17:57:00.000000000 +0800
@@ -334,8 +334,6 @@ struct ata_port {
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
 
-	struct work_struct	dataout_task;
-
 	struct work_struct	pio_task;
 	unsigned int		hsm_task_state;
 	unsigned long		pio_task_timeout;
--- id1/drivers/scsi/libata-core.c	2005-11-01 18:45:16.000000000 +0800
+++ id2/drivers/scsi/libata-core.c	2005-11-01 18:45:35.000000000 +0800
@@ -2963,8 +2963,8 @@ static void atapi_send_cdb(struct ata_po
 }
 
 /**
- *	ata_dataout_task - Write first data block to hardware
- *	@_data: Port to which ATA/ATAPI device is attached.
+ *	ata_pio_first_block - Write first data block to hardware
+ *	@ap: Port to which ATA/ATAPI device is attached.
  *
  *	When device has indicated its readiness to accept
  *	the data, this function sends out the CDB or 
@@ -2977,9 +2977,8 @@ static void atapi_send_cdb(struct ata_po
  *	Kernel thread context (may sleep)
  */
 
-static void ata_dataout_task(void *_data)
+static void ata_pio_first_block(struct ata_port *ap)
 {
-	struct ata_port *ap = _data;
 	struct ata_queued_cmd *qc;
 	u8 status;
 	unsigned long flags;
@@ -3253,6 +3252,10 @@ fsm_start:
 	qc_completed = 0;
 
 	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
+		ata_pio_first_block(ap);
+		return;
+
 	case HSM_ST:
 		ata_pio_block(ap);
 		break;
@@ -3703,10 +3706,10 @@ int ata_qc_issue_prot(struct ata_queued_
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
 			/* PIO data out protocol */
 			ap->hsm_task_state = HSM_ST_FIRST;
-			queue_work(ata_wq, &ap->dataout_task);
+			queue_work(ata_wq, &ap->pio_task);
 
 			/* always send first data block using
-			 * the ata_dataout_task() codepath.
+			 * the ata_pio_task() codepath.
 			 */
 		} else {
 			/* PIO data in protocol */
@@ -3733,7 +3736,7 @@ int ata_qc_issue_prot(struct ata_queued_
 		/* send cdb by polling if no cdb interrupt */
 		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
 		    (qc->tf.flags & ATA_TFLAG_POLLING))
-			queue_work(ata_wq, &ap->dataout_task);
+			queue_work(ata_wq, &ap->pio_task);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
@@ -3745,7 +3748,7 @@ int ata_qc_issue_prot(struct ata_queued_
 
 		/* send cdb by polling if no cdb interrupt */
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			queue_work(ata_wq, &ap->dataout_task);
+			queue_work(ata_wq, &ap->pio_task);
 		break;
 
 	default:
@@ -4325,7 +4328,6 @@ static void ata_host_init(struct ata_por
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
-	INIT_WORK(&ap->dataout_task, ata_dataout_task, ap);
 	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)


