From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC] libata-dev: handle DRQ=1 ERR=1 (revised)
Date: Sat, 01 Apr 2006 17:38:43 +0800
Message-ID: <442E4A23.8000409@tw.ibm.com>
References: <442DC9E7.5000203@garzik.org> <442E4444.1050806@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:14523 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750924AbWDAJi6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Apr 2006 04:38:58 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k319cqiH010088
	for <linux-ide@vger.kernel.org>; Sat, 1 Apr 2006 04:38:52 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k319g106105876
	for <linux-ide@vger.kernel.org>; Sat, 1 Apr 2006 02:42:01 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k319cpJ7009114
	for <linux-ide@vger.kernel.org>; Sat, 1 Apr 2006 02:38:51 -0700
In-Reply-To: <442E4444.1050806@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Handle DRQ=1 ERR=1 situation. Revised according to what IDE try_to_flush_leftover_data() does.

Changes:
 - For ATA PIO writes and ATAPI devices, just stop the HSM and let EH handle it.
 - For ATA PIO reads, read only one block of junk data and then let EH handle it.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Thanks for the IDE try_to_flush_leftover_data() pointer.
The difference between IDE and irq-pio (before this patch):
 1. IDE only does the data transfer for PIO reads.
    For PIO writes and ATAPI, it just stops and abort/reset.
 2. For PIO reads, only one block of data is transferred. EH then takes over if DRQ is still set after that.
    The behavior of irq-pio before this patch is: let HSM go on, until the device set DRQ=0 or all data read.

Te IDE behavior looks safer. (When the device is in bad status, we really should not
write any data to it.)

Patch against irq-pio branch (08a556db919f67e1e4d33ae8d40f7222da34d994).
For your review, thanks.

--- irq-pio0/drivers/scsi/libata-core.c	2006-04-01 10:34:59.000000000 +0800
+++ irq-pio-drq/drivers/scsi/libata-core.c	2006-04-01 17:09:00.000000000 +0800
@@ -3651,13 +3651,16 @@ fsm_start:
 
 		/* Device should not ask for data transfer (DRQ=1)
 		 * when it finds something wrong.
-		 * Anyway, we respect DRQ here and let HSM go on
-		 * without changing hsm_task_state to HSM_ST_ERR.
+		 * We ignore DRQ here and stop the HSM by
+		 * changing hsm_task_state to HSM_ST_ERR and
+		 * let the EH abort the command or reset the device.
 		 */
 		if (unlikely(status & (ATA_ERR | ATA_DF))) {
 			printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
 			       ap->id, status);
 			qc->err_mask |= AC_ERR_DEV;
+			ap->hsm_task_state = HSM_ST_ERR;
+			goto fsm_start;
 		}
 
 		/* Send the CDB (atapi) or the first data block (ata pio out).
@@ -3704,13 +3707,16 @@ fsm_start:
 
 			/* Device should not ask for data transfer (DRQ=1)
 			 * when it finds something wrong.
-			 * Anyway, we respect DRQ here and let HSM go on
-			 * without changing hsm_task_state to HSM_ST_ERR.
+			 * We ignore DRQ here and stop the HSM by
+			 * changing hsm_task_state to HSM_ST_ERR and
+			 * let the EH abort the command or reset the device.
 			 */
 			if (unlikely(status & (ATA_ERR | ATA_DF))) {
 				printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
 				       ap->id, status);
 				qc->err_mask |= AC_ERR_DEV;
+				ap->hsm_task_state = HSM_ST_ERR;
+				goto fsm_start;
 			}
 
 			atapi_pio_bytes(qc);
@@ -3728,20 +3734,32 @@ fsm_start:
 				goto fsm_start;
 			}
 
-			/* Some devices may ask for data transfer (DRQ=1)
-			 * alone with ERR=1 for PIO reads.
-			 * We respect DRQ here and let HSM go on without
-			 * changing hsm_task_state to HSM_ST_ERR.
+			/* For PIO reads, some devices may ask for
+			 * data transfer (DRQ=1) alone with ERR=1.
+			 * We respect DRQ here and transfer one
+			 * block of junk data before changing the
+			 * hsm_task_state to HSM_ST_ERR.
+			 *
+			 * For PIO writes, ERR=1 DRQ=1 doesn't make
+			 * sense since the data block has been
+			 * transferred to the device.
 			 */
 			if (unlikely(status & (ATA_ERR | ATA_DF))) {
-				/* For writes, ERR=1 DRQ=1 doesn't make
-				 * sense since the data block has been
-				 * transferred to the device.
-				 */
-				WARN_ON(qc->tf.flags & ATA_TFLAG_WRITE);
-
 				/* data might be corrputed */
 				qc->err_mask |= AC_ERR_DEV;
+
+				if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
+					ata_pio_sectors(qc);
+					ata_altstatus(ap);
+					status = ata_wait_idle(ap);
+				}
+
+				/* ata_pio_sectors() might change the
+				 * state to HSM_ST_LAST. so, the state
+				 * is changed after ata_pio_sectors().
+				 */
+				ap->hsm_task_state = HSM_ST_ERR;
+				goto fsm_start;
 			}
 
 			ata_pio_sectors(qc);


