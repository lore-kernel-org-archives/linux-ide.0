From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH RFC] libata: interrupt driven pio
Date: Sat, 10 Sep 2005 00:14:24 +0800
Message-ID: <4321B4E0.8020801@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020403020003000805060306"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.130]:46728 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030206AbVIIQOx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Sep 2005 12:14:53 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j89GEhG3127208
	for <linux-ide@vger.kernel.org>; Fri, 9 Sep 2005 12:14:45 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j89GF6tN182302
	for <linux-ide@vger.kernel.org>; Fri, 9 Sep 2005 10:15:06 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j89GEgNJ008968
	for <linux-ide@vger.kernel.org>; Fri, 9 Sep 2005 10:14:42 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------020403020003000805060306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear all,

The interrupt driven PIO draft patch is ready for your review.

Changes:
- add PIO_ST_FIRST for the state before sending ATAPI CDB or sending 
"ATA PIO data out" first data block.
- remove the ATA_FLAG_NOINTR flag since the interrupt handler is now 
aware of the states
- modify ata_pio_sector() and atapi_pio_bytes() to work in the interrupt 
context
- modify the ata_host_intr() to handle PIO interrupts
- modify ata_qc_issue_prot() to initialize states
- atapi_packet_task() changed to handle "ATA PIO data out" first data block
- support the pre-ATA4 ATAPI device which raise interrupt when ready to 
receive CDB

Patch against 2.6.13 (80ac2912f846c01d702774bb6aa7100ec71e88b9).

For your review and comment, thanks.

Albert



--------------020403020003000805060306
Content-Type: text/plain;
 name="idpio.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio.diff"

--- linux/include/linux/ata.h	2005-09-06 16:47:16.000000000 +0800
+++ id1/include/linux/ata.h	2005-09-09 14:34:00.000000000 +0800
@@ -181,6 +181,7 @@ enum {
 	ATA_TFLAG_ISADDR	= (1 << 1), /* enable r/w to nsect/lba regs */
 	ATA_TFLAG_DEVICE	= (1 << 2), /* enable r/w to device reg */
 	ATA_TFLAG_WRITE		= (1 << 3), /* data dir: host->dev==1 (write) */
+	ATA_TFLAG_POLLING	= (1 << 4), /* set nIEN to 1 and use polling */
 };
 
 enum ata_tf_protocols {
@@ -250,6 +251,8 @@ struct ata_taskfile {
 	  ((u64) (id)[(n) + 1] << 16) |	\
 	  ((u64) (id)[(n) + 0]) )
 
+#define atapi_id_cdb_intr(id)	(((id)[0] & 0x60) == 0x20)
+
 static inline int atapi_cdb_len(u16 *dev_id)
 {
 	u16 tmp = dev_id[0] & 0x3;
--- linux/include/linux/libata.h	2005-09-06 16:47:17.000000000 +0800
+++ id1/include/linux/libata.h	2005-09-09 17:41:14.000000000 +0800
@@ -116,8 +116,6 @@ enum {
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
-	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
-					     * proper HSM is in place. */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
@@ -166,6 +164,7 @@ enum pio_task_states {
 	PIO_ST_LAST,
 	PIO_ST_LAST_POLL,
 	PIO_ST_ERR,
+	PIO_ST_FIRST,
 };
 
 /* forward declarations */
--- linux/drivers/scsi/libata-core.c	2005-09-06 16:47:07.000000000 +0800
+++ id1/drivers/scsi/libata-core.c	2005-09-09 23:44:28.000000000 +0800
@@ -2401,7 +2401,6 @@ void ata_poll_qc_complete(struct ata_que
 	unsigned long flags;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->flags &= ~ATA_FLAG_NOINTR;
 	ata_irq_on(ap);
 	ata_qc_complete(qc, drv_stat);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
@@ -2660,7 +2659,10 @@ static void ata_pio_sector(struct ata_qu
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	buf = kmap(page) + offset;
+	if (in_atomic())
+		buf = kmap_atomic(page, KM_IRQ0) + offset;
+	else
+		buf = kmap(page) + offset;
 
 	qc->cursect++;
 	qc->cursg_ofs++;
@@ -2676,7 +2678,10 @@ static void ata_pio_sector(struct ata_qu
 	do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	ata_data_xfer(ap, buf, ATA_SECT_SIZE, do_write);
 
-	kunmap(page);
+	if (in_atomic())
+		kunmap_atomic(page, KM_IRQ0);
+	else
+		kunmap(page);
 }
 
 /**
@@ -2742,7 +2747,10 @@ next_sg:
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
 
-	buf = kmap(page) + offset;
+	if (in_atomic())
+		buf = kmap_atomic(page, KM_IRQ0) + offset;
+	else
+		buf = kmap(page) + offset;
 
 	bytes -= count;
 	qc->curbytes += count;
@@ -2758,7 +2766,10 @@ next_sg:
 	/* do the actual data transfer */
 	ata_data_xfer(ap, buf, count, do_write);
 
-	kunmap(page);
+	if (in_atomic())
+		kunmap_atomic(page, KM_IRQ0);
+	else
+		kunmap(page);
 
 	if (bytes)
 		goto next_sg;
@@ -2797,6 +2808,8 @@ static void atapi_pio_bytes(struct ata_q
 	if (do_write != i_write)
 		goto err_out;
 
+	VPRINTK("ata%u: xfering %d bytes\n", ap->id, bytes);
+
 	__atapi_pio_bytes(qc, bytes);
 
 	return;
@@ -3335,39 +3348,91 @@ int ata_qc_issue_prot(struct ata_queued_
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_NODATA:
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
 		ata_tf_to_host_nolock(ap, &qc->tf);
+		ap->pio_task_state = PIO_ST_LAST;
+
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			queue_work(ata_wq, &ap->pio_task);
+
 		break;
 
 	case ATA_PROT_DMA:
+		assert(!(qc->tf.flags & ATA_TFLAG_POLLING));
+
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
+		ap->pio_task_state = PIO_ST_LAST;
 		break;
 
-	case ATA_PROT_PIO: /* load tf registers, initiate polling pio */
-		ata_qc_set_polling(qc);
+	case ATA_PROT_PIO:
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
 		ata_tf_to_host_nolock(ap, &qc->tf);
-		ap->pio_task_state = PIO_ST;
-		queue_work(ata_wq, &ap->pio_task);
+
+		if (qc->tf.flags & ATA_TFLAG_POLLING) {
+			ap->pio_task_state = PIO_ST;
+			queue_work(ata_wq, &ap->pio_task);
+		} else {
+			/* Interrupt driven PIO. */
+			if (qc->tf.flags & ATA_TFLAG_WRITE) {
+				/*
+				 * PIO data out protocol
+				 */
+				ap->pio_task_state = PIO_ST_FIRST;
+				queue_work(ata_wq, &ap->packet_task);
+
+				/* send first data block by polling */
+			} else {
+				ap->pio_task_state = PIO_ST;
+
+				/* interrupt handler takes over from here */
+			}
+		}
+
 		break;
 
 	case ATA_PROT_ATAPI:
-		ata_qc_set_polling(qc);
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
 		ata_tf_to_host_nolock(ap, &qc->tf);
-		queue_work(ata_wq, &ap->packet_task);
+		ap->pio_task_state = PIO_ST_FIRST;
+
+		/* send cdb by polling if no cdb interrupt */
+		if ((!atapi_id_cdb_intr(qc->dev->id)) ||
+		    qc->tf.flags & ATA_TFLAG_POLLING)
+			queue_work(ata_wq, &ap->packet_task);
 		break;
 
 	case ATA_PROT_ATAPI_NODATA:
-		ap->flags |= ATA_FLAG_NOINTR;
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
 		ata_tf_to_host_nolock(ap, &qc->tf);
-		queue_work(ata_wq, &ap->packet_task);
+		ap->pio_task_state = PIO_ST_FIRST;
+
+		/* send cdb by polling if no cdb interrupt */
+		if ((!atapi_id_cdb_intr(qc->dev->id)) ||
+		    qc->tf.flags & ATA_TFLAG_POLLING)
+			queue_work(ata_wq, &ap->packet_task);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
-		ap->flags |= ATA_FLAG_NOINTR;
+		assert(!(qc->tf.flags & ATA_TFLAG_POLLING));
+
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		queue_work(ata_wq, &ap->packet_task);
+		ap->pio_task_state = PIO_ST_FIRST;
+
+		/* send cdb by polling if no cdb interrupt */
+		if ((!atapi_id_cdb_intr(qc->dev->id)) ||
+		    qc->tf.flags & ATA_TFLAG_POLLING)
+			queue_work(ata_wq, &ap->packet_task);
 		break;
 
 	default:
@@ -3609,6 +3674,29 @@ void ata_bmdma_stop(struct ata_queued_cm
 	ata_altstatus(ap);        /* dummy read */
 }
 
+static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	/* send SCSI cdb */
+	DPRINTK("send cdb\n");
+	assert(ap->cdb_len >= 12);
+
+	ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
+
+	switch (qc->tf.protocol) {
+	case ATA_PROT_ATAPI:
+		ap->pio_task_state = PIO_ST;
+		break;
+	case ATA_PROT_ATAPI_NODATA:
+		ap->pio_task_state = PIO_ST_LAST;
+		break;
+	case ATA_PROT_ATAPI_DMA:
+		ap->pio_task_state = PIO_ST_LAST;
+		/* initiate bmdma */
+		ap->ops->bmdma_start(qc);
+		break;
+	}
+}
+
 /**
  *	ata_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
@@ -3630,45 +3718,132 @@ inline unsigned int ata_host_intr (struc
 {
 	u8 status, host_stat;
 
-	switch (qc->tf.protocol) {
-
-	case ATA_PROT_DMA:
-	case ATA_PROT_ATAPI_DMA:
-	case ATA_PROT_ATAPI:
-		/* check status of DMA engine */
-		host_stat = ap->ops->bmdma_status(ap);
-		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
+	VPRINTK("ata%u: protocol %d task state %d\n",
+		ap->id, qc->tf.protocol, ap->pio_task_state);
 
-		/* if it's not our irq... */
-		if (!(host_stat & ATA_DMA_INTR))
+	/* Check whether we are expecting interrupt in this state */
+	switch (ap->pio_task_state) {
+	case PIO_ST_FIRST:
+		if (!(is_atapi_taskfile(&qc->tf) &&
+		      atapi_id_cdb_intr(qc->dev->id)))
 			goto idle_irq;
+		break;
+	case PIO_ST_LAST:
+		if (qc->tf.protocol == ATA_PROT_DMA ||
+		    qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
+			/* check status of DMA engine */
+			host_stat = ap->ops->bmdma_status(ap);
+			VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
+
+			/* if it's not our irq... */
+			if (!(host_stat & ATA_DMA_INTR))
+				goto idle_irq;
 
-		/* before we do anything else, clear DMA-Start bit */
-		ap->ops->bmdma_stop(qc);
+			/* before we do anything else, clear DMA-Start bit */
+			ap->ops->bmdma_stop(qc);
+		}
+		break;
+	case PIO_ST:
+		break;
+	default:
+		goto idle_irq;
+	}
 
-		/* fall through */
+	/* check altstatus */
+	status = ata_altstatus(ap);
+	if (status & ATA_BUSY) {
+		goto idle_irq;
+	}
 
-	case ATA_PROT_ATAPI_NODATA:
-	case ATA_PROT_NODATA:
-		/* check altstatus */
-		status = ata_altstatus(ap);
-		if (status & ATA_BUSY)
-			goto idle_irq;
+	/* check main status, clearing INTRQ */
+	status = ata_chk_status(ap);
+	if (unlikely(status & ATA_BUSY))
+		goto idle_irq;
 
-		/* check main status, clearing INTRQ */
-		status = ata_chk_status(ap);
-		if (unlikely(status & ATA_BUSY))
-			goto idle_irq;
-		DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
-			ap->id, qc->tf.protocol, status);
+	DPRINTK("ata%u: protocol %d task state %d (dev_stat 0x%X)\n",
+		ap->id, qc->tf.protocol, ap->pio_task_state, status);
+
+	/* check whether error */
+	if (status & ATA_ERR) {
+		ap->pio_task_state = PIO_ST_ERR;
+	}
+
+fsm_start:
+	switch (ap->pio_task_state) {
+	case PIO_ST_FIRST:
+		/* Some pre-ATAPI-4 devices assert INTRQ 
+		 * at this point when ready to receive CDB.
+		 */
+
+		/* check device status */
+		if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
+			/* Wrong status. Let EH handle this */
+			ap->pio_task_state = PIO_ST_ERR;
+			goto fsm_start;
+		}
+
+		atapi_send_cdb(ap, qc);
+
+		break;
+
+	case PIO_ST:
+		/* complete command or read/write the data register */
+		if (qc->tf.protocol == ATA_PROT_ATAPI) {
+			/* ATAPI PIO protocol */
+			if ((status & ATA_DRQ) == 0) {
+				ap->pio_task_state = PIO_ST_LAST;
+				goto fsm_start;
+			}
+			
+			atapi_pio_bytes(qc);
+
+		} else {
+			/* ATA PIO protocol */
+			if (unlikely((status & ATA_DRQ) == 0)) {
+				/* handle BSY=0, DRQ=0 as error */
+				ap->pio_task_state = PIO_ST_ERR;
+				goto fsm_start;
+			}
+
+			ata_pio_sector(qc);
+
+			if (ap->pio_task_state == PIO_ST_LAST &&
+			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
+				/* complete the command */
+				status = ata_altstatus(ap);
+				status = ata_chk_status(ap);
+				goto fsm_start;
+			}
+		}
+
+		break;
+
+	case PIO_ST_LAST:
+		if (status & ATA_DRQ) {
+			/* status error */
+			ap->pio_task_state = PIO_ST_ERR;
+			goto fsm_start;
+		}
+
+		/* no more data to transfer */
+		DPRINTK("ata%u: PIO complete, drv_stat 0x%x\n",
+			ap->id, status);
 
 		/* ack bmdma irq events */
 		ap->ops->irq_clear(ap);
 
+		ap->pio_task_state = PIO_ST_IDLE;
+
 		/* complete taskfile transaction */
 		ata_qc_complete(qc, status);
 		break;
 
+	case PIO_ST_ERR:
+		printk(KERN_ERR "ata%u: PIO error, drv_stat 0x%x\n",
+		       ap->id, status);
+		ap->pio_task_state = PIO_ST_IDLE;
+		ata_qc_complete(qc, status | ATA_ERR);
+		break;
 	default:
 		goto idle_irq;
 	}
@@ -3720,7 +3895,7 @@ irqreturn_t ata_interrupt (int irq, void
 
 		ap = host_set->ports[i];
 		if (ap &&
-		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & ATA_FLAG_PORT_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -3754,6 +3929,7 @@ static void atapi_packet_task(void *_dat
 	struct ata_port *ap = _data;
 	struct ata_queued_cmd *qc;
 	u8 status;
+	unsigned long flags;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
@@ -3769,34 +3945,31 @@ static void atapi_packet_task(void *_dat
 	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
 		goto err_out;
 
-	/* send SCSI cdb */
-	DPRINTK("send cdb\n");
-	assert(ap->cdb_len >= 12);
 
-	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA ||
-	    qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {
-		unsigned long flags;
-
-		/* Once we're done issuing command and kicking bmdma,
-		 * irq handler takes over.  To not lose irq, we need
-		 * to clear NOINTR flag before sending cdb, but
-		 * interrupt handler shouldn't be invoked before we're
-		 * finished.  Hence, the following locking.
-		 */
+	if (is_atapi_taskfile(&qc->tf)) {
 		spin_lock_irqsave(&ap->host_set->lock, flags);
-		ap->flags &= ~ATA_FLAG_NOINTR;
-		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
-		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
-			ap->ops->bmdma_start(qc);	/* initiate bmdma */
+
+		/* send CDB */
+		atapi_send_cdb(ap, qc);
+
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			queue_work(ata_wq, &ap->pio_task);
+
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	} else {
-		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
+		/* PIO data out protocol.
+		 * send first data block.
+		 */
+		ata_pio_sector(qc);
 
-		/* PIO commands are handled by polling */
+		spin_lock_irqsave(&ap->host_set->lock, flags);
 		ap->pio_task_state = PIO_ST;
-		queue_work(ata_wq, &ap->pio_task);
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+		/* interrupt handler takes over from here */
 	}
 
+
 	return;
 
 err_out:

--------------020403020003000805060306--

