From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH 1/3] libata - Use PIO mode for request sense
Date: Wed, 15 Dec 2004 17:45:19 +0800
Message-ID: <003001c4e28a$d0b19640$f17a4109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002D_01C4E2CD.D8319E40"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:25071 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262312AbULOJpf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Dec 2004 04:45:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.

------=_NextPart_000_002D_01C4E2CD.D8319E40
Content-Type: text/plain;
	charset="big5"
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
  Attached please find the resent patch for change #1 to use PIO mode for request sense
(the patch is against libata-dev-2.6 tree).

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-core.c libata-dev-2.6/drivers/scsi/libata-core.c
--- libata-dev-2.6-ori/drivers/scsi/libata-core.c 2004-11-30 12:52:28.000000000 +0800
+++ libata-dev-2.6/drivers/scsi/libata-core.c 2004-12-15 16:03:24.776409226 +0800
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
------=_NextPart_000_002D_01C4E2CD.D8319E40
Content-Type: application/octet-stream;
	name="request_sense.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="request_sense.patch"

diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-core.c =
libata-dev-2.6/drivers/scsi/libata-core.c=0A=
--- libata-dev-2.6-ori/drivers/scsi/libata-core.c	2004-11-30 =
12:52:28.000000000 +0800=0A=
+++ libata-dev-2.6/drivers/scsi/libata-core.c	2004-12-15 =
16:03:24.776409226 +0800=0A=
@@ -2435,7 +2435,6 @@=0A=
 	DECLARE_COMPLETION(wait);=0A=
 	struct ata_queued_cmd *qc;=0A=
 	unsigned long flags;=0A=
-	int using_pio =3D dev->flags & ATA_DFLAG_PIO;=0A=
 	int rc;=0A=
 =0A=
 	DPRINTK("ATAPI request sense\n");=0A=
@@ -2456,16 +2455,10 @@=0A=
 	qc->tf.flags |=3D ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;=0A=
 	qc->tf.command =3D ATA_CMD_PACKET;=0A=
 =0A=
-	if (using_pio) {=0A=
-		qc->tf.protocol =3D ATA_PROT_ATAPI;=0A=
-		qc->tf.lbam =3D (8 * 1024) & 0xff;=0A=
-		qc->tf.lbah =3D (8 * 1024) >> 8;=0A=
-=0A=
-		qc->nbytes =3D SCSI_SENSE_BUFFERSIZE;=0A=
-	} else {=0A=
-		qc->tf.protocol =3D ATA_PROT_ATAPI_DMA;=0A=
-		qc->tf.feature |=3D ATAPI_PKT_DMA;=0A=
-	}=0A=
+	qc->tf.protocol =3D ATA_PROT_ATAPI;=0A=
+	qc->tf.lbam =3D (8 * 1024) & 0xff;=0A=
+	qc->tf.lbah =3D (8 * 1024) >> 8;=0A=
+	qc->nbytes =3D SCSI_SENSE_BUFFERSIZE;=0A=
 =0A=
 	qc->waiting =3D &wait;=0A=
 	qc->complete_fn =3D ata_qc_complete_noop;=0A=

------=_NextPart_000_002D_01C4E2CD.D8319E40--

