From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] atapi request sense work
Date: Tue, 18 May 2004 19:48:10 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40AAA0BA.9040307@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482 8		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.3211	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com> <1084920024.3191.8.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010402090200040407070902"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41354 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263588AbUERXsX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 May 2004 19:48:23 -0400
In-Reply-To: <1084920024.3191.8.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Pat LaVarre <p.lavarre@ieee.org>

This is a multi-part message in MIME format.
--------------010402090200040407070902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I don't necessarily expect this work, but we'll see...


--------------010402090200040407070902
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/libata-core.c 1.64 vs edited =====
--- 1.64/drivers/scsi/libata-core.c	Mon May 17 19:39:49 2004
+++ edited/drivers/scsi/libata-core.c	Tue May 18 19:45:10 2004
@@ -2162,6 +2162,79 @@
 	}
 }
 
+static void atapi_error(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ata_taskfile tf;
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	u8 status;
+	u16 len;
+	const u8 request_sense_cdb[16] = {
+		REQUEST_SENSE, 0, 0, 0, SCSI_SENSE_BUFFERSIZE,
+	};
+
+	ata_tf_init(ap, &tf, qc->dev->devno);
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_ATAPI;
+	tf.ctl |= ATA_NIEN;
+	tf.lbam = SCSI_SENSE_BUFFERSIZE & 0xff;
+	tf.command = ATA_CMD_PACKET;
+	ata_tf_to_host(ap, &tf);
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
+		goto err_out;
+
+	status = ata_chk_status(ap);
+	if ((status & ATA_DRQ) == 0)
+		goto err_out;
+
+	/* FIXME: mmio-ize */
+	DPRINTK("send cdb\n");
+	outsl(ap->ioaddr.data_addr, request_sense_cdb,
+	      ap->host->max_cmd_len / 4);
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
+		goto err_out;
+
+	status = ata_chk_status(ap);
+	if ((status & ATA_DRQ) == 0)
+		goto err_out;
+
+	ap->ops->tf_read(ap, &tf);
+	len = tf.lbam;
+	len |= ((u16)tf.lbah) << 8;
+
+	if (len % 4)
+		printk(KERN_WARNING "ata%u: odd ATAPI length %u\n",
+		       ap->id, len);
+	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
+	insl(ap->ioaddr.data_addr, cmd->sense_buffer, len / 4);
+
+	if ((cmd->sense_buffer[0] & 0x7e) != 0x70) {
+		u8 err = ata_chk_err(ap);
+		cmd->sense_buffer[0] = 0xf0;
+		cmd->sense_buffer[2] = err >> 4;
+	}
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
+		goto err_out;
+
+	ata_irq_on(ap);
+
+out:
+	cmd->result = SAM_STAT_CHECK_CONDITION;
+	qc->scsidone(cmd);
+	return;
+
+err_out:
+	ata_irq_on(ap); /* re-enable interrupts */
+	cmd->sense_buffer[0] = 0xf0;
+	cmd->sense_buffer[2] = HARDWARE_ERROR;
+	cmd->sense_buffer[7] = 14 - 8;  /* addnl. sense len. FIXME: correct? */
+	cmd->sense_buffer[12] = 0x8; /* logical unit comm failure */
+	goto out;
+}
+
 /**
  *	ata_eng_timeout - Handle timeout of queued command
  *	@ap: Port on which timed-out command is active
@@ -2185,6 +2258,7 @@
 {
 	u8 host_stat, drv_stat;
 	struct ata_queued_cmd *qc;
+	int check_cond = 0;
 
 	DPRINTK("ENTER\n");
 
@@ -2195,16 +2269,30 @@
 		goto out;
 	}
 
-	/* hack alert!  We cannot use the supplied completion
-	 * function from inside the ->eh_strategy_handler() thread.
-	 * libata is the only user of ->eh_strategy_handler() in
-	 * any kernel, so the default scsi_done() assumes it is
-	 * not being called from the SCSI EH.
-	 */
-	qc->scsidone = scsi_finish_command;
+	if (qc->scsicmd) {
+		check_cond = !(qc->scsicmd->eh_eflags & SCSI_EH_CANCEL_CMD);
+
+		/* hack alert!  We cannot use the supplied completion
+		 * function from inside the ->eh_strategy_handler() thread.
+		 * libata is the only user of ->eh_strategy_handler() in
+		 * any kernel, so the default scsi_done() assumes it is
+		 * not being called from the SCSI EH.
+		 */
+		qc->scsidone = scsi_finish_command;
+	}
+
+	/* ATAPI devices */
+	if (qc->dev->class == ATA_DEV_ATAPI) {
+		if (check_cond) {
+			atapi_error(qc);
+			goto out;
+		}
+	}
 
+	/* ATA devices */
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
+	case ATA_PROT_ATAPI_DMA:
 		if (ap->flags & ATA_FLAG_MMIO) {
 			void *mmio = (void *) ap->ioaddr.bmdma_addr;
 			host_stat = readb(mmio + ATA_DMA_STATUS);
@@ -2217,6 +2305,7 @@
 		ata_dma_complete(qc, host_stat);
 		break;
 
+	case ATA_PROT_ATAPI:
 	case ATA_PROT_NODATA:
 		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
@@ -2317,15 +2406,23 @@
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
 
-	if (likely(qc->flags & ATA_QCFLAG_SG))
+	if (likely(qc->flags & ATA_QCFLAG_SG)) {
 		ata_sg_clean(qc);
+		qc->flags &= ~ATA_QCFLAG_SG;
+	}
 
 	if (cmd) {
 		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
-			if (is_atapi_taskfile(&qc->tf))
+			if (is_atapi_taskfile(&qc->tf)) {
 				cmd->result = SAM_STAT_CHECK_CONDITION;
-			else
-				ata_to_sense_error(qc);
+				qc->scsidone(cmd);
+				return;
+				/* error handler thread takes
+				 * over from here
+				 */
+			}
+
+			ata_to_sense_error(qc);
 		} else {
 			cmd->result = SAM_STAT_GOOD;
 		}
===== drivers/scsi/libata-scsi.c 1.37 vs edited =====
--- 1.37/drivers/scsi/libata-scsi.c	Mon May 17 19:39:49 2004
+++ edited/drivers/scsi/libata-scsi.c	Tue May 18 19:43:54 2004
@@ -137,7 +137,7 @@
 
 	cmd->result = SAM_STAT_CHECK_CONDITION;
 
-	cmd->sense_buffer[0] = 0x70;
+	cmd->sense_buffer[0] = 0xf0;
 	cmd->sense_buffer[2] = MEDIUM_ERROR;
 	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
 
@@ -927,7 +927,7 @@
 	DPRINTK("ENTER\n");
 	cmd->result = SAM_STAT_CHECK_CONDITION;
 
-	cmd->sense_buffer[0] = 0x70;
+	cmd->sense_buffer[0] = 0xf0;
 	cmd->sense_buffer[2] = ILLEGAL_REQUEST;
 	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
 	cmd->sense_buffer[12] = asc;
===== drivers/scsi/libata.h 1.15 vs edited =====
--- 1.15/drivers/scsi/libata.h	Sun May 16 21:33:12 2004
+++ edited/drivers/scsi/libata.h	Tue May 18 19:02:12 2004
@@ -28,6 +28,10 @@
 #define DRV_NAME	"libata"
 #define DRV_VERSION	"1.02"	/* must be exactly four chars */
 
+#ifndef SCSI_EH_CANCEL_CMD
+#define SCSI_EH_CANCEL_CMD	0x0001	/* Cancel this cmd */
+#endif /* SCSI_EH_CANCEL_CMD */
+
 struct ata_scsi_args {
 	struct ata_port		*ap;
 	struct ata_device	*dev;

--------------010402090200040407070902--

