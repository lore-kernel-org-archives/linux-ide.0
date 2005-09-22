From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 2/3] libata: rename task states/variables
Date: Thu, 22 Sep 2005 12:11:04 +0800
Message-ID: <43322ED8.8050509@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com> <43322C50.1060009@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070404090107050209070003"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:64193 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965193AbVIVELQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Sep 2005 00:11:16 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8M4AjXu007924
	for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2005 00:10:45 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8M4B5aP452390
	for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2005 22:11:05 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8M4B403015111
	for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2005 22:11:05 -0600
In-Reply-To: <43322C50.1060009@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------070404090107050209070003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 2/3: rename task states/variables

Changes:
s/PIO_ST_/HSM_ST_/ and s/pio_task_state/hsm_task_state/.

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------070404090107050209070003
Content-Type: text/plain;
 name="idpio2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio2.diff"

--- id1/include/linux/libata.h	2005-09-21 15:49:14.000000000 +0800
+++ id2/include/linux/libata.h	2005-09-21 16:25:26.000000000 +0800
@@ -155,16 +155,16 @@ enum {
 	ATA_SHIFT_PIO		= 11,
 };
 
-enum pio_task_states {
-	PIO_ST_UNKNOWN,
-	PIO_ST_IDLE,
-	PIO_ST_POLL,
-	PIO_ST_TMOUT,
-	PIO_ST,
-	PIO_ST_LAST,
-	PIO_ST_LAST_POLL,
-	PIO_ST_ERR,
-	PIO_ST_FIRST,
+enum hsm_task_states {
+	HSM_ST_UNKNOWN,
+	HSM_ST_IDLE,
+	HSM_ST_POLL,
+	HSM_ST_TMOUT,
+	HSM_ST,
+	HSM_ST_LAST,
+	HSM_ST_LAST_POLL,
+	HSM_ST_ERR,
+	HSM_ST_FIRST,
 };
 
 /* forward declarations */
@@ -319,7 +319,7 @@ struct ata_port {
 	struct work_struct	packet_task;
 
 	struct work_struct	pio_task;
-	unsigned int		pio_task_state;
+	unsigned int		hsm_task_state;
 	unsigned long		pio_task_timeout;
 
 	void			*private_data;
--- id1/drivers/scsi/libata-core.c	2005-09-22 10:26:34.000000000 +0800
+++ id2/drivers/scsi/libata-core.c	2005-09-22 10:26:38.000000000 +0800
@@ -2427,20 +2427,20 @@ void ata_poll_qc_complete(struct ata_que
 static unsigned long ata_pio_poll(struct ata_port *ap)
 {
 	u8 status;
-	unsigned int poll_state = PIO_ST_UNKNOWN;
-	unsigned int reg_state = PIO_ST_UNKNOWN;
-	const unsigned int tmout_state = PIO_ST_TMOUT;
-
-	switch (ap->pio_task_state) {
-	case PIO_ST:
-	case PIO_ST_POLL:
-		poll_state = PIO_ST_POLL;
-		reg_state = PIO_ST;
-		break;
-	case PIO_ST_LAST:
-	case PIO_ST_LAST_POLL:
-		poll_state = PIO_ST_LAST_POLL;
-		reg_state = PIO_ST_LAST;
+	unsigned int poll_state = HSM_ST_UNKNOWN;
+	unsigned int reg_state = HSM_ST_UNKNOWN;
+	const unsigned int tmout_state = HSM_ST_TMOUT;
+
+	switch (ap->hsm_task_state) {
+	case HSM_ST:
+	case HSM_ST_POLL:
+		poll_state = HSM_ST_POLL;
+		reg_state = HSM_ST;
+		break;
+	case HSM_ST_LAST:
+	case HSM_ST_LAST_POLL:
+		poll_state = HSM_ST_LAST_POLL;
+		reg_state = HSM_ST_LAST;
 		break;
 	default:
 		BUG();
@@ -2450,14 +2450,14 @@ static unsigned long ata_pio_poll(struct
 	status = ata_chk_status(ap);
 	if (status & ATA_BUSY) {
 		if (time_after(jiffies, ap->pio_task_timeout)) {
-			ap->pio_task_state = tmout_state;
+			ap->hsm_task_state = tmout_state;
 			return 0;
 		}
-		ap->pio_task_state = poll_state;
+		ap->hsm_task_state = poll_state;
 		return ATA_SHORT_PAUSE;
 	}
 
-	ap->pio_task_state = reg_state;
+	ap->hsm_task_state = reg_state;
 	return 0;
 }
 
@@ -2482,14 +2482,14 @@ static int ata_pio_complete (struct ata_
 	 * we enter, BSY will be cleared in a chk-status or two.  If not,
 	 * the drive is probably seeking or something.  Snooze for a couple
 	 * msecs, then chk-status again.  If still busy, fall back to
-	 * PIO_ST_POLL state.
+	 * HSM_ST_POLL state.
 	 */
 	drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
 	if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
 		msleep(2);
 		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
 		if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
-			ap->pio_task_state = PIO_ST_LAST_POLL;
+			ap->hsm_task_state = HSM_ST_LAST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
 			return 0;
 		}
@@ -2497,14 +2497,14 @@ static int ata_pio_complete (struct ata_
 
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
-		ap->pio_task_state = PIO_ST_ERR;
+		ap->hsm_task_state = HSM_ST_ERR;
 		return 0;
 	}
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
-	ap->pio_task_state = PIO_ST_IDLE;
+	ap->hsm_task_state = HSM_ST_IDLE;
 
 	ata_poll_qc_complete(qc, drv_stat);
 
@@ -2667,7 +2667,7 @@ static void ata_pio_sector(struct ata_qu
 #endif
 
 	if (qc->cursect == (qc->nsect - 1))
-		ap->pio_task_state = PIO_ST_LAST;
+		ap->hsm_task_state = HSM_ST_LAST;
 
 	page = sg[qc->cursg].page;
 	offset = sg[qc->cursg].offset + qc->cursg_ofs * ATA_SECT_SIZE;
@@ -2726,7 +2726,7 @@ static void __atapi_pio_bytes(struct ata
 #endif
 
 	if (qc->curbytes + bytes >= qc->nbytes)
-		ap->pio_task_state = PIO_ST_LAST;
+		ap->hsm_task_state = HSM_ST_LAST;
 
 next_sg:
 	if (unlikely(qc->cursg >= qc->n_elem)) {
@@ -2748,7 +2748,7 @@ next_sg:
 		for (i = 0; i < words; i++)
 			ata_data_xfer(ap, (unsigned char*)pad_buf, 2, do_write);
 
-		ap->pio_task_state = PIO_ST_LAST;
+		ap->hsm_task_state = HSM_ST_LAST;
 		return;
 	}
 
@@ -2836,7 +2836,7 @@ static void atapi_pio_bytes(struct ata_q
 err_out:
 	printk(KERN_INFO "ata%u: dev %u: ATAPI check failed\n",
 	      ap->id, dev->devno);
-	ap->pio_task_state = PIO_ST_ERR;
+	ap->hsm_task_state = HSM_ST_ERR;
 }
 
 /**
@@ -2858,14 +2858,14 @@ static void ata_pio_block(struct ata_por
 	 * a chk-status or two.  If not, the drive is probably seeking
 	 * or something.  Snooze for a couple msecs, then
 	 * chk-status again.  If still busy, fall back to
-	 * PIO_ST_POLL state.
+	 * HSM_ST_POLL state.
 	 */
 	status = ata_busy_wait(ap, ATA_BUSY, 5);
 	if (status & ATA_BUSY) {
 		msleep(2);
 		status = ata_busy_wait(ap, ATA_BUSY, 10);
 		if (status & ATA_BUSY) {
-			ap->pio_task_state = PIO_ST_POLL;
+			ap->hsm_task_state = HSM_ST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
 			return;
 		}
@@ -2877,7 +2877,7 @@ static void ata_pio_block(struct ata_por
 	if (is_atapi_taskfile(&qc->tf)) {
 		/* no more data to transfer or unsupported ATAPI command */
 		if ((status & ATA_DRQ) == 0) {
-			ap->pio_task_state = PIO_ST_LAST;
+			ap->hsm_task_state = HSM_ST_LAST;
 			return;
 		}
 
@@ -2885,7 +2885,7 @@ static void ata_pio_block(struct ata_por
 	} else {
 		/* handle BSY=0, DRQ=0 as error */
 		if ((status & ATA_DRQ) == 0) {
-			ap->pio_task_state = PIO_ST_ERR;
+			ap->hsm_task_state = HSM_ST_ERR;
 			return;
 		}
 
@@ -2905,7 +2905,7 @@ static void ata_pio_error(struct ata_por
 	printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
 	       ap->id, drv_stat);
 
-	ap->pio_task_state = PIO_ST_IDLE;
+	ap->hsm_task_state = HSM_ST_IDLE;
 
 	ata_poll_qc_complete(qc, drv_stat | ATA_ERR);
 }
@@ -2920,25 +2920,25 @@ fsm_start:
 	timeout = 0;
 	qc_completed = 0;
 
-	switch (ap->pio_task_state) {
-	case PIO_ST_IDLE:
+	switch (ap->hsm_task_state) {
+	case HSM_ST_IDLE:
 		return;
 
-	case PIO_ST:
+	case HSM_ST:
 		ata_pio_block(ap);
 		break;
 
-	case PIO_ST_LAST:
+	case HSM_ST_LAST:
 		qc_completed = ata_pio_complete(ap);
 		break;
 
-	case PIO_ST_POLL:
-	case PIO_ST_LAST_POLL:
+	case HSM_ST_POLL:
+	case HSM_ST_LAST_POLL:
 		timeout = ata_pio_poll(ap);
 		break;
 
-	case PIO_ST_TMOUT:
-	case PIO_ST_ERR:
+	case HSM_ST_TMOUT:
+	case HSM_ST_ERR:
 		ata_pio_error(ap);
 		return;
 	}
@@ -3075,7 +3075,7 @@ static void ata_qc_timeout(struct ata_qu
 		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
-		ap->pio_task_state = PIO_ST_IDLE;
+		ap->hsm_task_state = HSM_ST_IDLE;
 
 		/* complete taskfile transaction */
 		ata_qc_complete(qc, drv_stat);
@@ -3375,7 +3375,7 @@ int ata_qc_issue_prot(struct ata_queued_
 			ata_qc_set_polling(qc);
 
 		ata_tf_to_host_nolock(ap, &qc->tf);
-		ap->pio_task_state = PIO_ST_LAST;
+		ap->hsm_task_state = HSM_ST_LAST;
 
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			queue_work(ata_wq, &ap->pio_task);
@@ -3388,7 +3388,7 @@ int ata_qc_issue_prot(struct ata_queued_
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
-		ap->pio_task_state = PIO_ST_LAST;
+		ap->hsm_task_state = HSM_ST_LAST;
 		break;
 
 	case ATA_PROT_PIO:
@@ -3399,19 +3399,19 @@ int ata_qc_issue_prot(struct ata_queued_
 
 		if (qc->tf.flags & ATA_TFLAG_POLLING) {
 			/* polling PIO */
-			ap->pio_task_state = PIO_ST;
+			ap->hsm_task_state = HSM_ST;
 			queue_work(ata_wq, &ap->pio_task);
 		} else {
 			/* interrupt driven PIO */
 			if (qc->tf.flags & ATA_TFLAG_WRITE) {
 				/* PIO data out protocol */
-				ap->pio_task_state = PIO_ST_FIRST;
+				ap->hsm_task_state = HSM_ST_FIRST;
 				queue_work(ata_wq, &ap->packet_task);
 
 				/* send first data block by polling */
 			} else {
 				/* PIO data in protocol */
-				ap->pio_task_state = PIO_ST;
+				ap->hsm_task_state = HSM_ST;
 
 				/* interrupt handler takes over from here */
 			}
@@ -3424,7 +3424,7 @@ int ata_qc_issue_prot(struct ata_queued_
 			ata_qc_set_polling(qc);
 
 		ata_tf_to_host_nolock(ap, &qc->tf);
-		ap->pio_task_state = PIO_ST_FIRST;
+		ap->hsm_task_state = HSM_ST_FIRST;
 
 		/* send cdb by polling if no cdb interrupt */
 		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
@@ -3437,7 +3437,7 @@ int ata_qc_issue_prot(struct ata_queued_
 			ata_qc_set_polling(qc);
 
 		ata_tf_to_host_nolock(ap, &qc->tf);
-		ap->pio_task_state = PIO_ST_FIRST;
+		ap->hsm_task_state = HSM_ST_FIRST;
 
 		/* send cdb by polling if no cdb interrupt */
 		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
@@ -3450,7 +3450,7 @@ int ata_qc_issue_prot(struct ata_queued_
 
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		ap->pio_task_state = PIO_ST_FIRST;
+		ap->hsm_task_state = HSM_ST_FIRST;
 
 		/* send cdb by polling if no cdb interrupt */
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
@@ -3660,7 +3660,7 @@ u8 ata_bmdma_status(struct ata_port *ap)
 		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 		host_stat = readb(mmio + ATA_DMA_STATUS);
 	} else
-	host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	return host_stat;
 }
 
@@ -3718,13 +3718,13 @@ static void atapi_send_cdb(struct ata_po
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_ATAPI:
-		ap->pio_task_state = PIO_ST;
+		ap->hsm_task_state = HSM_ST;
 		break;
 	case ATA_PROT_ATAPI_NODATA:
-		ap->pio_task_state = PIO_ST_LAST;
+		ap->hsm_task_state = HSM_ST_LAST;
 		break;
 	case ATA_PROT_ATAPI_DMA:
-		ap->pio_task_state = PIO_ST_LAST;
+		ap->hsm_task_state = HSM_ST_LAST;
 		/* initiate bmdma */
 		ap->ops->bmdma_start(qc);
 		break;
@@ -3753,11 +3753,11 @@ inline unsigned int ata_host_intr (struc
 	u8 status, host_stat = 0;
 
 	VPRINTK("ata%u: protocol %d task_state %d\n",
-		ap->id, qc->tf.protocol, ap->pio_task_state);
+		ap->id, qc->tf.protocol, ap->hsm_task_state);
 
 	/* Check whether we are expecting interrupt in this state */
-	switch (ap->pio_task_state) {
-	case PIO_ST_FIRST:
+	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
 		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
 		 * The flag was turned on only for atapi devices,
 		 * no need to check is_atapi_taskfile(&qc->tf) again.
@@ -3765,7 +3765,7 @@ inline unsigned int ata_host_intr (struc
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
 			goto idle_irq;
 		break;
-	case PIO_ST_LAST:
+	case HSM_ST_LAST:
 		if (qc->tf.protocol == ATA_PROT_DMA ||
 		    qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
 			/* check status of DMA engine */
@@ -3780,7 +3780,7 @@ inline unsigned int ata_host_intr (struc
 			ap->ops->bmdma_stop(qc);
 		}
 		break;
-	case PIO_ST:
+	case HSM_ST:
 		break;
 	default:
 		goto idle_irq;
@@ -3797,18 +3797,18 @@ inline unsigned int ata_host_intr (struc
 		goto idle_irq;
 
 	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->id, qc->tf.protocol, ap->pio_task_state, status);
+		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
 
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
 
 	/* check error */
 	if (unlikely((status & ATA_ERR) || (host_stat & ATA_DMA_ERR)))
-		ap->pio_task_state = PIO_ST_ERR;
+		ap->hsm_task_state = HSM_ST_ERR;
 
 fsm_start:
-	switch (ap->pio_task_state) {
-	case PIO_ST_FIRST:
+	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
 		/* Some pre-ATAPI-4 devices assert INTRQ 
 		 * at this state when ready to receive CDB.
 		 */
@@ -3816,7 +3816,7 @@ fsm_start:
 		/* check device status */
 		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
 			/* Wrong status. Let EH handle this */
-			ap->pio_task_state = PIO_ST_ERR;
+			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}
 
@@ -3824,19 +3824,19 @@ fsm_start:
 
 		break;
 
-	case PIO_ST:
+	case HSM_ST:
 		/* complete command or read/write the data register */
 		if (qc->tf.protocol == ATA_PROT_ATAPI) {
 			/* ATAPI PIO protocol */
 			if ((status & ATA_DRQ) == 0) {
 				/* no more data to transfer */
-				ap->pio_task_state = PIO_ST_LAST;
+				ap->hsm_task_state = HSM_ST_LAST;
 				goto fsm_start;
 			}
 			
 			atapi_pio_bytes(qc);
 
-			if (unlikely(ap->pio_task_state == PIO_ST_ERR))
+			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
 				/* bad ireason reported by device */
 				goto fsm_start;
 
@@ -3844,13 +3844,13 @@ fsm_start:
 			/* ATA PIO protocol */
 			if (unlikely((status & ATA_DRQ) == 0)) {
 				/* handle BSY=0, DRQ=0 as error */
-				ap->pio_task_state = PIO_ST_ERR;
+				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
 			}
 
 			ata_pio_sector(qc);
 
-			if (ap->pio_task_state == PIO_ST_LAST &&
+			if (ap->hsm_task_state == HSM_ST_LAST &&
 			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
 				/* all data read */
 				ata_altstatus(ap);
@@ -3861,10 +3861,10 @@ fsm_start:
 
 		break;
 
-	case PIO_ST_LAST:
+	case HSM_ST_LAST:
 		if (unlikely(status & ATA_DRQ)) {
 			/* handle DRQ=1 as error */
-			ap->pio_task_state = PIO_ST_ERR;
+			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}
 
@@ -3872,17 +3872,17 @@ fsm_start:
 		DPRINTK("ata%u: command complete, drv_stat 0x%x\n",
 			ap->id, status);
 
-		ap->pio_task_state = PIO_ST_IDLE;
+		ap->hsm_task_state = HSM_ST_IDLE;
 
 		/* complete taskfile transaction */
 		ata_qc_complete(qc, status);
 		break;
 
-	case PIO_ST_ERR:
+	case HSM_ST_ERR:
 		printk(KERN_ERR "ata%u: command error, drv_stat 0x%x host_stat 0x%x\n",
 		       ap->id, status, host_stat);
 
-		ap->pio_task_state = PIO_ST_IDLE;
+		ap->hsm_task_state = HSM_ST_IDLE;
 		ata_qc_complete(qc, status | ATA_ERR);
 		break;
 	default:
@@ -3989,7 +3989,7 @@ static void atapi_packet_task(void *_dat
 	/* Send the CDB (atapi) or the first data block (ata pio out).
 	 * During the state transition, interrupt handler shouldn't
 	 * be invoked before the data transfer is complete and
-	 * pio_task_state is changed. Hence, the following locking.
+	 * hsm_task_state is changed. Hence, the following locking.
 	 */
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
@@ -4004,7 +4004,7 @@ static void atapi_packet_task(void *_dat
 		 * send first data block.
 		 */
 		ata_pio_sector(qc);
-		ap->pio_task_state = PIO_ST;
+		ap->hsm_task_state = HSM_ST;
 
 		/* interrupt handler takes over from here */
 	}

--------------070404090107050209070003--

