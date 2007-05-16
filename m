From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 5/8] libata: ack unsolicited INTRQ when polling
Date: Wed, 16 May 2007 15:20:23 +0800
Message-ID: <464AB0B7.4000803@tw.ibm.com>
References: <464AACDF.1030903@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:53026 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757844AbXEPHUc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 03:20:32 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l4G7GoXw016264
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 03:16:50 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4G7KQXN246090
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:20:26 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4G7KPN6020445
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:20:26 -0600
In-Reply-To: <464AACDF.1030903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

patch 5/8:

- Move the ATA_TFLAG_POLLING check from ata_interrupt to ata_host_intr
- Ack unsolicited INTRQ if polling and before the HSM accessing the port.
  (e.g. some device asserts INTRQ even if polling and nIEN = 1.)

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>
---
1.
This fixes the Benq "irq nobody cared" problem.
 (Some device asserts INTRQ even if nIEN = 1 and polling.
http://bugzilla.kernel.org/show_bug.cgi?id=8441)

Other unsolicited irqs that Alan concerned about will be address in patch 8/8.

2. Per Tejun's advice, I have checked the LLDDs.
The following LLDDs checks ATA_TFLAG_POLLING in their interrupt handler:
  pdc_adma, sata_inic162x, sata_mv, sata_nv, sata_promise,
  sata_qstor, sata_sil, sata_sx4 and sata_vsc.
After review, it seems non of them requires change due to this patch.

BTW, sata_sil and some other LLDDs already have such workaround in it.

diff -Nrup 04_move_narrow_lock/drivers/ata/libata-core.c 05_polling_ack/drivers/ata/libata-core.c
--- 04_move_narrow_lock/drivers/ata/libata-core.c	2007-05-16 13:53:16.000000000 +0800
+++ 05_polling_ack/drivers/ata/libata-core.c	2007-05-16 13:53:20.000000000 +0800
@@ -5694,6 +5694,13 @@ inline unsigned int ata_host_intr (struc
 	if (ap->pflags & ATA_PFLAG_HSM_WQ)
 		goto idle_irq;
 
+	/* polling, while HSM not yet active in wq */
+	if (qc->tf.flags & ATA_TFLAG_POLLING) {
+		/* ack unsolicited irq */
+		ata_chk_status(ap);
+		goto idle_irq;
+	}
+
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
@@ -5804,8 +5811,7 @@ irqreturn_t ata_interrupt (int irq, void
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
-			    (qc->flags & ATA_QCFLAG_ACTIVE))
+			if (qc && (qc->flags & ATA_QCFLAG_ACTIVE))
 				handled |= ata_host_intr(ap, qc);
 		}
 	}


