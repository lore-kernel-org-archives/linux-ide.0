From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/2] libata-2.6: Ignore interrupt before the ATAPI CDB is
 sent to the device
Date: Fri, 29 Apr 2005 17:39:00 +0800
Message-ID: <427200B4.4050308@tw.ibm.com>
References: <4271FE02.1080009@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000001020300080907070303"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:24042 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262209AbVD2Jj0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Apr 2005 05:39:26 -0400
In-Reply-To: <4271FE02.1080009@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Jens Axboe <axboe@suse.de>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000001020300080907070303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Problem:
   Sometimes the interrupt handler is invoked before atapi_packet_task() sending CDB to the device.
The interrupt handler completes the command and later when atapi_packet_task() runs, the command is already gone.

Changes:
  - Add 2 PIO states to libata.h.
  - Prevent the interrupt handler from completing the command before the ATAPI CDB is sent to the device.

Attached please find the patch against the libata-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------000001020300080907070303
Content-Type: text/plain;
 name="atapi_state_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atapi_state_fix.diff"

--- linux-2.6.11.7-twe/include/linux/libata.h	2005-04-25 14:59:15.000000000 +0800
+++ linux-2.6.11.7-mod/include/linux/libata.h	2005-04-25 15:06:25.000000000 +0800
@@ -161,6 +161,8 @@
 	PIO_ST_LAST,
 	PIO_ST_LAST_POLL,
 	PIO_ST_ERR,
+	PIO_ST_PKT,
+	PIO_ST_CDB_SENT,
 };
 
 /* forward declarations */
--- linux-2.6.11.7-twe/drivers/scsi/libata-core.c	2005-04-25 16:19:05.000000000 +0800
+++ linux-2.6.11.7-mod/drivers/scsi/libata-core.c	2005-04-29 16:20:32.000000000 +0800
@@ -2632,6 +2632,7 @@
 	default:
 		ata_altstatus(ap);
 		drv_stat = ata_chk_status(ap);
+		ap->pio_task_state = PIO_ST_IDLE;
 
 		/* ack bmdma irq events */
 		ap->ops->irq_clear(ap);
@@ -2934,17 +2935,20 @@
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
 
@@ -3142,6 +3146,13 @@
 {
 	u8 status, host_stat;
 
+	/* ATAPI: Ignore interrupt if CDB is not sent yet  */
+	if (is_atapi_taskfile(&qc->tf) &&
+	    ap->pio_task_state != PIO_ST_CDB_SENT) {
+		DPRINTK("ata%u: not my atapi interrupt\n", ap->id);
+		goto idle_irq;
+	}
+
 	switch (qc->tf.protocol) {
 
 	case ATA_PROT_DMA:
@@ -3174,6 +3185,8 @@
 		DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
 			ap->id, qc->tf.protocol, status);
 
+		ap->pio_task_state = PIO_ST_IDLE;
+
 		/* ack bmdma irq events */
 		ap->ops->irq_clear(ap);
 
@@ -3260,6 +3273,7 @@
 	struct ata_port *ap = _data;
 	struct ata_queued_cmd *qc;
 	u8 status;
+	unsigned long flags;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
@@ -3275,10 +3289,13 @@
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
@@ -3295,6 +3312,8 @@
 		queue_work(ata_wq, &ap->pio_task);
 	}
 
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	return;
 
 err_out:

--------------000001020300080907070303--


