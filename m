From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/4] libata: minor patch before moving err_mask
Date: Mon, 05 Dec 2005 15:36:08 +0800
Message-ID: <4393EDE8.5050808@tw.ibm.com>
References: <437181D5.8070903@tw.ibm.com> <43718400.5000409@tw.ibm.com> <43719670.20708@pobox.com> <4372FD45.8080404@tw.ibm.com> <43924E11.60500@pobox.com> <4393E513.5070203@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:24980 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751306AbVLEHgQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Dec 2005 02:36:16 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jB57a6b5025154
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 02:36:06 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jB57bcWB100008
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 00:37:38 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jB57a6bW018606
	for <linux-ide@vger.kernel.org>; Mon, 5 Dec 2005 00:36:06 -0700
In-Reply-To: <4393E513.5070203@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Patch 1/4:
  minor patch before moving the err_mask

Changes:
  - add qc to ata_pio_poll()
  - reorder the initialization of qc in ata_pio_complete()

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

===================

--- upstream/drivers/scsi/libata-core.c	2005-12-05 10:13:48.000000000 +0800
+++ err_mask1/drivers/scsi/libata-core.c	2005-12-05 12:32:33.000000000 +0800
@@ -2802,10 +2802,14 @@ void ata_poll_qc_complete(struct ata_que
 
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
@@ -2870,15 +2874,15 @@ static int ata_pio_complete (struct ata_
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


