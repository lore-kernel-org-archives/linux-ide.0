From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 12 May 2004 17:14:14 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084403654.3196.31.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:7630 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263169AbUELXOj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 May 2004 19:14:39 -0400
In-Reply-To: <40A28BB6.7090204@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jeff G:

> decent first step ...
> Good guess ...
> ..
> [1] not sure you should bother ...
> [2] don't use ifdef, test ATA_QCFLAG_DMA ...
> [3] for DMA, ... zero
> [4] for PIO, ... 8K (one SATA FIS) ...
> [5] eliminate the dev->class test ...
> [6] modify ata_get_xlat_func
> to return atapi_xlat when dev->class == ATAPI

Changes complete as requested, I hope, in the new patch inline.

> > -	VPRINTK("ENTER, drv_stat = 0x%x\n", ata_chk_status(ap));
> > ...
> > -	atapi_start(qc);
>
> Note that by deleting this, there is no
> longer anything to start the ATAPI transfer
> really.

Aye, the dmesg tell me I'm timing out with command incomplete.

> You must the latter half of the above code
> [the part you are deleting] either to
> ata_qc_issue_prot() or your new atapi_xlat().

The dmesg tell me my guess below of how to do this actually ended up
writing the x1F7 Command = xA0 Packet twice, whoops.

Please choose for me from:

1) Keep only the atapi_start/ ata_tf_to_host_nolock/
ata_exec_command_pio.

2) Keep only the worker_thread/ atapi_packet_task/ ata_bmdma_start_pio/
ata_exec_command_pio.

3) Try something else entirely.

> drivers/ide and Hale Landis's ATADRVR
> (http://www.ata-atapi.com/) for comparing IO
> write-for-write, to make sure I have the steps
> and the state machine correct.  And of course
> the state machine docs itself, in ATA/ATAPI7.

Yes.  Myself, I have experience making Dos talk UDMA, a PATA bus
analyser on my desk, and intermittent access to a SATA bus analyser.

> you need to make sure your ATAPI device
> supports ultra DMA,

Please tell me if you want more evidence.

The paper that accompanied my (Silicon Image 3611CT80 1.5) SATA/ PATA
bridge tells me it talks UDMA "66, 100, 133 and 150" Mb/s though not
UDMA 33/ MWDMA/ SWMA.

I remember the paper that accompanied my PATA device tells me it talks
at least UDMA 4, maybe actually UDMA 5.  I know I have myself seen this
device sustain about 1.5 GB/min = 25 MB/s.  I could reboot to quote its
op xEC Identify "word"s any time we like.

> as you don't want
> to bother with PIO or [SM]WDMA right now.

I'm happy starting with SATA PIO, if you like that better.

I do eventually want to talk SATA UDMA because I hope to end by
achieving burst rates more like the 133 MB/s of UDMA, well above the
16.7 MB/s limit of PATA PIO 4.

For ATAPI myself I recommend DMA only for well-known block ops, in order
to get the exact byte counting of PIO otherwise.

> > modprobe -r ata-piix
> > modprobe ata-piix

modprobe's still mostly work, but depending on my patch, I see that
`modprobe ata-piix` may appear to halt my kernel with the HDD activity
light lit after the dmesg:

ata_bus_reset: ENTER, host 2, port 1
ata_bus_softreset: ata2: bus reset via SRST

Pat LaVarre

diff -Nurp linux-2.6.6-bk1/drivers/scsi/libata-core.c linux-2.6.6-bk1-pel/drivers/scsi/libata-core.c
--- linux-2.6.6-bk1/drivers/scsi/libata-core.c	2004-05-12 09:57:09.000000000 -0600
+++ linux-2.6.6-bk1-pel/drivers/scsi/libata-core.c	2004-05-12 16:32:20.000000000 -0600
@@ -245,6 +245,9 @@ void ata_tf_load_mmio(struct ata_port *a
 void ata_exec_command_pio(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
+if (tf->command == 0xA0) {
+	dump_stack();
+}
 
        	outb(tf->command, ap->ioaddr.command_addr);
 	ata_pause(ap);
@@ -2438,6 +2441,7 @@ static int ata_qc_issue_prot(struct ata_
 
 	ata_dev_select(ap, qc->dev->devno, 1, 0);
 
+	DPRINTK("qc->tf.protocol = %d\n", qc->tf.protocol);
 	switch (qc->tf.protocol) {
 	case ATA_PROT_NODATA:
 		ata_tf_to_host_nolock(ap, &qc->tf);
@@ -2456,6 +2460,12 @@ static int ata_qc_issue_prot(struct ata_
 		queue_work(ata_wq, &ap->pio_task);
 		break;
 
+	case ATA_PROT_ATAPI_DMA:
+		atapi_start(qc);
+		break;
+
+	case ATA_PROT_ATAPI:
+		DPRINTK("Assertion fail: qc->tf.protocol != ATA_PROT_ATAPI\n");
 	default:
 		WARN_ON(1);
 		return -1;
@@ -2812,6 +2822,9 @@ static void atapi_packet_task(void *_dat
 	/* if we are DMA'ing, irq handler takes over from here */
 	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
 		/* FIXME: start DMA here */
+		DPRINTK("before bmdma_start\n");
+		ap->ops->bmdma_start(qc);
+		DPRINTK("after bmdma_start\n");
 	} else {
 		ap->pio_task_state = PIO_ST;
 		queue_work(ata_wq, &ap->pio_task);
diff -Nurp linux-2.6.6-bk1/drivers/scsi/libata-scsi.c linux-2.6.6-bk1-pel/drivers/scsi/libata-scsi.c
--- linux-2.6.6-bk1/drivers/scsi/libata-scsi.c	2004-05-12 09:57:09.000000000 -0600
+++ linux-2.6.6-bk1-pel/drivers/scsi/libata-scsi.c	2004-05-12 15:51:10.000000000 -0600
@@ -215,6 +215,45 @@ int ata_scsi_error(struct Scsi_Host *hos
 
 	DPRINTK("EXIT\n");
 	return 0;
+} 
+
+/**
+ *	atapi_xlat - Pass SCSI r/w command thru to ATAPI
+ *	@qc: Storage for translated ATA taskfile
+ *	@scsicmd: SCSI command to translate
+ *
+ *	Trust caller already cleared *qc->tf (often via ata_tf_init),
+ *	deciding tf->device & (0x10 ATA_DEV1 | 0x07 SFF 8070i LUN), etc.
+ *
+ *	Choose ATAPI PIO BCL from:
+ *
+ *		0x2000 = 8 Ki = one SATA FIS
+ *		0xFFFE = largest specified in oldest public docs
+ *		0xFFFF = first massively distributed (Win 95B)
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on error.
+ */
+
+static unsigned int atapi_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
+{
+	int bcl = (8 * 0x400); /* PIO "byte count limit" */
+	struct ata_taskfile *tf = &qc->tf;
+	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf->protocol = qc->dev->xfer_protocol;
+	tf->command = ATA_CMD_PACKET; /* often 0xA0 */
+	if (qc->flags & ATA_QCFLAG_DMA) {
+		DPRINTK("DMA ATAPI 0x%lX %d\n", qc->flags, qc->tf.protocol);
+		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
+		tf->feature = ATAPI_PKT_DMA; /* often x01 */
+	} else {
+		DPRINTK("PIO ATAPI 0x%lX %d\n", qc->flags, qc->tf.protocol);
+		qc->tf.protocol = ATA_PROT_ATAPI;
+		tf->lbam = bcl >> 8;
+		tf->lbah = bcl;
+	}
+	qc->flags |= ATA_QCFLAG_ATAPI;
+	return 0;
 }
 
 /**
@@ -885,78 +924,6 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
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
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-static void atapi_scsi_queuecmd(struct ata_port *ap, struct ata_device *dev,
-			       struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
-{
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
-
-	qc->flags |= ATA_QCFLAG_ATAPI;
-
-	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	if (cmd->sc_data_direction == SCSI_DATA_WRITE) {
-		qc->tf.flags |= ATA_TFLAG_WRITE;
-		DPRINTK("direction: write\n");
-	}
-
-	qc->tf.command = ATA_CMD_PACKET;
-
-	if (cmd->sc_data_direction == SCSI_DATA_NONE) {
-		qc->tf.protocol = ATA_PROT_ATAPI;
-		qc->flags |= ATA_QCFLAG_POLL;
-		qc->tf.ctl |= ATA_NIEN;	/* disable interrupts */
-	} else {
-		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
-		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
-		qc->tf.feature |= ATAPI_PKT_DMA;
-	}
-
-	atapi_start(qc);
-}
-
-/**
  *	ata_scsi_find_dev - lookup ata_device from scsi_cmnd
  *	@ap: ATA port to which the device is attached
  *	@cmd: SCSI command to be sent to the device
@@ -1010,8 +977,12 @@ ata_scsi_find_dev(struct ata_port *ap, s
  *	Pointer to translation function if possible, %NULL if not.
  */
 
-static inline ata_xlat_func_t ata_get_xlat_func(u8 cmd)
+static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 {
+	if (dev->class == ATA_DEV_ATAPI) { /* (thus != ATA_DEV_ATAPI_UNSUP) */
+		return atapi_xlat;
+	}
+
 	switch (cmd) {
 	case READ_6:
 	case READ_10:
@@ -1072,6 +1043,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 {
 	struct ata_port *ap;
 	struct ata_device *dev;
+	ata_xlat_func_t xlat_func;
 
 	ap = (struct ata_port *) &cmd->device->host->hostdata[0];
 
@@ -1084,15 +1056,11 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 		goto out_unlock;
 	}
 
-	if (dev->class == ATA_DEV_ATA) {
-		ata_xlat_func_t xlat_func = ata_get_xlat_func(cmd->cmnd[0]);
-
-		if (xlat_func)
-			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
-		else
-			ata_scsi_simulate(ap, dev, cmd, done);
-	} else
-		atapi_scsi_queuecmd(ap, dev, cmd, done);
+	xlat_func = ata_get_xlat_func(dev, cmd->cmnd[0]);
+	if (xlat_func)
+		ata_scsi_translate(ap, dev, cmd, done, xlat_func);
+	else
+		ata_scsi_simulate(ap, dev, cmd, done);
 
 out_unlock:
 	return 0;


