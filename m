From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2/2] libata-2.6: Ignore interrupt before the ATAPI CDB
 is sent to the device
Date: Mon, 16 May 2005 18:37:40 +0800
Message-ID: <428877F4.5050405@tw.ibm.com>
References: <4271FE02.1080009@tw.ibm.com> <427200B4.4050308@tw.ibm.com> <4287D1E3.9070606@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040708070402070405030602"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:54772 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261540AbVEPKir (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 May 2005 06:38:47 -0400
In-Reply-To: <4287D1E3.9070606@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Jens Axboe <axboe@suse.de>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040708070402070405030602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Jeff:

> 
> There is an additional complication:
> 
> As specified in IDENTIFY PACKET DEVICE Word 0, in some older ATAPI 
> devices, the device will assert an interrupt after the CDB has been 
> submitted to the device.
> 
> Your patch is moving in the right direction...   but I think we should 
> check Word 0 and perform actions accordingly, as some ATAPI devices 
> appear to expect it.

I didn't consider this case.
Just take a look at the ATA-4 draft spec:

http://www.t13.org/project/d1153r18-ATA-ATAPI-4.pdf
(Fig. 16, page. 236)
"Some devices prior to ATA/ATAPI-4 assert INTRQ if enabled at this point. See
IDENTIFY PACKET DEVICE, word 0, bits 5-6 to determine if an interrupt will occur."

The interrupt seems to be after PACKET but before CDB is sent.
It looks like a good news, since the previous patch can almost handle such interrupt.
We can add IDENTIFY PACKET DEVICE Word 0 checking, if bit 6-5 is 01, then we return irq_handled
instead of ignoring the interrupt. Attached please find the revised patch for your review.


> 
> I wonder if your ATAPI device is one of these?
> 

My ATAPI devices at hand do not generate the interrupt before CDB is sent.
(I wish I have one to test this patch.)
The unexpected interrupt is caused by a pdc2027x hardware problem:
When both primary/secondary channels of the pdc20275 are stressed,
sometimes the interrupt in the 2nd channel will cause the ATA_DMA_INTR bit of the 1st
channel to be set. If only 1 channel is used, the unexpected interrupt is never seen.


Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------040708070402070405030602
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
+++ linux-2.6.11.7-mod/drivers/scsi/libata-core.c	2005-05-16 18:15:55.000000000 +0800
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
 
@@ -3142,6 +3146,18 @@
 {
 	u8 status, host_stat;
 
+	/* ATAPI: Ignore interrupt if CDB is not sent yet  */
+	if (is_atapi_taskfile(&qc->tf) &&
+	    ap->pio_task_state != PIO_ST_CDB_SENT) {
+		if ((qc->dev->id[0] & 0x60) == 0x20) {
+			DPRINTK("ata%u: atapi interrupt handled\n", ap->id);
+			return 1;	/* irq handled */
+		} else {
+			DPRINTK("ata%u: atapi interrupt ignored\n", ap->id);
+			goto idle_irq;
+		}
+	}
+
 	switch (qc->tf.protocol) {
 
 	case ATA_PROT_DMA:
@@ -3174,6 +3190,8 @@
 		DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
 			ap->id, qc->tf.protocol, status);
 
+		ap->pio_task_state = PIO_ST_IDLE;
+
 		/* ack bmdma irq events */
 		ap->ops->irq_clear(ap);
 
@@ -3260,6 +3278,7 @@
 	struct ata_port *ap = _data;
 	struct ata_queued_cmd *qc;
 	u8 status;
+	unsigned long flags;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
@@ -3275,10 +3294,13 @@
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
@@ -3295,6 +3317,8 @@
 		queue_work(ata_wq, &ap->pio_task);
 	}
 
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	return;
 
 err_out:

--------------040708070402070405030602--


