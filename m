From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] libata atapi work #4
Date: Fri, 14 May 2004 14:26:33 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A50F59.8070109@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090903010306060505070504"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44213 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262009AbUENS0q
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 14:26:46 -0400
Received: from rdu74-153-143.nc.rr.com ([24.74.153.143] helo=pobox.com)
	by www.linux.org.uk with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.33)
	id 1BOhOQ-0001Zu-25
	for linux-ide@vger.kernel.org; Fri, 14 May 2004 19:26:46 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090903010306060505070504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

attached.

--------------090903010306060505070504
Content-Type: text/plain;
 name="patch.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.4"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/13 22:39:17-04:00 jgarzik@redhat.com 
#   [libata] random minor bug fixes
#   
#   * Only call ata_sg_setup{_one} if ATA_QCFLAG_SG is set.  Preparation
#     for future use, as currently ATA_QCFLAG_SG is always set when
#     ata_qc_issue is called.
#   
#     This change in theory is incorrect for Promise TX/SX4 drivers,
#     since those drivers set up the Promise-specific packet in their
#     ->fill_sg hook, which is now called conditionally.
#   
#     A FIXME that doesn't affect anything, for now.
#   
#   * ATA_PROT_ATAPI and ATA_PROT_ATAPI_DMA command issue need to be
#     differentiated.
#   
#   * Create and use ata_qc_set_polling() to consistently set/clear the
#     flags associated with using polling instead of interrupts.
# 
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	Fri May 14 14:24:17 2004
+++ b/drivers/scsi/libata-core.c	Fri May 14 14:24:17 2004
@@ -2396,16 +2396,18 @@
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
@@ -2450,14 +2452,17 @@
 		break;
 
 	case ATA_PROT_PIO: /* load tf registers, initiate polling pio */
-		qc->flags |= ATA_QCFLAG_POLL;
-		qc->tf.ctl |= ATA_NIEN;	/* disable interrupts */
+		ata_qc_set_polling(qc);
 		ata_tf_to_host_nolock(ap, &qc->tf);
 		ap->pio_task_state = PIO_ST;
 		queue_work(ata_wq, &ap->pio_task);
 		break;
 
 	case ATA_PROT_ATAPI:
+		ata_tf_to_host_nolock(ap, &qc->tf);
+		queue_work(ata_wq, &ap->packet_task);
+		break;
+
 	case ATA_PROT_ATAPI_DMA:
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	Fri May 14 14:24:17 2004
+++ b/drivers/scsi/libata-scsi.c	Fri May 14 14:24:17 2004
@@ -912,9 +912,8 @@
 
 	if ((cmd->sc_data_direction == SCSI_DATA_NONE) ||
 	    ((qc->flags & ATA_QCFLAG_DMA) == 0)) {
-		qc->flags |= ATA_QCFLAG_POLL;
+		ata_qc_set_polling(qc);
 		qc->tf.protocol = ATA_PROT_ATAPI;
-		qc->tf.ctl |= ATA_NIEN;	/* disable interrupts */
 		qc->tf.lbam = (8 * 1024) & 0xff;
 		qc->tf.lbah = (8 * 1024) >> 8;
 	} else {
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	Fri May 14 14:24:17 2004
+++ b/include/linux/libata.h	Fri May 14 14:24:17 2004
@@ -481,6 +481,13 @@
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

--------------090903010306060505070504--

