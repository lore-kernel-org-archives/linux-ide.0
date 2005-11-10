From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 1/4] libata: minor patch before moving err_mask
Date: Thu, 10 Nov 2005 15:59:24 +0800
Message-ID: <4372FDDC.7000109@tw.ibm.com>
References: <437181D5.8070903@tw.ibm.com> <43718400.5000409@tw.ibm.com> <43719670.20708@pobox.com> <4372FD45.8080404@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:41196 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751336AbVKJH7d
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 02:59:33 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jAA7xQFn032390
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 02:59:26 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jAA80b78053704
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 01:00:37 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jAA7xPSF029918
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 00:59:26 -0700
In-Reply-To: <4372FD45.8080404@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Patch 1/4:
  minor patch before moving the err_mask

Changes:
  - add qc to ata_pio_poll()
  - reorder the initialization of qc in ata_pio_complete()

For your review and advice, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

============
--- linux/drivers/scsi/libata-core.c	2005-11-10 11:03:03.000000000 +0800
+++ err_mask1/drivers/scsi/libata-core.c	2005-11-10 11:13:54.000000000 +0800
@@ -2744,10 +2744,14 @@ void ata_poll_qc_complete(struct ata_que
 
 static unsigned long ata_pio_poll(struct ata_port *ap)
 {
+	struct ata_queued_cmd *qc;
 	u8 status;
 	unsigned int poll_state = HSM_ST_UNKNOWN;
 	unsigned int reg_state = HSM_ST_UNKNOWN;
 
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	assert(qc != NULL);
+
 	switch (ap->hsm_task_state) {
 	case HSM_ST:
 	case HSM_ST_POLL:
@@ -2812,15 +2816,15 @@ static int ata_pio_complete (struct ata_
 		}
 	}
 
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	assert(qc != NULL);
+
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
 		ap->hsm_task_state = HSM_ST_ERR;
 		return 0;
 	}
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	assert(qc != NULL);
-
 	ap->hsm_task_state = HSM_ST_IDLE;
 
 	ata_poll_qc_complete(qc, 0);


