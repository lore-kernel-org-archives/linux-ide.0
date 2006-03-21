From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC] libata-dev: handle ERR=1 DRQ=1
Date: Tue, 21 Mar 2006 19:39:49 +0800
Message-ID: <441FE605.8010202@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:18101 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030351AbWCULkN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 06:40:13 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2LBe7JD012941
	for <linux-ide@vger.kernel.org>; Tue, 21 Mar 2006 06:40:07 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2LBh8wu167970
	for <linux-ide@vger.kernel.org>; Tue, 21 Mar 2006 04:43:08 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2LBe76I001259
	for <linux-ide@vger.kernel.org>; Tue, 21 Mar 2006 04:40:07 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

handle ERR=1 DRQ=1 for PIO protocol

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

Some PIO read commands might set DRQ=1 alone with ERR=1.
Under such situation, the data block should be transferred even if err=1.

This patch adds extra logic to HSM_ST_ERR to handle the required
data transfer.

BTW, also found the following work in progress:
"Disable Data Transfer after Error Detection"
http://t13.org/docs2006/dt1825Lr3-DDT_TR.pdf
If this feature is turned on, then DRQ will be guaranteed 0 when ERR=1
which would simplify the PIO error handling.

Patch against the irq-pio branch.
Need your review and advice, thanks.

Albert


--- irq-pio-printk/drivers/scsi/libata-core.c	2006-03-21 17:55:35.000000000 +0800
+++ irq-pio-err/drivers/scsi/libata-core.c	2006-03-21 19:09:38.000000000 +0800
@@ -3684,6 +3684,46 @@ fsm_start:
 			printk(KERN_ERR "ata%u: command error, drv_stat 0x%x\n",
 			       ap->id, status);
 
+		/* handle ERR=1 DRQ=1 */
+		if ((status & ATA_ERR) && (status & ATA_DRQ)) {
+			/* ERR=1 DRQ=1 is only possible for reads (READ PIO
+			 * and READ MULTI, etc). For writes, DRQ=1 doesn't
+			 * make sense since the data block has been
+			 * transferred to the device.
+			 */
+			if ((qc->tf.protocol == ATA_PROT_PIO) &&
+			    !(qc->tf.flags & ATA_TFLAG_WRITE)) {
+				/* Transfer the corrupted data */
+				ata_pio_sectors(qc);
+
+				/* FIXME: contents of taskfile registers
+				 * undefined after the data xfer.
+				 * Maybe we should call ->tf_read()
+				 * and backup the taskfile somewhere?
+				 * Otherwise ata_gen_fixed_sense() won't
+				 * get needed information.
+				 */
+
+				/* FIXME: The spec said if "correctable"
+				 * data error, subsequent blocks will
+				 * be transferred. Isn't the command
+				 * stopped if ERR is set?
+				 */
+
+				ata_altstatus(ap); /* flush */
+				status = ata_chk_status(ap);
+
+				printk(KERN_ERR "ata%u: ERR=1 DRQ=1 error"
+				       " block transferred, drv_stat 0x%x\n",
+				       ap->id, status);
+			} else
+				/* Low possibility for other protocols
+				 * being ERR=1 DRQ=1. Maybe device error?
+				 */
+				printk(KERN_ERR "ata%u: ERR=1 DRQ=1\n",
+				       ap->id);
+		}
+
 		/* make sure qc->err_mask is available to
 		 * know what's wrong and recover
 		 */


