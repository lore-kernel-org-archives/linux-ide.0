From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/2] libata-2.6: Prevent the interrupt handler from completing
 a command twice
Date: Fri, 29 Apr 2005 17:34:59 +0800
Message-ID: <4271FFC3.5070403@tw.ibm.com>
References: <4271FE02.1080009@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020500030407020309060104"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:46568 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262191AbVD2JfX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Apr 2005 05:35:23 -0400
In-Reply-To: <4271FE02.1080009@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Jens Axboe <axboe@suse.de>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020500030407020309060104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Problem:
   During the libata CD-ROM stress test, sometimes the "BUG: timeout without command" error is seen.

Root cause:
  Unexpected interrupt occurs after the ata_qc_complete() is called, but before the SCSI error handler.
The interrupt handler is invoked before the SCSI error handler, and it clears the command by calling ata_qc_complete() again.
Later when the SCSI error handler is run, the ata_queued_cmd is already gone, causing the "BUG: timeout without command" error.

Changes:
  - Use the ATA_QCFLAG_ACTIVE flag to prevent the interrupt handler from completing the command twice,
    before the scsi_error_handler.

Attached please find the patch against the libata-2.6 tree
for your review. Thanks.


Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------020500030407020309060104
Content-Type: text/plain;
 name="timeout_without_command.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timeout_without_command.diff"

--- linux-2.6.11.7/drivers/scsi/libata-core.c	2005-04-08 02:57:08.000000000 +0800
+++ linux-2.6.11.7-twe/drivers/scsi/libata-core.c	2005-04-25 16:19:05.000000000 +0800
@@ -2539,7 +2539,7 @@
 	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
 	qc->dma_dir = DMA_FROM_DEVICE;
 
-	memset(&qc->cdb, 0, sizeof(ap->cdb_len));
+	memset(&qc->cdb, 0, ap->cdb_len);
 	qc->cdb[0] = REQUEST_SENSE;
 	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
 
@@ -2811,6 +2811,7 @@
 
 	/* call completion callback */
 	rc = qc->complete_fn(qc, drv_stat);
+	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -3229,7 +3230,8 @@
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+			if (qc && (!(qc->tf.ctl & ATA_NIEN)) &&
+			    (qc->flags & ATA_QCFLAG_ACTIVE))
 				handled |= ata_host_intr(ap, qc);
 		}
 	}

--------------020500030407020309060104--


