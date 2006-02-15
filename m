From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata: minor fix for 2.6.16 (respin)
Date: Wed, 15 Feb 2006 14:55:50 +0800
Message-ID: <43F2D076.4080207@tw.ibm.com>
References: <43F0659D.9000109@tw.ibm.com> <43F2C524.6030705@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:11216 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422903AbWBOG4F
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Feb 2006 01:56:05 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k1F6txIo005235
	for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2006 01:55:59 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k1F6wV0e008336
	for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2006 23:58:31 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k1F6twP3006415
	for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2006 23:55:58 -0700
In-Reply-To: <43F2C524.6030705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

Jeff,

Respin two minor fixes from libata-dev tree that might be good for 2.6.16:
 - Fix the array index value in ata_rwcmd_protocol() for the added FUA commands.
   (This only affects some VIA PATA adapters. Other hardware is safe from this bug.)
 - Filter out ATAPI packet command error messages in ata_pio_error()

Patch against the libata-dev upstream branch
(f1b318793dcd2d9ff6b5ac06e7762098fa079cee).
For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

---

--- upstream/drivers/scsi/libata-core.c	2006-02-15 14:36:20.000000000 +0800
+++ upstream-mod/drivers/scsi/libata-core.c	2006-02-15 14:39:33.000000000 +0800
@@ -213,7 +213,7 @@ int ata_rwcmd_protocol(struct ata_queued
 	} else if (lba48 && (qc->ap->flags & ATA_FLAG_PIO_LBA48)) {
 		/* Unable to use DMA due to host limitation */
 		tf->protocol = ATA_PROT_PIO;
-		index = dev->multi_count ? 0 : 4;
+		index = dev->multi_count ? 0 : 8;
 	} else {
 		tf->protocol = ATA_PROT_DMA;
 		index = 16;
@@ -3426,11 +3426,12 @@ static void ata_pio_error(struct ata_por
 {
 	struct ata_queued_cmd *qc;
 
-	printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
-
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	WARN_ON(qc == NULL);
 
+	if (qc->tf.command != ATA_CMD_PACKET)
+		printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
+
 	/* make sure qc->err_mask is available to 
 	 * know what's wrong and recover
 	 */


