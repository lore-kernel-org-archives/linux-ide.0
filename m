From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: merge irq-pio
Date: Thu, 11 May 2006 22:33:24 +0900
Message-ID: <11473544042174-git-send-email-htejun@gmail.com>
References: <11473544041507-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.196]:63839 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751774AbWEKNdb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:33:31 -0400
Received: by wx-out-0102.google.com with SMTP id t5so3660wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:33:30 -0700 (PDT)
In-Reply-To: <11473544041507-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Merge irq-pio.

---

 drivers/scsi/libata-core.c  |  803 +++++++++++++++++++++++++++-----------------
 drivers/scsi/libata-eh.c    |    2 
 drivers/scsi/pdc_adma.c     |    8 
 drivers/scsi/sata_mv.c      |    6 
 drivers/scsi/sata_nv.c      |    4 
 drivers/scsi/sata_promise.c |    7 
 drivers/scsi/sata_qstor.c   |   11 
 drivers/scsi/sata_sx4.c     |    6 
 drivers/scsi/sata_vsc.c     |   15 
 include/linux/ata.h         |   12 
 include/linux/libata.h      |   24 -
 11 files changed, 550 insertions(+), 348 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f50fea6..b230856 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1345,11 +1345,19 @@ static int ata_dev_configure(struct ata_
 					dev->cylinders, dev->heads, dev->sectors);
 		}
 
+		if (dev->id[59] & 0x100) {
+			dev->multi_count = dev->id[59] & 0xff;
+			DPRINTK("ata%u: dev %u multi count %u\n",
+				ap->id, dev->devno, dev->multi_count);
+		}
+
 		dev->cdb_len = 16;
 	}
 
 	/* ATAPI-specific feature tests */
 	else if (dev->class == ATA_DEV_ATAPI) {
+		char *cdb_intr_string = "";
+
 		rc = atapi_cdb_len(id);
 		if ((rc < 12) || (rc > ATAPI_CDB_LEN)) {
 			ata_dev_printk(dev, KERN_WARNING,
@@ -1359,10 +1367,16 @@ static int ata_dev_configure(struct ata_
 		}
 		dev->cdb_len = (unsigned int) rc;
 
+		if (ata_id_cdb_intr(dev->id)) {
+			dev->flags |= ATA_DFLAG_CDB_INTR;
+			cdb_intr_string = ", CDB intr";
+		}
+
 		/* print device info to dmesg */
 		if (print_info)
-			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s\n",
-				       ata_mode_string(xfer_mask));
+			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s%s\n",
+				       ata_mode_string(xfer_mask),
+				       cdb_intr_string);
 	}
 
 	ap->host->max_cmd_len = 0;
@@ -3210,6 +3224,15 @@ int ata_check_atapi_dma(struct ata_queue
 	if (ap->ops->check_atapi_dma)
 		rc = ap->ops->check_atapi_dma(qc);
 
+	/* We don't support polling DMA.
+	 * Use PIO if the LLDD handles only interrupts in
+	 * the HSM_ST_LAST state and the ATAPI device
+	 * generates CDB interrupts.
+	 */
+	if ((ap->flags & ATA_FLAG_PIO_POLLING) &&
+	    (qc->dev->flags & ATA_DFLAG_CDB_INTR))
+		rc = 1;
+
 	return rc;
 }
 /**
@@ -3457,7 +3480,6 @@ void ata_poll_qc_complete(struct ata_que
 		qc = ata_qc_from_tag(ap, qc->tag);
 		if (qc) {
 			if (!(qc->err_mask & AC_ERR_HSM)) {
-				ap->flags &= ~ATA_FLAG_NOINTR;
 				ata_irq_on(ap);
 				ata_qc_complete(qc);
 			} else
@@ -3465,7 +3487,6 @@ void ata_poll_qc_complete(struct ata_que
 		}
 	} else {
 		/* old EH */
-		ap->flags &= ~ATA_FLAG_NOINTR;
 		ata_irq_on(ap);
 		ata_qc_complete(qc);
 	}
@@ -3474,105 +3495,6 @@ void ata_poll_qc_complete(struct ata_que
 }
 
 /**
- *	ata_pio_poll - poll using PIO, depending on current state
- *	@qc: qc in progress
- *
- *	LOCKING:
- *	None.  (executing in kernel thread context)
- *
- *	RETURNS:
- *	timeout value to use
- */
-static unsigned long ata_pio_poll(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	u8 status;
-	unsigned int poll_state = HSM_ST_UNKNOWN;
-	unsigned int reg_state = HSM_ST_UNKNOWN;
-
-	switch (ap->hsm_task_state) {
-	case HSM_ST:
-	case HSM_ST_POLL:
-		poll_state = HSM_ST_POLL;
-		reg_state = HSM_ST;
-		break;
-	case HSM_ST_LAST:
-	case HSM_ST_LAST_POLL:
-		poll_state = HSM_ST_LAST_POLL;
-		reg_state = HSM_ST_LAST;
-		break;
-	default:
-		BUG();
-		break;
-	}
-
-	status = ata_chk_status(ap);
-	if (status & ATA_BUSY) {
-		if (time_after(jiffies, ap->pio_task_timeout)) {
-			qc->err_mask |= AC_ERR_TIMEOUT;
-			ap->hsm_task_state = HSM_ST_TMOUT;
-			return 0;
-		}
-		ap->hsm_task_state = poll_state;
-		return ATA_SHORT_PAUSE;
-	}
-
-	ap->hsm_task_state = reg_state;
-	return 0;
-}
-
-/**
- *	ata_pio_complete - check if drive is busy or idle
- *	@qc: qc to complete
- *
- *	LOCKING:
- *	None.  (executing in kernel thread context)
- *
- *	RETURNS:
- *	Non-zero if qc completed, zero otherwise.
- */
-static int ata_pio_complete(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	u8 drv_stat;
-
-	/*
-	 * This is purely heuristic.  This is a fast path.  Sometimes when
-	 * we enter, BSY will be cleared in a chk-status or two.  If not,
-	 * the drive is probably seeking or something.  Snooze for a couple
-	 * msecs, then chk-status again.  If still busy, fall back to
-	 * HSM_ST_POLL state.
-	 */
-	drv_stat = ata_busy_wait(ap, ATA_BUSY, 10);
-	if (drv_stat & ATA_BUSY) {
-		msleep(2);
-		drv_stat = ata_busy_wait(ap, ATA_BUSY, 10);
-		if (drv_stat & ATA_BUSY) {
-			ap->hsm_task_state = HSM_ST_LAST_POLL;
-			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
-			return 0;
-		}
-	}
-
-	drv_stat = ata_wait_idle(ap);
-	if (!ata_ok(drv_stat)) {
-		qc->err_mask |= __ac_err_mask(drv_stat);
-		ap->hsm_task_state = HSM_ST_ERR;
-		return 0;
-	}
-
-	ap->hsm_task_state = HSM_ST_IDLE;
-
-	WARN_ON(qc->err_mask);
-	ata_poll_qc_complete(qc);
-
-	/* another command may start at this point */
-
-	return 1;
-}
-
-
-/**
  *	swap_buf_le16 - swap halves of 16-bit words in place
  *	@buf:  Buffer to swap
  *	@buf_words:  Number of 16-bit words in buffer.
@@ -3740,7 +3662,23 @@ static void ata_pio_sector(struct ata_qu
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	buf = kmap(page) + offset;
+	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+
+	if (PageHighMem(page)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		buf = kmap_atomic(page, KM_IRQ0);
+
+		/* do the actual data transfer */
+		ata_data_xfer(ap, buf + offset, ATA_SECT_SIZE, do_write);
+
+		kunmap_atomic(buf, KM_IRQ0);
+		local_irq_restore(flags);
+	} else {
+		buf = page_address(page);
+		ata_data_xfer(ap, buf + offset, ATA_SECT_SIZE, do_write);
+	}
 
 	qc->cursect++;
 	qc->cursg_ofs++;
@@ -3749,14 +3687,68 @@ static void ata_pio_sector(struct ata_qu
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
+}
 
-	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+/**
+ *	ata_pio_sectors - Transfer one or many 512-byte sectors.
+ *	@qc: Command on going
+ *
+ *	Transfer one or many ATA_SECT_SIZE of data from/to the 
+ *	ATA device for the DRQ request.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
 
-	/* do the actual data transfer */
-	do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
-	ata_data_xfer(ap, buf, ATA_SECT_SIZE, do_write);
+static void ata_pio_sectors(struct ata_queued_cmd *qc)
+{
+	if (is_multi_taskfile(&qc->tf)) {
+		/* READ/WRITE MULTIPLE */
+		unsigned int nsect;
+
+		WARN_ON(qc->dev->multi_count == 0);
 
-	kunmap(page);
+		nsect = min(qc->nsect - qc->cursect, qc->dev->multi_count);
+		while (nsect--)
+			ata_pio_sector(qc);
+	} else
+		ata_pio_sector(qc);
+}
+
+/**
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
+	WARN_ON(qc->dev->cdb_len < 12);
+
+	ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
+	ata_altstatus(ap); /* flush */
+
+	switch (qc->tf.protocol) {
+	case ATA_PROT_ATAPI:
+		ap->hsm_task_state = HSM_ST;
+		break;
+	case ATA_PROT_ATAPI_NODATA:
+		ap->hsm_task_state = HSM_ST_LAST;
+		break;
+	case ATA_PROT_ATAPI_DMA:
+		ap->hsm_task_state = HSM_ST_LAST;
+		/* initiate bmdma */
+		ap->ops->bmdma_start(qc);
+		break;
+	}
 }
 
 /**
@@ -3822,7 +3814,23 @@ next_sg:
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
 
-	buf = kmap(page) + offset;
+	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
+
+	if (PageHighMem(page)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		buf = kmap_atomic(page, KM_IRQ0);
+
+		/* do the actual data transfer */
+		ata_data_xfer(ap, buf + offset, count, do_write);
+
+		kunmap_atomic(buf, KM_IRQ0);
+		local_irq_restore(flags);
+	} else {
+		buf = page_address(page);
+		ata_data_xfer(ap, buf + offset, count, do_write);
+	}
 
 	bytes -= count;
 	qc->curbytes += count;
@@ -3833,13 +3841,6 @@ next_sg:
 		qc->cursg_ofs = 0;
 	}
 
-	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
-
-	/* do the actual data transfer */
-	ata_data_xfer(ap, buf, count, do_write);
-
-	kunmap(page);
-
 	if (bytes)
 		goto next_sg;
 }
@@ -3876,6 +3877,8 @@ static void atapi_pio_bytes(struct ata_q
 	if (do_write != i_write)
 		goto err_out;
 
+	VPRINTK("ata%u: xfering %d bytes\n", ap->id, bytes);
+
 	__atapi_pio_bytes(qc, bytes);
 
 	return;
@@ -3887,186 +3890,294 @@ err_out:
 }
 
 /**
- *	ata_pio_block - start PIO on a block
- *	@qc: qc to transfer block for
+ *	ata_hsm_ok_in_wq - Check if the qc can be handled in the workqueue.
+ *	@ap: the target ata_port
+ *	@qc: qc on going
  *
- *	LOCKING:
- *	None.  (executing in kernel thread context)
+ *	RETURNS:
+ *	1 if ok in workqueue, 0 otherwise.
  */
-static void ata_pio_block(struct ata_queued_cmd *qc)
+
+static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap = qc->ap;
-	u8 status;
+	if (qc->tf.flags & ATA_TFLAG_POLLING)
+		return 1;
 
-	/*
-	 * This is purely heuristic.  This is a fast path.
-	 * Sometimes when we enter, BSY will be cleared in
-	 * a chk-status or two.  If not, the drive is probably seeking
-	 * or something.  Snooze for a couple msecs, then
-	 * chk-status again.  If still busy, fall back to
-	 * HSM_ST_POLL state.
-	 */
-	status = ata_busy_wait(ap, ATA_BUSY, 5);
-	if (status & ATA_BUSY) {
-		msleep(2);
-		status = ata_busy_wait(ap, ATA_BUSY, 10);
-		if (status & ATA_BUSY) {
-			ap->hsm_task_state = HSM_ST_POLL;
-			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
-			return;
-		}
-	}
+	if (ap->hsm_task_state == HSM_ST_FIRST) {
+		if (qc->tf.protocol == ATA_PROT_PIO &&
+		    (qc->tf.flags & ATA_TFLAG_WRITE))
+		    return 1;
 
-	/* check error */
-	if (status & (ATA_ERR | ATA_DF)) {
-		qc->err_mask |= AC_ERR_DEV;
-		ap->hsm_task_state = HSM_ST_ERR;
-		return;
+		if (is_atapi_taskfile(&qc->tf) &&
+		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+			return 1;
 	}
 
-	/* transfer data if any */
-	if (is_atapi_taskfile(&qc->tf)) {
-		/* DRQ=0 means no more data to transfer */
-		if ((status & ATA_DRQ) == 0) {
-			ap->hsm_task_state = HSM_ST_LAST;
-			return;
-		}
+	return 0;
+}
 
-		atapi_pio_bytes(qc);
-	} else {
-		/* handle BSY=0, DRQ=0 as error */
-		if ((status & ATA_DRQ) == 0) {
+/**
+ *	ata_hsm_move - move the HSM to the next state.
+ *	@ap: the target ata_port
+ *	@qc: qc on going
+ *	@status: current device status
+ *	@in_wq: 1 if called from workqueue, 0 otherwise
+ *
+ *	RETURNS:
+ *	1 when poll next status needed, 0 otherwise.
+ */
+
+static int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
+			 u8 status, int in_wq)
+{
+	unsigned long flags = 0;
+	int poll_next;
+
+	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
+
+	/* Make sure ata_qc_issue_prot() does not throw things
+	 * like DMA polling into the workqueue. Notice that
+	 * in_wq is not equivalent to (qc->tf.flags & ATA_TFLAG_POLLING).
+	 */
+	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
+
+fsm_start:
+	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
+		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
+
+	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
+		/* Send first data block or PACKET CDB */
+
+		/* If polling, we will stay in the work queue after
+		 * sending the data. Otherwise, interrupt handler
+		 * takes over after sending the data.
+		 */
+		poll_next = (qc->tf.flags & ATA_TFLAG_POLLING);
+
+		/* check device status */
+		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
+			/* Wrong status. Let EH handle this */
 			qc->err_mask |= AC_ERR_HSM;
 			ap->hsm_task_state = HSM_ST_ERR;
-			return;
+			goto fsm_start;
 		}
 
-		ata_pio_sector(qc);
-	}
-}
+		/* Device should not ask for data transfer (DRQ=1)
+		 * when it finds something wrong.
+		 * We ignore DRQ here and stop the HSM by
+		 * changing hsm_task_state to HSM_ST_ERR and
+		 * let the EH abort the command or reset the device.
+		 */
+		if (unlikely(status & (ATA_ERR | ATA_DF))) {
+			printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
+			       ap->id, status);
+			qc->err_mask |= AC_ERR_DEV;
+			ap->hsm_task_state = HSM_ST_ERR;
+			goto fsm_start;
+		}
 
-static void ata_pio_error(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
+		/* Send the CDB (atapi) or the first data block (ata pio out).
+		 * During the state transition, interrupt handler shouldn't
+		 * be invoked before the data transfer is complete and
+		 * hsm_task_state is changed. Hence, the following locking.
+		 */
+		if (in_wq)
+			spin_lock_irqsave(&ap->host_set->lock, flags);
 
-	if (qc->tf.command != ATA_CMD_PACKET)
-		ata_dev_printk(qc->dev, KERN_WARNING, "PIO error\n");
+		if (qc->tf.protocol == ATA_PROT_PIO) {
+			/* PIO data out protocol.
+			 * send first data block.
+			 */
 
-	/* make sure qc->err_mask is available to
-	 * know what's wrong and recover
-	 */
-	WARN_ON(qc->err_mask == 0);
+			/* ata_pio_sectors() might change the state
+			 * to HSM_ST_LAST. so, the state is changed here
+			 * before ata_pio_sectors().
+			 */
+			ap->hsm_task_state = HSM_ST;
+			ata_pio_sectors(qc);
+			ata_altstatus(ap); /* flush */
+		} else
+			/* send CDB */
+			atapi_send_cdb(ap, qc);
 
-	ap->hsm_task_state = HSM_ST_IDLE;
+		if (in_wq)
+			spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
-	ata_poll_qc_complete(qc);
-}
+		/* if polling, ata_pio_task() handles the rest.
+		 * otherwise, interrupt handler takes over from here.
+		 */
+		break;
 
-static void ata_pio_task(void *_data)
-{
-	struct ata_queued_cmd *qc = _data;
-	struct ata_port *ap = qc->ap;
-	unsigned long timeout;
-	int qc_completed;
+	case HSM_ST:
+		/* complete command or read/write the data register */
+		if (qc->tf.protocol == ATA_PROT_ATAPI) {
+			/* ATAPI PIO protocol */
+			if ((status & ATA_DRQ) == 0) {
+				/* no more data to transfer */
+				ap->hsm_task_state = HSM_ST_LAST;
+				goto fsm_start;
+			}
 
-fsm_start:
-	timeout = 0;
-	qc_completed = 0;
+			/* Device should not ask for data transfer (DRQ=1)
+			 * when it finds something wrong.
+			 * We ignore DRQ here and stop the HSM by
+			 * changing hsm_task_state to HSM_ST_ERR and
+			 * let the EH abort the command or reset the device.
+			 */
+			if (unlikely(status & (ATA_ERR | ATA_DF))) {
+				printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
+				       ap->id, status);
+				qc->err_mask |= AC_ERR_DEV;
+				ap->hsm_task_state = HSM_ST_ERR;
+				goto fsm_start;
+			}
 
-	switch (ap->hsm_task_state) {
-	case HSM_ST_IDLE:
-		return;
+			atapi_pio_bytes(qc);
 
-	case HSM_ST:
-		ata_pio_block(qc);
+			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
+				/* bad ireason reported by device */
+				goto fsm_start;
+
+		} else {
+			/* ATA PIO protocol */
+			if (unlikely((status & ATA_DRQ) == 0)) {
+				/* handle BSY=0, DRQ=0 as error */
+				qc->err_mask |= AC_ERR_HSM;
+				ap->hsm_task_state = HSM_ST_ERR;
+				goto fsm_start;
+			}
+
+			/* For PIO reads, some devices may ask for
+			 * data transfer (DRQ=1) alone with ERR=1.
+			 * We respect DRQ here and transfer one
+			 * block of junk data before changing the
+			 * hsm_task_state to HSM_ST_ERR.
+			 *
+			 * For PIO writes, ERR=1 DRQ=1 doesn't make
+			 * sense since the data block has been
+			 * transferred to the device.
+			 */
+			if (unlikely(status & (ATA_ERR | ATA_DF))) {
+				/* data might be corrputed */
+				qc->err_mask |= AC_ERR_DEV;
+
+				if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
+					ata_pio_sectors(qc);
+					ata_altstatus(ap);
+					status = ata_wait_idle(ap);
+				}
+
+				/* ata_pio_sectors() might change the
+				 * state to HSM_ST_LAST. so, the state
+				 * is changed after ata_pio_sectors().
+				 */
+				ap->hsm_task_state = HSM_ST_ERR;
+				goto fsm_start;
+			}
+
+			ata_pio_sectors(qc);
+
+			if (ap->hsm_task_state == HSM_ST_LAST &&
+			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
+				/* all data read */
+				ata_altstatus(ap);
+				status = ata_wait_idle(ap);
+				goto fsm_start;
+			}
+		}
+
+		ata_altstatus(ap); /* flush */
+		poll_next = 1;
 		break;
 
 	case HSM_ST_LAST:
-		qc_completed = ata_pio_complete(qc);
-		break;
+		if (unlikely(!ata_ok(status))) {
+			qc->err_mask |= __ac_err_mask(status);
+			ap->hsm_task_state = HSM_ST_ERR;
+			goto fsm_start;
+		}
+
+		/* no more data to transfer */
+		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
+			ap->id, qc->dev->devno, status);
 
-	case HSM_ST_POLL:
-	case HSM_ST_LAST_POLL:
-		timeout = ata_pio_poll(qc);
+		WARN_ON(qc->err_mask);
+
+		ap->hsm_task_state = HSM_ST_IDLE;
+
+		/* complete taskfile transaction */
+		if (in_wq)
+			ata_poll_qc_complete(qc);
+		else
+			ata_qc_complete(qc);
+
+		poll_next = 0;
 		break;
 
-	case HSM_ST_TMOUT:
 	case HSM_ST_ERR:
-		ata_pio_error(qc);
-		return;
+		if (qc->tf.command != ATA_CMD_PACKET)
+			printk(KERN_ERR "ata%u: dev %u command error, drv_stat 0x%x\n",
+			       ap->id, qc->dev->devno, status);
+
+		/* make sure qc->err_mask is available to
+		 * know what's wrong and recover
+		 */
+		WARN_ON(qc->err_mask == 0);
+
+		ap->hsm_task_state = HSM_ST_IDLE;
+
+		/* complete taskfile transaction */
+		if (in_wq)
+			ata_poll_qc_complete(qc);
+		else
+			ata_qc_complete(qc);
+
+		poll_next = 0;
+		break;
+	default:
+		poll_next = 0;
+		BUG();
 	}
 
-	if (timeout)
-		ata_port_queue_task(ap, ata_pio_task, qc, timeout);
-	else if (!qc_completed)
-		goto fsm_start;
+	return poll_next;
 }
 
-/**
- *	atapi_packet_task - Write CDB bytes to hardware
- *	@_data: qc in progress
- *
- *	When device has indicated its readiness to accept
- *	a CDB, this function is called.  Send the CDB.
- *	If DMA is to be performed, exit immediately.
- *	Otherwise, we are in polling mode, so poll
- *	status under operation succeeds or fails.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- */
-static void atapi_packet_task(void *_data)
+static void ata_pio_task(void *_data)
 {
 	struct ata_queued_cmd *qc = _data;
 	struct ata_port *ap = qc->ap;
 	u8 status;
+	int poll_next;
 
-	/* sleep-wait for BSY to clear */
-	DPRINTK("busy wait\n");
-	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB)) {
-		qc->err_mask |= AC_ERR_TIMEOUT;
-		goto err_out;
-	}
-
-	/* make sure DRQ is set */
-	status = ata_chk_status(ap);
-	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
-		qc->err_mask |= AC_ERR_HSM;
-		goto err_out;
-	}
-
-	/* send SCSI cdb */
-	DPRINTK("send cdb\n");
-	WARN_ON(qc->dev->cdb_len < 12);
-
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
-		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
-		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
-			ap->ops->bmdma_start(qc);	/* initiate bmdma */
-		spin_unlock_irqrestore(&ap->host_set->lock, flags);
-	} else {
-		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
+fsm_start:
+	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
 
-		/* PIO commands are handled by polling */
-		ap->hsm_task_state = HSM_ST;
-		ata_port_queue_task(ap, ata_pio_task, qc, 0);
+	/*
+	 * This is purely heuristic.  This is a fast path.
+	 * Sometimes when we enter, BSY will be cleared in
+	 * a chk-status or two.  If not, the drive is probably seeking
+	 * or something.  Snooze for a couple msecs, then
+	 * chk-status again.  If still busy, queue delayed work.
+	 */
+	status = ata_busy_wait(ap, ATA_BUSY, 5);
+	if (status & ATA_BUSY) {
+		msleep(2);
+		status = ata_busy_wait(ap, ATA_BUSY, 10);
+		if (status & ATA_BUSY) {
+			ata_port_queue_task(ap, ata_pio_task, qc, ATA_SHORT_PAUSE);
+			return;
+		}
 	}
 
-	return;
+	/* move the HSM */
+	poll_next = ata_hsm_move(ap, qc, status, 1);
 
-err_out:
-	ata_poll_qc_complete(qc);
+	/* another command or interrupt handler
+	 * may be running at this point.
+	 */
+	if (poll_next)
+		goto fsm_start;
 }
 
 /**
@@ -4321,43 +4432,105 @@ unsigned int ata_qc_issue_prot(struct at
 {
 	struct ata_port *ap = qc->ap;
 
+	/* Use polling pio if the LLD doesn't handle
+	 * interrupt driven pio and atapi CDB interrupt.
+	 */
+	if (ap->flags & ATA_FLAG_PIO_POLLING) {
+		switch (qc->tf.protocol) {
+		case ATA_PROT_PIO:
+		case ATA_PROT_ATAPI:
+		case ATA_PROT_ATAPI_NODATA:
+			qc->tf.flags |= ATA_TFLAG_POLLING;
+			break;
+		case ATA_PROT_ATAPI_DMA:
+			if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
+				/* see ata_check_atapi_dma() */
+				BUG();
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* select the device */
 	ata_dev_select(ap, qc->dev->devno, 1, 0);
 
+	/* start the command */
 	switch (qc->tf.protocol) {
 	case ATA_PROT_NODATA:
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
 		ata_tf_to_host(ap, &qc->tf);
+		ap->hsm_task_state = HSM_ST_LAST;
+
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_port_queue_task(ap, ata_pio_task, qc, 0);
+
 		break;
 
 	case ATA_PROT_DMA:
+		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
+
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
+		ap->hsm_task_state = HSM_ST_LAST;
 		break;
 
-	case ATA_PROT_PIO: /* load tf registers, initiate polling pio */
-		ata_qc_set_polling(qc);
-		ata_tf_to_host(ap, &qc->tf);
-		ap->hsm_task_state = HSM_ST;
-		ata_port_queue_task(ap, ata_pio_task, qc, 0);
-		break;
+	case ATA_PROT_PIO:
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
 
-	case ATA_PROT_ATAPI:
-		ata_qc_set_polling(qc);
 		ata_tf_to_host(ap, &qc->tf);
-		ata_port_queue_task(ap, atapi_packet_task, qc, 0);
+
+		if (qc->tf.flags & ATA_TFLAG_WRITE) {
+			/* PIO data out protocol */
+			ap->hsm_task_state = HSM_ST_FIRST;
+			ata_port_queue_task(ap, ata_pio_task, qc, 0);
+
+			/* always send first data block using
+			 * the ata_pio_task() codepath.
+			 */
+		} else {
+			/* PIO data in protocol */
+			ap->hsm_task_state = HSM_ST;
+
+			if (qc->tf.flags & ATA_TFLAG_POLLING)
+				ata_port_queue_task(ap, ata_pio_task, qc, 0);
+
+			/* if polling, ata_pio_task() handles the rest.
+			 * otherwise, interrupt handler takes over from here.
+			 */
+		}
+
 		break;
 
+	case ATA_PROT_ATAPI:
 	case ATA_PROT_ATAPI_NODATA:
-		ap->flags |= ATA_FLAG_NOINTR;
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			ata_qc_set_polling(qc);
+
 		ata_tf_to_host(ap, &qc->tf);
-		ata_port_queue_task(ap, atapi_packet_task, qc, 0);
+
+		ap->hsm_task_state = HSM_ST_FIRST;
+
+		/* send cdb by polling if no cdb interrupt */
+		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
+		    (qc->tf.flags & ATA_TFLAG_POLLING))
+			ata_port_queue_task(ap, ata_pio_task, qc, 0);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
-		ap->flags |= ATA_FLAG_NOINTR;
+		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
+
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		ata_port_queue_task(ap, atapi_packet_task, qc, 0);
+		ap->hsm_task_state = HSM_ST_FIRST;
+
+		/* send cdb by polling if no cdb interrupt */
+		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+			ata_port_queue_task(ap, ata_pio_task, qc, 0);
 		break;
 
 	default:
@@ -4387,52 +4560,66 @@ unsigned int ata_qc_issue_prot(struct at
 inline unsigned int ata_host_intr (struct ata_port *ap,
 				   struct ata_queued_cmd *qc)
 {
-	u8 status, host_stat;
-
-	switch (qc->tf.protocol) {
-
-	case ATA_PROT_DMA:
-	case ATA_PROT_ATAPI_DMA:
-	case ATA_PROT_ATAPI:
-		/* check status of DMA engine */
-		host_stat = ap->ops->bmdma_status(ap);
-		VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
+	u8 status, host_stat = 0;
 
-		/* if it's not our irq... */
-		if (!(host_stat & ATA_DMA_INTR))
-			goto idle_irq;
-
-		/* before we do anything else, clear DMA-Start bit */
-		ap->ops->bmdma_stop(qc);
+	VPRINTK("ata%u: protocol %d task_state %d\n",
+		ap->id, qc->tf.protocol, ap->hsm_task_state);
 
-		/* fall through */
-
-	case ATA_PROT_ATAPI_NODATA:
-	case ATA_PROT_NODATA:
-		/* check altstatus */
-		status = ata_altstatus(ap);
-		if (status & ATA_BUSY)
-			goto idle_irq;
+	/* Check whether we are expecting interrupt in this state */
+	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
+		/* Some pre-ATAPI-4 devices assert INTRQ
+		 * at this state when ready to receive CDB.
+		 */
 
-		/* check main status, clearing INTRQ */
-		status = ata_chk_status(ap);
-		if (unlikely(status & ATA_BUSY))
+		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
+		 * The flag was turned on only for atapi devices.
+		 * No need to check is_atapi_taskfile(&qc->tf) again.
+		 */
+		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
 			goto idle_irq;
-		DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
-			ap->id, qc->tf.protocol, status);
-
-		/* ack bmdma irq events */
-		ap->ops->irq_clear(ap);
-
-		/* complete taskfile transaction */
-		qc->err_mask |= ac_err_mask(status);
-		ata_qc_complete(qc);
 		break;
-
+	case HSM_ST_LAST:
+		if (qc->tf.protocol == ATA_PROT_DMA ||
+		    qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
+			/* check status of DMA engine */
+			host_stat = ap->ops->bmdma_status(ap);
+			VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
+
+			/* if it's not our irq... */
+			if (!(host_stat & ATA_DMA_INTR))
+				goto idle_irq;
+
+			/* before we do anything else, clear DMA-Start bit */
+			ap->ops->bmdma_stop(qc);
+
+			if (unlikely(host_stat & ATA_DMA_ERR)) {
+				/* error when transfering data to/from memory */
+				qc->err_mask |= AC_ERR_HOST_BUS;
+				ap->hsm_task_state = HSM_ST_ERR;
+			}
+		}
+		break;
+	case HSM_ST:
+		break;
 	default:
 		goto idle_irq;
 	}
 
+	/* check altstatus */
+	status = ata_altstatus(ap);
+	if (status & ATA_BUSY)
+		goto idle_irq;
+
+	/* check main status, clearing INTRQ */
+	status = ata_chk_status(ap);
+	if (unlikely(status & ATA_BUSY))
+		goto idle_irq;
+
+	/* ack bmdma irq events */
+	ap->ops->irq_clear(ap);
+
+	ata_hsm_move(ap, qc, status, 0);
 	return 1;	/* irq handled */
 
 idle_irq:
@@ -4479,11 +4666,11 @@ irqreturn_t ata_interrupt (int irq, void
 
 		ap = host_set->ports[i];
 		if (ap &&
-		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)) &&
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
 			    (qc->flags & ATA_QCFLAG_ACTIVE))
 				handled |= ata_host_intr(ap, qc);
 		}
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 41b36c5..3b692f5 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -356,7 +356,7 @@ static void ata_qc_timeout(struct ata_qu
 			       qc->tf.command, drv_stat, host_stat);
 
 		/* complete taskfile transaction */
-		qc->err_mask |= ac_err_mask(drv_stat);
+		qc->err_mask |= AC_ERR_TIMEOUT;
 		break;
 	}
 
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index b9a3c56..a341fa8 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -455,13 +455,13 @@ static inline unsigned int adma_intr_pkt
 			continue;
 		handled = 1;
 		adma_enter_reg_mode(ap);
-		if (ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))
+		if (ap->flags & ATA_FLAG_DISABLED)
 			continue;
 		pp = ap->private_data;
 		if (!pp || pp->state != adma_state_pkt)
 			continue;
 		qc = ata_qc_from_tag(ap, ap->active_tag);
-		if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+		if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 			if ((status & (aPERR | aPSD | aUIRQ)))
 				qc->err_mask |= AC_ERR_OTHER;
 			else if (pp->pkt[0] != cDONE)
@@ -480,13 +480,13 @@ static inline unsigned int adma_intr_mmi
 	for (port_no = 0; port_no < host_set->n_ports; ++port_no) {
 		struct ata_port *ap;
 		ap = host_set->ports[port_no];
-		if (ap && (!(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR)))) {
+		if (ap && (!(ap->flags & ATA_FLAG_DISABLED))) {
 			struct ata_queued_cmd *qc;
 			struct adma_port_priv *pp = ap->private_data;
 			if (!pp || pp->state != adma_state_mmio)
 				continue;
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 
 				/* check main status, clearing INTRQ */
 				u8 status = ata_check_status(ap);
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 5b7fea5..56105a1 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -87,7 +87,7 @@ enum {
 	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
 	MV_COMMON_FLAGS		= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
-				   ATA_FLAG_NO_ATAPI),
+				   ATA_FLAG_PIO_POLLING),
 	MV_6XXX_FLAGS		= MV_FLAG_IRQ_COALESCE,
 
 	CRQB_FLAG_READ		= (1 << 0),
@@ -1396,7 +1396,7 @@ static void mv_host_intr(struct ata_host
 			}
 		}
 
-		if (ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))
+		if (ap && (ap->flags & ATA_FLAG_DISABLED))
 			continue;
 
 		err_mask = ac_err_mask(ata_status);
@@ -1417,7 +1417,7 @@ static void mv_host_intr(struct ata_host
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
 				/* mark qc status appropriately */
-				if (!(qc->tf.ctl & ATA_NIEN)) {
+				if (!(qc->tf.flags & ATA_TFLAG_POLLING)) {
 					qc->err_mask |= err_mask;
 					ata_qc_complete(qc);
 				}
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 3a70875..70c5108 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -279,11 +279,11 @@ static irqreturn_t nv_interrupt (int irq
 
 		ap = host_set->ports[i];
 		if (ap &&
-		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += ata_host_intr(ap, qc);
 			else
 				// No request pending?  Clear interrupt status
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index e9d61bc..bb00043 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -76,7 +76,8 @@ enum {
 	PDC_RESET		= (1 << 11), /* HDMA reset */
 
 	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
-				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI,
+				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
+				  ATA_FLAG_PIO_POLLING,
 };
 
 
@@ -534,11 +535,11 @@ static irqreturn_t pdc_interrupt (int ir
 		ap = host_set->ports[i];
 		tmp = mask & (1 << (i + 1));
 		if (tmp && ap &&
-		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += pdc_host_intr(ap, qc);
 		}
 	}
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 259c2de..54283e0 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -175,7 +175,7 @@ static const struct ata_port_info qs_por
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SATA_RESET |
 				  //FIXME ATA_FLAG_SRST |
-				  ATA_FLAG_MMIO,
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x7f, /* udma0-6 */
 		.port_ops	= &qs_ata_ops,
@@ -394,14 +394,13 @@ static inline unsigned int qs_intr_pkt(s
 			DPRINTK("SFF=%08x%08x: sCHAN=%u sHST=%d sDST=%02x\n",
 					sff1, sff0, port_no, sHST, sDST);
 			handled = 1;
-			if (ap && !(ap->flags &
-				    (ATA_FLAG_DISABLED|ATA_FLAG_NOINTR))) {
+			if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
 				struct ata_queued_cmd *qc;
 				struct qs_port_priv *pp = ap->private_data;
 				if (!pp || pp->state != qs_state_pkt)
 					continue;
 				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+				if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 					switch (sHST) {
 					case 0: /* successful CPB */
 					case 3: /* device error */
@@ -428,13 +427,13 @@ static inline unsigned int qs_intr_mmio(
 		struct ata_port *ap;
 		ap = host_set->ports[port_no];
 		if (ap &&
-		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 			struct qs_port_priv *pp = ap->private_data;
 			if (!pp || pp->state != qs_state_mmio)
 				continue;
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 
 				/* check main status, clearing INTRQ */
 				u8 status = ata_check_status(ap);
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 96d7b73..70a6954 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -218,7 +218,7 @@ static const struct ata_port_info pdc_po
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  ATA_FLAG_NO_ATAPI,
+				  ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -833,11 +833,11 @@ static irqreturn_t pdc20621_interrupt (i
 		tmp = mask & (1 << i);
 		VPRINTK("seq %u, port_no %u, ap %p, tmp %x\n", i, port_no, ap, tmp);
 		if (tmp && ap &&
-		    !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
+		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled += pdc20621_host_intr(ap, qc, (i > 4),
 							      mmio_base);
 		}
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 9646c39..0372be7 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -221,14 +221,21 @@ static irqreturn_t vsc_sata_interrupt (i
 
 			ap = host_set->ports[i];
 
-			if (ap && !(ap->flags &
-				    (ATA_FLAG_DISABLED|ATA_FLAG_NOINTR))) {
+			if (is_vsc_sata_int_err(i, int_status)) {
+				u32 err_status;
+				printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
+				err_status = ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
+				vsc_sata_scr_write(ap, SCR_ERROR, err_status);
+				handled++;
+			}
+
+			if (ap && !(ap->flags & ATA_FLAG_DISABLED)) {
 				struct ata_queued_cmd *qc;
 
 				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
+				if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 					handled += ata_host_intr(ap, qc);
-				} else if (is_vsc_sata_int_err(i, int_status)) {
+				else if (is_vsc_sata_int_err(i, int_status)) {
 					/*
 					 * On some chips (i.e. Intel 31244), an error
 					 * interrupt will sneak in at initialization
diff --git a/include/linux/ata.h b/include/linux/ata.h
index a7c41f3..1cbeb43 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -212,6 +212,7 @@ enum {
 	ATA_TFLAG_WRITE		= (1 << 3), /* data dir: host->dev==1 (write) */
 	ATA_TFLAG_LBA		= (1 << 4), /* enable LBA */
 	ATA_TFLAG_FUA		= (1 << 5), /* enable FUA */
+	ATA_TFLAG_POLLING	= (1 << 6), /* set nIEN to 1 and use polling */
 };
 
 enum ata_tf_protocols {
@@ -285,6 +286,8 @@ struct ata_taskfile {
 	  ((u64) (id)[(n) + 1] << 16) |	\
 	  ((u64) (id)[(n) + 0]) )
 
+#define ata_id_cdb_intr(id)	(((id)[0] & 0x60) == 0x20)
+
 static inline unsigned int ata_id_major_version(const u16 *id)
 {
 	unsigned int mver;
@@ -324,6 +327,15 @@ static inline int is_atapi_taskfile(cons
 	       (tf->protocol == ATA_PROT_ATAPI_DMA);
 }
 
+static inline int is_multi_taskfile(struct ata_taskfile *tf)
+{
+	return (tf->command == ATA_CMD_READ_MULTI) ||
+	       (tf->command == ATA_CMD_WRITE_MULTI) ||
+	       (tf->command == ATA_CMD_READ_MULTI_EXT) ||
+	       (tf->command == ATA_CMD_WRITE_MULTI_EXT) ||
+	       (tf->command == ATA_CMD_WRITE_MULTI_FUA_EXT);
+}
+
 static inline int ata_ok(u8 status)
 {
 	return ((status & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ | ATA_ERR))
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6ac840f..ed884d6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -124,6 +124,7 @@ enum {
 	/* struct ata_device stuff */
 	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
 	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
+	ATA_DFLAG_CDB_INTR	= (1 << 2), /* device asserts INTRQ when ready for CDB */
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
@@ -149,9 +150,9 @@ enum {
 	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
 	ATA_FLAG_PIO_LBA48	= (1 << 8), /* Host DMA engine is LBA28 only */
 	ATA_FLAG_IRQ_MASK	= (1 << 9), /* Mask IRQ in PIO xfers */
+	ATA_FLAG_PIO_POLLING	= (1 << 10), /* use polling PIO if LLD
+					      * doesn't handle PIO interrupts */
 
-	ATA_FLAG_NOINTR		= (1 << 13), /* FIXME: Remove this once
-					      * proper HSM is in place. */
 	ATA_FLAG_DEBUGMSG	= (1 << 14),
 	ATA_FLAG_FLUSH_PORT_TASK = (1 << 15), /* flush port task */
 
@@ -180,11 +181,8 @@ enum {
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host_set only */
 	
 	/* various lengths of time */
-	ATA_TMOUT_PIO		= 30 * HZ,
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* heuristic */
-	ATA_TMOUT_CDB		= 30 * HZ,
-	ATA_TMOUT_CDB_QUICK	= 5 * HZ,
 	ATA_TMOUT_INTERNAL	= 30 * HZ,
 	ATA_TMOUT_INTERNAL_QUICK = 5 * HZ,
 
@@ -251,14 +249,13 @@ enum {
 };
 
 enum hsm_task_states {
-	HSM_ST_UNKNOWN,
-	HSM_ST_IDLE,
-	HSM_ST_POLL,
-	HSM_ST_TMOUT,
-	HSM_ST,
-	HSM_ST_LAST,
-	HSM_ST_LAST_POLL,
-	HSM_ST_ERR,
+	HSM_ST_UNKNOWN,		/* state unknown */
+	HSM_ST_IDLE,		/* no command on going */
+	HSM_ST,			/* (waiting the device to) transfer data */
+	HSM_ST_LAST,		/* (waiting the device to) complete command */
+	HSM_ST_ERR,		/* error */
+	HSM_ST_FIRST,		/* (waiting the device to)
+				   write CDB or first data block */
 };
 
 enum ata_completion_errors {
@@ -488,7 +485,6 @@ struct ata_port {
 	struct work_struct	port_task;
 
 	unsigned int		hsm_task_state;
-	unsigned long		pio_task_timeout;
 
 	u32			msg_enable;
 	struct list_head	eh_done_q;

