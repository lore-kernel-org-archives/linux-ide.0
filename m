From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/1] libata: Handle ATAPI interrupt before CDB is sent
Date: Thu, 09 Jun 2005 15:13:52 +0800
Message-ID: <42A7EC30.2060404@tw.ibm.com>
References: <4271FE02.1080009@tw.ibm.com> <427200B4.4050308@tw.ibm.com>	 <4287D1E3.9070606@pobox.com> <428877F4.5050405@tw.ibm.com>	 <42A6A60D.7020807@tw.ibm.com> <58cb370e05060803014046ef0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090100010101090506000702"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:36849 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262304AbVFIHOR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Jun 2005 03:14:17 -0400
In-Reply-To: <58cb370e05060803014046ef0b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090100010101090506000702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Hi Bart,


> 
>>@@ -3457,6 +3461,32 @@
>> {
>>        u8 status, host_stat;
>>
>>+       /* ATAPI: Handle the interrupt before CDB is sent */
>>+       if (is_atapi_taskfile(&qc->tf) &&
>>+           ap->pio_task_state != PIO_ST_CDB_SENT) {
>>+               /* check whether it's our irq */
>>+               host_stat = ap->ops->bmdma_status(ap);
>>+
>>+               if (host_stat & ATA_DMA_INTR) {
>>+                       /* Some pre-ATAPI-4 devices assert INTRQ here
>>+                        * if nIEN is zero. qc->dev->id[0] bits 5-6 can
>>+                        * be used to identify such devices.
>>+                        */
>>+                       DPRINTK("ata%u: atapi interrupt handled\n", ap->id);
> 
> 
> This looks wrong for ATA_PROT_ATAPI_[NODATA],
> we can't expect host to support DMA.
> 
> 

Revised in this patch by checking qc->dev->id[0] and alt_status.


> 
> 
> 	case ATA_PROT_DMA:
> 	case ATA_PROT_ATAPI_DMA:
> 	case ATA_PROT_ATAPI:
> 		/* check status of DMA engine */
> 		host_stat = ap->ops->bmdma_status(ap);
> 		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
> 
> 		/* if it's not our irq... */
> 		if (!(host_stat & ATA_DMA_INTR))
> 			goto idle_irq;
> 
> 		/* before we do anything else, clear DMA-Start bit */
> 		ap->ops->bmdma_stop(ap);
> 
> 		/* fall through */
> 
> ditto (vanilla libata-core.c)

'case ATA_PROT_ATAPI' moved to 'default'.

Attached please find the revised patch for your review.
Hopefully it looks better this time.
Thanks for the comment. :)

Albert

--------------090100010101090506000702
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
+++ 20_atapi_intr_race_fix/drivers/scsi/libata-core.c	2005-06-09 14:40:51.000000000 +0800
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
 
@@ -3457,11 +3461,39 @@
 {
 	u8 status, host_stat;
 
+	/* ATAPI: Handle the interrupt before CDB is sent */
+	if (unlikely(is_atapi_taskfile(&qc->tf) &&
+	    ap->pio_task_state != PIO_ST_CDB_SENT)) {
+		/* check whether it's our irq */
+		if ((qc->dev->id[0] & 0x60) == 0x20) {
+			/* Some pre-ATAPI-4 devices assert INTRQ here 
+			 * if nIEN is zero. qc->dev->id[0] bits 5-6 can 
+			 * be used to identify such devices.
+			 */
+			status = ata_altstatus(ap);
+			if (status & ATA_BUSY)
+				goto idle_irq;
+
+			/* clear INTRQ */
+			status = ata_chk_status(ap);
+			if (unlikely(status & ATA_BUSY))
+			goto idle_irq;
+
+			DPRINTK("ata%u: atapi interrupt handled\n", ap->id);
+
+			/* clear bmdma interrupt bit */
+			ap->ops->irq_clear(ap);
+			return 1;	/* irq handled */
+		} else {
+			DPRINTK("ata%u: not my atapi interrupt\n", ap->id);
+			goto idle_irq;
+		}
+	}
+
 	switch (qc->tf.protocol) {
 
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
-	case ATA_PROT_ATAPI:
 		/* check status of DMA engine */
 		host_stat = ap->ops->bmdma_status(ap);
 		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
@@ -3489,6 +3521,8 @@
 		DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
 			ap->id, qc->tf.protocol, status);
 
+		ap->pio_task_state = PIO_ST_IDLE;
+
 		/* ack bmdma irq events */
 		ap->ops->irq_clear(ap);
 
@@ -3496,6 +3530,7 @@
 		ata_qc_complete(qc, status);
 		break;
 
+	case ATA_PROT_ATAPI:
 	default:
 		goto idle_irq;
 	}
@@ -3580,6 +3615,7 @@
 	struct ata_port *ap = _data;
 	struct ata_queued_cmd *qc;
 	u8 status;
+	unsigned long flags;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
@@ -3595,10 +3631,13 @@
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
@@ -3615,6 +3654,8 @@
 		queue_work(ata_wq, &ap->pio_task);
 	}
 
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	return;
 
 err_out:

--------------090100010101090506000702--


