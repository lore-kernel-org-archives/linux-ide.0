From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 5/7] libata: move and reduce locking to the pio data xfer
 functions
Date: Fri, 11 May 2007 15:35:05 +0800
Message-ID: <46441CA9.4030109@tw.ibm.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com> <4644192A.8090809@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:59230 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998AbXEKHfQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 03:35:16 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l4B7VknG023799
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 03:31:46 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4B7ZCZD136322
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:35:12 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4B7ZBwv007382
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:35:12 -0600
In-Reply-To: <4644192A.8090809@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

patch 5/7: 
- move the locking out from the ata_hsm_move() to the data xfer functions like ata_pio_sectors().
- added the ATA_PFLAG_HSM_WQ (HSM running in workqueue) flag to serialize irq and workqueue.
- the time holding ap->lock is reduced to last piece of pio transfer and clearing the ATA_PFLAG_HSM_WQ flag

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 04_polling_check/drivers/ata/libata-core.c 05_narrow_lock/drivers/ata/libata-core.c
--- 04_polling_check/drivers/ata/libata-core.c	2007-05-11 10:25:09.000000000 +0800
+++ 05_narrow_lock/drivers/ata/libata-core.c	2007-05-11 11:46:41.000000000 +0800
@@ -4031,7 +4031,7 @@ void ata_data_xfer_noirq(struct ata_devi
  *	Inherited from caller.
  */
 
-static void ata_pio_sector(struct ata_queued_cmd *qc, int last)
+static void ata_pio_sector(struct ata_queued_cmd *qc, int last, int lock)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	struct scatterlist *sg = qc->__sg;
@@ -4039,6 +4039,7 @@ static void ata_pio_sector(struct ata_qu
 	struct page *page;
 	unsigned int offset;
 	unsigned char *buf;
+	unsigned long irq_flags = 0;
 
 	if (qc->curbytes == qc->nbytes - ATA_SECT_SIZE)
 		ap->hsm_task_state = do_write ? HSM_ST_LAST : HSM_ST_IDLE;
@@ -4055,6 +4056,9 @@ static void ata_pio_sector(struct ata_qu
 	if (PageHighMem(page)) {
 		unsigned long flags;
 
+		if (lock)
+			spin_lock_irqsave(ap->lock, irq_flags);
+
 		/* FIXME: use a bounce buffer */
 		local_irq_save(flags);
 		buf = kmap_atomic(page, KM_IRQ0);
@@ -4065,8 +4069,18 @@ static void ata_pio_sector(struct ata_qu
 		kunmap_atomic(buf, KM_IRQ0);
 		local_irq_restore(flags);
 	} else {
+		unsigned int head = 0, tail = ATA_SECT_SIZE;
+
 		buf = page_address(page);
-		ap->ops->data_xfer(qc->dev, buf + offset, ATA_SECT_SIZE, do_write);
+
+		if (lock) {
+			tail = 8;
+			head = ATA_SECT_SIZE - tail; /* multiple of 8 bytes */
+			ap->ops->data_xfer(qc->dev, buf + offset, head, do_write);
+			spin_lock_irqsave(ap->lock, irq_flags);
+		}
+
+		ap->ops->data_xfer(qc->dev, buf + offset + head, tail, do_write);
 	}
 
 	if (last)
@@ -4079,6 +4093,11 @@ static void ata_pio_sector(struct ata_qu
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
+
+	if (lock) {
+		ap->pflags &= ~ATA_PFLAG_HSM_WQ;
+		spin_unlock_irqrestore(ap->lock, irq_flags);
+	}
 }
 
 /**
@@ -4092,7 +4111,7 @@ static void ata_pio_sector(struct ata_qu
  *	Inherited from caller.
  */
 
-static void ata_pio_sectors(struct ata_queued_cmd *qc)
+static void ata_pio_sectors(struct ata_queued_cmd *qc, int lock)
 {
 	if (is_multi_taskfile(&qc->tf)) {
 		/* READ/WRITE MULTIPLE */
@@ -4103,9 +4122,9 @@ static void ata_pio_sectors(struct ata_q
 		nsect = min((qc->nbytes - qc->curbytes) / ATA_SECT_SIZE,
 			    qc->dev->multi_count);
 		while (nsect--)
-			ata_pio_sector(qc, !nsect);
+			ata_pio_sector(qc, !nsect, lock && !nsect);
 	} else
-		ata_pio_sector(qc, 1);
+		ata_pio_sector(qc, 1, lock);
 }
 
 /**
@@ -4120,12 +4139,17 @@ static void ata_pio_sectors(struct ata_q
  *	caller.
  */
 
-static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
+static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc, int lock)
 {
+	unsigned long irq_flags = 0;
+
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
 	WARN_ON(qc->dev->cdb_len < 12);
 
+	if (lock)
+		spin_lock_irqsave(ap->lock, irq_flags);
+
 	ap->ops->data_xfer(qc->dev, qc->cdb, qc->dev->cdb_len, 1);
 	ata_altstatus(ap); /* flush */
 
@@ -4142,6 +4166,11 @@ static void atapi_send_cdb(struct ata_po
 		ap->ops->bmdma_start(qc);
 		break;
 	}
+
+	if (lock) {
+		ap->pflags &= ~ATA_PFLAG_HSM_WQ;
+		spin_unlock_irqrestore(ap->lock, irq_flags);
+	}
 }
 
 /**
@@ -4156,7 +4185,7 @@ static void atapi_send_cdb(struct ata_po
  *
  */
 
-static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
+static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes, int lock)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	struct scatterlist *sg = qc->__sg;
@@ -4164,6 +4193,8 @@ static void __atapi_pio_bytes(struct ata
 	struct page *page;
 	unsigned char *buf;
 	unsigned int offset, count;
+	unsigned long irq_flags = 0;
+	int transfer_lock = 0;
 
 	if (qc->curbytes + bytes >= qc->nbytes)
 		ap->hsm_task_state = HSM_ST_LAST;
@@ -4181,6 +4212,10 @@ next_sg:
 		unsigned int words = bytes >> 1;
 		unsigned int i;
 
+		WARN_ON(transfer_lock);
+		if (lock)
+			spin_lock_irqsave(ap->lock, irq_flags);
+
 		if (words) /* warning if bytes > 1 */
 			ata_dev_printk(qc->dev, KERN_WARNING,
 				       "%u bytes trailing data\n", bytes);
@@ -4191,6 +4226,12 @@ next_sg:
 		ata_altstatus(ap); /* flush */
 
 		ap->hsm_task_state = HSM_ST_LAST;
+
+		if (lock) {
+			ap->pflags &= ~ATA_PFLAG_HSM_WQ;
+			spin_unlock_irqrestore(ap->lock, irq_flags);
+		}
+
 		return;
 	}
 
@@ -4210,10 +4251,16 @@ next_sg:
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
 
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+	
+	if (lock && bytes <= count)
+		transfer_lock = 1;
 
 	if (PageHighMem(page)) {
 		unsigned long flags;
 
+		if (transfer_lock)
+			spin_lock_irqsave(ap->lock, irq_flags);
+
 		/* FIXME: use bounce buffer */
 		local_irq_save(flags);
 		buf = kmap_atomic(page, KM_IRQ0);
@@ -4224,8 +4271,21 @@ next_sg:
 		kunmap_atomic(buf, KM_IRQ0);
 		local_irq_restore(flags);
 	} else {
+		unsigned int head = 0, tail = count;
+
 		buf = page_address(page);
-		ap->ops->data_xfer(qc->dev,  buf + offset, count, do_write);
+
+		if (transfer_lock) {
+			if (count > 20) {
+				tail = 8 + count % 8;
+				head = count - tail; /* multiple of 8 bytes */
+				ap->ops->data_xfer(qc->dev,  buf + offset, head, do_write);
+			}
+
+			spin_lock_irqsave(ap->lock, irq_flags);
+		}
+
+		ap->ops->data_xfer(qc->dev,  buf + offset + head, tail, do_write);
 	}
 
 	bytes -= count;
@@ -4241,6 +4301,12 @@ next_sg:
 		goto next_sg;
 
 	ata_altstatus(ap); /* flush */
+
+	if (lock) {
+		WARN_ON(!transfer_lock);
+		ap->pflags &= ~ATA_PFLAG_HSM_WQ;
+		spin_unlock_irqrestore(ap->lock, irq_flags);
+	}
 }
 
 /**
@@ -4253,7 +4319,7 @@ next_sg:
  *	Inherited from caller.
  */
 
-static void atapi_pio_bytes(struct ata_queued_cmd *qc)
+static void atapi_pio_bytes(struct ata_queued_cmd *qc, int lock)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *dev = qc->dev;
@@ -4283,7 +4349,7 @@ static void atapi_pio_bytes(struct ata_q
 
 	VPRINTK("ata%u: xfering %d bytes\n", ap->print_id, bytes);
 
-	__atapi_pio_bytes(qc, bytes);
+	__atapi_pio_bytes(qc, bytes, lock);
 
 	return;
 
@@ -4385,7 +4451,6 @@ static void ata_hsm_qc_complete(struct a
 int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 		 u8 status, int in_wq)
 {
-	unsigned long flags = 0;
 	int poll_next;
 
 	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
@@ -4443,11 +4508,10 @@ fsm_start:
 		/* Send the CDB (atapi) or the first data block (ata pio out).
 		 * During the state transition, interrupt handler shouldn't
 		 * be invoked before the data transfer is complete and
-		 * hsm_task_state is changed. Hence, the following locking.
+		 * hsm_task_state is changed. This is ensured by the
+		 * ATA_PFLAG_HSM_WQ flag and holding ap->lock in the PIO
+		 * data transfer functions.
 		 */
-		if (in_wq)
-			spin_lock_irqsave(ap->lock, flags);
-
 		if (qc->tf.protocol == ATA_PROT_PIO) {
 			/* PIO data out protocol.
 			 * send first data block.
@@ -4458,13 +4522,10 @@ fsm_start:
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
@@ -4498,7 +4559,7 @@ fsm_start:
 				goto fsm_start;
 			}
 
-			atapi_pio_bytes(qc);
+			atapi_pio_bytes(qc, 0);
 
 			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
 				/* bad ireason reported by device */
@@ -4538,7 +4599,7 @@ fsm_start:
 				qc->err_mask |= AC_ERR_DEV;
 
 				if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
-					ata_pio_sectors(qc);
+					ata_pio_sectors(qc, 0);
 					status = ata_wait_idle(ap);
 				}
 
@@ -4553,7 +4614,7 @@ fsm_start:
 				goto fsm_start;
 			}
 
-			ata_pio_sectors(qc);
+			ata_pio_sectors(qc, 0);
 
 			if (ap->hsm_task_state == HSM_ST_IDLE) {
 				/* all data read */
@@ -4615,6 +4676,7 @@ static void ata_pio_task(struct work_str
 	struct ata_queued_cmd *qc = ap->port_task_data;
 	u8 status;
 	int poll_next;
+	unsigned long irq_flags;
 
 fsm_start:
 	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
@@ -4636,6 +4698,11 @@ fsm_start:
 		}
 	}
 
+	/* Let the irq handler know wq is accessing the port */
+	spin_lock_irqsave(ap->lock, irq_flags);
+	ap->pflags |= ATA_PFLAG_HSM_WQ;
+	spin_unlock_irqrestore(ap->lock, irq_flags);
+
 	/* move the HSM */
 	poll_next = ata_hsm_move(ap, qc, status, 1);
 
@@ -4749,6 +4816,7 @@ void __ata_qc_complete(struct ata_queued
 	 */
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 	ap->qc_active &= ~(1 << qc->tag);
+	ap->pflags &= ~ATA_PFLAG_HSM_WQ;
 
 	/* call completion callback */
 	qc->complete_fn(qc);
@@ -5119,6 +5187,10 @@ inline unsigned int ata_host_intr (struc
 	VPRINTK("ata%u: protocol %d task_state %d\n",
 		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
 
+	/* HSM accessing the port from the workqueue */
+	if (ap->pflags & ATA_PFLAG_HSM_WQ)
+		goto idle_irq;
+
 	/* polling */
 	if (qc->tf.flags & ATA_TFLAG_POLLING)
 		goto idle_irq;
diff -Nrup 04_polling_check/include/linux/libata.h 05_narrow_lock/include/linux/libata.h
--- 04_polling_check/include/linux/libata.h	2007-04-28 05:49:26.000000000 +0800
+++ 05_narrow_lock/include/linux/libata.h	2007-05-10 12:12:35.000000000 +0800
@@ -195,6 +195,7 @@ enum {
 	ATA_PFLAG_FLUSH_PORT_TASK = (1 << 16), /* flush port task */
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
+	ATA_PFLAG_HSM_WQ	= (1 << 19), /* hsm accessing the port in wq */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */


