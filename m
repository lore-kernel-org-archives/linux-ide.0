From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata update 20040515-1
Date: Sat, 15 May 2004 17:43:46 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A68F12.8020409@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040901060806080005050500"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38824 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264735AbUEOVoE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 17:44:04 -0400
Received: from rdu74-153-143.nc.rr.com ([24.74.153.143] helo=pobox.com)
	by www.linux.org.uk with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.33)
	id 1BP6ws-0004W2-Bm
	for linux-ide@vger.kernel.org; Sat, 15 May 2004 22:44:03 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040901060806080005050500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


The attached patch is what I sent to Linus earlier day, and should 
appear upstream vaguely soon.

Patches should be based off of 2.6.6-bk + this patch.



--------------040901060806080005050500
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	Sat May 15 17:42:11 2004
+++ b/drivers/scsi/ata_piix.c	Sat May 15 17:42:11 2004
@@ -136,6 +136,7 @@
 
 	.phy_reset		= piix_pata_phy_reset,
 
+	.bmdma_setup		= ata_bmdma_setup_pio,
 	.bmdma_start		= ata_bmdma_start_pio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
@@ -158,6 +159,7 @@
 
 	.phy_reset		= piix_sata_phy_reset,
 
+	.bmdma_setup		= ata_bmdma_setup_pio,
 	.bmdma_start		= ata_bmdma_start_pio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Sat May 15 17:42:11 2004
+++ b/drivers/scsi/libata-core.c	Sat May 15 17:42:11 2004
@@ -50,8 +50,7 @@
 				    unsigned long tmout_pat,
 			    	    unsigned long tmout);
 static void __ata_dev_select (struct ata_port *ap, unsigned int device);
-static void ata_dma_complete(struct ata_port *ap, u8 host_stat,
-			     unsigned int done_late);
+static void ata_dma_complete(struct ata_queued_cmd *qc, u8 host_stat);
 static void ata_host_set_pio(struct ata_port *ap);
 static void ata_host_set_udma(struct ata_port *ap);
 static void ata_dev_set_pio(struct ata_port *ap, unsigned int device);
@@ -1156,7 +1155,7 @@
 		ap->host->max_cmd_len = 16;
 
 		/* print device info to dmesg */
-		printk(KERN_INFO "ata%u: dev %u ATA, max %s, %Lu sectors: %s\n",
+		printk(KERN_INFO "ata%u: dev %u ATA, max %s, %Lu sectors:%s\n",
 		       ap->id, device,
 		       ata_udma_string(udma_modes),
 		       (unsigned long long)dev->n_sectors,
@@ -2066,7 +2065,7 @@
 
 	ata_irq_on(ap);
 
-	ata_qc_complete(qc, drv_stat, 0);
+	ata_qc_complete(qc, drv_stat);
 }
 
 /**
@@ -2239,7 +2238,7 @@
 		printk(KERN_ERR "ata%u: DMA timeout, stat 0x%x\n",
 		       ap->id, host_stat);
 
-		ata_dma_complete(ap, host_stat, 1);
+		ata_dma_complete(qc, host_stat);
 		break;
 
 	case ATA_PROT_NODATA:
@@ -2248,7 +2247,7 @@
 		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, drv_stat, 1);
+		ata_qc_complete(qc, drv_stat);
 		break;
 
 	default:
@@ -2257,7 +2256,7 @@
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, drv_stat, 1);
+		ata_qc_complete(qc, drv_stat);
 		break;
 	}
 
@@ -2328,13 +2327,12 @@
  *	ata_qc_complete -
  *	@qc:
  *	@drv_stat:
- *	@done_late:
  *
  *	LOCKING:
  *
  */
 
-void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat, unsigned int done_late)
+void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
 {
 	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
@@ -2396,16 +2394,18 @@
 	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
-	/* set up SG table */
-	if (cmd->use_sg) {
-		if (ata_sg_setup(qc))
-			goto err_out;
-	} else {
-		if (ata_sg_setup_one(qc))
-			goto err_out;
-	}
+	if (qc->flags & ATA_QCFLAG_SG) {
+		/* set up SG table */
+		if (cmd->use_sg) {
+			if (ata_sg_setup(qc))
+				goto err_out;
+		} else {
+			if (ata_sg_setup_one(qc))
+				goto err_out;
+		}
 
-	ap->ops->fill_sg(qc);
+		ap->ops->fill_sg(qc);
+	}
 
 	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
@@ -2445,17 +2445,28 @@
 
 	case ATA_PROT_DMA:
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
+		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
 		break;
 
 	case ATA_PROT_PIO: /* load tf registers, initiate polling pio */
-		qc->flags |= ATA_QCFLAG_POLL;
-		qc->tf.ctl |= ATA_NIEN;	/* disable interrupts */
+		ata_qc_set_polling(qc);
 		ata_tf_to_host_nolock(ap, &qc->tf);
 		ap->pio_task_state = PIO_ST;
 		queue_work(ata_wq, &ap->pio_task);
 		break;
 
+	case ATA_PROT_ATAPI:
+		ata_tf_to_host_nolock(ap, &qc->tf);
+		queue_work(ata_wq, &ap->packet_task);
+		break;
+
+	case ATA_PROT_ATAPI_DMA:
+		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
+		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
+		queue_work(ata_wq, &ap->packet_task);
+		break;
+
 	default:
 		WARN_ON(1);
 		return -1;
@@ -2465,14 +2476,14 @@
 }
 
 /**
- *	ata_bmdma_start_mmio -
- *	@qc:
+ *	ata_bmdma_setup_mmio - Set up PCI IDE BMDMA transaction (MMIO)
+ *	@qc: Info associated with this ATA transaction.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
+void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -2496,8 +2507,24 @@
 
 	/* issue r/w command */
 	ap->ops->exec_command(ap, &qc->tf);
+}
+
+/**
+ *	ata_bmdma_start_mmio - Start a PCI IDE BMDMA transaction (MMIO)
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void *mmio = (void *) ap->ioaddr.bmdma_addr;
+	u8 dmactl;
 
 	/* start host DMA transaction */
+	dmactl = readb(mmio + ATA_DMA_CMD);
 	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
 
 	/* Strictly, one may wish to issue a readb() here, to
@@ -2514,14 +2541,14 @@
 }
 
 /**
- *	ata_bmdma_start_pio -
- *	@qc:
+ *	ata_bmdma_setup_pio - Set up PCI IDE BMDMA transaction (PIO)
+ *	@qc: Info associated with this ATA transaction.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
+void ata_bmdma_setup_pio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -2544,24 +2571,38 @@
 
 	/* issue r/w command */
 	ap->ops->exec_command(ap, &qc->tf);
+}
+
+/**
+ *	ata_bmdma_start_pio - Start a PCI IDE BMDMA transaction (PIO)
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	u8 dmactl;
 
 	/* start host DMA transaction */
+	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 	outb(dmactl | ATA_DMA_START,
 	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
 
 /**
  *	ata_dma_complete -
- *	@ap:
+ *	@qc:
  *	@host_stat:
- *	@done_late:
  *
  *	LOCKING:
  */
 
-static void ata_dma_complete(struct ata_port *ap, u8 host_stat,
-			     unsigned int done_late)
+static void ata_dma_complete(struct ata_queued_cmd *qc, u8 host_stat)
 {
+	struct ata_port *ap = qc->ap;
 	VPRINTK("ENTER\n");
 
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -2592,8 +2633,7 @@
 		ap->id, (u32) host_stat, (u32) ata_chk_status(ap));
 
 	/* get drive status; clear intr; complete txn */
-	ata_qc_complete(ata_qc_from_tag(ap, ap->active_tag),
-			ata_wait_idle(ap), done_late);
+	ata_qc_complete(qc, ata_wait_idle(ap));
 }
 
 /**
@@ -2620,6 +2660,7 @@
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
+	case ATA_PROT_ATAPI_DMA:
 		if (ap->flags & ATA_FLAG_MMIO) {
 			void *mmio = (void *) ap->ioaddr.bmdma_addr;
 			host_stat = readb(mmio + ATA_DMA_STATUS);
@@ -2632,14 +2673,14 @@
 			break;
 		}
 
-		ata_dma_complete(ap, host_stat, 0);
+		ata_dma_complete(qc, host_stat);
 		handled = 1;
 		break;
 
 	case ATA_PROT_NODATA:	/* command completion, but no data xfer */
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
-		ata_qc_complete(qc, status, 0);
+		ata_qc_complete(qc, status);
 		handled = 1;
 		break;
 
@@ -2689,7 +2730,7 @@
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
+			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
 				handled += ata_host_intr(ap, qc);
 		}
 	}
@@ -2755,20 +2796,6 @@
 	return timeout;
 }
 
-void atapi_start(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-
-	qc->flags |= ATA_QCFLAG_ACTIVE;
-	ap->active_tag = qc->tag;
-
-	ata_dev_select(ap, qc->dev->devno, 1, 0);
-	ata_tf_to_host_nolock(ap, &qc->tf);
-	queue_work(ata_wq, &ap->packet_task);
-
-	VPRINTK("EXIT\n");
-}
-
 /**
  *	atapi_packet_task - Write CDB bytes to hardware
  *	@_data: Port to which ATAPI device is attached.
@@ -2811,7 +2838,7 @@
 
 	/* if we are DMA'ing, irq handler takes over from here */
 	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
-		/* FIXME: start DMA here */
+		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
 	} else {
 		ap->pio_task_state = PIO_ST;
 		queue_work(ata_wq, &ap->pio_task);
@@ -2820,7 +2847,7 @@
 	return;
 
 err_out:
-	ata_qc_complete(qc, ATA_ERR, 0);
+	ata_qc_complete(qc, ATA_ERR);
 }
 
 int ata_port_start (struct ata_port *ap)
@@ -3475,7 +3502,9 @@
 EXPORT_SYMBOL_GPL(ata_port_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_fill_sg);
+EXPORT_SYMBOL_GPL(ata_bmdma_setup_pio);
 EXPORT_SYMBOL_GPL(ata_bmdma_start_pio);
+EXPORT_SYMBOL_GPL(ata_bmdma_setup_mmio);
 EXPORT_SYMBOL_GPL(ata_bmdma_start_mmio);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	Sat May 15 17:42:11 2004
+++ b/drivers/scsi/libata-scsi.c	Sat May 15 17:42:11 2004
@@ -885,53 +885,20 @@
 }
 
 /**
- *	atapi_scsi_queuecmd - Send CDB to ATAPI device
- *	@ap: Port to which ATAPI device is attached.
- *	@dev: Target device for CDB.
- *	@cmd: SCSI command being sent to device.
- *	@done: SCSI command completion function.
- *
- *	Sends CDB to ATAPI device.  If the Linux SCSI layer sends a
- *	non-data command, then this function handles the command
- *	directly, via polling.  Otherwise, the bmdma engine is started.
+ *	atapi_xlat - Initialize PACKET taskfile
+ *	@qc: command structure to be initialized
+ *	@scsicmd: SCSI CDB associated with this PACKET command
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on failure.
  */
 
-static void atapi_scsi_queuecmd(struct ata_port *ap, struct ata_device *dev,
-			       struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
+static unsigned int atapi_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
 {
-	struct ata_queued_cmd *qc;
-	u8 *scsicmd = cmd->cmnd;
-
-	VPRINTK("ENTER, drv_stat = 0x%x\n", ata_chk_status(ap));
-
-	if (cmd->sc_data_direction == SCSI_DATA_UNKNOWN) {
-		DPRINTK("unknown data, scsicmd 0x%x\n", scsicmd[0]);
-		ata_bad_cdb(cmd, done);
-		return;
-	}
-
-	switch(scsicmd[0]) {
-	case READ_6:
-	case WRITE_6:
-	case MODE_SELECT:
-	case MODE_SENSE:
-		DPRINTK("read6/write6/modesel/modesense trap\n");
-		ata_bad_scsiop(cmd, done);
-		return;
-
-	default:
-		/* do nothing */
-		break;
-	}
-
-	qc = ata_scsi_qc_new(ap, dev, cmd, done);
-	if (!qc) {
-		printk(KERN_ERR "ata%u: command queue empty\n", ap->id);
-		return;
-	}
+	struct scsi_cmnd *cmd = qc->scsicmd;
 
 	qc->flags |= ATA_QCFLAG_ATAPI;
 
@@ -943,17 +910,19 @@
 
 	qc->tf.command = ATA_CMD_PACKET;
 
-	if (cmd->sc_data_direction == SCSI_DATA_NONE) {
+	if ((cmd->sc_data_direction == SCSI_DATA_NONE) ||
+	    ((qc->flags & ATA_QCFLAG_DMA) == 0)) {
+		ata_qc_set_polling(qc);
 		qc->tf.protocol = ATA_PROT_ATAPI;
-		qc->flags |= ATA_QCFLAG_POLL;
-		qc->tf.ctl |= ATA_NIEN;	/* disable interrupts */
+		qc->tf.lbam = (8 * 1024) & 0xff;
+		qc->tf.lbah = (8 * 1024) >> 8;
 	} else {
-		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
+		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 	}
 
-	atapi_start(qc);
+	return 0;
 }
 
 /**
@@ -1092,7 +1061,7 @@
 		else
 			ata_scsi_simulate(ap, dev, cmd, done);
 	} else
-		atapi_scsi_queuecmd(ap, dev, cmd, done);
+		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
 out_unlock:
 	return 0;
diff -Nru a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h	Sat May 15 17:42:11 2004
+++ b/drivers/scsi/libata.h	Sat May 15 17:42:11 2004
@@ -44,7 +44,6 @@
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void ata_tf_to_host_nolock(struct ata_port *ap, struct ata_taskfile *tf);
-extern void atapi_start(struct ata_queued_cmd *qc);
 
 
 /* libata-scsi.c */
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	Sat May 15 17:42:11 2004
+++ b/drivers/scsi/sata_promise.c	Sat May 15 17:42:11 2004
@@ -74,6 +74,7 @@
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static void pdc_dma_setup(struct ata_queued_cmd *qc);
 static void pdc_dma_start(struct ata_queued_cmd *qc);
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
@@ -111,6 +112,7 @@
 	.check_status		= ata_check_status_mmio,
 	.exec_command		= pdc_exec_command_mmio,
 	.phy_reset		= pdc_phy_reset,
+	.bmdma_setup            = pdc_dma_setup,
 	.bmdma_start            = pdc_dma_start,
 	.fill_sg		= pdc_fill_sg,
 	.eng_timeout		= pdc_eng_timeout,
@@ -285,8 +287,7 @@
 	u8 err_bit = have_err ? ATA_ERR : 0;
 
 	/* get drive status; clear intr; complete txn */
-	ata_qc_complete(ata_qc_from_tag(ap, ap->active_tag),
-			ata_wait_idle(ap) | err_bit, 0);
+	ata_qc_complete(qc, ata_wait_idle(ap) | err_bit);
 }
 
 static void pdc_eng_timeout(struct ata_port *ap)
@@ -314,8 +315,7 @@
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 		printk(KERN_ERR "ata%u: DMA timeout\n", ap->id);
-		ata_qc_complete(ata_qc_from_tag(ap, ap->active_tag),
-			        ata_wait_idle(ap) | ATA_ERR, 0);
+		ata_qc_complete(qc, ata_wait_idle(ap) | ATA_ERR);
 		break;
 
 	case ATA_PROT_NODATA:
@@ -324,7 +324,7 @@
 		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, drv_stat, 1);
+		ata_qc_complete(qc, drv_stat);
 		break;
 
 	default:
@@ -333,7 +333,7 @@
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, drv_stat, 1);
+		ata_qc_complete(qc, drv_stat);
 		break;
 	}
 
@@ -366,7 +366,7 @@
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
 		if (have_err)
 			status |= ATA_ERR;
-		ata_qc_complete(qc, status, 0);
+		ata_qc_complete(qc, status);
 		handled = 1;
 		break;
 
@@ -419,7 +419,7 @@
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
+			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
 				handled += pdc_host_intr(ap, qc);
 		}
 	}
@@ -429,6 +429,12 @@
 	VPRINTK("EXIT\n");
 
 	return IRQ_RETVAL(handled);
+}
+
+static void pdc_dma_setup(struct ata_queued_cmd *qc)
+{
+	/* nothing for now.  later, we will call standard
+	 * code in libata-core for ATAPI here */
 }
 
 static void pdc_dma_start(struct ata_queued_cmd *qc)
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	Sat May 15 17:42:11 2004
+++ b/drivers/scsi/sata_sil.c	Sat May 15 17:42:11 2004
@@ -129,6 +129,7 @@
 	.exec_command		= ata_exec_command_mmio,
 	.phy_reset		= sata_phy_reset,
 	.post_set_mode		= sil_post_set_mode,
+	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	Sat May 15 17:42:11 2004
+++ b/drivers/scsi/sata_sis.c	Sat May 15 17:42:11 2004
@@ -98,6 +98,7 @@
 	.check_status		= ata_check_status_pio,
 	.exec_command		= ata_exec_command_pio,
 	.phy_reset		= sata_phy_reset,
+	.bmdma_setup            = ata_bmdma_setup_pio,
 	.bmdma_start            = ata_bmdma_start_pio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	Sat May 15 17:42:11 2004
+++ b/drivers/scsi/sata_svw.c	Sat May 15 17:42:11 2004
@@ -231,6 +231,7 @@
 	.check_status		= k2_stat_check_status,
 	.exec_command		= ata_exec_command_mmio,
 	.phy_reset		= sata_phy_reset,
+	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	Sat May 15 17:42:11 2004
+++ b/drivers/scsi/sata_sx4.c	Sat May 15 17:42:11 2004
@@ -146,6 +146,7 @@
 
 
 static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static void pdc20621_dma_setup(struct ata_queued_cmd *qc);
 static void pdc20621_dma_start(struct ata_queued_cmd *qc);
 static irqreturn_t pdc20621_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void pdc_eng_timeout(struct ata_port *ap);
@@ -197,6 +198,7 @@
 	.check_status		= ata_check_status_mmio,
 	.exec_command		= pdc_exec_command_mmio,
 	.phy_reset		= pdc_20621_phy_reset,
+	.bmdma_setup            = pdc20621_dma_setup,
 	.bmdma_start            = pdc20621_dma_start,
 	.fill_sg		= pdc20621_fill_sg,
 	.eng_timeout		= pdc_eng_timeout,
@@ -568,6 +570,12 @@
 static inline void pdc20621_dump_hdma(struct ata_queued_cmd *qc) { }
 #endif /* ATA_VERBOSE_DEBUG */
 
+static void pdc20621_dma_setup(struct ata_queued_cmd *qc)
+{
+	/* nothing for now.  later, we will call standard
+	 * code in libata-core for ATAPI here */
+}
+
 static void pdc20621_dma_start(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -681,7 +689,7 @@
 
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
-		ata_qc_complete(qc, status, 0);
+		ata_qc_complete(qc, status);
 		handled = 1;
 
 	} else {
@@ -740,7 +748,7 @@
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
+			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
 				handled += pdc20621_host_intr(ap, qc, (i > 4),
 							      mmio_base);
 		}
@@ -762,8 +770,7 @@
 	u8 err_bit = have_err ? ATA_ERR : 0;
 
 	/* get drive status; clear intr; complete txn */
-	ata_qc_complete(ata_qc_from_tag(ap, ap->active_tag),
-			ata_wait_idle(ap) | err_bit, 0);
+	ata_qc_complete(qc, ata_wait_idle(ap) | err_bit);
 }
 
 static void pdc_eng_timeout(struct ata_port *ap)
@@ -791,8 +798,7 @@
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 		printk(KERN_ERR "ata%u: DMA timeout\n", ap->id);
-		ata_qc_complete(ata_qc_from_tag(ap, ap->active_tag),
-			        ata_wait_idle(ap) | ATA_ERR, 0);
+		ata_qc_complete(qc, ata_wait_idle(ap) | ATA_ERR);
 		break;
 
 	case ATA_PROT_NODATA:
@@ -801,7 +807,7 @@
 		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, drv_stat, 1);
+		ata_qc_complete(qc, drv_stat);
 		break;
 
 	default:
@@ -810,7 +816,7 @@
 		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
 		       ap->id, qc->tf.command, drv_stat);
 
-		ata_qc_complete(qc, drv_stat, 1);
+		ata_qc_complete(qc, drv_stat);
 		break;
 	}
 
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	Sat May 15 17:42:11 2004
+++ b/drivers/scsi/sata_via.c	Sat May 15 17:42:11 2004
@@ -106,6 +106,7 @@
 
 	.phy_reset		= sata_phy_reset,
 
+	.bmdma_setup            = ata_bmdma_setup_pio,
 	.bmdma_start            = ata_bmdma_start_pio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	Sat May 15 17:42:11 2004
+++ b/drivers/scsi/sata_vsc.c	Sat May 15 17:42:11 2004
@@ -175,7 +175,7 @@
 				struct ata_queued_cmd *qc;
 
 				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
+				if (qc && (!(qc->tf.ctl & ATA_NIEN)))
 					handled += ata_host_intr(ap, qc);
 			}
 		}
@@ -213,6 +213,7 @@
 	.exec_command		= ata_exec_command_mmio,
 	.check_status		= ata_check_status_mmio,
 	.phy_reset		= sata_phy_reset,
+	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
 	.fill_sg		= ata_fill_sg,
 	.eng_timeout		= ata_eng_timeout,
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	Sat May 15 17:42:11 2004
+++ b/include/linux/libata.h	Sat May 15 17:42:11 2004
@@ -112,7 +112,6 @@
 	ATA_QCFLAG_DMA		= (1 << 2), /* data delivered via DMA */
 	ATA_QCFLAG_ATAPI	= (1 << 3), /* is ATAPI packet command? */
 	ATA_QCFLAG_SG		= (1 << 4), /* have s/g table? */
-	ATA_QCFLAG_POLL		= (1 << 5), /* polling, no interrupts */
 
 	/* various lengths of time */
 	ATA_TMOUT_EDD		= 5 * HZ,	/* hueristic */
@@ -335,6 +334,7 @@
 	void (*phy_reset) (struct ata_port *ap);
 	void (*post_set_mode) (struct ata_port *ap);
 
+	void (*bmdma_setup) (struct ata_queued_cmd *qc);
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
 	void (*fill_sg) (struct ata_queued_cmd *qc);
 	void (*eng_timeout) (struct ata_port *ap);
@@ -397,10 +397,12 @@
 extern void ata_port_stop (struct ata_port *ap);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_fill_sg(struct ata_queued_cmd *qc);
+extern void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_mmio (struct ata_queued_cmd *qc);
+extern void ata_bmdma_setup_pio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_pio (struct ata_queued_cmd *qc);
 extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
-extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat, unsigned int done_late);
+extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
 extern void ata_eng_timeout(struct ata_port *ap);
 extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct block_device *bdev,
@@ -471,6 +473,12 @@
 	}
 
 	return status;
+}
+
+static inline void ata_qc_set_polling(struct ata_queued_cmd *qc)
+{
+	qc->flags &= ~ATA_QCFLAG_DMA;
+	qc->tf.ctl |= ATA_NIEN;
 }
 
 static inline struct ata_queued_cmd *ata_qc_from_tag (struct ata_port *ap,

--------------040901060806080005050500--

