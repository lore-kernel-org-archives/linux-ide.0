From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/2] libata-dev: determine err_mask when error is found
Date: Mon, 26 Dec 2005 16:40:53 +0800
Message-ID: <43AFAC95.7030207@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:27319 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751057AbVLZIlN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Dec 2005 03:41:13 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jBQ8f3hw027096
	for <linux-ide@vger.kernel.org>; Mon, 26 Dec 2005 03:41:03 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jBQ8dueD104964
	for <linux-ide@vger.kernel.org>; Mon, 26 Dec 2005 01:39:56 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jBQ8f1Ew010198
	for <linux-ide@vger.kernel.org>; Mon, 26 Dec 2005 01:41:02 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Jeff,

Patch 1/2: Minor fix to determine err_mask directly when an error is found.

Changes:
- Determine err_mask directly when an error is found.
- Remove "qc->err_mask |= __ac_err_mask(status);" in ata_host_intr() 

Patch against the libata-dev irq-pio branch 
(3d0a59c02303df01848537b3bf938dc11e9a0ded).

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

============

--- irq-pio/drivers/scsi/libata-core.c	2005-12-26 11:25:52.000000000 +0800
+++ err_mask/drivers/scsi/libata-core.c	2005-12-26 14:59:53.000000000 +0800
@@ -3209,6 +3209,7 @@ static int ata_pio_first_block(struct at
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
 	if (ata_busy_sleep(ap, ATA_TMOUT_DATAOUT_QUICK, ATA_TMOUT_DATAOUT)) {
+		qc->err_mask |= AC_ERR_ATA_BUS;
 		ap->hsm_task_state = HSM_ST_TMOUT;
 		goto err_out;
 	}
@@ -3217,6 +3218,7 @@ static int ata_pio_first_block(struct at
 	status = ata_chk_status(ap);
 	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
 		/* device status error */
+		qc->err_mask |= AC_ERR_ATA_BUS;
 		ap->hsm_task_state = HSM_ST_ERR;
 		goto err_out;
 	}
@@ -4232,6 +4234,12 @@ inline unsigned int ata_host_intr (struc
 
 			/* before we do anything else, clear DMA-Start bit */
 			ap->ops->bmdma_stop(qc);
+
+			if (unlikely(host_stat & ATA_DMA_ERR)) {
+				/* error when transfering data to/from memory */
+				qc->err_mask |= AC_ERR_HOST_BUS;
+				ap->hsm_task_state = HSM_ST_ERR;
+			}
 		}
 		break;
 	case HSM_ST:
@@ -4257,8 +4265,10 @@ inline unsigned int ata_host_intr (struc
 	ap->ops->irq_clear(ap);
 
 	/* check error */
-	if (unlikely((status & ATA_ERR) || (host_stat & ATA_DMA_ERR)))
+	if (unlikely(status & (ATA_ERR | ATA_DF))) {
+		qc->err_mask |= AC_ERR_DEV;
 		ap->hsm_task_state = HSM_ST_ERR;
+	}
 
 fsm_start:
 	switch (ap->hsm_task_state) {
@@ -4270,6 +4280,7 @@ fsm_start:
 		/* check device status */
 		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
 			/* Wrong status. Let EH handle this */
+			qc->err_mask |= AC_ERR_ATA_BUS;
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}
@@ -4298,6 +4309,7 @@ fsm_start:
 			/* ATA PIO protocol */
 			if (unlikely((status & ATA_DRQ) == 0)) {
 				/* handle BSY=0, DRQ=0 as error */
+				qc->err_mask |= AC_ERR_ATA_BUS;
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
 			}
@@ -4319,6 +4331,7 @@ fsm_start:
 	case HSM_ST_LAST:
 		if (unlikely(status & ATA_DRQ)) {
 			/* handle DRQ=1 as error */
+			qc->err_mask |= AC_ERR_ATA_BUS;
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}
@@ -4338,8 +4351,12 @@ fsm_start:
 		printk(KERN_ERR "ata%u: command error, drv_stat 0x%x host_stat 0x%x\n",
 		       ap->id, status, host_stat);
 
+		/* make sure qc->err_mask is available to 
+		 * know what's wrong and recover
+		 */
+		assert(qc->err_mask);
+
 		ap->hsm_task_state = HSM_ST_IDLE;
-		qc->err_mask |= __ac_err_mask(status);
 		ata_qc_complete(qc);
 		break;
 	default:

