From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [libata] REQUEST_SENSE support for ATAPI
Date: Sat, 16 Oct 2004 01:06:49 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e0410151606566a6627@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.204]:14818 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267313AbUJOXGu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Oct 2004 19:06:50 -0400
Received: by mproxy.gmail.com with SMTP id 77so28332rnk
        for <linux-ide@vger.kernel.org>; Fri, 15 Oct 2004 16:06:50 -0700 (PDT)
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi,

It is quite different from your patch:
* uses ata_qc_issue()
* supports both DMA and PIO
* ->sense_buffer[] mangling dropped for now

Now libata works with ATAPI devices (yeah!)...
...unless PIO is used, then it fails in mysterious way.

Bartlomiej
--

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-10-16 00:52:33 +02:00
+++ b/drivers/scsi/libata-core.c	2004-10-16 00:52:33 +02:00
@@ -39,6 +39,7 @@
 #include <linux/workqueue.h>
 #include <scsi/scsi.h>
 #include "scsi.h"
+#include "scsi_priv.h"
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 #include <asm/io.h>
@@ -58,6 +59,7 @@
 				u8 *xfer_mode_out,
 				unsigned int *xfer_shift_out);
 static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat);
+static void __ata_qc_complete(struct ata_queued_cmd *qc);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -2395,6 +2397,59 @@
 	}
 }
 
+static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
+				struct scsi_cmnd *cmd)
+{
+	DECLARE_COMPLETION(wait);
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	int using_pio = dev->flags & ATA_DFLAG_PIO;
+	int rc;
+
+	DPRINTK("ATAPI request sense\n");
+
+	qc = ata_qc_new_init(ap, dev);
+	BUG_ON(qc == NULL);
+
+	/* FIXME: is this needed? */
+	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
+
+	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
+	qc->pci_dma_dir = PCI_DMA_FROMDEVICE;
+
+	memset(&qc->cdb, 0, sizeof(ap->cdb_len));
+	qc->cdb[0] = REQUEST_SENSE;
+	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
+
+	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	qc->tf.command = ATA_CMD_PACKET;
+
+	if (using_pio) {
+		qc->tf.protocol = ATA_PROT_ATAPI;
+		qc->tf.lbam = (8 * 1024) & 0xff;
+		qc->tf.lbah = (8 * 1024) >> 8;
+
+		qc->nbytes = SCSI_SENSE_BUFFERSIZE;
+	} else {
+		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
+		qc->tf.feature |= ATAPI_PKT_DMA;
+	}
+
+	qc->waiting = &wait;
+	qc->complete_fn = ata_qc_complete_noop;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (rc)
+		ata_port_disable(ap);
+	else
+		wait_for_completion(&wait);
+
+	DPRINTK("EXIT\n");
+}
+
 /**
  *	ata_qc_timeout - Handle timeout of queued command
  *	@qc: Command that timed out
@@ -2416,10 +2471,29 @@
 static void ata_qc_timeout(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_device *dev = qc->dev;
 	u8 host_stat = 0, drv_stat;
 
 	DPRINTK("ENTER\n");
 
+	/* FIXME: doesn't this conflict with timeout handling? */
+	if (qc->dev->class == ATA_DEV_ATAPI && qc->scsicmd) {
+		struct scsi_cmnd *cmd = qc->scsicmd;
+
+		if (!scsi_eh_eflags_chk(cmd, SCSI_EH_CANCEL_CMD)) {
+
+			/* finish completing original command */
+			__ata_qc_complete(qc);
+
+			atapi_request_sense(ap, dev, cmd);
+
+			cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
+			scsi_finish_command(cmd);
+
+			goto out;
+		}
+	}
+
 	/* hack alert!  We cannot use the supplied completion
 	 * function from inside the ->eh_strategy_handler() thread.
 	 * libata is the only user of ->eh_strategy_handler() in
@@ -2453,7 +2527,7 @@
 		ata_qc_complete(qc, drv_stat);
 		break;
 	}
-
+out:
 	DPRINTK("EXIT\n");
 }
 
@@ -2558,6 +2632,30 @@
 	return 0;
 }
 
+static void __ata_qc_complete(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned int tag, do_clear = 0;
+
+	qc->flags = 0;
+	tag = qc->tag;
+	if (likely(ata_tag_valid(tag))) {
+		if (tag == ap->active_tag)
+			ap->active_tag = ATA_TAG_POISON;
+		qc->tag = ATA_TAG_POISON;
+		do_clear = 1;
+	}
+
+	if (qc->waiting) {
+		struct completion *waiting = qc->waiting;
+		qc->waiting = NULL;
+		complete(waiting);
+	}
+
+	if (likely(do_clear))
+		clear_bit(tag, &ap->qactive);
+}
+
 /**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
@@ -2569,8 +2667,6 @@
 
 void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
 {
-	struct ata_port *ap = qc->ap;
-	unsigned int tag, do_clear = 0;
 	int rc;
 
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
@@ -2588,23 +2684,7 @@
 	if (rc != 0)
 		return;
 
-	qc->flags = 0;
-	tag = qc->tag;
-	if (likely(ata_tag_valid(tag))) {
-		if (tag == ap->active_tag)
-			ap->active_tag = ATA_TAG_POISON;
-		qc->tag = ATA_TAG_POISON;
-		do_clear = 1;
-	}
-
-	if (qc->waiting) {
-		struct completion *waiting = qc->waiting;
-		qc->waiting = NULL;
-		complete(waiting);
-	}
-
-	if (likely(do_clear))
-		clear_bit(tag, &ap->qactive);
+	__ata_qc_complete(qc);
 
 	VPRINTK("EXIT\n");
 }
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-10-16 00:52:33 +02:00
+++ b/drivers/scsi/libata-scsi.c	2004-10-16 00:52:33 +02:00
@@ -1412,9 +1412,15 @@
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
-	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
+	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
+		DPRINTK("request check condition\n");
+
 		cmd->result = SAM_STAT_CHECK_CONDITION;
-	else {
+
+		qc->scsidone(cmd);
+
+		return 1;
+	} else {
 		u8 *scsicmd = cmd->cmnd;
 
 		if (scsicmd[0] == INQUIRY) {
