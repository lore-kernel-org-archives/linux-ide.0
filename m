From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 15 May 2004 09:49:40 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084636180.3083.17.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455  
	9	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com><1084578453.5 3
	4	 3.	26.camel@patibmrh9><1084579362.3271.5.camel@patibmrh9> <40A5669B.608
	010	8@pobox.com><1084626376.3079.8.camel@patibmrh9> <1084628978.5082.7.ca m
	el@patibmrh9><40A636D2.3090205@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=-M4V3MdHjKouMaDL/w0JJ"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:50426 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264635AbUEOPuF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 11:50:05 -0400
In-Reply-To: <40A636D2.3090205@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--=-M4V3MdHjKouMaDL/w0JJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > Success! ...
> ...
> Does this mean you actually got ATAPI to work?

I mean to say, I have seen:

$ sudo modprobe ata-piix
$ sudo modprobe -r ata-piix
$

despite having plugged in an Si 3611CT80 1.4 SATA DVD and having turned
on libata.h ATA_ENABLE_ATAPI.

In particular, my /var/log/messages now include:

kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 24 00 00 00 46
kernel: ata_scsi_translate: ENTER
kernel: ata_sg_setup_one: mapped buffer of 36 bytes for read
kernel: ata_fill_sg: PRD[0] = (0x46EE54, 0x24)
kernel: ata_dev_select: ENTER, ata2: device 0, wait 1
kernel: ata_tf_load_pio: feat 0x5 nsect 0x0 lba 0x0 0x0 0x0
kernel: ata_tf_load_pio: device 0xA0
kernel: ata_exec_command_pio: ata2: cmd 0xA0
kernel: ata_scsi_translate: EXIT
kernel: atapi_packet_task: busy wait
kernel: atapi_packet_task: send cdb
kernel: ata_host_intr: BUS_DMA (host_stat 0x24)
kernel: ata_dma_complete: ENTER
kernel: ata_dma_complete: host 2, host_stat==0x24, drv_stat==0x50
kernel: ata_sg_clean: unmapping 1 sg elements
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 c0 00 00 00 46
kernel: ata_scsi_translate: ENTER
kernel: ata_sg_setup_one: mapped buffer of 192 bytes for read
kernel: ata_fill_sg: PRD[0] = (0x46EE54, 0xC0)
kernel: ata_dev_select: ENTER, ata2: device 0, wait 1
kernel: ata_tf_load_pio: feat 0x5 nsect 0x0 lba 0x0 0x0 0x0
kernel: ata_tf_load_pio: device 0xA0
kernel: ata_exec_command_pio: ata2: cmd 0xA0
kernel: ata_scsi_translate: EXIT
kernel: atapi_packet_task: busy wait
kernel: atapi_packet_task: send cdb
kernel: ata_host_intr: BUS_DMA (host_stat 0x24)
kernel: ata_dma_complete: ENTER
kernel: ata_dma_complete: host 2, host_stat==0x24, drv_stat==0x50
kernel: ata_sg_clean: unmapping 1 sg elements
kernel:   Vendor: Iomega    Model: RRD               Rev: 74.B
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 00
kernel: ata_scsi_dump_cdb: CDB (2:0,1,0) 12 00 00 00 24 00 00 00 46

> Or just that we made progress?

Yes I have three or more new troubles to report, I will reply again.

Meanwhile, attached to this e-mail is the last composite patch I tried.

This should match your patch [1234567] except then also it has the
dmadir revised as Bartlomiej and I discussed in "Re: [PATCH] libata-core
when not ata_id_use_dmadir despite yes Silicon Image".

Pat LaVarre

P.S. (-: Wow.  Always an emotionally powerful moment for me when someone
tells me I'm not talking enough. :-)

diff -Nurp linux-2.6.6-bk2/include/linux/ata.h linux-2.6.6-bk1-pel/include/linux/ata.h
--- linux-2.6.6-bk2/include/linux/ata.h	2004-05-15 08:43:05.677175640 -0600
+++ linux-2.6.6-bk1-pel/include/linux/ata.h	2004-05-15 08:41:04.368617344 -0600
@@ -134,6 +134,8 @@ enum {
 
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
+	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
+						   0=to device, 1=to host */
 
 	/* cable types */
 	ATA_CBL_NONE		= 0,
diff -Nurp linux-2.6.6-bk2/include/linux/libata.h linux-2.6.6-bk1-pel/include/linux/libata.h
--- linux-2.6.6-bk2/include/linux/libata.h	2004-05-15 08:43:05.692173360 -0600
+++ linux-2.6.6-bk1-pel/include/linux/libata.h	2004-05-15 08:40:52.197467640 -0600
@@ -335,6 +335,7 @@ struct ata_port_operations {
 	void (*phy_reset) (struct ata_port *ap);
 	void (*post_set_mode) (struct ata_port *ap);
 
+	void (*bmdma_setup) (struct ata_queued_cmd *qc);
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
 	void (*fill_sg) (struct ata_queued_cmd *qc);
 	void (*eng_timeout) (struct ata_port *ap);
@@ -397,7 +398,9 @@ extern int ata_port_start (struct ata_po
 extern void ata_port_stop (struct ata_port *ap);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_fill_sg(struct ata_queued_cmd *qc);
+extern void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_mmio (struct ata_queued_cmd *qc);
+extern void ata_bmdma_setup_pio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_pio (struct ata_queued_cmd *qc);
 extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat, unsigned int done_late);
@@ -473,6 +481,13 @@ static inline u8 ata_wait_idle(struct at
 	return status;
 }
 
+static inline void ata_qc_set_polling(struct ata_queued_cmd *qc)
+{
+	qc->flags |= ATA_QCFLAG_POLL;
+	qc->flags &= ~ATA_QCFLAG_DMA;
+	qc->tf.ctl |= ATA_NIEN;
+}
+
 static inline struct ata_queued_cmd *ata_qc_from_tag (struct ata_port *ap,
 						      unsigned int tag)
 {
diff -Nurp linux-2.6.6-bk2/drivers/scsi/libata-core.c linux-2.6.6-bk1-pel/drivers/scsi/libata-core.c
--- linux-2.6.6-bk2/drivers/scsi/libata-core.c	2004-05-15 08:43:03.928441488 -0600
+++ linux-2.6.6-bk1-pel/drivers/scsi/libata-core.c	2004-05-15 08:40:40.017319304 -0600
@@ -2396,16 +2396,18 @@ int ata_qc_issue(struct ata_queued_cmd *
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
@@ -2445,17 +2447,28 @@ static int ata_qc_issue_prot(struct ata_
 
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
@@ -2465,14 +2478,14 @@ static int ata_qc_issue_prot(struct ata_
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
@@ -2496,8 +2509,24 @@ void ata_bmdma_start_mmio (struct ata_qu
 
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
@@ -2514,14 +2543,14 @@ void ata_bmdma_start_mmio (struct ata_qu
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
@@ -2544,8 +2573,23 @@ void ata_bmdma_start_pio (struct ata_que
 
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
@@ -2620,6 +2664,7 @@ inline unsigned int ata_host_intr (struc
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
+	case ATA_PROT_ATAPI_DMA:
 		if (ap->flags & ATA_FLAG_MMIO) {
 			void *mmio = (void *) ap->ioaddr.bmdma_addr;
 			host_stat = readb(mmio + ATA_DMA_STATUS);
@@ -2755,20 +2800,6 @@ static unsigned long ata_thread_iter(str
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
@@ -2811,7 +2842,7 @@ static void atapi_packet_task(void *_dat
 
 	/* if we are DMA'ing, irq handler takes over from here */
 	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
-		/* FIXME: start DMA here */
+		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
 	} else {
 		ap->pio_task_state = PIO_ST;
 		queue_work(ata_wq, &ap->pio_task);
@@ -3475,7 +3506,9 @@ EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_fill_sg);
+EXPORT_SYMBOL_GPL(ata_bmdma_setup_pio);
 EXPORT_SYMBOL_GPL(ata_bmdma_start_pio);
+EXPORT_SYMBOL_GPL(ata_bmdma_setup_mmio);
 EXPORT_SYMBOL_GPL(ata_bmdma_start_mmio);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
diff -Nurp linux-2.6.6-bk2/drivers/scsi/libata-scsi.c linux-2.6.6-bk1-pel/drivers/scsi/libata-scsi.c
--- linux-2.6.6-bk2/drivers/scsi/libata-scsi.c	2004-05-15 08:43:03.930441184 -0600
+++ linux-2.6.6-bk1-pel/drivers/scsi/libata-scsi.c	2004-05-15 08:40:25.263562216 -0600
@@ -885,53 +885,20 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
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
 
@@ -943,17 +910,21 @@ static void atapi_scsi_queuecmd(struct a
 
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
+		if (cmd->sc_data_direction != SCSI_DATA_WRITE)
+			qc->tf.feature |= ATAPI_DMADIR;
 	}
 
-	atapi_start(qc);
+	return 0;
 }
 
 /**
@@ -1092,7 +1063,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 		else
 			ata_scsi_simulate(ap, dev, cmd, done);
 	} else
-		atapi_scsi_queuecmd(ap, dev, cmd, done);
+		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
 out_unlock:
 	return 0;


--=-M4V3MdHjKouMaDL/w0JJ
Content-Disposition: attachment; filename=pel.patch.1234567
Content-Type: text/x-patch; name=pel.patch.1234567; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Nurp linux-2.6.6-bk2/include/linux/ata.h linux-2.6.6-bk1-pel/include/linux/ata.h
--- linux-2.6.6-bk2/include/linux/ata.h	2004-05-15 08:43:05.677175640 -0600
+++ linux-2.6.6-bk1-pel/include/linux/ata.h	2004-05-15 08:41:04.368617344 -0600
@@ -134,6 +134,8 @@ enum {
 
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
+	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
+						   0=to device, 1=to host */
 
 	/* cable types */
 	ATA_CBL_NONE		= 0,
diff -Nurp linux-2.6.6-bk2/include/linux/libata.h linux-2.6.6-bk1-pel/include/linux/libata.h
--- linux-2.6.6-bk2/include/linux/libata.h	2004-05-15 08:43:05.692173360 -0600
+++ linux-2.6.6-bk1-pel/include/linux/libata.h	2004-05-15 08:40:52.197467640 -0600
@@ -335,6 +335,7 @@ struct ata_port_operations {
 	void (*phy_reset) (struct ata_port *ap);
 	void (*post_set_mode) (struct ata_port *ap);
 
+	void (*bmdma_setup) (struct ata_queued_cmd *qc);
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
 	void (*fill_sg) (struct ata_queued_cmd *qc);
 	void (*eng_timeout) (struct ata_port *ap);
@@ -397,7 +398,9 @@ extern int ata_port_start (struct ata_po
 extern void ata_port_stop (struct ata_port *ap);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_fill_sg(struct ata_queued_cmd *qc);
+extern void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_mmio (struct ata_queued_cmd *qc);
+extern void ata_bmdma_setup_pio (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start_pio (struct ata_queued_cmd *qc);
 extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat, unsigned int done_late);
@@ -473,6 +481,13 @@ static inline u8 ata_wait_idle(struct at
 	return status;
 }
 
+static inline void ata_qc_set_polling(struct ata_queued_cmd *qc)
+{
+	qc->flags |= ATA_QCFLAG_POLL;
+	qc->flags &= ~ATA_QCFLAG_DMA;
+	qc->tf.ctl |= ATA_NIEN;
+}
+
 static inline struct ata_queued_cmd *ata_qc_from_tag (struct ata_port *ap,
 						      unsigned int tag)
 {
diff -Nurp linux-2.6.6-bk2/drivers/scsi/libata-core.c linux-2.6.6-bk1-pel/drivers/scsi/libata-core.c
--- linux-2.6.6-bk2/drivers/scsi/libata-core.c	2004-05-15 08:43:03.928441488 -0600
+++ linux-2.6.6-bk1-pel/drivers/scsi/libata-core.c	2004-05-15 08:40:40.017319304 -0600
@@ -2396,16 +2396,18 @@ int ata_qc_issue(struct ata_queued_cmd *
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
@@ -2445,17 +2447,28 @@ static int ata_qc_issue_prot(struct ata_
 
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
@@ -2465,14 +2478,14 @@ static int ata_qc_issue_prot(struct ata_
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
@@ -2496,8 +2509,24 @@ void ata_bmdma_start_mmio (struct ata_qu
 
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
@@ -2514,14 +2543,14 @@ void ata_bmdma_start_mmio (struct ata_qu
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
@@ -2544,8 +2573,23 @@ void ata_bmdma_start_pio (struct ata_que
 
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
@@ -2620,6 +2664,7 @@ inline unsigned int ata_host_intr (struc
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
+	case ATA_PROT_ATAPI_DMA:
 		if (ap->flags & ATA_FLAG_MMIO) {
 			void *mmio = (void *) ap->ioaddr.bmdma_addr;
 			host_stat = readb(mmio + ATA_DMA_STATUS);
@@ -2755,20 +2800,6 @@ static unsigned long ata_thread_iter(str
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
@@ -2811,7 +2842,7 @@ static void atapi_packet_task(void *_dat
 
 	/* if we are DMA'ing, irq handler takes over from here */
 	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
-		/* FIXME: start DMA here */
+		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
 	} else {
 		ap->pio_task_state = PIO_ST;
 		queue_work(ata_wq, &ap->pio_task);
@@ -3475,7 +3506,9 @@ EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_fill_sg);
+EXPORT_SYMBOL_GPL(ata_bmdma_setup_pio);
 EXPORT_SYMBOL_GPL(ata_bmdma_start_pio);
+EXPORT_SYMBOL_GPL(ata_bmdma_setup_mmio);
 EXPORT_SYMBOL_GPL(ata_bmdma_start_mmio);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
diff -Nurp linux-2.6.6-bk2/drivers/scsi/libata-scsi.c linux-2.6.6-bk1-pel/drivers/scsi/libata-scsi.c
--- linux-2.6.6-bk2/drivers/scsi/libata-scsi.c	2004-05-15 08:43:03.930441184 -0600
+++ linux-2.6.6-bk1-pel/drivers/scsi/libata-scsi.c	2004-05-15 08:40:25.263562216 -0600
@@ -885,53 +885,20 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
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
 
@@ -943,17 +910,21 @@ static void atapi_scsi_queuecmd(struct a
 
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
+		if (cmd->sc_data_direction != SCSI_DATA_WRITE)
+			qc->tf.feature |= ATAPI_DMADIR;
 	}
 
-	atapi_start(qc);
+	return 0;
 }
 
 /**
@@ -1092,7 +1063,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 		else
 			ata_scsi_simulate(ap, dev, cmd, done);
 	} else
-		atapi_scsi_queuecmd(ap, dev, cmd, done);
+		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
 out_unlock:
 	return 0;

--=-M4V3MdHjKouMaDL/w0JJ--

