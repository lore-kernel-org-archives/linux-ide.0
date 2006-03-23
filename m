From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/2] libata-dev: irq-pio minor fixes
Date: Thu, 23 Mar 2006 16:04:12 +0800
Message-ID: <4422567C.5000008@tw.ibm.com>
References: <441FE605.8010202@tw.ibm.com> <44203953.3080803@pobox.com> <311601c90603210943v132a369aya443a073c11ee2bf@mail.gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:3275 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030195AbWCWIFS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2006 03:05:18 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2N84HwL032286
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 03:04:17 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2N87JOu169978
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 01:07:19 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2N84G9G032625
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 01:04:17 -0700
In-Reply-To: <311601c90603210943v132a369aya443a073c11ee2bf@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

irq-pio minor fixes for printk() and comments.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

Patch against previous irq-pio snapshot.
The current irq-pio branch (949ec2c8e6b7b89179b85baf6309c009e1a1b951)
looks strange. Maybe it is under refresh.

--- irq-pio-00/drivers/scsi/libata-core.c	2006-03-23 11:10:58.000000000 +0800
+++ irq-pio-deverr0/drivers/scsi/libata-core.c	2006-03-23 14:56:03.000000000 +0800
@@ -1283,7 +1283,7 @@ static int ata_dev_configure(struct ata_
 		if (dev->id[59] & 0x100) {
 			dev->multi_count = dev->id[59] & 0xff;
 			DPRINTK("ata%u: dev %u multi count %u\n",
-				ap->id, device, dev->multi_count);
+				ap->id, dev->devno, dev->multi_count);
 		}
 
 		dev->cdb_len = 16;
@@ -3562,6 +3562,9 @@ static int ata_hsm_move(struct ata_port 
 	}
 
 fsm_start:
+	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
+		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
+
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
 		/* Send first data block or PACKET CDB */
@@ -3688,6 +3691,7 @@ fsm_start:
 
 		ap->hsm_task_state = HSM_ST_IDLE;
 
+		/* complete taskfile transaction */
 		if (in_wq)
 			ata_poll_qc_complete(qc);
 		else
@@ -4441,9 +4445,6 @@ inline unsigned int ata_host_intr (struc
 	if (unlikely(status & ATA_BUSY))
 		goto idle_irq;
 
-	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
-
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
 



