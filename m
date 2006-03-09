From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 2/5] libata-dev: Minor fix for ata_hsm_move() to work
 with ata_host_intr()
Date: Thu, 09 Mar 2006 16:49:32 +0800
Message-ID: <440FEC1C.30601@tw.ibm.com>
References: <440FEA4B.10500@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:47013 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751061AbWCIIt0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Mar 2006 03:49:26 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k298nOw5029639
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 03:49:24 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k298qER7181596
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 01:52:14 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k298nNC3004249
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 01:49:23 -0700
In-Reply-To: <440FEA4B.10500@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

Minor fix for ata_hsm_move() to work with ata_host_intr().

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

Changes:
- WARN_ON() and comment fix
- Make the HSM_ST_LAST device status checking more rigid. 
- Treate unknown HSM state as BUG().

--- 01_move_out/drivers/scsi/libata-core.c	2006-03-08 18:10:21.000000000 +0800
+++ 02_minor_fix/drivers/scsi/libata-core.c	2006-03-08 18:58:16.000000000 +0800
@@ -3631,6 +3631,9 @@ static void ata_pio_error(struct ata_por
 static void ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 			u8 status)
 {
+	WARN_ON(qc == NULL);
+	WARN_ON((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
+
 	/* check error */
 	if (unlikely(status & (ATA_ERR | ATA_DF))) {
 		qc->err_mask |= AC_ERR_DEV;
@@ -3640,10 +3643,6 @@ static void ata_hsm_move(struct ata_port
 fsm_start:
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
-		/* Some pre-ATAPI-4 devices assert INTRQ 
-		 * at this state when ready to receive CDB.
-		 */
-
 		/* check device status */
 		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
 			/* Wrong status. Let EH handle this */
@@ -3696,9 +3695,8 @@ fsm_start:
 		break;
 
 	case HSM_ST_LAST:
-		if (unlikely(status & ATA_DRQ)) {
-			/* handle DRQ=1 as error */
-			qc->err_mask |= AC_ERR_HSM;
+		if (unlikely(!ata_ok(status))) {
+			qc->err_mask |= __ac_err_mask(status);
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}
@@ -3707,17 +3705,18 @@ fsm_start:
 		DPRINTK("ata%u: command complete, drv_stat 0x%x\n",
 			ap->id, status);
 
+		WARN_ON(qc->err_mask);
+
 		ap->hsm_task_state = HSM_ST_IDLE;
 
 		/* complete taskfile transaction */
-		qc->err_mask |= ac_err_mask(status);
 		ata_qc_complete(qc);
 		break;
 
 	case HSM_ST_ERR:
 		if (qc->tf.command != ATA_CMD_PACKET)
-			printk(KERN_ERR "ata%u: command error, drv_stat 0x%x host_stat 0x%x\n",
-			       ap->id, status, host_stat);
+			printk(KERN_ERR "ata%u: command error, drv_stat 0x%x\n",
+			       ap->id, status);
 
 		/* make sure qc->err_mask is available to 
 		 * know what's wrong and recover
@@ -3728,7 +3727,7 @@ fsm_start:
 		ata_qc_complete(qc);
 		break;
 	default:
-		goto idle_irq;
+		BUG();
 	}
 
 }
@@ -4427,6 +4426,10 @@ inline unsigned int ata_host_intr (struc
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
+		/* Some pre-ATAPI-4 devices assert INTRQ 
+		 * at this state when ready to receive CDB.
+		 */
+
 		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
 		 * The flag was turned on only for atapi devices.
 		 * No need to check is_atapi_taskfile(&qc->tf) again.


