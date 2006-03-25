From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/3] libata-dev: fix the device err check sequence (respin)
Date: Sat, 25 Mar 2006 18:11:12 +0800
Message-ID: <44251740.7040003@tw.ibm.com>
References: <441FE605.8010202@tw.ibm.com> <44203953.3080803@pobox.com> <311601c90603210943v132a369aya443a073c11ee2bf@mail.gmail.com> <4422567C.5000008@tw.ibm.com> <44242C25.3020002@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:46217 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750796AbWCYKLS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Mar 2006 05:11:18 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k2PABCHb003183
	for <linux-ide@vger.kernel.org>; Sat, 25 Mar 2006 05:11:12 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2PAEG1r179898
	for <linux-ide@vger.kernel.org>; Sat, 25 Mar 2006 03:14:16 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2PABCto013034
	for <linux-ide@vger.kernel.org>; Sat, 25 Mar 2006 03:11:12 -0700
In-Reply-To: <44242C25.3020002@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

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
AC_ERR_DEV is set to err_mask and tell the upper layer that the data
does not look good.

--- c1/drivers/scsi/libata-core.c	2006-03-25 16:58:19.000000000 +0800
+++ c2/drivers/scsi/libata-core.c	2006-03-25 16:59:26.000000000 +0800
@@ -3587,12 +3587,6 @@ static int ata_hsm_move(struct ata_port 
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
@@ -3615,6 +3609,17 @@ fsm_start:
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
@@ -3657,6 +3662,17 @@ fsm_start:
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
@@ -3672,6 +3688,22 @@ fsm_start:
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


