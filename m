From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata: minor fix for 2.6.16-rc3
Date: Mon, 13 Feb 2006 18:55:25 +0800
Message-ID: <43F0659D.9000109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:36245 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932298AbWBMKzq
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Feb 2006 05:55:46 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k1DAtbse007985
	for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2006 05:55:37 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k1DArQIB262230
	for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2006 03:53:26 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k1DAtbKC013758
	for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2006 03:55:37 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Jeff,

Just two minor fixes from libata-dev tree that might be good for 2.6.16:
 - Fix the array index value in ata_rwcmd_protocol() for the added FUA commands.
 - Filter out ATAPI packet command error messages in ata_pio_error()

Patch against the mainline 2.6.16-rc3 tree.
For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

---

--- linux-2.6.16-rc3/drivers/scsi/libata-core.c	2006-02-13 18:41:48.000000000 +0800
+++ linux-2.6.16-rc3-mod/drivers/scsi/libata-core.c	2006-02-13 18:44:58.000000000 +0800
@@ -614,7 +614,7 @@ int ata_rwcmd_protocol(struct ata_queued
 	} else if (lba48 && (qc->ap->flags & ATA_FLAG_PIO_LBA48)) {
 		/* Unable to use DMA due to host limitation */
 		tf->protocol = ATA_PROT_PIO;
-		index = dev->multi_count ? 0 : 4;
+		index = dev->multi_count ? 0 : 8;
 	} else {
 		tf->protocol = ATA_PROT_DMA;
 		index = 16;
@@ -3357,11 +3357,12 @@ static void ata_pio_error(struct ata_por
 {
 	struct ata_queued_cmd *qc;
 
-	printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
-
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
+	if (qc->tf.command != ATA_CMD_PACKET)
+		printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
+
 	/* make sure qc->err_mask is available to 
 	 * know what's wrong and recover
 	 */

