From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 2/4] irq-pio: remove ap->dataout_task
Date: Mon, 03 Oct 2005 21:02:07 +0800
Message-ID: <43412BCF.4080408@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030503050406080207020201"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:9856 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932179AbVJCNCV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Oct 2005 09:02:21 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j93D0uNN025466
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 09:00:56 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j93D2uQm548920
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 07:02:56 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j93D2EPG029982
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 07:02:15 -0600
In-Reply-To: <43411A1A.8050901@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

This is a multi-part message in MIME format.
--------------030503050406080207020201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 2/4: remove ap->dataout_task

changes:
    - remove ap->dataout_task
    - let ata_pio_task() handle the HSM_ST_FIRST state.
    - rename ata_dataout_task() to ata_pio_first_block()


For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>


--------------030503050406080207020201
Content-Type: text/plain;
 name="idpio2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio2.diff"

--- id2/include/linux/libata.h	2005-09-30 17:48:55.000000000 +0800
+++ id6/include/linux/libata.h	2005-10-03 10:18:29.000000000 +0800
@@ -319,8 +319,6 @@ struct ata_port {
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
 
-	struct work_struct	dataout_task;
-
 	struct work_struct	pio_task;
 	unsigned int		hsm_task_state;
 	unsigned long		pio_task_timeout;
--- id5/drivers/scsi/libata-core.c	2005-10-03 10:25:01.000000000 +0800
+++ id6/drivers/scsi/libata-core.c	2005-10-03 11:07:01.000000000 +0800
@@ -2732,8 +2732,8 @@ static void atapi_send_cdb(struct ata_po
 }
 
 /**
- *	ata_dataout_task - Write first data block to hardware
- *	@_data: Port to which ATA/ATAPI device is attached.
+ *	ata_pio_first_block - Write first data block to hardware
+ *	@ap: Port to which ATA/ATAPI device is attached.
  *
  *	When device has indicated its readiness to accept
  *	the data, this function sends out the CDB or 
@@ -2746,9 +2746,8 @@ static void atapi_send_cdb(struct ata_po
  *	Kernel thread context (may sleep)
  */
 
-static void ata_dataout_task(void *_data)
+static void ata_pio_first_block(struct ata_port *ap)
 {
-	struct ata_port *ap = _data;
 	struct ata_queued_cmd *qc;
 	u8 status;
 	unsigned long flags;
@@ -3018,7 +3017,8 @@ fsm_start:
 	qc_completed = 0;
 
 	switch (ap->hsm_task_state) {
-	case HSM_ST_IDLE:
+	case HSM_ST_FIRST:
+		ata_pio_first_block(ap);
 		return;
 
 	case HSM_ST:
@@ -3038,6 +3038,9 @@ fsm_start:
 	case HSM_ST_ERR:
 		ata_pio_error(ap);
 		return;
+	default:
+		BUG();
+		return;
 	}
 
 	if (timeout)
@@ -3518,10 +3521,10 @@ int ata_qc_issue_prot(struct ata_queued_
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
@@ -3548,7 +3551,7 @@ int ata_qc_issue_prot(struct ata_queued_
 		/* send cdb by polling if no cdb interrupt */
 		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
 		    (qc->tf.flags & ATA_TFLAG_POLLING))
-			queue_work(ata_wq, &ap->dataout_task);
+			queue_work(ata_wq, &ap->pio_task);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
@@ -3560,7 +3563,7 @@ int ata_qc_issue_prot(struct ata_queued_
 
 		/* send cdb by polling if no cdb interrupt */
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			queue_work(ata_wq, &ap->dataout_task);
+			queue_work(ata_wq, &ap->pio_task);
 		break;
 
 	default:
@@ -4141,7 +4144,6 @@ static void ata_host_init(struct ata_por
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
 
-	INIT_WORK(&ap->dataout_task, ata_dataout_task, ap);
 	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)

--------------030503050406080207020201--

