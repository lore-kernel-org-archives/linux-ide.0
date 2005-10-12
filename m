From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/4] CHS: move the initialization of taskfile LBA flags (revise
 #6)
Date: Wed, 12 Oct 2005 15:04:18 +0800
Message-ID: <434CB572.6060900@tw.ibm.com>
References: <434CAF8E.5040607@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:29339 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932392AbVJLHE1
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Oct 2005 03:04:27 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j9C73A0d019092
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 03:03:10 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j9C74HlJ508946
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 01:04:17 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j9C74HlG009816
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 01:04:17 -0600
In-Reply-To: <434CAF8E.5040607@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Patch 1/4:

   move the initialization of taskfile LBA flags
     "ATA_TFLAG_LBA" and "ATA_TFLAG_LBA48 flags"
   to the SCSI translation functions

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

=============

--- upstream/drivers/scsi/libata-core.c	2005-10-11 11:40:03.000000000 +0800
+++ ch1/drivers/scsi/libata-core.c	2005-10-11 12:44:53.000000000 +0800
@@ -3195,13 +3195,6 @@ struct ata_queued_cmd *ata_qc_new_init(s
 		qc->nbytes = qc->curbytes = 0;
 
 		ata_tf_init(ap, &qc->tf, dev->devno);
-
-		if (dev->flags & ATA_DFLAG_LBA) {
-			qc->tf.flags |= ATA_TFLAG_LBA;
-
-			if (dev->flags & ATA_DFLAG_LBA48)
-				qc->tf.flags |= ATA_TFLAG_LBA48;
-		}
 	}
 
 	return qc;
--- upstream/drivers/scsi/libata-scsi.c	2005-10-11 11:40:03.000000000 +0800
+++ ch1/drivers/scsi/libata-scsi.c	2005-10-11 12:53:36.000000000 +0800
@@ -492,7 +492,7 @@ static unsigned int ata_scsi_flush_xlat(
 	tf->flags |= ATA_TFLAG_DEVICE;
 	tf->protocol = ATA_PROT_NODATA;
 
-	if ((tf->flags & ATA_TFLAG_LBA48) &&
+	if ((qc->dev->flags & ATA_DFLAG_LBA48) &&
 	    (ata_id_has_flush_ext(qc->dev->id)))
 		tf->command = ATA_CMD_FLUSH_EXT;
 	else
@@ -612,8 +612,6 @@ static unsigned int ata_scsi_verify_xlat
 {
 	struct ata_taskfile *tf = &qc->tf;
 	struct ata_device *dev = qc->dev;
-	unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
-	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
 	u64 dev_sectors = qc->dev->n_sectors;
 	u64 block;
 	u32 n_block;
@@ -634,16 +632,16 @@ static unsigned int ata_scsi_verify_xlat
 		goto out_of_range;
 	if ((block + n_block) > dev_sectors)
 		goto out_of_range;
-	if (lba48) {
-		if (n_block > (64 * 1024))
-			goto invalid_fld;
-	} else {
-		if (n_block > 256)
-			goto invalid_fld;
-	}
 
-	if (lba) {
-		if (lba48) {
+	if (dev->flags & ATA_DFLAG_LBA) {
+		tf->flags |= ATA_TFLAG_LBA;
+
+		if (dev->flags & ATA_DFLAG_LBA48) {
+			if (n_block > (64 * 1024))
+				goto invalid_fld;
+
+			/* use LBA48 */
+			tf->flags |= ATA_TFLAG_LBA48;
 			tf->command = ATA_CMD_VERIFY_EXT;
 
 			tf->hob_nsect = (n_block >> 8) & 0xff;
@@ -652,6 +650,10 @@ static unsigned int ata_scsi_verify_xlat
 			tf->hob_lbam = (block >> 32) & 0xff;
 			tf->hob_lbal = (block >> 24) & 0xff;
 		} else {
+			if (n_block > 256)
+				goto invalid_fld;
+
+			/* use LBA28 */
 			tf->command = ATA_CMD_VERIFY;
 
 			tf->device |= (block >> 24) & 0xf;
@@ -668,6 +670,9 @@ static unsigned int ata_scsi_verify_xlat
 		/* CHS */
 		u32 sect, head, cyl, track;
 
+		if (n_block > 256)
+			goto invalid_fld;
+
 		/* Convert LBA to CHS */
 		track = (u32)block / dev->sectors;
 		cyl   = track / dev->heads;
@@ -733,8 +738,6 @@ static unsigned int ata_scsi_rw_xlat(str
 {
 	struct ata_taskfile *tf = &qc->tf;
 	struct ata_device *dev = qc->dev;
-	unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
-	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
 	u64 block;
 	u32 n_block;
 
@@ -783,19 +786,24 @@ static unsigned int ata_scsi_rw_xlat(str
 		 */
 		goto nothing_to_do;
 
-	if (lba) {
-		if (lba48) {
+	if (dev->flags & ATA_DFLAG_LBA) {
+		tf->flags |= ATA_TFLAG_LBA;
+
+		if (dev->flags & ATA_DFLAG_LBA48) {
 			/* The request -may- be too large for LBA48. */
 			if ((block >> 48) || (n_block > 65536))
 				goto out_of_range;
 
+			/* use LBA48 */
+			tf->flags |= ATA_TFLAG_LBA48;
+
 			tf->hob_nsect = (n_block >> 8) & 0xff;
 
 			tf->hob_lbah = (block >> 40) & 0xff;
 			tf->hob_lbam = (block >> 32) & 0xff;
 			tf->hob_lbal = (block >> 24) & 0xff;
 		} else { 
-			/* LBA28 */
+			/* use LBA28 */
 
 			/* The request -may- be too large for LBA28. */
 			if ((block >> 28) || (n_block > 256))




