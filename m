From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 27 May 2004 17:12:02 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085699522.3853.1.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.ed
	u	 .	pl><1085162347.4791.24.camel@patibmrh9><1085170025.3083.91.camel@pati
	bm	r h9> <40AE79E1.9020005@pobox.com><1085182749.3122.15.camel@patibmrh9> <
	40AE9493.1040701@pobox.com><1085186021.4510.0.camel@patibmrh9>  <1085188300
	.3658.18.camel@patibmrh9><1085608170.4148.138.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:35826 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265614AbUE0XMK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 May 2004 19:12:10 -0400
In-Reply-To: <1085608170.4148.138.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

I've started again working towards auto sense.

You may remember, as a first step, I'm trying to inject a PIO "REQUEST
SENSE" CDB after every ordinary CDB, no matter whether it fails or not. 
I resorted to that first step because Jeff G's auto sense patch gives me
indefinite repeated dmesg, as discussed previously.

But the following naive variation on your auto sense patch took down my
ATA_DEBUG ATA_VERBOSE_DEBUG ATA_ENABLE_ATAPI ATAPI_ENABLE_DMADIR kernel
when I tried: modprobe ata-piix

I'll follow up with quoted dmesg when I can acquire them (they're
missing from /var/log/messages).  You might notice, I've left myself in
2.6.7-rc1-bk3, since -bk4 did not change ata.h libata.h libata-core.c
libata-scsi.c.

Pat LaVarre

diff -Nurp linux-2.6.7-rc1-bk3/drivers/scsi/libata-core.c linux-2.6.7-rc1-bk3-pel/drivers/scsi/libata-core.c
--- linux-2.6.7-rc1-bk3/drivers/scsi/libata-core.c	2004-05-25 14:47:00.000000000 -0600
+++ linux-2.6.7-rc1-bk3-pel/drivers/scsi/libata-core.c	2004-05-27 16:56:27.000000000 -0600
@@ -2146,6 +2146,22 @@ static void ata_pio_task(void *_data)
 }
 
 /**
+ *	ata_check_bmdma - read PCI IDE BMDMA status
+ *	@ap: struct ata_port
+ */
+
+static u8 ata_check_bmdma(struct ata_port *ap)
+{
+	u8 host_stat;
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+		host_stat = readb(mmio + ATA_DMA_STATUS);
+	} else
+		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	return host_stat;
+}
+
+/**
  *	ata_eng_timeout - Handle timeout of queued command
  *	@ap: Port on which timed-out command is active
  *
@@ -2188,11 +2204,7 @@ void ata_eng_timeout(struct ata_port *ap
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
-		if (ap->flags & ATA_FLAG_MMIO) {
-			void *mmio = (void *) ap->ioaddr.bmdma_addr;
-			host_stat = readb(mmio + ATA_DMA_STATUS);
-		} else
-			host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		host_stat = ata_check_bmdma(ap);
 
 		printk(KERN_ERR "ata%u: DMA timeout, stat 0x%x\n",
 		       ap->id, host_stat);
@@ -2283,6 +2295,86 @@ struct ata_queued_cmd *ata_qc_new_init(s
 }
 
 /**
+ *	atapi_error - 
+ *	@qc:
+ */
+
+static void atapi_error(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ata_taskfile tf;
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	u8 status;
+	u8 max = min(0x12, SCSI_SENSE_BUFFERSIZE);
+	u16 len;
+	const u8 request_sense_cdb[16] = {
+		REQUEST_SENSE, 0, 0, 0, max, 0,
+	};
+	u8 err = ata_chk_err(ap); /* fetch before ata_tf_to_host */
+
+	ata_tf_init(ap, &tf, qc->dev->devno);
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_ATAPI;
+	tf.ctl |= ATA_NIEN;
+	tf.lbam = max;
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
+	if (!len || (len % 4) || (max < len))
+		printk(KERN_WARNING "ata%u: surprise ATAPI length %u\n",
+		       ap->id, len);
+	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
+	insl(ap->ioaddr.data_addr, cmd->sense_buffer, (len + 4 - 1) / 4);
+
+	if ((cmd->sense_buffer[0] & 0x7e) != 0x70) {
+		cmd->sense_buffer[0] = 0x70;
+		cmd->sense_buffer[2] = err >> 4;
+	}
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB))
+		goto err_out;
+
+
+out:
+	/* ata_irq_on(ap); */
+	cmd->result = SAM_STAT_CHECK_CONDITION;
+	cmd->result = SAM_STAT_GOOD; /* FIXME */
+	qc->scsidone(cmd);
+	return;
+
+err_out:
+	cmd->sense_buffer[0] = 0x70;
+	cmd->sense_buffer[2] = HARDWARE_ERROR; /* SK, often 0x4 */
+	cmd->sense_buffer[7] = 14 - 7 - 1; /* total - offset - length */
+	cmd->sense_buffer[12] = 0x08; /* ASC, logical unit comm failure */
+	/* cmd->sense_buffer[13] = 0x03; // ASCQ, UDMA CRC */
+	goto out; /* above */
+}
+
+/**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
  *	@drv_stat: ATA status register contents
@@ -2312,6 +2404,8 @@ void ata_qc_complete(struct ata_queued_c
 		} else {
 			cmd->result = SAM_STAT_GOOD;
 		}
+		cmd->result = SAM_STAT_GOOD; /* FIXME */
+		atapi_error(qc); /* FIXME */
 
 		qc->scsidone(cmd);
 	}
@@ -2584,7 +2678,6 @@ static void ata_dma_complete(struct ata_
 		     ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	}
 
-
 	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
 	ata_altstatus(ap);		/* dummy read */
 
@@ -2622,11 +2715,7 @@ inline unsigned int ata_host_intr (struc
 	/* BMDMA completion */
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
-		if (ap->flags & ATA_FLAG_MMIO) {
-			void *mmio = (void *) ap->ioaddr.bmdma_addr;
-			host_stat = readb(mmio + ATA_DMA_STATUS);
-		} else
-			host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		host_stat = ata_check_bmdma(ap);
 		VPRINTK("BUS_DMA (host_stat 0x%X)\n", host_stat);
 
 		if (!(host_stat & ATA_DMA_INTR)) {
@@ -2650,11 +2739,14 @@ inline unsigned int ata_host_intr (struc
 	case ATA_PROT_NODATA:
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
-		ata_qc_complete(qc, status);
+		host_stat = ata_check_bmdma(ap);
+		DPRINTK("BUS_NODATA (host_stat 0x%X)\n", host_stat);
+		ata_dma_complete(qc, host_stat);
 		handled = 1;
 		break;
 
 	default:
+		DPRINTK("irq trappable\n");
 		ap->stats.idle_irq++;
 
 #ifdef ATA_IRQ_TRAP


