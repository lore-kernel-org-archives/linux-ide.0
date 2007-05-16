From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/8] libata: change the state after "PIO data-in" to HSM_ST_IDLE
 instead of HSM_ST_LAST
Date: Wed, 16 May 2007 15:13:06 +0800
Message-ID: <464AAF02.8000407@tw.ibm.com>
References: <464AACDF.1030903@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:52177 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756332AbXEPHNK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 03:13:10 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4G7D9wb002272
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 03:13:09 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4G7D8PM119680
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:13:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4G7D76k005720
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:13:08 -0600
In-Reply-To: <464AACDF.1030903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

patch 3/8:
  Change the state after "PIO data-in" to HSM_ST_IDLE instead of HSM_ST_LAST.

This can prevent the irq handler from thinking "HSM is waiting for the last irq"
and submitting redundant tasks to the workqueue.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
This patch is needed if irq driven pio to be delegated to workqueue.

diff -Nrup 02_smart_flush/drivers/ata/libata-core.c 03_read_state/drivers/ata/libata-core.c
--- 02_smart_flush/drivers/ata/libata-core.c	2007-05-16 10:37:53.000000000 +0800
+++ 03_read_state/drivers/ata/libata-core.c	2007-05-16 10:37:57.000000000 +0800
@@ -4453,7 +4453,7 @@ static void ata_pio_sector(struct ata_qu
 	unsigned char *buf;
 
 	if (qc->curbytes == qc->nbytes - qc->sect_size)
-		ap->hsm_task_state = HSM_ST_LAST;
+		ap->hsm_task_state = do_write ? HSM_ST_LAST : HSM_ST_IDLE;
 
 	page = sg[qc->cursg].page;
 	offset = sg[qc->cursg].offset + qc->cursg_ofs;
@@ -4807,6 +4807,8 @@ int ata_hsm_move(struct ata_port *ap, st
 	 */
 	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
+	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
+
 fsm_start:
 	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
 		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
@@ -4964,8 +4966,7 @@ fsm_start:
 
 			ata_pio_sectors(qc);
 
-			if (ap->hsm_task_state == HSM_ST_LAST &&
-			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
+			if (ap->hsm_task_state == HSM_ST_IDLE) {
 				/* all data read */
 				status = ata_wait_idle(ap);
 				goto fsm_start;
@@ -4976,6 +4977,7 @@ fsm_start:
 		break;
 
 	case HSM_ST_LAST:
+	case HSM_ST_IDLE:
 		if (unlikely(!ata_ok(status))) {
 			qc->err_mask |= __ac_err_mask(status);
 			ap->hsm_task_state = HSM_ST_ERR;


