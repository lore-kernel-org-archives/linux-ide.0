From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 4/8] libata: move and reduce locking to the pio data xfer
 functions
Date: Wed, 16 May 2007 15:18:01 +0800
Message-ID: <464AB029.90903@tw.ibm.com>
References: <464AACDF.1030903@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:50740 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755695AbXEPHSI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 03:18:08 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l4G7ES9F013518
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 03:14:29 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4G7I4Ui207474
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:18:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4G7I39Y015516
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:18:04 -0600
In-Reply-To: <464AACDF.1030903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

patch 4/8: 
- Added the ATA_PFLAG_HSM_WQ (i.e. HSM running in workqueue) flag to serialize irq and workqueue access to the port.
- Moved the locking out from the ata_hsm_move() to the data xfer functions like ata_pio_sectors().
- The time holding ap->lock is reduced to only part of last pio transfer and clearing of the ATA_PFLAG_HSM_WQ flag.
- The transfer of "head" is made to be multiple of 8-bytes such that  ->data_xfer() could possibly utilize 32-bit pio/mmio.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>
---
The variable name is changed to "irq_handover" per Tejun's review.
sata_sil is also modified per Tejun's advice.
Alan's concern about unsolicited irq will be addressed later in patch 5/8 and 8/8.
The chang to __atapi_pio_bytes() is the hardest part. Hopefully this patch gets it right.

diff -Nrup 03_read_state/drivers/ata/libata-core.c 04_move_narrow_lock/drivers/ata/libata-core.c
--- 03_read_state/drivers/ata/libata-core.c	2007-05-16 10:37:57.000000000 +0800
+++ 04_move_narrow_lock/drivers/ata/libata-core.c	2007-05-16 13:53:16.000000000 +0800
@@ -4436,6 +4436,7 @@ void ata_data_xfer_noirq(struct ata_devi
  *	ata_pio_sector - Transfer a sector of data.
  *	@qc: Command on going
  *	@drq_last: Last sector of pio DRQ transfer
+ *	@irq_handover: workqueue is going to handover to the irq handler
  *
  *	Transfer qc->sect_size bytes of data from/to the ATA device.
  *
@@ -4443,7 +4444,7 @@ void ata_data_xfer_noirq(struct ata_devi
  *	Inherited from caller.
  */
 
-static void ata_pio_sector(struct ata_queued_cmd *qc, int drq_last)
+static void ata_pio_sector(struct ata_queued_cmd *qc, int drq_last, int irq_handover)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	struct scatterlist *sg = qc->__sg;
@@ -4451,6 +4452,7 @@ static void ata_pio_sector(struct ata_qu
 	struct page *page;
 	unsigned int offset;
 	unsigned char *buf;
+	unsigned long irq_flags = 0;
 
 	if (qc->curbytes == qc->nbytes - qc->sect_size)
 		ap->hsm_task_state = do_write ? HSM_ST_LAST : HSM_ST_IDLE;
@@ -4467,6 +4469,16 @@ static void ata_pio_sector(struct ata_qu
 	if (PageHighMem(page)) {
 		unsigned long flags;
 
+		if (irq_handover)
+			/* Data transfer will trigger INTRQ.
+			 * Acquire ap->lock to 
+			 *  - transfer the last sector of data
+			 *  - read and discard altstatus 
+			 *  - clear ATA_PFLAG_HSM_WQ
+			 * atomically.
+			 */
+			spin_lock_irqsave(ap->lock, irq_flags);
+
 		/* FIXME: use a bounce buffer */
 		local_irq_save(flags);
 		buf = kmap_atomic(page, KM_IRQ0);
@@ -4477,8 +4489,34 @@ static void ata_pio_sector(struct ata_qu
 		kunmap_atomic(buf, KM_IRQ0);
 		local_irq_restore(flags);
 	} else {
+		unsigned int head = 0, tail = qc->sect_size;
+
 		buf = page_address(page);
-		ap->ops->data_xfer(qc->dev, buf + offset, qc->sect_size, do_write);
+
+		if (irq_handover) {
+			tail = 8;
+			head = qc->sect_size - tail;
+
+			/* Data transfer of "head" is done without holding
+			 * ap->lock to improve interrupt latency.
+			 * Hopefully no unsolicited INTRQ at this point,
+			 * otherwise we may have nobody cared irq.
+			 * Make "head" to be multiple of 8 bytes such that
+			 * ->data_xfer() could utilize 32-bit pio/mmio.
+			 */
+			ap->ops->data_xfer(qc->dev, buf + offset, head, do_write);
+
+			/* Data transfer of "tail" will trigger INTRQ.
+			 * Acquire ap->lock to 
+			 *  - transfer the last 8 bytes of data
+			 *  - read and discard altstatus 
+			 *  - clear ATA_PFLAG_HSM_WQ
+			 * atomically.
+			 */
+			spin_lock_irqsave(ap->lock, irq_flags);
+		}
+
+		ap->ops->data_xfer(qc->dev, buf + offset + head, tail, do_write);
 	}
 
 	if (drq_last)
@@ -4491,11 +4529,21 @@ static void ata_pio_sector(struct ata_qu
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
+
+	if (irq_handover) {
+		ap->pflags &= ~ATA_PFLAG_HSM_WQ;
+		spin_unlock_irqrestore(ap->lock, irq_flags);
+	}
+
+	/* irq handler or another command might
+	 *  be running at this point
+	 */
 }
 
 /**
  *	ata_pio_sectors - Transfer one or many sectors.
  *	@qc: Command on going
+ *	@irq_handover: workqueue is going to handover to the irq handler
  *
  *	Transfer one or many sectors of data from/to the
  *	ATA device for the DRQ request.
@@ -4504,7 +4552,7 @@ static void ata_pio_sector(struct ata_qu
  *	Inherited from caller.
  */
 
-static void ata_pio_sectors(struct ata_queued_cmd *qc)
+static void ata_pio_sectors(struct ata_queued_cmd *qc, int irq_handover)
 {
 	if (is_multi_taskfile(&qc->tf)) {
 		/* READ/WRITE MULTIPLE */
@@ -4515,15 +4563,20 @@ static void ata_pio_sectors(struct ata_q
 		nsect = min((qc->nbytes - qc->curbytes) / qc->sect_size,
 			    qc->dev->multi_count);
 		while (nsect--)
-			ata_pio_sector(qc, !nsect);
+			ata_pio_sector(qc, !nsect, irq_handover && !nsect);
 	} else
-		ata_pio_sector(qc, 1);
+		ata_pio_sector(qc, 1, irq_handover);
+
+	/* irq handler or another command might
+	 *  be running at this point
+	 */
 }
 
 /**
  *	atapi_send_cdb - Write CDB bytes to hardware
  *	@ap: Port to which ATAPI device is attached.
  *	@qc: Taskfile currently active
+ *	@irq_handover: workqueue is going to handover to the irq handler
  *
  *	When device has indicated its readiness to accept
  *	a CDB, this function is called.  Send the CDB.
@@ -4532,12 +4585,17 @@ static void ata_pio_sectors(struct ata_q
  *	caller.
  */
 
-static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
+static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc, int irq_handover)
 {
+	unsigned long irq_flags = 0;
+
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
 	WARN_ON(qc->dev->cdb_len < 12);
 
+	if (irq_handover)
+		spin_lock_irqsave(ap->lock, irq_flags);
+
 	ap->ops->data_xfer(qc->dev, qc->cdb, qc->dev->cdb_len, 1);
 	ata_altstatus(ap); /* flush */
 
@@ -4554,12 +4612,22 @@ static void atapi_send_cdb(struct ata_po
 		ap->ops->bmdma_start(qc);
 		break;
 	}
+
+	if (irq_handover) {
+		ap->pflags &= ~ATA_PFLAG_HSM_WQ;
+		spin_unlock_irqrestore(ap->lock, irq_flags);
+	}
+
+	/* irq handler or another command might
+	 *  be running at this point
+	 */
 }
 
 /**
  *	__atapi_pio_bytes - Transfer data from/to the ATAPI device.
  *	@qc: Command on going
  *	@bytes: number of bytes
+ *	@irq_handover: workqueue is going to handover to the irq handler
  *
  *	Transfer Transfer data from/to the ATAPI device.
  *
@@ -4568,7 +4636,7 @@ static void atapi_send_cdb(struct ata_po
  *
  */
 
-static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
+static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes, int irq_handover)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	struct scatterlist *sg = qc->__sg;
@@ -4576,9 +4644,14 @@ static void __atapi_pio_bytes(struct ata
 	struct page *page;
 	unsigned char *buf;
 	unsigned int offset, count;
+	unsigned int trailing_bytes = 0;
+	unsigned long irq_flags = 0;
+	int drq_last = 0;
 
-	if (qc->curbytes + bytes >= qc->nbytes)
+	if (qc->curbytes + bytes >= qc->nbytes) {
+		trailing_bytes = qc->curbytes + bytes - qc->nbytes;
 		ap->hsm_task_state = HSM_ST_LAST;
+	}
 
 next_sg:
 	if (unlikely(qc->cursg >= qc->n_elem)) {
@@ -4593,6 +4666,8 @@ next_sg:
 		unsigned int words = bytes >> 1;
 		unsigned int i;
 
+		WARN_ON(bytes != trailing_bytes);
+
 		if (words) /* warning if bytes > 1 */
 			ata_dev_printk(qc->dev, KERN_WARNING,
 				       "%u bytes trailing data\n", bytes);
@@ -4600,8 +4675,18 @@ next_sg:
 		for (i = 0; i < words; i++)
 			ap->ops->data_xfer(qc->dev, (unsigned char*)pad_buf, 2, do_write);
 
+		WARN_ON(!drq_last);
 		ata_altstatus(ap); /* flush */
 		ap->hsm_task_state = HSM_ST_LAST;
+
+		if (irq_handover) {
+			ap->pflags &= ~ATA_PFLAG_HSM_WQ;
+			spin_unlock_irqrestore(ap->lock, irq_flags);
+		}
+
+		/* irq handler or another command might
+		 *  be running at this point
+		 */
 		return;
 	}
 
@@ -4622,9 +4707,28 @@ next_sg:
 
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
+	/* check if last transfer of real data */
+	if (bytes - count <= trailing_bytes)
+		drq_last = 1;
+
+	/* odd transfer only permitted at last */
+	WARN_ON((count & 1) && !(ap->hsm_task_state == HSM_ST_LAST &&
+				 drq_last));
+
 	if (PageHighMem(page)) {
 		unsigned long flags;
 
+		if (irq_handover && drq_last)
+			/* Data transfer will trigger INTRQ.
+			 * Acquire ap->lock to 
+			 *  - transfer the last bytes of data
+			 *  - transfer the trailing data, if any
+			 *  - read and discard altstatus 
+			 *  - clear ATA_PFLAG_HSM_WQ
+			 * atomically.
+			 */
+			spin_lock_irqsave(ap->lock, irq_flags);
+
 		/* FIXME: use bounce buffer */
 		local_irq_save(flags);
 		buf = kmap_atomic(page, KM_IRQ0);
@@ -4635,8 +4739,39 @@ next_sg:
 		kunmap_atomic(buf, KM_IRQ0);
 		local_irq_restore(flags);
 	} else {
+		unsigned int head = 0, tail = count;
+
 		buf = page_address(page);
-		ap->ops->data_xfer(qc->dev,  buf + offset, count, do_write);
+
+		if (irq_handover && drq_last) {
+			if (count > 20) {
+				tail = 8 + count % 8;
+				head = count - tail;
+
+				/* Data transfer of "head" is done without
+				 * holding ap->lock to improve interrupt
+				 * latency. Hopefully no unsolicited INTRQ
+				 * at this point, otherwise we may have
+				 * nobody cared irq. Make "head" to be 
+				 * multiple of 8 bytes such that
+				 * ->data_xfer() could utilize 32-bit
+				 * pio/mmio.
+				 */
+				ap->ops->data_xfer(qc->dev,  buf + offset, head, do_write);
+			}
+
+			/* Data transfer of "tail" will trigger INTRQ.
+			 * Acquire ap->lock to 
+			 *  - transfer the last 8(~15) bytes of data
+			 *  - transfer the trailing data, if any
+			 *  - read and discard altstatus 
+			 *  - clear ATA_PFLAG_HSM_WQ
+			 * atomically.
+			 */
+			spin_lock_irqsave(ap->lock, irq_flags);
+		}
+
+		ap->ops->data_xfer(qc->dev,  buf + offset + head, tail, do_write);
 	}
 
 	bytes -= count;
@@ -4651,12 +4786,23 @@ next_sg:
 	if (bytes)
 		goto next_sg;
 
+	WARN_ON(!drq_last);
 	ata_altstatus(ap); /* flush */
+
+	if (irq_handover) {
+		ap->pflags &= ~ATA_PFLAG_HSM_WQ;
+		spin_unlock_irqrestore(ap->lock, irq_flags);
+	}
+
+	/* irq handler or another command might
+	 *  be running at this point
+	 */
 }
 
 /**
  *	atapi_pio_bytes - Transfer data from/to the ATAPI device.
  *	@qc: Command on going
+ *	@irq_handover: workqueue is going to handover to the irq handler
  *
  *	Transfer Transfer data from/to the ATAPI device.
  *
@@ -4664,7 +4810,7 @@ next_sg:
  *	Inherited from caller.
  */
 
-static void atapi_pio_bytes(struct ata_queued_cmd *qc)
+static void atapi_pio_bytes(struct ata_queued_cmd *qc, int irq_handover)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *dev = qc->dev;
@@ -4694,8 +4840,11 @@ static void atapi_pio_bytes(struct ata_q
 
 	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
 
-	__atapi_pio_bytes(qc, bytes);
+	__atapi_pio_bytes(qc, bytes, irq_handover);
 
+	/* irq handler or another command might
+	 *  be running at this point
+	 */
 	return;
 
 err_out:
@@ -4796,7 +4945,6 @@ static void ata_hsm_qc_complete(struct a
 int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 		 u8 status, int in_wq)
 {
-	unsigned long flags = 0;
 	int poll_next;
 
 	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
@@ -4856,9 +5004,6 @@ fsm_start:
 		 * be invoked before the data transfer is complete and
 		 * hsm_task_state is changed. Hence, the following locking.
 		 */
-		if (in_wq)
-			spin_lock_irqsave(ap->lock, flags);
-
 		if (qc->tf.protocol == ATA_PROT_PIO) {
 			/* PIO data out protocol.
 			 * send first data block.
@@ -4869,13 +5014,10 @@ fsm_start:
 			 * before ata_pio_sectors().
 			 */
 			ap->hsm_task_state = HSM_ST;
-			ata_pio_sectors(qc);
+			ata_pio_sectors(qc, in_wq);
 		} else
 			/* send CDB */
-			atapi_send_cdb(ap, qc);
-
-		if (in_wq)
-			spin_unlock_irqrestore(ap->lock, flags);
+			atapi_send_cdb(ap, qc, in_wq);
 
 		/* if polling, ata_pio_task() handles the rest.
 		 * otherwise, interrupt handler takes over from here.
@@ -4909,7 +5051,11 @@ fsm_start:
 				goto fsm_start;
 			}
 
-			atapi_pio_bytes(qc);
+			atapi_pio_bytes(qc, in_wq);
+
+			/* irq handler or another command might
+			 *  be running at this point
+			 */
 
 			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
 				/* bad ireason reported by device */
@@ -4949,7 +5095,10 @@ fsm_start:
 				qc->err_mask |= AC_ERR_DEV;
 
 				if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
-					ata_pio_sectors(qc);
+					/* set irq_handover = 0 since
+					 * irq is not expected here
+					 */
+					ata_pio_sectors(qc, 0);
 					status = ata_wait_idle(ap);
 				}
 
@@ -4964,7 +5113,11 @@ fsm_start:
 				goto fsm_start;
 			}
 
-			ata_pio_sectors(qc);
+			ata_pio_sectors(qc, in_wq);
+
+			/* irq handler or another command might
+			 *  be running at this point
+			 */
 
 			if (ap->hsm_task_state == HSM_ST_IDLE) {
 				/* all data read */
@@ -5026,6 +5179,7 @@ static void ata_pio_task(struct work_str
 	struct ata_queued_cmd *qc = ap->port_task_data;
 	u8 status;
 	int poll_next;
+	unsigned long irq_flags;
 
 fsm_start:
 	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
@@ -5047,6 +5201,11 @@ fsm_start:
 		}
 	}
 
+	/* Let the irq handler know wq is accessing the port */
+	spin_lock_irqsave(ap->lock, irq_flags);
+	ap->pflags |= ATA_PFLAG_HSM_WQ;
+	spin_unlock_irqrestore(ap->lock, irq_flags);
+
 	/* move the HSM */
 	poll_next = ata_hsm_move(ap, qc, status, 1);
 
@@ -5160,6 +5319,7 @@ void __ata_qc_complete(struct ata_queued
 	 */
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 	ap->qc_active &= ~(1 << qc->tag);
+	ap->pflags &= ~ATA_PFLAG_HSM_WQ;
 
 	/* call completion callback */
 	qc->complete_fn(qc);
@@ -5530,6 +5690,10 @@ inline unsigned int ata_host_intr (struc
 	VPRINTK("ata%u: protocol %d task_state %d\n",
 		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
 
+	/* HSM accessing the port from the workqueue */
+	if (ap->pflags & ATA_PFLAG_HSM_WQ)
+		goto idle_irq;
+
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
diff -Nrup 03_read_state/drivers/ata/sata_sil.c 04_move_narrow_lock/drivers/ata/sata_sil.c
--- 03_read_state/drivers/ata/sata_sil.c	2007-05-14 12:18:45.000000000 +0800
+++ 04_move_narrow_lock/drivers/ata/sata_sil.c	2007-05-15 12:33:37.000000000 +0800
@@ -396,6 +396,10 @@ static void sil_host_intr(struct ata_por
 	if (unlikely(!qc))
 		goto freeze;
 
+	/* HSM accessing the port from the workqueue */
+	if (ap->pflags & ATA_PFLAG_HSM_WQ)
+		return;
+
 	if (unlikely(qc->tf.flags & ATA_TFLAG_POLLING)) {
 		/* this sometimes happens, just clear IRQ */
 		ata_chk_status(ap);
diff -Nrup 03_read_state/include/linux/libata.h 04_move_narrow_lock/include/linux/libata.h
--- 03_read_state/include/linux/libata.h	2007-05-14 12:19:04.000000000 +0800
+++ 04_move_narrow_lock/include/linux/libata.h	2007-05-14 14:45:28.000000000 +0800
@@ -195,6 +195,7 @@ enum {
 	ATA_PFLAG_FLUSH_PORT_TASK = (1 << 16), /* flush port task */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
+	ATA_PFLAG_HSM_WQ	= (1 << 19), /* hsm accessing the port in wq */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */


