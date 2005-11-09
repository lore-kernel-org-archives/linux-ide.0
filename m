From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/3] libata: if condition fix for ata_dev_identify()
Date: Wed, 09 Nov 2005 13:03:30 +0800
Message-ID: <43718322.4010608@tw.ibm.com>
References: <437181D5.8070903@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:50620 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030372AbVKIFDk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Nov 2005 00:03:40 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jA953ZRe004727
	for <linux-ide@vger.kernel.org>; Wed, 9 Nov 2005 00:03:35 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jA954j1K047740
	for <linux-ide@vger.kernel.org>; Tue, 8 Nov 2005 22:04:45 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jA953YqN024789
	for <linux-ide@vger.kernel.org>; Tue, 8 Nov 2005 22:03:34 -0700
In-Reply-To: <437181D5.8070903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Patch 1/3:
  - if condition fix for ata_dev_identify()
  - ata_pio_poll() minor cleanup.

Changes:
   - Use (dev->class == ATA_DEV_ATA) for ata_dev_identify()
     since "qc->tf.command" has been overwritten by the device status
   - Use HSM_ST_TMOUT directly in ata_pio_poll()

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

============
--- linux/drivers/scsi/libata-core.c	2005-11-07 18:25:38.000000000 +0800
+++ identify/drivers/scsi/libata-core.c	2005-11-09 10:14:41.000000000 +0800
@@ -1144,7 +1144,7 @@ retry:
 		 * ATA software reset (SRST, the default) does not appear
 		 * to have this problem.
 		 */
-		if ((using_edd) && (qc->tf.command == ATA_CMD_ID_ATA)) {
+		if ((using_edd) && (dev->class == ATA_DEV_ATA)) {
 			u8 err = qc->tf.feature;
 			if (err & ATA_ABORTED) {
 				dev->class = ATA_DEV_ATAPI;
@@ -2747,7 +2747,6 @@ static unsigned long ata_pio_poll(struct
 	u8 status;
 	unsigned int poll_state = HSM_ST_UNKNOWN;
 	unsigned int reg_state = HSM_ST_UNKNOWN;
-	const unsigned int tmout_state = HSM_ST_TMOUT;
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST:
@@ -2768,7 +2767,7 @@ static unsigned long ata_pio_poll(struct
 	status = ata_chk_status(ap);
 	if (status & ATA_BUSY) {
 		if (time_after(jiffies, ap->pio_task_timeout)) {
-			ap->hsm_task_state = tmout_state;
+			ap->hsm_task_state = HSM_ST_TMOUT;
 			return 0;
 		}
 		ap->hsm_task_state = poll_state;


