From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/2] libata: change the last state of pio read to HSM_ST_IDLE
Date: Wed, 04 Jul 2007 16:33:01 +0800
Message-ID: <468B5B3D.6040805@tw.ibm.com>
References: <468B5930.3070000@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:42628 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301AbXGDIdG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 04:33:06 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l648X5Yd023739
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 04:33:05 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l648X5FW269222
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 02:33:05 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l648X4nS019956
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 02:33:04 -0600
In-Reply-To: <468B5930.3070000@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Patch 2/2:
  After reading the last pio data block, the HSM is waiting for device
to be idle, not waiting for the last interrupt.

This patch changes the state after "PIO data-in" to HSM_ST_IDLE instead
of HSM_ST_LAST for accuracy.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 01_move_altstatus/drivers/ata/libata-core.c 02_pio_read_state/drivers/ata/libata-core.c
--- 01_move_altstatus/drivers/ata/libata-core.c	2007-07-04 11:32:36.000000000 +0800
+++ 02_pio_read_state/drivers/ata/libata-core.c	2007-07-04 11:33:53.000000000 +0800
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


