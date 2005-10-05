From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 1/4] CHS: move the initialization of taskfile LBA flags
Date: Wed, 05 Oct 2005 19:20:32 +0800
Message-ID: <4343B700.8010702@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com> <434276B9.7080807@tw.ibm.com> <43427AFD.1020405@pobox.com> <4343B5F5.4090402@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:65220 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932614AbVJELUr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Oct 2005 07:20:47 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j95BJ7W1007523
	for <linux-ide@vger.kernel.org>; Wed, 5 Oct 2005 07:19:07 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j95BLONX547718
	for <linux-ide@vger.kernel.org>; Wed, 5 Oct 2005 05:21:24 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j95BKetb004920
	for <linux-ide@vger.kernel.org>; Wed, 5 Oct 2005 05:20:41 -0600
In-Reply-To: <4343B5F5.4090402@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Patch 1/4:
  move the initialization of taskfile LBA flags:
    ATA_TFLAG_LBA and ATA_TFLAG_LBA48 flags
  to the SCSI translation functions

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

=============

--- upstream/drivers/scsi/libata-core.c    2005-10-05 18:04:07.000000000 
+0800
+++ ch1/drivers/scsi/libata-core.c    2005-10-05 18:10:28.000000000 +0800
@@ -3241,13 +3241,6 @@ struct ata_queued_cmd *ata_qc_new_init(s
         qc->nbytes = qc->curbytes = 0;
 
         ata_tf_init(ap, &qc->tf, dev->devno);
-
-        if (dev->flags & ATA_DFLAG_LBA) {
-            qc->tf.flags |= ATA_TFLAG_LBA;
-
-            if (dev->flags & ATA_DFLAG_LBA48)
-                qc->tf.flags |= ATA_TFLAG_LBA48;
-        }
     }
 
     return qc;
--- upstream/drivers/scsi/libata-scsi.c    2005-10-05 18:04:07.000000000 
+0800
+++ ch1/drivers/scsi/libata-scsi.c    2005-10-05 18:10:28.000000000 +0800
@@ -489,7 +489,7 @@ static unsigned int ata_scsi_flush_xlat(
     tf->flags |= ATA_TFLAG_DEVICE;
     tf->protocol = ATA_PROT_NODATA;
 
-    if ((tf->flags & ATA_TFLAG_LBA48) &&
+    if ((qc->dev->flags & ATA_DFLAG_LBA48) &&
         (ata_id_has_flush_ext(qc->dev->id)))
         tf->command = ATA_CMD_FLUSH_EXT;
     else
@@ -609,8 +609,6 @@ static unsigned int ata_scsi_verify_xlat
 {
     struct ata_taskfile *tf = &qc->tf;
     struct ata_device *dev = qc->dev;
-    unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
-    unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
     u64 dev_sectors = qc->dev->n_sectors;
     u64 block;
     u32 n_block;
@@ -631,16 +629,16 @@ static unsigned int ata_scsi_verify_xlat
         return 1;
     if ((block + n_block) > dev_sectors)
         return 1;
-    if (lba48) {
-        if (n_block > (64 * 1024))
-            return 1;
-    } else {
-        if (n_block > 256)
-            return 1;
-    }
 
-    if (lba) {
-        if (lba48) {
+    if (dev->flags & ATA_DFLAG_LBA) {
+        tf->flags |= ATA_TFLAG_LBA;
+
+        if (dev->flags & ATA_DFLAG_LBA48) {
+            if (n_block > (64 * 1024))
+                return 1;
+
+            /* use LBA48 */
+            tf->flags |= ATA_TFLAG_LBA48;
             tf->command = ATA_CMD_VERIFY_EXT;
 
             tf->hob_nsect = (n_block >> 8) & 0xff;
@@ -649,8 +647,11 @@ static unsigned int ata_scsi_verify_xlat
             tf->hob_lbam = (block >> 32) & 0xff;
             tf->hob_lbal = (block >> 24) & 0xff;
         } else {
-            tf->command = ATA_CMD_VERIFY;
+            if (n_block > 256)
+                return 1;
 
+            /* use LBA28 */
+            tf->command = ATA_CMD_VERIFY;
             tf->device |= (block >> 24) & 0xf;
         }
 
@@ -665,6 +666,9 @@ static unsigned int ata_scsi_verify_xlat
         /* CHS */
         u32 sect, head, cyl, track;
 
+        if (n_block > 256)
+            return 1;
+
         /* Convert LBA to CHS */
         track = (u32)block / dev->sectors;
         cyl   = track / dev->heads;
@@ -716,8 +720,6 @@ static unsigned int ata_scsi_rw_xlat(str
 {
     struct ata_taskfile *tf = &qc->tf;
     struct ata_device *dev = qc->dev;
-    unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
-    unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
     u64 block;
     u32 n_block;
 
@@ -766,19 +768,24 @@ static unsigned int ata_scsi_rw_xlat(str
          */
         return 1;
 
-    if (lba) {
-        if (lba48) {
+    if (dev->flags & ATA_DFLAG_LBA) {
+        tf->flags |= ATA_TFLAG_LBA;
+
+        if (dev->flags & ATA_DFLAG_LBA48) {
             /* The request -may- be too large for LBA48. */
             if ((block >> 48) || (n_block > 65536))
                 return 1;
 
+            /* use LBA48 */
+            tf->flags |= ATA_TFLAG_LBA48;
+
             tf->hob_nsect = (n_block >> 8) & 0xff;
 
             tf->hob_lbah = (block >> 40) & 0xff;
             tf->hob_lbam = (block >> 32) & 0xff;
             tf->hob_lbal = (block >> 24) & 0xff;
         } else {
-            /* LBA28 */
+            /* use LBA28 */
 
             /* The request -may- be too large for LBA28. */
             if ((block >> 28) || (n_block > 256))


