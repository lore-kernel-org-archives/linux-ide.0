From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 5/5] libata-dev: Cleanup unused enums/functions
Date: Thu, 09 Mar 2006 16:56:07 +0800
Message-ID: <440FEDA7.2060703@tw.ibm.com>
References: <440FEA4B.10500@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:56762 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751270AbWCIIz7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Mar 2006 03:55:59 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k298twAZ031804
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 03:55:58 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k298wnR7179474
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 01:58:49 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k298tv6j014400
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 01:55:58 -0700
In-Reply-To: <440FEA4B.10500@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Cleanup unused enums/functions.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Remove the following unused functions:
- ata_pio_poll()
- ata_pio_complete()
- ata_pio_first_block()
- ata_pio_block()
- ata_pio_error()
and other enums.

--- 04_pio_task/include/linux/libata.h	2006-03-09 09:58:18.000000000 +0800
+++ 05_cleanup/include/linux/libata.h	2006-03-09 10:54:40.000000000 +0800
@@ -166,10 +166,6 @@ enum {
 	ATA_TMOUT_PIO		= 30 * HZ,
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* heuristic */
-	ATA_TMOUT_DATAOUT	= 30 * HZ,
-	ATA_TMOUT_DATAOUT_QUICK	= 5 * HZ,
-	ATA_TMOUT_CDB		= 30 * HZ,
-	ATA_TMOUT_CDB_QUICK	= 5 * HZ,
 	ATA_TMOUT_INTERNAL	= 30 * HZ,
 	ATA_TMOUT_INTERNAL_QUICK = 5 * HZ,
 
@@ -209,11 +205,9 @@ enum {
 enum hsm_task_states {
 	HSM_ST_UNKNOWN,		/* state unknown */
 	HSM_ST_IDLE,		/* no command on going */
-	HSM_ST_POLL,		/* same as HSM_ST, waits longer */
 	HSM_ST_TMOUT,		/* timeout */
 	HSM_ST,			/* (waiting the device to) transfer data */
 	HSM_ST_LAST,		/* (waiting the device to) complete command */
-	HSM_ST_LAST_POLL,	/* same as HSM_ST_LAST, waits longer */
 	HSM_ST_ERR,		/* error */
 	HSM_ST_FIRST,		/* (waiting the device to)
 				   write CDB or first data block */
--- 04_pio_task/drivers/scsi/libata-core.c	2006-03-09 15:14:41.000000000 +0800
+++ 05_cleanup/drivers/scsi/libata-core.c	2006-03-09 15:15:17.000000000 +0800
@@ -70,7 +70,6 @@ static int fgb(u32 bitmap);
 static int ata_choose_xfer_mode(const struct ata_port *ap,
 				u8 *xfer_mode_out,
 				unsigned int *xfer_shift_out);
-static void ata_pio_error(struct ata_port *ap);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -2957,114 +2956,6 @@ void ata_poll_qc_complete(struct ata_que
 }
 
 /**
- *	ata_pio_poll - poll using PIO, depending on current state
- *	@ap: the target ata_port
- *
- *	LOCKING:
- *	None.  (executing in kernel thread context)
- *
- *	RETURNS:
- *	timeout value to use
- */
-
-static unsigned long ata_pio_poll(struct ata_port *ap)
-{
-	struct ata_queued_cmd *qc;
-	u8 status;
-	unsigned int poll_state = HSM_ST_UNKNOWN;
-	unsigned int reg_state = HSM_ST_UNKNOWN;
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
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
- *	@ap: the target ata_port
- *
- *	LOCKING:
- *	None.  (executing in kernel thread context)
- *
- *	RETURNS:
- *	Zero if qc completed.
- *	Non-zero if has next.
- */
-
-static int ata_pio_complete (struct ata_port *ap)
-{
-	struct ata_queued_cmd *qc;
-	u8 drv_stat;
-
-	/*
-	 * This is purely heuristic.  This is a fast path.  Sometimes when
-	 * we enter, BSY will be cleared in a chk-status or two.  If not,
-	 * the drive is probably seeking or something.  Snooze for a couple
-	 * msecs, then chk-status again.  If still busy, fall back to
-	 * HSM_ST_LAST_POLL state.
-	 */
-	drv_stat = ata_busy_wait(ap, ATA_BUSY, 10);
-	if (drv_stat & ATA_BUSY) {
-		msleep(2);
-		drv_stat = ata_busy_wait(ap, ATA_BUSY, 10);
-		if (drv_stat & ATA_BUSY) {
-			ap->hsm_task_state = HSM_ST_LAST_POLL;
-			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
-			return 1;
-		}
-	}
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
-
-	drv_stat = ata_wait_idle(ap);
-	if (!ata_ok(drv_stat)) {
-		qc->err_mask |= __ac_err_mask(drv_stat);
-		ap->hsm_task_state = HSM_ST_ERR;
-		return 1;
-	}
-
-	ap->hsm_task_state = HSM_ST_IDLE;
-
-	WARN_ON(qc->err_mask);
-	ata_poll_qc_complete(qc);
-
-	/* another command may start at this point */
-
-	return 0;
-}
-
-
-/**
  *	swap_buf_le16 - swap halves of 16-bit words in place
  *	@buf:  Buffer to swap
  *	@buf_words:  Number of 16-bit words in buffer.
@@ -3322,91 +3213,6 @@ static void atapi_send_cdb(struct ata_po
 }
 
 /**
- *	ata_pio_first_block - Write first data block to hardware
- *	@ap: Port to which ATA/ATAPI device is attached.
- *
- *	When device has indicated its readiness to accept
- *	the data, this function sends out the CDB or 
- *	the first data block by PIO.
- *	After this, 
- *	  - If polling, ata_pio_task() handles the rest.
- *	  - Otherwise, interrupt handler takes over.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	Zero if irq handler takes over
- *	Non-zero if has next (polling).
- */
-
-static int ata_pio_first_block(struct ata_port *ap)
-{
-	struct ata_queued_cmd *qc;
-	u8 status;
-	unsigned long flags;
-	int has_next;
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
-	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
-
-	/* if polling, we will stay in the work queue after sending the data.
-	 * otherwise, interrupt handler takes over after sending the data.
-	 */
-	has_next = (qc->tf.flags & ATA_TFLAG_POLLING);
-
-	/* sleep-wait for BSY to clear */
-	DPRINTK("busy wait\n");
-	if (ata_busy_sleep(ap, ATA_TMOUT_DATAOUT_QUICK, ATA_TMOUT_DATAOUT)) {
-		qc->err_mask |= AC_ERR_TIMEOUT;
-		ap->hsm_task_state = HSM_ST_TMOUT;
-		goto err_out;
-	}
-
-	/* make sure DRQ is set */
-	status = ata_chk_status(ap);
-	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
-		/* device status error */
-		qc->err_mask |= AC_ERR_HSM;
-		ap->hsm_task_state = HSM_ST_ERR;
-		goto err_out;
-	}
-
-	/* Send the CDB (atapi) or the first data block (ata pio out).
-	 * During the state transition, interrupt handler shouldn't
-	 * be invoked before the data transfer is complete and
-	 * hsm_task_state is changed. Hence, the following locking.
-	 */
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-
-	if (qc->tf.protocol == ATA_PROT_PIO) {
-		/* PIO data out protocol.
-		 * send first data block.
-		 */
-
-		/* ata_pio_sectors() might change the state to HSM_ST_LAST.
-		 * so, the state is changed here before ata_pio_sectors().
-		 */
-		ap->hsm_task_state = HSM_ST;
-		ata_pio_sectors(qc);
-		ata_altstatus(ap); /* flush */
-	} else
-		/* send CDB */
-		atapi_send_cdb(ap, qc);
-
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	/* if polling, ata_pio_task() handles the rest.
-	 * otherwise, interrupt handler takes over from here.
-	 */
-	return has_next;
-
-err_out:
-	return 1; /* has next */
-}
-
-/**
  *	__atapi_pio_bytes - Transfer data from/to the ATAPI device.
  *	@qc: Command on going
  *	@bytes: number of bytes
@@ -3546,91 +3352,6 @@ err_out:
 }
 
 /**
- *	ata_pio_block - start PIO on a block
- *	@ap: the target ata_port
- *
- *	LOCKING:
- *	None.  (executing in kernel thread context)
- */
-
-static void ata_pio_block(struct ata_port *ap)
-{
-	struct ata_queued_cmd *qc;
-	u8 status;
-
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
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
-
-	/* check error */
-	if (status & (ATA_ERR | ATA_DF)) {
-		qc->err_mask |= AC_ERR_DEV;
-		ap->hsm_task_state = HSM_ST_ERR;
-		return;
-	}
-
-	/* transfer data if any */
-	if (is_atapi_taskfile(&qc->tf)) {
-		/* DRQ=0 means no more data to transfer */
-		if ((status & ATA_DRQ) == 0) {
-			ap->hsm_task_state = HSM_ST_LAST;
-			return;
-		}
-
-		atapi_pio_bytes(qc);
-	} else {
-		/* handle BSY=0, DRQ=0 as error */
-		if ((status & ATA_DRQ) == 0) {
-			qc->err_mask |= AC_ERR_HSM;
-			ap->hsm_task_state = HSM_ST_ERR;
-			return;
-		}
-
-		ata_pio_sectors(qc);
-	}
-
-	ata_altstatus(ap); /* flush */
-}
-
-static void ata_pio_error(struct ata_port *ap)
-{
-	struct ata_queued_cmd *qc;
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
-
-	if (qc->tf.command != ATA_CMD_PACKET)
-		printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
-
-	/* make sure qc->err_mask is available to 
-	 * know what's wrong and recover
-	 */
-	WARN_ON(qc->err_mask == 0);
-
-	ap->hsm_task_state = HSM_ST_IDLE;
-
-	ata_poll_qc_complete(qc);
-}
-
-/**
  *	ata_hsm_move - move the HSM to the next state.
  *	@ap: the target ata_port
  *	@qc: qc on going


