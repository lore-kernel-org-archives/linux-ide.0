From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 1/4] irq-pio: move functions
Date: Mon, 03 Oct 2005 21:00:17 +0800
Message-ID: <43412B61.7020805@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040502030500050208010609"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:60392 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932129AbVJCNAn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Oct 2005 09:00:43 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j93Cx6pr013247
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 08:59:06 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j93D0btP536840
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 07:00:37 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j93D0Z3H022978
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 07:00:36 -0600
In-Reply-To: <43411A1A.8050901@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

This is a multi-part message in MIME format.
--------------040502030500050208010609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 1/4:
  move atapi_send_cdb() and ata_dataout_task() to be near ata_pio_*() 
functions


For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------040502030500050208010609
Content-Type: text/plain;
 name="idpio1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio1.diff"

--- id4/drivers/scsi/libata-core.c	2005-09-30 18:04:33.000000000 +0800
+++ id5/drivers/scsi/libata-core.c	2005-10-03 10:25:01.000000000 +0800
@@ -2696,6 +2696,114 @@ static void ata_pio_sector(struct ata_qu
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
+}
+
+/**
+ *	ata_dataout_task - Write first data block to hardware
+ *	@_data: Port to which ATA/ATAPI device is attached.
+ *
+ *	When device has indicated its readiness to accept
+ *	the data, this function sends out the CDB or 
+ *	the first data block by PIO.
+ *	After this, 
+ *	  - If polling, ata_pio_task() handles the rest.
+ *	  - Otherwise, interrupt handler takes over.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+
+static void ata_dataout_task(void *_data)
+{
+	struct ata_port *ap = _data;
+	struct ata_queued_cmd *qc;
+	u8 status;
+	unsigned long flags;
+
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	assert(qc != NULL);
+	assert(qc->flags & ATA_QCFLAG_ACTIVE);
+
+	/* sleep-wait for BSY to clear */
+	DPRINTK("busy wait\n");
+	if (ata_busy_sleep(ap, ATA_TMOUT_DATAOUT_QUICK, ATA_TMOUT_DATAOUT))
+		goto err_out;
+
+	/* make sure DRQ is set */
+	status = ata_chk_status(ap);
+	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
+		goto err_out;
+
+	/* Send the CDB (atapi) or the first data block (ata pio out).
+	 * During the state transition, interrupt handler shouldn't
+	 * be invoked before the data transfer is complete and
+	 * hsm_task_state is changed. Hence, the following locking.
+	 */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	if (qc->tf.protocol == ATA_PROT_PIO) {
+		/* PIO data out protocol.
+		 * send first data block.
+		 */
+
+		/* ata_pio_sector() might change the state to HSM_ST_LAST.
+		 * so, the state is changed here before ata_pio_sector().
+		 */
+		ap->hsm_task_state = HSM_ST;
+		ata_pio_sector(qc);
+		ata_altstatus(ap); /* flush */
+	} else
+		/* send CDB */
+		atapi_send_cdb(ap, qc);
+
+	/* if polling, ata_pio_task() handles the rest.
+	 * otherwise, interrupt handler takes over from here.
+	 */
+	if (qc->tf.flags & ATA_TFLAG_POLLING)
+		queue_work(ata_wq, &ap->pio_task);
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	return;
+
+err_out:
+	ata_pio_error(ap);
+}
+
+/**
  *	__atapi_pio_bytes - Transfer data from/to the ATAPI device.
  *	@qc: Command on going
  *	@bytes: number of bytes
@@ -3695,42 +3803,6 @@ void ata_bmdma_stop(struct ata_queued_cm
 }
 
 /**
- *	atapi_send_cdb - Write CDB bytes to hardware
- *	@ap: Port to which ATAPI device is attached.
- *	@qc: Taskfile currently active
- *
- *	When device has indicated its readiness to accept
- *	a CDB, this function is called.  Send the CDB.
- *
- *	LOCKING:
- *	caller.
- */
-
-static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
-{
-	/* send SCSI cdb */
-	DPRINTK("send cdb\n");
-	assert(ap->cdb_len >= 12);
-
-	ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
-	ata_altstatus(ap); /* flush */
-
-	switch (qc->tf.protocol) {
-	case ATA_PROT_ATAPI:
-		ap->hsm_task_state = HSM_ST;
-		break;
-	case ATA_PROT_ATAPI_NODATA:
-		ap->hsm_task_state = HSM_ST_LAST;
-		break;
-	case ATA_PROT_ATAPI_DMA:
-		ap->hsm_task_state = HSM_ST_LAST;
-		/* initiate bmdma */
-		ap->ops->bmdma_start(qc);
-		break;
-	}
-}
-
-/**
  *	ata_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
  *	@qc: Taskfile currently active in engine
@@ -3952,79 +4024,6 @@ irqreturn_t ata_interrupt (int irq, void
 }
 
 /**
- *	ata_dataout_task - Write first data block to hardware
- *	@_data: Port to which ATA/ATAPI device is attached.
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
- */
-
-static void ata_dataout_task(void *_data)
-{
-	struct ata_port *ap = _data;
-	struct ata_queued_cmd *qc;
-	u8 status;
-	unsigned long flags;
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
-	assert(qc->flags & ATA_QCFLAG_ACTIVE);
-
-	/* sleep-wait for BSY to clear */
-	DPRINTK("busy wait\n");
-	if (ata_busy_sleep(ap, ATA_TMOUT_DATAOUT_QUICK, ATA_TMOUT_DATAOUT))
-		goto err_out;
-
-	/* make sure DRQ is set */
-	status = ata_chk_status(ap);
-	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)
-		goto err_out;
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
-		/* ata_pio_sector() might change the state to HSM_ST_LAST.
-		 * so, the state is changed here before ata_pio_sector().
-		 */
-		ap->hsm_task_state = HSM_ST;
-		ata_pio_sector(qc);
-		ata_altstatus(ap); /* flush */
-	} else
-		/* send CDB */
-		atapi_send_cdb(ap, qc);
-
-	/* if polling, ata_pio_task() handles the rest.
-	 * otherwise, interrupt handler takes over from here.
-	 */
-	if (qc->tf.flags & ATA_TFLAG_POLLING)
-		queue_work(ata_wq, &ap->pio_task);
-
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	return;
-
-err_out:
-	ata_pio_error(ap);
-}
-
-
-/**
  *	ata_port_start - Set port up for dma.
  *	@ap: Port to initialize
  *

--------------040502030500050208010609--

