From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 6/8] libata: delegate irq driven pio to workqueue
Date: Wed, 16 May 2007 15:23:19 +0800
Message-ID: <464AB167.9030203@tw.ibm.com>
References: <464AACDF.1030903@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:58634 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106AbXEPHXW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 03:23:22 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4G7NMbr020382
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 03:23:22 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4G7NLOl217898
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:23:21 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4G7NKJP026611
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:23:21 -0600
In-Reply-To: <464AACDF.1030903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

patch 6/8:
 - Delegate irq driven pio to workqueue.
 - HSM_ST_LAST is kept in the interrupt since this is not CPU intensive.
   (Mostly for DMA and non-data.)

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>
---
sata_sil is not changed to delegate to workqueue at this moment.
Maybe we can add such feature in the future if needed.


diff -Nrup 05_polling_ack/drivers/ata/libata-core.c 06_irq_wq/drivers/ata/libata-core.c
--- 05_polling_ack/drivers/ata/libata-core.c	2007-05-16 13:53:20.000000000 +0800
+++ 06_irq_wq/drivers/ata/libata-core.c	2007-05-16 13:53:25.000000000 +0800
@@ -4864,20 +4864,15 @@ err_out:
 
 static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
-	if (qc->tf.flags & ATA_TFLAG_POLLING)
-		return 1;
-
-	if (ap->hsm_task_state == HSM_ST_FIRST) {
-		if (qc->tf.protocol == ATA_PROT_PIO &&
-		    (qc->tf.flags & ATA_TFLAG_WRITE))
-		    return 1;
-
-		if (is_atapi_taskfile(&qc->tf) &&
-		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			return 1;
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+		return 0;
+	case ATA_PROT_ATAPI_DMA:
+		if (ap->hsm_task_state != HSM_ST_FIRST)
+			return 0;
 	}
 
-	return 0;
+	return (ap->pflags & ATA_PFLAG_HSM_WQ) ? 1 : 0;
 }
 
 /**
@@ -5217,6 +5212,39 @@ fsm_start:
 }
 
 /**
+ *	ata_irq_task - queue task for irq pio
+ *	@work: associated work_struct
+ *
+ *	LOCKING:
+ *	None.
+ */
+
+static void ata_irq_task(struct work_struct *work)
+{
+	struct ata_port *ap =
+		container_of(work, struct ata_port, port_task.work);
+	struct ata_queued_cmd *qc = ap->port_task_data;
+	u8 status;
+
+	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
+
+	/* double check the device is not busy */
+	status = ata_chk_status(ap);
+	if (status & ATA_BUSY) {
+		ata_port_printk(ap, KERN_ERR, "Unexpected device busy "
+				"(Status 0x%x)\n", status);
+		return;
+	}
+
+	/* move the HSM */
+	ata_hsm_move(ap, qc, status, 1);
+
+	/* another command or interrupt handler
+	 * may be running at this point.
+	 */
+}
+
+/**
  *	ata_qc_new - Request an available ATA command, for queueing
  *	@ap: Port associated with device @dev
  *	@dev: Device from whom we request an available command structure
@@ -5756,11 +5784,21 @@ inline unsigned int ata_host_intr (struc
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
 
-	ata_hsm_move(ap, qc, status, 0);
+	/* move the HSM */
+	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
+	case HSM_ST:
+		/* delegate PIO data transfer to workqueue */
+		ap->pflags |= ATA_PFLAG_HSM_WQ;
+		ata_port_queue_task(ap, ata_irq_task, qc, 0);
+		break;
+	default:
+		ata_hsm_move(ap, qc, status, 0);
 
-	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
-				       qc->tf.protocol == ATA_PROT_ATAPI_DMA))
-		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
+		if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
+					       qc->tf.protocol == ATA_PROT_ATAPI_DMA))
+			ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
+	}
 
 	return 1;	/* irq handled */
 


