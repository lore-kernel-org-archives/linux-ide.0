From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata atapi work #2.1
Date: Sat, 15 May 2004 18:12:51 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A695E3.6040707@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080007060807030604040402"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21929 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264758AbUEOWNH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 18:13:07 -0400
Received: from rdu74-153-143.nc.rr.com ([24.74.153.143] helo=pobox.com)
	by www.linux.org.uk with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.33)
	id 1BP7P0-0004jC-4i
	for linux-ide@vger.kernel.org; Sat, 15 May 2004 23:13:06 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080007060807030604040402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Patch based on libata 20040515-1 patch just posted.

Now that the previous patches are flushed into the for-upstream queue, 
this is the beginning of a new patch series.  To reduce confusion, all 
patches in this series are numbered 2.<n>.

If you have a bridge that requires DMADIR, you'll have to apply a 
variant of the DMADIR patch to get your setup working.



--------------080007060807030604040402
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# ChangeSet
#   2004/05/15 18:07:32-04:00 jgarzik@redhat.com 
#   [libata] handle non-data ATAPI commands via interrupt
#   
#   It's easier to do it this way, than polling, at the moment.
#   
#   Also, fix a test in ata_scsi_translate that was incorrectly
#   erroring-out non-data commands.
# 
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Sat May 15 18:09:46 2004
+++ b/drivers/scsi/libata-core.c	Sat May 15 18:09:46 2004
@@ -2677,6 +2677,7 @@
 		handled = 1;
 		break;
 
+	case ATA_PROT_ATAPI:
 	case ATA_PROT_NODATA:	/* command completion, but no data xfer */
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
@@ -2837,9 +2838,16 @@
 	      qc->scsicmd->cmnd, ap->host->max_cmd_len / 4);
 
 	/* if we are DMA'ing, irq handler takes over from here */
-	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
+	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
 		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
-	} else {
+
+	/* non-data commands are also handled via irq */
+	else if (qc->scsicmd->sc_data_direction == SCSI_DATA_NONE) {
+		/* do nothing */
+	}
+
+	/* PIO commands are handled by polling */
+	else {
 		ap->pio_task_state = PIO_ST;
 		queue_work(ata_wq, &ap->pio_task);
 	}
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	Sat May 15 18:09:46 2004
+++ b/drivers/scsi/libata-scsi.c	Sat May 15 18:09:46 2004
@@ -46,8 +46,8 @@
  *	@geom: location to which geometry will be output
  *
  *	Generic bios head/sector/cylinder calculator
- *	used by sd. Most BIOSes nowadays expect a XXX/255/16  (CHS) 
- *	mapping. Some situations may arise where the disk is not 
+ *	used by sd. Most BIOSes nowadays expect a XXX/255/16  (CHS)
+ *	mapping. Some situations may arise where the disk is not
  *	bootable if this is not used.
  *
  *	LOCKING:
@@ -57,7 +57,7 @@
  *	Zero.
  */
 int ata_std_bios_param(struct scsi_device *sdev, struct block_device *bdev,
-		       sector_t capacity, int geom[]) 
+		       sector_t capacity, int geom[])
 {
 	geom[0] = 255;
 	geom[1] = 63;
@@ -362,19 +362,20 @@
 
 	VPRINTK("ENTER\n");
 
-	if (unlikely(cmd->request_bufflen < 1)) {
-		printk(KERN_WARNING "ata%u(%u): empty request buffer\n",
-		       ap->id, dev->devno);
-		goto err_out;
-	}
-
 	qc = ata_scsi_qc_new(ap, dev, cmd, done);
 	if (!qc)
 		return;
 
 	if (cmd->sc_data_direction == SCSI_DATA_READ ||
-	    cmd->sc_data_direction == SCSI_DATA_WRITE)
+	    cmd->sc_data_direction == SCSI_DATA_WRITE) {
+		if (unlikely(cmd->request_bufflen < 1)) {
+			printk(KERN_WARNING "ata%u(%u): WARNING: zero len r/w req\n",
+			       ap->id, dev->devno);
+			goto err_out;
+		}
+
 		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
+	}
 
 	if (xlat_func(qc, scsicmd))
 		goto err_out;
@@ -910,12 +911,18 @@
 
 	qc->tf.command = ATA_CMD_PACKET;
 
-	if ((cmd->sc_data_direction == SCSI_DATA_NONE) ||
-	    ((qc->flags & ATA_QCFLAG_DMA) == 0)) {
+	/* no data - interrupt-driven */
+	if (cmd->sc_data_direction == SCSI_DATA_NONE)
+		qc->tf.protocol = ATA_PROT_ATAPI;
+
+	/* PIO data xfer - polling */
+	else if ((qc->flags & ATA_QCFLAG_DMA) == 0) {
 		ata_qc_set_polling(qc);
 		qc->tf.protocol = ATA_PROT_ATAPI;
 		qc->tf.lbam = (8 * 1024) & 0xff;
 		qc->tf.lbah = (8 * 1024) >> 8;
+
+	/* DMA data xfer - interrupt-driven */
 	} else {
 		qc->flags |= ATA_QCFLAG_SG; /* data is present; dma-map it */
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;

--------------080007060807030604040402--

