From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 3/4] libata: determine the err_mask when the error is
 found
Date: Thu, 10 Nov 2005 16:03:04 +0800
Message-ID: <4372FEB8.2010604@tw.ibm.com>
References: <437181D5.8070903@tw.ibm.com> <43718400.5000409@tw.ibm.com> <43719670.20708@pobox.com> <4372FD45.8080404@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:24729 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751381AbVKJIDM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 03:03:12 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jAA836hF018403
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 03:03:06 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jAA831xP073916
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 01:03:01 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jAA835a2003410
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 01:03:06 -0700
In-Reply-To: <4372FD45.8080404@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Patch 3/4:
  determine the err_mask when the error is found

Changes:
  - move "qc->err_mask |= AC_ERR_ATA_BUS" to where the error is found
  - add "assert(qc->err_mask)" to ata_pio_error() to make sure qc->err_mask was available when we enter the error state


For your review and advice, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

============

--- err_mask2/drivers/scsi/libata-core.c	2005-11-10 11:28:51.000000000 +0800
+++ err_mask3/drivers/scsi/libata-core.c	2005-11-10 15:09:52.000000000 +0800
@@ -2772,6 +2772,7 @@ static unsigned long ata_pio_poll(struct
 	status = ata_chk_status(ap);
 	if (status & ATA_BUSY) {
 		if (time_after(jiffies, ap->pio_task_timeout)) {
+			qc->err_mask |= AC_ERR_ATA_BUS;
 			ap->hsm_task_state = HSM_ST_TMOUT;
 			return 0;
 		}
@@ -2822,6 +2823,7 @@ static int ata_pio_complete (struct ata_
 
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
+		qc->err_mask |= AC_ERR_ATA_BUS;
 		ap->hsm_task_state = HSM_ST_ERR;
 		return 0;
 	}
@@ -3137,6 +3139,7 @@ static void atapi_pio_bytes(struct ata_q
 err_out:
 	printk(KERN_INFO "ata%u: dev %u: ATAPI check failed\n",
 	      ap->id, dev->devno);
+	qc->err_mask |= AC_ERR_ATA_BUS;
 	ap->hsm_task_state = HSM_ST_ERR;
 }
 
@@ -3186,6 +3189,7 @@ static void ata_pio_block(struct ata_por
 	} else {
 		/* handle BSY=0, DRQ=0 as error */
 		if ((status & ATA_DRQ) == 0) {
+			qc->err_mask |= AC_ERR_ATA_BUS;
 			ap->hsm_task_state = HSM_ST_ERR;
 			return;
 		}
@@ -3203,9 +3207,13 @@ static void ata_pio_error(struct ata_por
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
+	/* make sure qc->err_mask was available to 
+	 * know about what's going wrong and recover
+	 */
+	assert(qc->err_mask);
+
 	ap->hsm_task_state = HSM_ST_IDLE;
 
-	qc->err_mask |= AC_ERR_ATA_BUS;
 	ata_poll_qc_complete(qc);
 }
 


