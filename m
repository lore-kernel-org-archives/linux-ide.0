From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata: Use ATAPI PIO mode for specific request buffer sizes
Date: Fri, 3 Dec 2004 15:18:04 +0800
Message-ID: <002701c4d908$40740e90$be4d4109@tw.ibm.com>
References: <00ce01c4d6b8$d222d080$bc604109@tw.ibm.com> <41AEFAA4.80907@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0024_01C4D94B.48F1B070"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:9714 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261813AbULCHT2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Dec 2004 02:19:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.

------=_NextPart_000_0024_01C4D94B.48F1B070
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi, Jeff:

> > ..
> > Two changes:
> > 1. Use ATAPI PIO mode for ATAPI REQUEST_SENSE
> > 2. Use ATAPI PIO mode for specific SCSI commands issued to ATAPI device that
> >     buffer_size % 256 != 0.
> > 
> >   Since for most commands, buffer_size % 256 is 0,  this patch
> > won't introduce big impact to the performance of libata (hopefully).
> >   
> >   Tested OK on on my machine with pdc20275 and ASUS CD-RW drive.
> 
> hmmmmmmm.
> 
> Your change #1 makes perfect sense, and I agree it is the safer (and 
> more simple) route.
> 
> I must ponder change #2 some more (after some sleep :)).  In particular, 
> I am concerned that making change #2 across all controllers will hurt 
> performance on the commands whose data length is not purely sector-sized 
> chunks.
> 
> Would you mind splitting up change #1 and #2 into separate patches?
> 

  Attached please find the request sense patch for change #1 (the patch is against 
libata-dev-2.6 tree).

  For change #2, agreed the previous patch is problematic since it will impact all 
adapters and the buffer_size % 256 rule might also fail for other host adapters. 

  How about let LLD provide a callback function such that libata core
can ask the LLD: "Which protocol do you like this command to be processed? " or
"Can this command be processed in ATAPI DMA mode reliably? " 
when the the command is received?

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
-----------------------------------------------------------------------------------------------------------
diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-core.c libata-dev-2.6/drivers/scsi/libata-core.c
--- libata-dev-2.6-ori/drivers/scsi/libata-core.c 2004-11-30 12:52:28.000000000 +0800
+++ libata-dev-2.6/drivers/scsi/libata-core.c 2004-11-30 13:49:36.000000000 +0800
@@ -2435,7 +2435,6 @@
  DECLARE_COMPLETION(wait);
  struct ata_queued_cmd *qc;
  unsigned long flags;
- int using_pio = dev->flags & ATA_DFLAG_PIO;
  int rc;
 
  DPRINTK("ATAPI request sense\n");
@@ -2456,16 +2455,10 @@
  qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
  qc->tf.command = ATA_CMD_PACKET;
 
- if (using_pio) {
-  qc->tf.protocol = ATA_PROT_ATAPI;
-  qc->tf.lbam = (8 * 1024) & 0xff;
-  qc->tf.lbah = (8 * 1024) >> 8;
-
-  qc->nbytes = SCSI_SENSE_BUFFERSIZE;
- } else {
-  qc->tf.protocol = ATA_PROT_ATAPI_DMA;
-  qc->tf.feature |= ATAPI_PKT_DMA;
- }
+ qc->tf.protocol = ATA_PROT_ATAPI;
+ qc->tf.lbam = (8 * 1024) & 0xff;
+ qc->tf.lbah = (8 * 1024) >> 8;
+ qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
  qc->waiting = &wait;
  qc->complete_fn = ata_qc_complete_noop;


------=_NextPart_000_0024_01C4D94B.48F1B070
Content-Type: application/octet-stream;
	name="request_sense.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="request_sense.patch"

diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-core.c libata-dev-2.6/drivers/scsi/libata-core.c
--- libata-dev-2.6-ori/drivers/scsi/libata-core.c	2004-11-30 12:52:28.000000000 +0800
+++ libata-dev-2.6/drivers/scsi/libata-core.c	2004-11-30 13:49:36.000000000 +0800
@@ -2435,7 +2435,6 @@
 	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
-	int using_pio = dev->flags & ATA_DFLAG_PIO;
 	int rc;
 
 	DPRINTK("ATAPI request sense\n");
@@ -2456,16 +2455,10 @@
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	qc->tf.command = ATA_CMD_PACKET;
 
-	if (using_pio) {
-		qc->tf.protocol = ATA_PROT_ATAPI;
-		qc->tf.lbam = (8 * 1024) & 0xff;
-		qc->tf.lbah = (8 * 1024) >> 8;
-
-		qc->nbytes = SCSI_SENSE_BUFFERSIZE;
-	} else {
-		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
-		qc->tf.feature |= ATAPI_PKT_DMA;
-	}
+	qc->tf.protocol = ATA_PROT_ATAPI;
+	qc->tf.lbam = (8 * 1024) & 0xff;
+	qc->tf.lbah = (8 * 1024) >> 8;
+	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
 	qc->waiting = &wait;
 	qc->complete_fn = ata_qc_complete_noop;

------=_NextPart_000_0024_01C4D94B.48F1B070--

