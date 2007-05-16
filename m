From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/8] libata: move ata_altstatus() out from ata_hsm_move()
 to the pio data xfer functions
Date: Wed, 16 May 2007 15:11:40 +0800
Message-ID: <464AAEAC.20708@tw.ibm.com>
References: <464AACDF.1030903@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:33260 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbXEPHLn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 03:11:43 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4G7BhYA012033
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 03:11:43 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4G7Bg1E119622
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:11:42 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4G7BfnX003048
	for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 01:11:42 -0600
In-Reply-To: <464AACDF.1030903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

patch 2/8:
 Move ata_altstatus() out from ata_hsm_move() to the pio data xfer functions,
like ata_pio_sectors() and atapi_pio_bytes() that know better if ata_altstatus() is needed.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
atapi_send_cdb() already did ata_altstatus() in itself.
This patch makes ata_pio_sector(), ata_pio_sectors() and atapi_pio_bytes() do the same.

diff -Nrup 01_flush_fix/drivers/ata/libata-core.c 02_smart_flush/drivers/ata/libata-core.c
--- 01_flush_fix/drivers/ata/libata-core.c	2007-05-15 10:05:33.000000000 +0800
+++ 02_smart_flush/drivers/ata/libata-core.c	2007-05-16 10:37:53.000000000 +0800
@@ -4435,6 +4435,7 @@ void ata_data_xfer_noirq(struct ata_devi
 /**
  *	ata_pio_sector - Transfer a sector of data.
  *	@qc: Command on going
+ *	@drq_last: Last sector of pio DRQ transfer
  *
  *	Transfer qc->sect_size bytes of data from/to the ATA device.
  *
@@ -4442,7 +4443,7 @@ void ata_data_xfer_noirq(struct ata_devi
  *	Inherited from caller.
  */
 
-static void ata_pio_sector(struct ata_queued_cmd *qc)
+static void ata_pio_sector(struct ata_queued_cmd *qc, int drq_last)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	struct scatterlist *sg = qc->__sg;
@@ -4480,6 +4481,9 @@ static void ata_pio_sector(struct ata_qu
 		ap->ops->data_xfer(qc->dev, buf + offset, qc->sect_size, do_write);
 	}
 
+	if (drq_last)
+		ata_altstatus(ap); /* flush */
+
 	qc->curbytes += qc->sect_size;
 	qc->cursg_ofs += qc->sect_size;
 
@@ -4511,9 +4515,9 @@ static void ata_pio_sectors(struct ata_q
 		nsect = min((qc->nbytes - qc->curbytes) / qc->sect_size,
 			    qc->dev->multi_count);
 		while (nsect--)
-			ata_pio_sector(qc);
+			ata_pio_sector(qc, !nsect);
 	} else
-		ata_pio_sector(qc);
+		ata_pio_sector(qc, 1);
 }
 
 /**
@@ -4596,6 +4600,7 @@ next_sg:
 		for (i = 0; i < words; i++)
 			ap->ops->data_xfer(qc->dev, (unsigned char*)pad_buf, 2, do_write);
 
+		ata_altstatus(ap); /* flush */
 		ap->hsm_task_state = HSM_ST_LAST;
 		return;
 	}
@@ -4645,6 +4650,8 @@ next_sg:
 
 	if (bytes)
 		goto next_sg;
+
+	ata_altstatus(ap); /* flush */
 }
 
 /**
@@ -4861,7 +4868,6 @@ fsm_start:
 			 */
 			ap->hsm_task_state = HSM_ST;
 			ata_pio_sectors(qc);
-			ata_altstatus(ap); /* flush */
 		} else
 			/* send CDB */
 			atapi_send_cdb(ap, qc);
@@ -4942,7 +4948,6 @@ fsm_start:
 
 				if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
 					ata_pio_sectors(qc);
-					ata_altstatus(ap);
 					status = ata_wait_idle(ap);
 				}
 
@@ -4962,13 +4967,11 @@ fsm_start:
 			if (ap->hsm_task_state == HSM_ST_LAST &&
 			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
 				/* all data read */
-				ata_altstatus(ap);
 				status = ata_wait_idle(ap);
 				goto fsm_start;
 			}
 		}
 
-		ata_altstatus(ap); /* flush */
 		poll_next = 1;
 		break;
 


