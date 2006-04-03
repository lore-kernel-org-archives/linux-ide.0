From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata-dev: irq-pio minor fix 2
Date: Mon, 03 Apr 2006 18:31:44 +0800
Message-ID: <4430F990.9090604@tw.ibm.com>
References: <11439680863256-git-send-email-htejun@gmail.com> <442FE142.7030304@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:59084 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750901AbWDCKb5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Apr 2006 06:31:57 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k33AVp5X008731
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 06:31:51 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k33ASYWm262608
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 04:28:34 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k33AVpiN032021
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 04:31:51 -0600
In-Reply-To: <442FE142.7030304@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

irq-pio minor fix 2:
- Use qc as data for ata_pio_task().

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
I forgot this. One more minor fix for irq-pio.

Patch against irq-pio branch
(7819d64e31a685e35e4819515c84168d0879816e).

--- irq-pio1/drivers/scsi/libata-core.c	2006-04-03 15:36:10.000000000 +0800
+++ irq-pio2/drivers/scsi/libata-core.c	2006-04-03 18:05:45.000000000 +0800
@@ -4097,9 +4097,6 @@ static void ata_pio_task(void *_data)
 fsm_start:
 	WARN_ON(ap->hsm_task_state == HSM_ST_IDLE);
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	WARN_ON(qc == NULL);
-
 	/*
 	 * This is purely heuristic.  This is a fast path.
 	 * Sometimes when we enter, BSY will be cleared in
@@ -4112,7 +4109,7 @@ fsm_start:
 		msleep(2);
 		status = ata_busy_wait(ap, ATA_BUSY, 10);
 		if (status & ATA_BUSY) {
-			ata_port_queue_task(ap, ata_pio_task, ap, ATA_SHORT_PAUSE);
+			ata_port_queue_task(ap, ata_pio_task, qc, ATA_SHORT_PAUSE);
 			return;
 		}
 	}
@@ -4347,7 +4344,7 @@ unsigned int ata_qc_issue_prot(struct at
 		ap->hsm_task_state = HSM_ST_LAST;
 
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_port_queue_task(ap, ata_pio_task, ap, 0);
+			ata_port_queue_task(ap, ata_pio_task, qc, 0);
 
 		break;
 
@@ -4369,7 +4366,7 @@ unsigned int ata_qc_issue_prot(struct at
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
 			/* PIO data out protocol */
 			ap->hsm_task_state = HSM_ST_FIRST;
-			ata_port_queue_task(ap, ata_pio_task, ap, 0);
+			ata_port_queue_task(ap, ata_pio_task, qc, 0);
 
 			/* always send first data block using
 			 * the ata_pio_task() codepath.
@@ -4379,7 +4376,7 @@ unsigned int ata_qc_issue_prot(struct at
 			ap->hsm_task_state = HSM_ST;
 
 			if (qc->tf.flags & ATA_TFLAG_POLLING)
-				ata_port_queue_task(ap, ata_pio_task, ap, 0);
+				ata_port_queue_task(ap, ata_pio_task, qc, 0);
 
 			/* if polling, ata_pio_task() handles the rest.
 			 * otherwise, interrupt handler takes over from here.
@@ -4400,7 +4397,7 @@ unsigned int ata_qc_issue_prot(struct at
 		/* send cdb by polling if no cdb interrupt */
 		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
 		    (qc->tf.flags & ATA_TFLAG_POLLING))
-			ata_port_queue_task(ap, ata_pio_task, ap, 0);
+			ata_port_queue_task(ap, ata_pio_task, qc, 0);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
@@ -4412,7 +4409,7 @@ unsigned int ata_qc_issue_prot(struct at
 
 		/* send cdb by polling if no cdb interrupt */
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			ata_port_queue_task(ap, ata_pio_task, ap, 0);
+			ata_port_queue_task(ap, ata_pio_task, qc, 0);
 		break;
 
 	default:


