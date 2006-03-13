From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/5] libata-dev: Move out the HSM code from ata_host_intr()
Date: Mon, 13 Mar 2006 15:37:37 +0800
Message-ID: <44152141.3070902@tw.ibm.com>
References: <440FEA4B.10500@tw.ibm.com> <44136D61.4020007@pobox.com> <4415203F.4070103@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:25795 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751953AbWCMHhs
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Mar 2006 02:37:48 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2D7bgXh023079
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 02:37:42 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2D7eZfw180890
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:40:35 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2D7bfGj012670
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:37:41 -0700
In-Reply-To: <4415203F.4070103@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Move out the irq-pio HSM code from ata_host_intr() to the new ata_hsm_move() function verbatim.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

---
(trailing whitespaces removed.)

--- 00.5_removeatapi/drivers/scsi/libata-core.c	2006-03-13 11:38:06.000000000 +0800
+++ 01_move_out/drivers/scsi/libata-core.c	2006-03-13 11:41:07.000000000 +0800
@@ -3770,6 +3770,111 @@ static void ata_pio_error(struct ata_por
 	ata_poll_qc_complete(qc);
 }
 
+static void ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
+			 u8 status)
+{
+	/* check error */
+	if (unlikely(status & (ATA_ERR | ATA_DF))) {
+		qc->err_mask |= AC_ERR_DEV;
+		ap->hsm_task_state = HSM_ST_ERR;
+	}
+
+fsm_start:
+	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
+		/* Some pre-ATAPI-4 devices assert INTRQ
+		 * at this state when ready to receive CDB.
+		 */
+
+		/* check device status */
+		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
+			/* Wrong status. Let EH handle this */
+			qc->err_mask |= AC_ERR_HSM;
+			ap->hsm_task_state = HSM_ST_ERR;
+			goto fsm_start;
+		}
+
+		atapi_send_cdb(ap, qc);
+
+		break;
+
+	case HSM_ST:
+		/* complete command or read/write the data register */
+		if (qc->tf.protocol == ATA_PROT_ATAPI) {
+			/* ATAPI PIO protocol */
+			if ((status & ATA_DRQ) == 0) {
+				/* no more data to transfer */
+				ap->hsm_task_state = HSM_ST_LAST;
+				goto fsm_start;
+			}
+
+			atapi_pio_bytes(qc);
+
+			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
+				/* bad ireason reported by device */
+				goto fsm_start;
+
+		} else {
+			/* ATA PIO protocol */
+			if (unlikely((status & ATA_DRQ) == 0)) {
+				/* handle BSY=0, DRQ=0 as error */
+				qc->err_mask |= AC_ERR_HSM;
+				ap->hsm_task_state = HSM_ST_ERR;
+				goto fsm_start;
+			}
+
+			ata_pio_sectors(qc);
+
+			if (ap->hsm_task_state == HSM_ST_LAST &&
+			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
+				/* all data read */
+				ata_altstatus(ap);
+				status = ata_chk_status(ap);
+				goto fsm_start;
+			}
+		}
+
+		ata_altstatus(ap); /* flush */
+		break;
+
+	case HSM_ST_LAST:
+		if (unlikely(status & ATA_DRQ)) {
+			/* handle DRQ=1 as error */
+			qc->err_mask |= AC_ERR_HSM;
+			ap->hsm_task_state = HSM_ST_ERR;
+			goto fsm_start;
+		}
+
+		/* no more data to transfer */
+		DPRINTK("ata%u: command complete, drv_stat 0x%x\n",
+			ap->id, status);
+
+		ap->hsm_task_state = HSM_ST_IDLE;
+
+		/* complete taskfile transaction */
+		qc->err_mask |= ac_err_mask(status);
+		ata_qc_complete(qc);
+		break;
+
+	case HSM_ST_ERR:
+		if (qc->tf.command != ATA_CMD_PACKET)
+			printk(KERN_ERR "ata%u: command error, drv_stat 0x%x host_stat 0x%x\n",
+			       ap->id, status, host_stat);
+
+		/* make sure qc->err_mask is available to
+		 * know what's wrong and recover
+		 */
+		WARN_ON(qc->err_mask == 0);
+
+		ap->hsm_task_state = HSM_ST_IDLE;
+		ata_qc_complete(qc);
+		break;
+	default:
+		goto idle_irq;
+	}
+
+}
+
 static void ata_pio_task(void *_data)
 {
 	struct ata_port *ap = _data;
@@ -4513,106 +4618,7 @@ inline unsigned int ata_host_intr (struc
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
 
-	/* check error */
-	if (unlikely(status & (ATA_ERR | ATA_DF))) {
-		qc->err_mask |= AC_ERR_DEV;
-		ap->hsm_task_state = HSM_ST_ERR;
-	}
-
-fsm_start:
-	switch (ap->hsm_task_state) {
-	case HSM_ST_FIRST:
-		/* Some pre-ATAPI-4 devices assert INTRQ
-		 * at this state when ready to receive CDB.
-		 */
-
-		/* check device status */
-		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
-			/* Wrong status. Let EH handle this */
-			qc->err_mask |= AC_ERR_HSM;
-			ap->hsm_task_state = HSM_ST_ERR;
-			goto fsm_start;
-		}
-
-		atapi_send_cdb(ap, qc);
-
-		break;
-
-	case HSM_ST:
-		/* complete command or read/write the data register */
-		if (qc->tf.protocol == ATA_PROT_ATAPI) {
-			/* ATAPI PIO protocol */
-			if ((status & ATA_DRQ) == 0) {
-				/* no more data to transfer */
-				ap->hsm_task_state = HSM_ST_LAST;
-				goto fsm_start;
-			}
-
-			atapi_pio_bytes(qc);
-
-			if (unlikely(ap->hsm_task_state == HSM_ST_ERR))
-				/* bad ireason reported by device */
-				goto fsm_start;
-
-		} else {
-			/* ATA PIO protocol */
-			if (unlikely((status & ATA_DRQ) == 0)) {
-				/* handle BSY=0, DRQ=0 as error */
-				qc->err_mask |= AC_ERR_HSM;
-				ap->hsm_task_state = HSM_ST_ERR;
-				goto fsm_start;
-			}
-
-			ata_pio_sectors(qc);
-
-			if (ap->hsm_task_state == HSM_ST_LAST &&
-			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
-				/* all data read */
-				ata_altstatus(ap);
-				status = ata_chk_status(ap);
-				goto fsm_start;
-			}
-		}
-
-		ata_altstatus(ap); /* flush */
-		break;
-
-	case HSM_ST_LAST:
-		if (unlikely(status & ATA_DRQ)) {
-			/* handle DRQ=1 as error */
-			qc->err_mask |= AC_ERR_HSM;
-			ap->hsm_task_state = HSM_ST_ERR;
-			goto fsm_start;
-		}
-
-		/* no more data to transfer */
-		DPRINTK("ata%u: command complete, drv_stat 0x%x\n",
-			ap->id, status);
-
-		ap->hsm_task_state = HSM_ST_IDLE;
-
-		/* complete taskfile transaction */
-		qc->err_mask |= ac_err_mask(status);
-		ata_qc_complete(qc);
-		break;
-
-	case HSM_ST_ERR:
-		if (qc->tf.command != ATA_CMD_PACKET)
-			printk(KERN_ERR "ata%u: command error, drv_stat 0x%x host_stat 0x%x\n",
-			       ap->id, status, host_stat);
-
-		/* make sure qc->err_mask is available to
-		 * know what's wrong and recover
-		 */
-		WARN_ON(qc->err_mask == 0);
-
-		ap->hsm_task_state = HSM_ST_IDLE;
-		ata_qc_complete(qc);
-		break;
-	default:
-		goto idle_irq;
-	}
-
+	ata_hsm_move(ap, qc, status);
 	return 1;	/* irq handled */
 
 idle_irq:

