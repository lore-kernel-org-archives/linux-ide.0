From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/4] libata-dev: Use new ata_queue_pio_task() for PIO polling
 task
Date: Wed, 08 Feb 2006 16:48:49 +0800
Message-ID: <43E9B071.6070000@tw.ibm.com>
References: <43DA2CFB.4010605@pobox.com> <43E9AAE0.8020302@tw.ibm.com> <43E9AD00.8070900@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:31924 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030578AbWBHIs7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Feb 2006 03:48:59 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k188mrl6026626
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 03:48:53 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k188pK5b182374
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 01:51:20 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k188mrNh025828
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 01:48:53 -0700
In-Reply-To: <43E9AD00.8070900@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Patch 2/4:

Changes:
  - Use new ata_queue_pio_task() for PIO polling task.
  - Remove the unused ata_queue_packet_task() function.
    (irq-pio had merged the 2 queues into one.)

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

===

--- rwcmd/drivers/scsi/libata-core.c	2006-02-08 13:39:34.000000000 +0800
+++ queuework/drivers/scsi/libata-core.c	2006-02-08 14:06:41.000000000 +0800
@@ -1073,12 +1073,6 @@ static unsigned int ata_pio_modes(const 
 }
 
 static inline void
-ata_queue_packet_task(struct ata_port *ap)
-{
-	queue_work(ata_wq, &ap->packet_task);
-}
-
-static inline void
 ata_queue_pio_task(struct ata_port *ap)
 {
 	queue_work(ata_wq, &ap->pio_task);
@@ -3971,7 +3965,7 @@ unsigned int ata_qc_issue_prot(struct at
 		ap->hsm_task_state = HSM_ST_LAST;
 
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			queue_work(ata_wq, &ap->pio_task);
+			ata_queue_pio_task(ap);
 
 		break;
 
@@ -4024,7 +4018,7 @@ unsigned int ata_qc_issue_prot(struct at
 		/* send cdb by polling if no cdb interrupt */
 		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
 		    (qc->tf.flags & ATA_TFLAG_POLLING))
-			ata_queue_packet_task(ap);
+			ata_queue_pio_task(ap);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
@@ -4036,7 +4030,7 @@ unsigned int ata_qc_issue_prot(struct at
 
 		/* send cdb by polling if no cdb interrupt */
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			ata_queue_packet_task(ap);
+			ata_queue_pio_task(ap);
 		break;
 
 	default:



