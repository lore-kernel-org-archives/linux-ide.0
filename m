From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/3] libata: change the last state of pio read to HSM_ST_IDLE
Date: Tue, 05 Jun 2007 11:53:09 +0800
Message-ID: <4664DE25.30701@tw.ibm.com>
References: <4664DB99.8010202@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:47533 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760909AbXFEDxP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jun 2007 23:53:15 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l553muZS032663
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 23:48:56 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l553rBCC261570
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 21:53:11 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l553rBJa017547
	for <linux-ide@vger.kernel.org>; Mon, 4 Jun 2007 21:53:11 -0600
In-Reply-To: <4664DB99.8010202@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Patch 3/3:
  After reading the last pio block, the HSM is waiting for device
to be idle, not waiting for the last interrupt.

Change the state after "PIO data-in" to HSM_ST_IDLE instead of HSM_ST_LAST for accuracy.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
diff -Nrup 02_move_altstatus/drivers/ata/libata-core.c 03_read_state/drivers/ata/libata-core.c
--- 02_move_altstatus/drivers/ata/libata-core.c	2007-06-04 18:16:24.000000000 +0800
+++ 03_read_state/drivers/ata/libata-core.c	2007-06-04 18:25:00.000000000 +0800
@@ -4462,7 +4462,7 @@ static void ata_pio_sector(struct ata_qu
 	unsigned char *buf;
 
 	if (qc->curbytes == qc->nbytes - qc->sect_size)
-		ap->hsm_task_state = HSM_ST_LAST;
+		ap->hsm_task_state = do_write ? HSM_ST_LAST : HSM_ST_IDLE;
 
 	page = sg[qc->cursg].page;
 	offset = sg[qc->cursg].offset + qc->cursg_ofs;
@@ -4811,6 +4811,8 @@ int ata_hsm_move(struct ata_port *ap, st
 	 */
 	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
+	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
+
 fsm_start:
 	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
 		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
@@ -4968,8 +4970,7 @@ fsm_start:
 
 			ata_pio_sectors(qc);
 
-			if (ap->hsm_task_state == HSM_ST_LAST &&
-			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
+			if (ap->hsm_task_state == HSM_ST_IDLE) {
 				/* all data read */
 				status = ata_wait_idle(ap);
 				goto fsm_start;
@@ -4980,6 +4981,7 @@ fsm_start:
 		break;
 
 	case HSM_ST_LAST:
+	case HSM_ST_IDLE:
 		if (unlikely(!ata_ok(status))) {
 			qc->err_mask |= __ac_err_mask(status);
 			ap->hsm_task_state = HSM_ST_ERR;


