From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata-dev: Make the the in_wq check as an inline function
Date: Mon, 13 Mar 2006 16:42:28 +0800
Message-ID: <44153074.8050304@tw.ibm.com>
References: <440FEA4B.10500@tw.ibm.com> <44136D61.4020007@pobox.com> <4415203F.4070103@tw.ibm.com> <4415231B.1090906@tw.ibm.com> <44152588.10908@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:38794 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932354AbWCMImk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Mar 2006 03:42:40 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2D8gYdw013005
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 03:42:34 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2D8jRfw165886
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 01:45:27 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2D8gXk4019222
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 01:42:33 -0700
In-Reply-To: <44152588.10908@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Make the the in_wq check easier to read as an inline function.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
irq-pio follow-up per Jeff's advice.

--- 06_check_atapi_dma/drivers/scsi/libata-core.c	2006-03-13 13:29:25.000000000 +0800
+++ 07_followup/drivers/scsi/libata-core.c	2006-03-13 16:25:52.000000000 +0800
@@ -3501,6 +3501,33 @@ err_out:
 }
 
 /**
+ *	ata_hsm_ok_in_wq - Check if the qc can be handled in the workqueue.
+ *	@ap: the target ata_port
+ *	@qc: qc on going
+ *
+ *	RETURNS:
+ *	1 if ok in workqueue, 0 otherwise.
+ */
+
+static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	if (qc->tf.flags & ATA_TFLAG_POLLING)
+		return 1;
+
+	if (ap->hsm_task_state == HSM_ST_FIRST) {
+		if (qc->tf.protocol == ATA_PROT_PIO &&
+		    (qc->tf.flags & ATA_TFLAG_WRITE))
+		    return 1;
+
+		if (is_atapi_taskfile(&qc->tf) &&
+		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+			return 1;
+	}
+
+	return 0;
+}
+
+/**
  *	ata_hsm_move - move the HSM to the next state.
  *	@ap: the target ata_port
  *	@qc: qc on going
@@ -3523,12 +3550,7 @@ static int ata_hsm_move(struct ata_port 
 	 * like DMA polling into the workqueue. Notice that
 	 * in_wq is not equivalent to (qc->tf.flags & ATA_TFLAG_POLLING).
 	 */
-	WARN_ON(in_wq != ((qc->tf.flags & ATA_TFLAG_POLLING) ||
-			  (ap->hsm_task_state == HSM_ST_FIRST &&
-			   ((qc->tf.protocol == ATA_PROT_PIO &&
-			     (qc->tf.flags & ATA_TFLAG_WRITE)) ||
-			    (is_atapi_taskfile(&qc->tf) &&
-			     !(qc->dev->flags & ATA_DFLAG_CDB_INTR))))));
+	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
 	/* check error */
 	if (unlikely(status & (ATA_ERR | ATA_DF))) {

