From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC] libata-dev: make the returned err_mask more accurate
 (revised)
Date: Thu, 06 Apr 2006 15:43:56 +0800
Message-ID: <4434C6BC.6060602@tw.ibm.com>
References: <4434BD0C.9080302@tw.ibm.com> <20060406071442.GF31998@htj.dyndns.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:52716 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932140AbWDFHoJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Apr 2006 03:44:09 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k367i0Jh001327
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 03:44:00 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k367lDXm190634
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 01:47:13 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k367hx4A008229
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 01:44:00 -0600
In-Reply-To: <20060406071442.GF31998@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

make the returned err_mask more accurate
Changes:
- add ac_err_drq() and ac_err_idle() to map err_mask from drv_status for data xfer and idle states.
- fix ata_hsm_move() to use the functions for err_mask mapping.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
(revised to not inline per Tejun's comments.)

The current err_mask returned by HSM doesn't look right.
e.g. When we found DRQ=0 when data transfer is expected, AC_ERR_HSM is returned.
However, DRQ=0 maybe caused by device error. So, during data transfer,
if we see DRQ=0 and ERR=1, returning AC_ERR_DEV should be more accurate.

e.g. In HSM_ST_LAST state, AC_ERR_OTHER is returned for BSY=0 DRQ=1 currently.
AC_ERR_HSM shoule be more accurate.

Patch against irq-pio (79fa1b677be3a985cc66b9218a4dd09818f1051b).
For your review, thanks.


--- irq-pio0/drivers/scsi/libata-core.c	2006-04-06 10:08:44.000000000 +0800
+++ irq-pio1/drivers/scsi/libata-core.c	2006-04-06 15:29:47.000000000 +0800
@@ -3838,6 +3838,62 @@ err_out:
 }
 
 /**
+ *	ac_err_drq - check status when PIO data transfer expected.
+ *	@status: device status
+ *
+ *	RETURNS:
+ *	0 if status looks good, err_mask otherwise.
+ */
+
+static unsigned int ac_err_drq(u8 status)
+{
+	/* BSY = 1*/
+	if (status & ATA_BUSY)
+		return AC_ERR_HSM;
+
+	/* BSY = 0, DRQ = 1 */
+	if (status & ATA_DRQ)
+		return 0;
+
+	/* BSY = 0, DRQ = 0, device err */
+	if (status & (ATA_ERR | ATA_DF))
+		return AC_ERR_DEV;
+
+	/* BSY = 0, DRQ = 0, no device err.
+	 * but we are expecting data transfer...
+	 */
+	return AC_ERR_HSM;
+}
+
+/**
+ *	ac_err_idle - check status when the transaction is finished.
+ *	@status: device status
+ *
+ *	RETURNS:
+ *	0 if status looks good, err_mask otherwise.
+ */
+
+static unsigned int ac_err_idle(u8 status)
+{
+	/* BSY = 1 or DRQ = 1 */
+	if (status & (ATA_BUSY | ATA_DRQ))
+		return AC_ERR_HSM;
+
+	/* BSY = 0, DRQ = 0, device err */
+	if (status & (ATA_ERR | ATA_DF))
+		return AC_ERR_DEV;
+
+	/* BSY = 0, DRQ = 0, no device err. DRDY = 1 */
+	if (status & ATA_DRDY)
+		return 0;
+
+	/* thing looks good.
+	 * don't know why DRDY not set.
+	 */
+	return AC_ERR_OTHER;
+}
+
+/**
  *	ata_hsm_ok_in_wq - Check if the qc can be handled in the workqueue.
  *	@ap: the target ata_port
  *	@qc: qc on going
@@ -3906,7 +3962,7 @@ fsm_start:
 		/* check device status */
 		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
 			/* Wrong status. Let EH handle this */
-			qc->err_mask |= AC_ERR_HSM;
+			qc->err_mask |= ac_err_drq(status);
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}
@@ -3920,7 +3976,7 @@ fsm_start:
 		if (unlikely(status & (ATA_ERR | ATA_DF))) {
 			printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
 			       ap->id, status);
-			qc->err_mask |= AC_ERR_DEV;
+			qc->err_mask |= AC_ERR_HSM;
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}
@@ -3976,7 +4032,7 @@ fsm_start:
 			if (unlikely(status & (ATA_ERR | ATA_DF))) {
 				printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
 				       ap->id, status);
-				qc->err_mask |= AC_ERR_DEV;
+				qc->err_mask |= AC_ERR_HSM;
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
 			}
@@ -3991,7 +4047,7 @@ fsm_start:
 			/* ATA PIO protocol */
 			if (unlikely((status & ATA_DRQ) == 0)) {
 				/* handle BSY=0, DRQ=0 as error */
-				qc->err_mask |= AC_ERR_HSM;
+				qc->err_mask |= ac_err_drq(status);
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
 			}
@@ -4007,13 +4063,16 @@ fsm_start:
 			 * transferred to the device.
 			 */
 			if (unlikely(status & (ATA_ERR | ATA_DF))) {
-				/* data might be corrputed */
-				qc->err_mask |= AC_ERR_DEV;
 
-				if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
+				if (qc->tf.flags & ATA_TFLAG_WRITE)
+					qc->err_mask |= AC_ERR_HSM;
+				else {
+					/* data might be corrputed */
+					qc->err_mask |= AC_ERR_DEV;
 					ata_pio_sectors(qc);
 					ata_altstatus(ap);
 					status = ata_wait_idle(ap);
+					qc->err_mask |= ac_err_idle(status);
 				}
 
 				/* ata_pio_sectors() might change the
@@ -4041,7 +4100,7 @@ fsm_start:
 
 	case HSM_ST_LAST:
 		if (unlikely(!ata_ok(status))) {
-			qc->err_mask |= __ac_err_mask(status);
+			qc->err_mask |= ac_err_idle(status);
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}


