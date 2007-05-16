From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 7/8] libata: fix ata_port_flush_task() for irq pio delegation
Date: Wed, 16 May 2007 15:24:59 +0800
Message-ID: <464AB1CB.7050501@tw.ibm.com>
References: <464AACDF.1030903@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:57183 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209AbXEPHZC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 03:25:02 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4G7P1E3020104
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 03:25:01 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4G7P1NZ187470
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:25:01 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4G7P0UY028542
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:25:01 -0600
In-Reply-To: <464AACDF.1030903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

7/8:
Submitting tasks from ata_host_intr() breaks ata_port_flush_task().
This patch adds code to disable irq pio delegation to ata_port_flush_task().
Irq pio delegation is re-enabled when next qc is issued.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Cc: Tejun Heo <htejun@gmail.com>
---
Don't know if this is good enough. Maybe Tejun have better ideas.

diff -Nrup 06_irq_wq/drivers/ata/libata-core.c 07_irq_wq_fix/drivers/ata/libata-core.c
--- 06_irq_wq/drivers/ata/libata-core.c	2007-05-16 13:53:25.000000000 +0800
+++ 07_irq_wq_fix/drivers/ata/libata-core.c	2007-05-16 13:53:37.000000000 +0800
@@ -1321,6 +1321,7 @@ void ata_port_flush_task(struct ata_port
 
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags |= ATA_PFLAG_FLUSH_PORT_TASK;
+	ap->pflags &= ~ATA_PFLAG_IRQ_DELEGATE;
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	DPRINTK("flush #1\n");
@@ -5604,6 +5605,9 @@ unsigned int ata_qc_issue_prot(struct at
 	    (ap->flags & ATA_FLAG_SETXFER_POLLING))
 		qc->tf.flags |= ATA_TFLAG_POLLING;
 
+	/* delegate data transfer of irq driven pio to workqueue */
+	ap->pflags |=  ATA_PFLAG_IRQ_DELEGATE;
+
 	/* select the device */
 	ata_dev_select(ap, qc->dev->devno, 1, 0);
 
@@ -5788,9 +5792,12 @@ inline unsigned int ata_host_intr (struc
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
 	case HSM_ST:
-		/* delegate PIO data transfer to workqueue */
-		ap->pflags |= ATA_PFLAG_HSM_WQ;
-		ata_port_queue_task(ap, ata_irq_task, qc, 0);
+		if (ap->pflags & ATA_PFLAG_IRQ_DELEGATE) {
+			/* delegate PIO data transfer to workqueue */
+			ap->pflags |= ATA_PFLAG_HSM_WQ;
+			ata_port_queue_task(ap, ata_irq_task, qc, 0);
+		} else
+			ata_hsm_move(ap, qc, status, 0);
 		break;
 	default:
 		ata_hsm_move(ap, qc, status, 0);
diff -Nrup 06_irq_wq/include/linux/libata.h 07_irq_wq_fix/include/linux/libata.h
--- 06_irq_wq/include/linux/libata.h	2007-05-14 14:45:28.000000000 +0800
+++ 07_irq_wq_fix/include/linux/libata.h	2007-05-15 18:14:49.000000000 +0800
@@ -196,6 +196,7 @@ enum {
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
 	ATA_PFLAG_HSM_WQ	= (1 << 19), /* hsm accessing the port in wq */
+	ATA_PFLAG_IRQ_DELEGATE	= (1 << 20), /* delegate irq pio to wq */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */


