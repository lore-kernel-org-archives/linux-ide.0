From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata atapi work #3
Date: Thu, 13 May 2004 21:34:34 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A4222A.7020403@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060902080901080600070207"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63697 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264373AbUENBes
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 May 2004 21:34:48 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Pat LaVarre <p.lavarre@ieee.org>

This is a multi-part message in MIME format.
--------------060902080901080600070207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------060902080901080600070207
Content-Type: text/plain;
 name="patch.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.3"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/13 21:26:59-04:00 jgarzik@redhat.com 
#   [libata] more ATAPI work - translate SCSI CDB to ATA PACKET
#   
#   Now that we can specify ATAPI as a taskfile protocol, we can utilize
#   the existing SCSI->ATA translation infrastructure to build an ATA
#   PACKET command quickly and easily.
# 
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Thu May 13 21:28:26 2004
+++ b/drivers/scsi/libata-core.c	Thu May 13 21:28:26 2004
@@ -2794,20 +2794,6 @@
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
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	Thu May 13 21:28:26 2004
+++ b/drivers/scsi/libata-scsi.c	Thu May 13 21:28:26 2004
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
 
@@ -943,17 +910,20 @@
 
 	qc->tf.command = ATA_CMD_PACKET;
 
-	if (cmd->sc_data_direction == SCSI_DATA_NONE) {
-		qc->tf.protocol = ATA_PROT_ATAPI;
+	if ((cmd->sc_data_direction == SCSI_DATA_NONE) ||
+	    ((qc->flags & ATA_QCFLAG_DMA) == 0)) {
 		qc->flags |= ATA_QCFLAG_POLL;
+		qc->tf.protocol = ATA_PROT_ATAPI;
 		qc->tf.ctl |= ATA_NIEN;	/* disable interrupts */
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
@@ -1092,7 +1062,7 @@
 		else
 			ata_scsi_simulate(ap, dev, cmd, done);
 	} else
-		atapi_scsi_queuecmd(ap, dev, cmd, done);
+		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
 out_unlock:
 	return 0;
diff -Nru a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h	Thu May 13 21:28:26 2004
+++ b/drivers/scsi/libata.h	Thu May 13 21:28:26 2004
@@ -44,7 +44,6 @@
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void ata_tf_to_host_nolock(struct ata_port *ap, struct ata_taskfile *tf);
-extern void atapi_start(struct ata_queued_cmd *qc);
 
 
 /* libata-scsi.c */

--------------060902080901080600070207--

