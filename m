From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 1/1] libata: err_mask misc fix
Date: Tue, 06 Dec 2005 11:34:59 +0800
Message-ID: <439506E3.2080202@tw.ibm.com>
References: <437181D5.8070903@tw.ibm.com> <43718400.5000409@tw.ibm.com> <43719670.20708@pobox.com> <4372FD45.8080404@tw.ibm.com> <43924E11.60500@pobox.com> <4393E513.5070203@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:20355 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751572AbVLFDfR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Dec 2005 22:35:17 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jB63Z7kg015066
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 22:35:07 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jB63YSJ5067154
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 20:34:28 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jB63Z76P016340
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 20:35:07 -0700
In-Reply-To: <4393E513.5070203@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>


Desc:
  Misc follow-up patch for the err_mask patch 1-4.

Changes:
  1. ata_pio_complete(): 
     It seems unnecessary to wait for the clearing of the DRQ bit.
     (Waiting for BSY=0 should be enough.
     ata_ok() also checks the correctness of the status bits later.)

  2. ata_pio_block(): 
     - added error checking, before transfering data.
     - minor comments fix

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

============

--- err_mask4/drivers/scsi/libata-core.c	2005-12-05 12:44:28.000000000 +0800
+++ pio_state5/drivers/scsi/libata-core.c	2005-12-06 11:17:14.000000000 +0800
@@ -2865,11 +2865,11 @@ static int ata_pio_complete (struct ata_
 	 * msecs, then chk-status again.  If still busy, fall back to
 	 * HSM_ST_POLL state.
 	 */
-	drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
-	if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
+	drv_stat = ata_busy_wait(ap, ATA_BUSY, 10);
+	if (drv_stat & ATA_BUSY) {
 		msleep(2);
-		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
-		if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
+		drv_stat = ata_busy_wait(ap, ATA_BUSY, 10);
+		if (drv_stat & ATA_BUSY) {
 			ap->hsm_task_state = HSM_ST_LAST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
 			return 0;
@@ -3236,8 +3236,16 @@ static void ata_pio_block(struct ata_por
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
+	/* check error */
+	if (status & (ATA_ERR | ATA_DF)) {
+		qc->err_mask |= AC_ERR_DEV;
+		ap->hsm_task_state = HSM_ST_ERR;
+		return;
+	}
+
+	/* transfer data if any */
 	if (is_atapi_taskfile(&qc->tf)) {
-		/* no more data to transfer or unsupported ATAPI command */
+		/* DRQ=0 means no more data to transfer */
 		if ((status & ATA_DRQ) == 0) {
 			ap->hsm_task_state = HSM_ST_LAST;
 			return;


