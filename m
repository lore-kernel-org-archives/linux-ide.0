From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 19 May 2004 16:24:27 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085005467.3141.5.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482  
	8		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.32
	 11	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com><1084920024.3191.8.ca
	 mel@patibmrh9>  <40AAA0BA.9040307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:57504 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264650AbUESWYm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2004 18:24:42 -0400
In-Reply-To: <40AAA0BA.9040307@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> I don't necessarily expect this work, but we'll see...

Many thanks again for restarting me.  Looks to me like we're now trying
to manually PIO an op x03 "REQUEST SENSE", analogous to how we manually
make PIO op xA1 "IDENTIFY" work.  I tried your patch as quoted below.

Consequently, I lost my display & mouse & keyboard.  I'll repeat that
test and report results.  A significant variable could be how I provoke
auto sense.  I first tried "TEST UNIT READY":

modprobe ata-piix
plscsi /dev/sg0 -X time 5 0 -i 8 -x "00 00:00:00 00 00"

I'll next try "READ CAPACITY":

modprobe ata-piix
plscsi /dev/sg0 -X time 5 0 -i 8 -x "25 00 00:00:00:00 00 00:00 00"

And maybe I should try ATA_FORCE_PIO.

Pat LaVarre

$ cd linux-2.6.6-bk6
$ patch -p1 <~/patch.as1
patching file drivers/scsi/libata-core.c
Hunk #1 succeeded at 2144 (offset -18 lines).
Hunk #3 succeeded at 2251 (offset -18 lines).
Hunk #5 succeeded at 2388 (offset -18 lines).
patching file drivers/scsi/libata-scsi.c
Hunk #2 succeeded at 926 (offset -1 lines).
patching file drivers/scsi/libata.h
$

diff -Nurp linux-2.6.6-bk6/drivers/scsi/libata-core.c linux-2.6.6-bk6-pel/drivers/scsi/libata-core.c
--- linux-2.6.6-bk6/drivers/scsi/libata-core.c	2004-05-19 13:35:25.000000000 -0600
+++ linux-2.6.6-bk6-pel/drivers/scsi/libata-core.c	2004-05-19 16:03:50.000000000 -0600
@@ -2144,6 +2144,79 @@ static void ata_pio_task(void *_data)
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
@@ -2167,6 +2240,7 @@ void ata_eng_timeout(struct ata_port *ap
 {
 	u8 host_stat, drv_stat;
 	struct ata_queued_cmd *qc;
+	int check_cond = 0;
 
 	DPRINTK("ENTER\n");
 
@@ -2177,16 +2251,30 @@ void ata_eng_timeout(struct ata_port *ap
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
@@ -2199,6 +2287,7 @@ void ata_eng_timeout(struct ata_port *ap
 		ata_dma_complete(qc, host_stat);
 		break;
 
+	case ATA_PROT_ATAPI:
 	case ATA_PROT_NODATA:
 		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
@@ -2299,15 +2388,23 @@ void ata_qc_complete(struct ata_queued_c
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
diff -Nurp linux-2.6.6-bk6/drivers/scsi/libata-scsi.c linux-2.6.6-bk6-pel/drivers/scsi/libata-scsi.c
--- linux-2.6.6-bk6/drivers/scsi/libata-scsi.c	2004-05-19 13:35:25.000000000 -0600
+++ linux-2.6.6-bk6-pel/drivers/scsi/libata-scsi.c	2004-05-19 16:03:50.000000000 -0600
@@ -137,7 +137,7 @@ void ata_to_sense_error(struct ata_queue
 
 	cmd->result = SAM_STAT_CHECK_CONDITION;
 
-	cmd->sense_buffer[0] = 0x70;
+	cmd->sense_buffer[0] = 0xf0;
 	cmd->sense_buffer[2] = MEDIUM_ERROR;
 	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
 
@@ -926,7 +926,7 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
 	DPRINTK("ENTER\n");
 	cmd->result = SAM_STAT_CHECK_CONDITION;
 
-	cmd->sense_buffer[0] = 0x70;
+	cmd->sense_buffer[0] = 0xf0;
 	cmd->sense_buffer[2] = ILLEGAL_REQUEST;
 	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
 	cmd->sense_buffer[12] = asc;

