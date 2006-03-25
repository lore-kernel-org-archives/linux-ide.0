From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/3] libata-dev: irq-pio minor fixes (respin)
Date: Sat, 25 Mar 2006 18:07:48 +0800
Message-ID: <44251674.20804@tw.ibm.com>
References: <441FE605.8010202@tw.ibm.com> <44203953.3080803@pobox.com> <311601c90603210943v132a369aya443a073c11ee2bf@mail.gmail.com> <4422567C.5000008@tw.ibm.com> <44242C25.3020002@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:44170 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751147AbWCYKHy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Mar 2006 05:07:54 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k2PA7mBA025621
	for <linux-ide@vger.kernel.org>; Sat, 25 Mar 2006 05:07:48 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2PAAp1r184380
	for <linux-ide@vger.kernel.org>; Sat, 25 Mar 2006 03:10:51 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2PA7lJs010037
	for <linux-ide@vger.kernel.org>; Sat, 25 Mar 2006 03:07:47 -0700
In-Reply-To: <44242C25.3020002@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

irq-pio minor fixes for printk() and comments.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

Patch against the irq-pio branch.

--- b7/drivers/scsi/libata-core.c	2006-03-25 16:51:06.000000000 +0800
+++ c1/drivers/scsi/libata-core.c	2006-03-25 16:58:19.000000000 +0800
@@ -1295,7 +1295,7 @@ static int ata_dev_configure(struct ata_
 		if (dev->id[59] & 0x100) {
 			dev->multi_count = dev->id[59] & 0xff;
 			DPRINTK("ata%u: dev %u multi count %u\n",
-				ap->id, device, dev->multi_count);
+				ap->id, dev->devno, dev->multi_count);
 		}
 
 		dev->cdb_len = 16;
@@ -3594,6 +3594,9 @@ static int ata_hsm_move(struct ata_port 
 	}
 
 fsm_start:
+	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
+		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
+
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
 		/* Send first data block or PACKET CDB */
@@ -3720,6 +3723,7 @@ fsm_start:
 
 		ap->hsm_task_state = HSM_ST_IDLE;
 
+		/* complete taskfile transaction */
 		if (in_wq)
 			ata_poll_qc_complete(qc);
 		else
@@ -4241,9 +4245,6 @@ inline unsigned int ata_host_intr (struc
 	if (unlikely(status & ATA_BUSY))
 		goto idle_irq;
 
-	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
-
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
 


