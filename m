From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: Handle ATAPI interrupt before CDB is sent
Date: Wed, 08 Jun 2005 16:02:21 +0800
Message-ID: <42A6A60D.7020807@tw.ibm.com>
References: <4271FE02.1080009@tw.ibm.com> <427200B4.4050308@tw.ibm.com> <4287D1E3.9070606@pobox.com> <428877F4.5050405@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030505050205060109060600"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:30199 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262140AbVFHIEX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jun 2005 04:04:23 -0400
In-Reply-To: <428877F4.5050405@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030505050205060109060600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Resubmit the revised patch.

Problem:
  atapi_packet_task(): assert(qc != NULL) failed when both primary/secondary IDE channels are stressed.

Root cause:
   Sometimes the interrupt handler is invoked before atapi_packet_task() sends the CDB to the device.
The interrupt handler completes the command. Later when atapi_packet_task() is executed, the command is already gone.

The following sequence causes the problem:
1. A packet command with ATA_PROT_ATAPI_NODATA is written to the CD-ROM drive.
2. atapi_packet_task() is queued.
3. The CD_ROM drive executes and finishes the packet command. It is not busy now.
4. The other IDE channel asserts IRQ.
5. The interrupt handler checks alt_status, seeing device not busy and completes the command.
6. atapi_packet_task() is executed, causing assert() fail.

Another possible cause is the pre-ATA4 devices which generate INTRQ before CDB is sent,
as you pointed out in the previous mail. However, I don't have such drive to test with.

Fix:
  - Add PIO_ST_PKT and PIO_ST_CDB_SENT states.
  - Prevent the interrupt handler from completing the command if the ATAPI CDB is not sent to the device yet.


BTW, it is not the problem of pdc20275 hardware as previously said; pdc20275 is innocent.

Attached please find the patch against the linux-2.6.git tree (2.6.12-rc6) for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------030505050205060109060600
Content-Type: text/plain;
 name="atapi_state_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atapi_state_fix.diff"

--- 10_atapi_pio_fix/include/linux/libata.h	2005-06-06 13:38:51.000000000 +0800
+++ 20_atapi_intr_race_fix/include/linux/libata.h	2005-06-07 11:08:26.000000000 +0800
@@ -161,6 +161,8 @@
 	PIO_ST_LAST,
 	PIO_ST_LAST_POLL,
 	PIO_ST_ERR,
+	PIO_ST_PKT,
+	PIO_ST_CDB_SENT,
 };
 
 /* forward declarations */
--- 10_atapi_pio_fix/drivers/scsi/libata-core.c	2005-06-06 13:37:50.000000000 +0800
+++ 20_atapi_intr_race_fix/drivers/scsi/libata-core.c	2005-06-08 13:41:48.000000000 +0800
@@ -2872,6 +2872,7 @@
 	default:
 		ata_altstatus(ap);
 		drv_stat = ata_chk_status(ap);
+		ap->pio_task_state = PIO_ST_IDLE;
 
 		/* ack bmdma irq events */
 		ap->ops->irq_clear(ap);
@@ -3184,17 +3185,20 @@
 	case ATA_PROT_ATAPI:
 		ata_qc_set_polling(qc);
 		ata_tf_to_host_nolock(ap, &qc->tf);
+		ap->pio_task_state = PIO_ST_PKT;
 		queue_work(ata_wq, &ap->packet_task);
 		break;
 
 	case ATA_PROT_ATAPI_NODATA:
 		ata_tf_to_host_nolock(ap, &qc->tf);
+		ap->pio_task_state = PIO_ST_PKT;
 		queue_work(ata_wq, &ap->packet_task);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
+		ap->pio_task_state = PIO_ST_PKT;
 		queue_work(ata_wq, &ap->packet_task);
 		break;
 
@@ -3457,6 +3461,32 @@
 {
 	u8 status, host_stat;
 
+	/* ATAPI: Handle the interrupt before CDB is sent */
+	if (is_atapi_taskfile(&qc->tf) &&
+	    ap->pio_task_state != PIO_ST_CDB_SENT) {
+		/* check whether it's our irq */
+		host_stat = ap->ops->bmdma_status(ap);
+
+		if (host_stat & ATA_DMA_INTR) {
+			/* Some pre-ATAPI-4 devices assert INTRQ here 
+			 * if nIEN is zero. qc->dev->id[0] bits 5-6 can 
+			 * be used to identify such devices.
+			 */
+			DPRINTK("ata%u: atapi interrupt handled\n", ap->id);
+
+			/* clear INTRQ */
+			status = ata_chk_status(ap);
+
+			/* clear bmdma status irq bit */
+			ap->ops->irq_clear(ap);
+
+			return 1;	/* irq handled */
+		} else {
+			DPRINTK("ata%u: not my atapi interrupt\n", ap->id);
+			goto idle_irq;
+		}
+	}
+
 	switch (qc->tf.protocol) {
 
 	case ATA_PROT_DMA:
@@ -3489,6 +3519,8 @@
 		DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
 			ap->id, qc->tf.protocol, status);
 
+		ap->pio_task_state = PIO_ST_IDLE;
+
 		/* ack bmdma irq events */
 		ap->ops->irq_clear(ap);
 
@@ -3580,6 +3612,7 @@
 	struct ata_port *ap = _data;
 	struct ata_queued_cmd *qc;
 	u8 status;
+	unsigned long flags;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
@@ -3595,10 +3628,13 @@
 	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
 		goto err_out;
 
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
 	assert(ap->cdb_len >= 12);
 	ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
+	ap->pio_task_state = PIO_ST_CDB_SENT;
 
 	/* if we are DMA'ing, irq handler takes over from here */
 	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
@@ -3615,6 +3651,8 @@
 		queue_work(ata_wq, &ap->pio_task);
 	}
 
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	return;
 
 err_out:

--------------030505050205060109060600--


