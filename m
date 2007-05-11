From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 6/7] libata: push part of the irq driven pio out to workqueue
Date: Fri, 11 May 2007 15:37:57 +0800
Message-ID: <46441D55.20507@tw.ibm.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com> <4644192A.8090809@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:37831 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797AbXEKHiJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 03:38:09 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4B7c4jt007486
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 03:38:04 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4B7c33w162654
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:38:03 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4B7c2rO010708
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:38:03 -0600
In-Reply-To: <4644192A.8090809@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

patch 6/7:
 Push part of the irq driven pio out to workqueue.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
It seems this creates new race condition with ata_exec_internal_sg() and EH?

diff -Nrup 05_narrow_lock/drivers/ata/libata-core.c 06_irq_wq/drivers/ata/libata-core.c
--- 05_narrow_lock/drivers/ata/libata-core.c	2007-05-11 11:46:41.000000000 +0800
+++ 06_irq_wq/drivers/ata/libata-core.c	2007-05-11 11:54:56.000000000 +0800
@@ -4370,20 +4370,15 @@ err_out:
 
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
@@ -4559,7 +4554,7 @@ fsm_start:
 				goto fsm_start;
 			}
 
-			atapi_pio_bytes(qc, 0);
+			atapi_pio_bytes(qc, in_wq);
 
 			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
 				/* bad ireason reported by device */
@@ -4614,7 +4609,7 @@ fsm_start:
 				goto fsm_start;
 			}
 
-			ata_pio_sectors(qc, 0);
+			ata_pio_sectors(qc, in_wq);
 
 			if (ap->hsm_task_state == HSM_ST_IDLE) {
 				/* all data read */
@@ -4713,6 +4708,31 @@ fsm_start:
 		goto fsm_start;
 }
 
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
 /**
  *	ata_qc_new - Request an available ATA command, for queueing
  *	@ap: Port associated with device @dev
@@ -5250,11 +5270,20 @@ inline unsigned int ata_host_intr (struc
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
 
-	ata_hsm_move(ap, qc, status, 0);
+	/* invoke HSM */
+	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
+	case HSM_ST:
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
 


