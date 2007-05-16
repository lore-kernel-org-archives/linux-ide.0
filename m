From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 8/8] libata: ack more unsolicited INTRQ
Date: Wed, 16 May 2007 15:29:55 +0800
Message-ID: <464AB2F3.7030103@tw.ibm.com>
References: <464AACDF.1030903@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:34961 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531AbXEPHaD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 03:30:03 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l4G7QLhP028873
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 03:26:21 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4G7TvEO142946
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:29:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4G7TuYf001408
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:29:57 -0600
In-Reply-To: <464AACDF.1030903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

patch 8/8: ack more unsolicited irq

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>
---
To address Alan's concern about the unsolicited irq (hopefully),
this patch tries to ack irq that happens after HSM accessing the port
but before the data transfer that actually triggers INTRQ.

For a typical transaction:
0. wait for irq or polling for device not busy
1. hsm starts accessing the port (ATA_PFLAG_HSM_WQ set)
2. hsm transfer the "head" part of the data
3. hsm acquires ap->lock
4. hsm transfer the "tail" part of the data (which may trigger INTRQ)
5. hsm clears ATA_PFLAG_HSM_WQ and release ap->lock

This patch allows the irq handler to ack irqs that occur during
1 and 2. (Another patch 5/8 acks irq before 1 and when polling.)

As previously discussed, the possible issue with this patch is:
Some ATA/ATAPI devices might be unhappy if the STATUS register
is read during data transfer (not sure if this is true or not).
(Patch 5/8 doesn't have such issue.) 


diff -Nrup 07_irq_wq_fix/drivers/ata/libata-core.c 08_possible_ack/drivers/ata/libata-core.c
--- 07_irq_wq_fix/drivers/ata/libata-core.c	2007-05-16 13:53:37.000000000 +0800
+++ 08_possible_ack/drivers/ata/libata-core.c	2007-05-16 13:53:45.000000000 +0800
@@ -5723,8 +5723,14 @@ inline unsigned int ata_host_intr (struc
 		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
 
 	/* HSM accessing the port from the workqueue */
-	if (ap->pflags & ATA_PFLAG_HSM_WQ)
+	if (ap->pflags & ATA_PFLAG_HSM_WQ) {
+		/* HSM is not transfering the last piece
+		 * of data that triggers INTRQ yet.
+		 * ack unsolicited irq.
+		 */
+		ata_chk_status(ap);
 		goto idle_irq;
+	}
 
 	/* polling, while HSM not yet active in wq */
 	if (qc->tf.flags & ATA_TFLAG_POLLING) {


