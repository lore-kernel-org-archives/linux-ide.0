From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/2] libata-dev: filter out noisy ATAPI error messages
Date: Mon, 26 Dec 2005 16:48:00 +0800
Message-ID: <43AFAE40.4030407@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:22993 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751066AbVLZIsI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Dec 2005 03:48:08 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jBQ8m0op017499
	for <linux-ide@vger.kernel.org>; Mon, 26 Dec 2005 03:48:00 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jBQ8nnVa076554
	for <linux-ide@vger.kernel.org>; Mon, 26 Dec 2005 01:49:49 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jBQ8lx4r031216
	for <linux-ide@vger.kernel.org>; Mon, 26 Dec 2005 01:48:00 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Jeff,

Patch 2/2: Minor patch to filter out noisy ATAPI error messages.

Changes:
 - Filter out ATAPI packet command error messages in ata_pio_error()
 - Filter out ATAPI packet command error messages in ata_host_intr()

Patch against the libata-dev irq-pio branch 
(3d0a59c02303df01848537b3bf938dc11e9a0ded).

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

======

--- err_mask/drivers/scsi/libata-core.c	2005-12-26 14:59:53.000000000 +0800
+++ noisy_err_msg/drivers/scsi/libata-core.c	2005-12-26 15:06:11.000000000 +0800
@@ -3464,11 +3464,12 @@ static void ata_pio_error(struct ata_por
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
@@ -4348,8 +4349,9 @@ fsm_start:
 		break;
 
 	case HSM_ST_ERR:
-		printk(KERN_ERR "ata%u: command error, drv_stat 0x%x host_stat 0x%x\n",
-		       ap->id, status, host_stat);
+		if (qc->tf.command != ATA_CMD_PACKET)
+			printk(KERN_ERR "ata%u: command error, drv_stat 0x%x host_stat 0x%x\n",
+			       ap->id, status, host_stat);
 
 		/* make sure qc->err_mask is available to 
 		 * know what's wrong and recover

