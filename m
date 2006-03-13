From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/3] libata-dev: Remove atapi_packet_task()
Date: Mon, 13 Mar 2006 15:28:50 +0800
Message-ID: <44151F32.8050607@tw.ibm.com>
References: <44119BC9.8080502@tw.ibm.com> <44136B04.4090203@pobox.com> <44151D53.3040606@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:9117 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751109AbWCMH24 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 02:28:56 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2D7StmH016093
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 02:28:55 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2D7Vnfw188888
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:31:49 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2D7StV8004264
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:28:55 -0700
In-Reply-To: <44151D53.3040606@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Remove unused atapi_packet_task().

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

atapi_packet_task() was replaced by ata_pio_task() in the irq-pio branch.

--- 00_cdblen/drivers/scsi/libata-core.c	2006-03-13 12:25:40.000000000 +0800
+++ 00.5_removeatapi/drivers/scsi/libata-core.c	2006-03-13 11:38:06.000000000 +0800
@@ -3815,79 +3815,6 @@ fsm_start:
 }
 
 /**
- *	atapi_packet_task - Write CDB bytes to hardware
- *	@_data: Port to which ATAPI device is attached.
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
-
-static void atapi_packet_task(void *_data)
-{
-	struct ata_port *ap = _data;
-	struct ata_queued_cmd *qc;
-	u8 status;
-
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
-	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
-
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
-#warning FIXME
-		/* ap->flags &= ~ATA_FLAG_NOINTR; */
-		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
-		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
-			ap->ops->bmdma_start(qc);	/* initiate bmdma */
-		spin_unlock_irqrestore(&ap->host_set->lock, flags);
-	} else {
-		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
-
-		/* PIO commands are handled by polling */
-		ap->hsm_task_state = HSM_ST;
-		ata_port_queue_task(ap, ata_pio_task, ap, 0);
-	}
-
-	return;
-
-err_out:
-	ata_poll_qc_complete(qc);
-}
-
-/**
  *	ata_qc_timeout - Handle timeout of queued command
  *	@qc: Command that timed out
  *


