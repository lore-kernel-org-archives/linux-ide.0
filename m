From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 2/2] libata-dev: fix the device err check sequence
Date: Thu, 23 Mar 2006 16:26:19 +0800
Message-ID: <44225BAB.2060902@tw.ibm.com>
References: <441FE605.8010202@tw.ibm.com> <44203953.3080803@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:65427 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030210AbWCWI0c
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Mar 2006 03:26:32 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2N8QODO030084
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 03:26:24 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2N8TQOu191618
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 01:29:26 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2N8QIBJ001119
	for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 01:26:19 -0700
In-Reply-To: <44203953.3080803@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, edmudama@gmail.com

Current irq-pio checks ERR bit and stops on ERR before it does anything else.
This behavior doesn't look right.
The DRQ bit should take higher precedence than the ERR bit.

Changes:
- Let the HSM do the data transfer whenever the
  device asks for DRQ bit, even if the ERR bit is set.
- For DRQ=1 ERR=1, don't trust the data

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

Revised per previous comments of Jeff and Eric.

The device error check in the entrance is removed.
Given the data returned on ERR=1 DRQ=1 might be corrupted or partial,
the device err check is added after DRQ check and before the data transfer.
We set AC_ERR_DEV to err_mask and tell the upper layer that the data
does not look good.

For your review, thanks.


--- irq-pio-deverr0/drivers/scsi/libata-core.c	2006-03-23 14:56:03.000000000 +0800
+++ irq-pio-deverr/drivers/scsi/libata-core.c	2006-03-23 15:26:03.000000000 +0800
@@ -3555,12 +3555,6 @@ static int ata_hsm_move(struct ata_port 
 	 */
 	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
-	/* check error */
-	if (unlikely(status & (ATA_ERR | ATA_DF))) {
-		qc->err_mask |= AC_ERR_DEV;
-		ap->hsm_task_state = HSM_ST_ERR;
-	}
-
 fsm_start:
 	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
 		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
@@ -3583,6 +3577,17 @@ fsm_start:
 			goto fsm_start;
 		}
 
+		/* Device should not ask for data transfer (DRQ=1)
+		 * when it finds something wrong.
+		 * Anyway, we respect DRQ here and let HSM go on
+		 * without changing hsm_task_state to HSM_ST_ERR.
+		 */
+		if (unlikely(status & (ATA_ERR | ATA_DF))) {
+			printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
+			       ap->id, status);
+			qc->err_mask |= AC_ERR_DEV;
+		}
+
 		/* Send the CDB (atapi) or the first data block (ata pio out).
 		 * During the state transition, interrupt handler shouldn't
 		 * be invoked before the data transfer is complete and
@@ -3625,6 +3630,17 @@ fsm_start:
 				goto fsm_start;
 			}
 
+			/* Device should not ask for data transfer (DRQ=1)
+			 * when it finds something wrong.
+			 * Anyway, we respect DRQ here and let HSM go on
+			 * without changing hsm_task_state to HSM_ST_ERR.
+			 */
+			if (unlikely(status & (ATA_ERR | ATA_DF))) {
+				printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
+				       ap->id, status);
+				qc->err_mask |= AC_ERR_DEV;
+			}
+
 			atapi_pio_bytes(qc);
 
 			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
@@ -3640,6 +3656,22 @@ fsm_start:
 				goto fsm_start;
 			}
 
+			/* Some devices may ask for data transfer (DRQ=1)
+			 * alone with ERR=1 for PIO reads.
+			 * We respect DRQ here and let HSM go on without
+			 * changing hsm_task_state to HSM_ST_ERR.
+			 */
+			if (unlikely(status & (ATA_ERR | ATA_DF))) {
+				/* For writes, ERR=1 DRQ=1 doesn't make
+				 * sense since the data block has been
+				 * transferred to the device.
+				 */
+				WARN_ON(qc->tf.flags & ATA_TFLAG_WRITE);
+
+				/* data might be corrputed */
+				qc->err_mask |= AC_ERR_DEV;
+			}
+
 			ata_pio_sectors(qc);
 
 			if (ap->hsm_task_state == HSM_ST_LAST &&


