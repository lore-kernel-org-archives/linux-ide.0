From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata: disable_irq() during polling IDENTIFY (take 2)
Date: Tue, 08 May 2007 19:30:24 +0800
Message-ID: <46405F50.5090901@tw.ibm.com>
References: <463EAB4D.3000309@tw.ibm.com> <463ED8B9.4060501@gmail.com> <463F0B25.40103@tw.ibm.com> <463F0DAD.5060307@gmail.com> <463F1374.1010100@tw.ibm.com> <463F1509.30100@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:49856 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934498AbXEHLar (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 07:30:47 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48BUePI002366
	for <linux-ide@vger.kernel.org>; Tue, 8 May 2007 07:30:40 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l48BUeaj137572
	for <linux-ide@vger.kernel.org>; Tue, 8 May 2007 05:30:40 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l48BUdQY009503
	for <linux-ide@vger.kernel.org>; Tue, 8 May 2007 05:30:40 -0600
In-Reply-To: <463F1509.30100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>

Problem:
  Kernel got "irq 5: nobody cared" when using
  libata + polling IDENTIFY + Promise 20275 adapter + Benq DW1620 drive.

  Detail message available in bug 8441 (http://bugzilla.kernel.org/show_bug.cgi?id=8441).

Cause:
  The Benq DW1620 drive raises INTRQ during polling IDENTIFY PACKET DEVICE, 
  even if nIEN = 1.

Proposed fix:
  Ack the possibly unexpected irq in ata_interrupt().

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Patch revised per Tejun's advice to ack the unexpected INTRQ in ata_interrupt().
Also, ap->lock is held when transfering PIO data from/to the port in case the
device doesn't like the status register to be read during data transfer.

Patch against 2.6.21.1 for your review, thanks.

diff -Nrup linux-2.6.21.1-ori/drivers/ata/libata-core.c linux-2.6.21.1-mod6/drivers/ata/libata-core.c
--- linux-2.6.21.1-ori/drivers/ata/libata-core.c	2007-05-04 11:22:23.000000000 +0800
+++ linux-2.6.21.1-mod6/drivers/ata/libata-core.c	2007-05-08 19:25:58.000000000 +0800
@@ -4490,8 +4490,17 @@ fsm_start:
 				goto fsm_start;
 			}
 
+			/* prevent ata_interrupt() from reading
+			 * status when transfering data for safty
+			 */
+			if (in_wq)
+				spin_lock_irqsave(ap->lock, flags);
+
 			atapi_pio_bytes(qc);
 
+			if (in_wq)
+				spin_unlock_irqrestore(ap->lock, flags);
+
 			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
 				/* bad ireason reported by device */
 				goto fsm_start;
@@ -4529,12 +4538,21 @@ fsm_start:
 				/* data might be corrputed */
 				qc->err_mask |= AC_ERR_DEV;
 
+				/* prevent ata_interrupt() from reading
+				 * status when transfering data for safty
+				 */
+				if (in_wq)
+					spin_lock_irqsave(ap->lock, flags);
+
 				if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
 					ata_pio_sectors(qc);
 					ata_altstatus(ap);
 					status = ata_wait_idle(ap);
 				}
 
+				if (in_wq)
+					spin_unlock_irqrestore(ap->lock, flags);
+
 				if (status & (ATA_BUSY | ATA_DRQ))
 					qc->err_mask |= AC_ERR_HSM;
 
@@ -4546,8 +4564,17 @@ fsm_start:
 				goto fsm_start;
 			}
 
+			/* prevent ata_interrupt() from reading status
+			 * when transfering data for safty
+			 */
+			if (in_wq)
+				spin_lock_irqsave(ap->lock, flags);
+
 			ata_pio_sectors(qc);
 
+			if (in_wq)
+				spin_unlock_irqrestore(ap->lock, flags);
+
 			if (ap->hsm_task_state == HSM_ST_LAST &&
 			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
 				/* all data read */
@@ -5227,6 +5254,9 @@ irqreturn_t ata_interrupt (int irq, void
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
 			    (qc->flags & ATA_QCFLAG_ACTIVE))
 				handled |= ata_host_intr(ap, qc);
+			else
+				/* ack possibly unexpected irq */
+				ata_chk_status(ap);
 		}
 	}
 


