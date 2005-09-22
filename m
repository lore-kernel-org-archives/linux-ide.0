From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 1/3] libata: interrupt driven pio for libata-core
Date: Thu, 22 Sep 2005 12:09:00 +0800
Message-ID: <43322E5C.8050500@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com> <43322C50.1060009@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080506050409000607010704"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:39331 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751431AbVIVEJV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Sep 2005 00:09:21 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8M470mE003286
	for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2005 00:07:00 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8M49Z2N543304
	for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2005 22:09:35 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8M491S9012343
	for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2005 22:09:02 -0600
In-Reply-To: <43322C50.1060009@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------080506050409000607010704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 1/3: interrupt driven pio for libata-core

Changes
- add PIO_ST_FIRST for the state before sending ATAPI CDB or sending 
"ATA PIO data out" first data block.
- add ATA_TFLAG_POLLING and ATA_DFLAG_CDB_INTR flags
- remove the ATA_FLAG_NOINTR flag since the interrupt handler is now 
aware of the states
- modify ata_pio_sector() and atapi_pio_bytes() to work in the interrupt 
context
- modify the ata_host_intr() to handle PIO interrupts
- modify ata_qc_issue_prot() to initialize states
- atapi_packet_task() changed to handle "ATA PIO data out" first data block
- support the pre-ATA4 ATAPI device which raise interrupt when ready to 
receive CDB

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------080506050409000607010704
Content-Type: text/plain;
 name="idpio1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio1.diff"

--- linux/include/linux/ata.h	2005-09-20 17:18:10.000000000 +0800
+++ id1/include/linux/ata.h	2005-09-19 16:18:45.000000000 +0800
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
 
+#define ata_id_cdb_intr(id)	(((id)[0] & 0x60) == 0x20)
+
 static inline int atapi_cdb_len(u16 *dev_id)
 {
 	u16 tmp = dev_id[0] & 0x3;
--- linux/include/linux/libata.h	2005-09-20 17:18:12.000000000 +0800
+++ id1/include/linux/libata.h	2005-09-21 15:49:14.000000000 +0800
@@ -97,6 +97,7 @@ enum {
 	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
 	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
 	ATA_DFLAG_LOCK_SECTORS	= (1 << 2), /* don't adjust max_sectors */
+	ATA_DFLAG_CDB_INTR	= (1 << 3), /* device asserts INTRQ when ready for CDB */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -115,8 +116,6 @@ enum {
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
-	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
-					     * proper HSM is in place. */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
@@ -165,6 +164,7 @@ enum pio_task_states {
 	PIO_ST_LAST,
 	PIO_ST_LAST_POLL,
 	PIO_ST_ERR,
+	PIO_ST_FIRST,
 };
 
 /* forward declarations */
--- linux/drivers/scsi/libata-core.c	2005-09-20 17:18:00.000000000 +0800
+++ id1/drivers/scsi/libata-core.c	2005-09-22 10:26:34.000000000 +0800
@@ -1292,6 +1292,9 @@ retry:
 		ap->cdb_len = (unsigned int) rc;
 		ap->host->max_cmd_len = (unsigned char) ap->cdb_len;
 
+		if (ata_id_cdb_intr(dev->id))
+			dev->flags |= ATA_DFLAG_CDB_INTR;
+
 		/* print device info to dmesg */
 		printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
 		       ap->id, device,
@@ -2405,7 +2408,6 @@ void ata_poll_qc_complete(struct ata_que
 	unsigned long flags;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->flags &= ~ATA_FLAG_NOINTR;
 	ata_irq_on(ap);
 	ata_qc_complete(qc, drv_stat);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
@@ -2660,6 +2662,9 @@ static void ata_pio_sector(struct ata_qu
 	struct page *page;
 	unsigned int offset;
 	unsigned char *buf;
+#ifdef CONFIG_HIGHMEM
+	unsigned long flags;
+#endif
 
 	if (qc->cursect == (qc->nsect - 1))
 		ap->pio_task_state = PIO_ST_LAST;
@@ -2671,7 +2676,10 @@ static void ata_pio_sector(struct ata_qu
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	buf = kmap(page) + offset;
+#ifdef CONFIG_HIGHMEM
+	local_irq_save(flags);
+#endif
+	buf = kmap_atomic(page, KM_IRQ0) + offset;
 
 	qc->cursect++;
 	qc->cursg_ofs++;
@@ -2687,7 +2695,10 @@ static void ata_pio_sector(struct ata_qu
 	do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	ata_data_xfer(ap, buf, ATA_SECT_SIZE, do_write);
 
-	kunmap(page);
+	kunmap_atomic(buf - offset, KM_IRQ0);
+#ifdef CONFIG_HIGHMEM
+	local_irq_restore(flags);
+#endif
 }
 
 /**
@@ -2710,6 +2721,9 @@ static void __atapi_pio_bytes(struct ata
 	struct page *page;
 	unsigned char *buf;
 	unsigned int offset, count;
+#ifdef CONFIG_HIGHMEM
+	unsigned long flags;
+#endif
 
 	if (qc->curbytes + bytes >= qc->nbytes)
 		ap->pio_task_state = PIO_ST_LAST;
@@ -2753,7 +2767,10 @@ next_sg:
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
 
-	buf = kmap(page) + offset;
+#ifdef CONFIG_HIGHMEM
+	local_irq_save(flags);
+#endif
+	buf = kmap_atomic(page, KM_IRQ0) + offset;
 
 	bytes -= count;
 	qc->curbytes += count;
@@ -2769,8 +2786,10 @@ next_sg:
 	/* do the actual data transfer */
 	ata_data_xfer(ap, buf, count, do_write);
 
-	kunmap(page);
-
+	kunmap_atomic(buf - offset, KM_IRQ0);
+#ifdef CONFIG_HIGHMEM
+	local_irq_restore(flags);
+#endif
 	if (bytes)
 		goto next_sg;
 }
@@ -2808,6 +2827,8 @@ static void atapi_pio_bytes(struct ata_q
 	if (do_write != i_write)
 		goto err_out;
 
+	VPRINTK("ata%u: xfering %d bytes\n", ap->id, bytes);
+
 	__atapi_pio_bytes(qc, bytes);
 
 	return;
@@ -3054,6 +3075,8 @@ static void ata_qc_timeout(struct ata_qu
 		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat, host_stat);
 
+		ap->pio_task_state = PIO_ST_IDLE;
+
 		/* complete taskfile transaction */
 		ata_qc_complete(qc, drv_stat);
 		break;
@@ -3348,39 +3371,90 @@ int ata_qc_issue_prot(struct ata_queued_
 
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
+			/* polling PIO */
+			ap->pio_task_state = PIO_ST;
+			queue_work(ata_wq, &ap->pio_task);
+		} else {
+			/* interrupt driven PIO */
+			if (qc->tf.flags & ATA_TFLAG_WRITE) {
+				/* PIO data out protocol */
+				ap->pio_task_state = PIO_ST_FIRST;
+				queue_work(ata_wq, &ap->packet_task);
+
+				/* send first data block by polling */
+			} else {
+				/* PIO data in protocol */
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
+		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
+		    (qc->tf.flags & ATA_TFLAG_POLLING))
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
+		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
+		    (qc->tf.flags & ATA_TFLAG_POLLING))
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
+		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+			queue_work(ata_wq, &ap->packet_task);
 		break;
 
 	default:
@@ -3623,6 +3697,41 @@ void ata_bmdma_stop(struct ata_queued_cm
 }
 
 /**
+ *	atapi_send_cdb - Write CDB bytes to hardware
+ *	@ap: Port to which ATAPI device is attached.
+ *	@qc: Taskfile currently active
+ *
+ *	When device has indicated its readiness to accept
+ *	a CDB, this function is called.  Send the CDB.
+ *
+ *	LOCKING:
+ *	caller.
+ */
+
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
+/**
  *	ata_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
  *	@qc: Taskfile currently active in engine
@@ -3641,47 +3750,141 @@ void ata_bmdma_stop(struct ata_queued_cm
 inline unsigned int ata_host_intr (struct ata_port *ap,
 				   struct ata_queued_cmd *qc)
 {
-	u8 status, host_stat;
+	u8 status, host_stat = 0;
 
-	switch (qc->tf.protocol) {
+	VPRINTK("ata%u: protocol %d task_state %d\n",
+		ap->id, qc->tf.protocol, ap->pio_task_state);
 
-	case ATA_PROT_DMA:
-	case ATA_PROT_ATAPI_DMA:
-	case ATA_PROT_ATAPI:
-		/* check status of DMA engine */
-		host_stat = ap->ops->bmdma_status(ap);
-		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
-
-		/* if it's not our irq... */
-		if (!(host_stat & ATA_DMA_INTR))
+	/* Check whether we are expecting interrupt in this state */
+	switch (ap->pio_task_state) {
+	case PIO_ST_FIRST:
+		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
+		 * The flag was turned on only for atapi devices,
+		 * no need to check is_atapi_taskfile(&qc->tf) again.
+		 */
+		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
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
+	if (status & ATA_BUSY)
+		goto idle_irq;
 
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
+	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
+		ap->id, qc->tf.protocol, ap->pio_task_state, status);
 
-		/* ack bmdma irq events */
-		ap->ops->irq_clear(ap);
+	/* ack bmdma irq events */
+	ap->ops->irq_clear(ap);
+
+	/* check error */
+	if (unlikely((status & ATA_ERR) || (host_stat & ATA_DMA_ERR)))
+		ap->pio_task_state = PIO_ST_ERR;
+
+fsm_start:
+	switch (ap->pio_task_state) {
+	case PIO_ST_FIRST:
+		/* Some pre-ATAPI-4 devices assert INTRQ 
+		 * at this state when ready to receive CDB.
+		 */
+
+		/* check device status */
+		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
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
+				/* no more data to transfer */
+				ap->pio_task_state = PIO_ST_LAST;
+				goto fsm_start;
+			}
+			
+			atapi_pio_bytes(qc);
+
+			if (unlikely(ap->pio_task_state == PIO_ST_ERR))
+				/* bad ireason reported by device */
+				goto fsm_start;
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
+				/* all data read */
+				ata_altstatus(ap);
+				status = ata_chk_status(ap);
+				goto fsm_start;
+			}
+		}
+
+		break;
+
+	case PIO_ST_LAST:
+		if (unlikely(status & ATA_DRQ)) {
+			/* handle DRQ=1 as error */
+			ap->pio_task_state = PIO_ST_ERR;
+			goto fsm_start;
+		}
+
+		/* no more data to transfer */
+		DPRINTK("ata%u: command complete, drv_stat 0x%x\n",
+			ap->id, status);
+
+		ap->pio_task_state = PIO_ST_IDLE;
 
 		/* complete taskfile transaction */
 		ata_qc_complete(qc, status);
 		break;
 
+	case PIO_ST_ERR:
+		printk(KERN_ERR "ata%u: command error, drv_stat 0x%x host_stat 0x%x\n",
+		       ap->id, status, host_stat);
+
+		ap->pio_task_state = PIO_ST_IDLE;
+		ata_qc_complete(qc, status | ATA_ERR);
+		break;
 	default:
 		goto idle_irq;
 	}
@@ -3733,11 +3936,11 @@ irqreturn_t ata_interrupt (int irq, void
 
 		ap = host_set->ports[i];
 		if (ap &&
-		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & ATA_FLAG_PORT_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)) &&
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
 			    (qc->flags & ATA_QCFLAG_ACTIVE))
 				handled |= ata_host_intr(ap, qc);
 		}
@@ -3767,6 +3970,7 @@ static void atapi_packet_task(void *_dat
 	struct ata_port *ap = _data;
 	struct ata_queued_cmd *qc;
 	u8 status;
+	unsigned long flags;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
@@ -3782,38 +3986,35 @@ static void atapi_packet_task(void *_dat
 	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
 		goto err_out;
 
-	/* send SCSI cdb */
-	DPRINTK("send cdb\n");
-	assert(ap->cdb_len >= 12);
+	/* Send the CDB (atapi) or the first data block (ata pio out).
+	 * During the state transition, interrupt handler shouldn't
+	 * be invoked before the data transfer is complete and
+	 * pio_task_state is changed. Hence, the following locking.
+	 */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
 
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
-		spin_lock_irqsave(&ap->host_set->lock, flags);
-		ap->flags &= ~ATA_FLAG_NOINTR;
-		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
-		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
-			ap->ops->bmdma_start(qc);	/* initiate bmdma */
-		spin_unlock_irqrestore(&ap->host_set->lock, flags);
-	} else {
-		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
+	if (is_atapi_taskfile(&qc->tf)) {
+		/* send CDB */
+		atapi_send_cdb(ap, qc);
 
-		/* PIO commands are handled by polling */
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			queue_work(ata_wq, &ap->pio_task);
+	} else {
+		/* PIO data out protocol.
+		 * send first data block.
+		 */
+		ata_pio_sector(qc);
 		ap->pio_task_state = PIO_ST;
-		queue_work(ata_wq, &ap->pio_task);
+
+		/* interrupt handler takes over from here */
 	}
 
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	return;
 
 err_out:
-	ata_poll_qc_complete(qc, ATA_ERR);
+	ata_pio_error(ap);
 }
 
 

--------------080506050409000607010704--

