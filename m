From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/7] libata: move ata_altstatus() out to the pio data xfer
 functions
Date: Fri, 11 May 2007 15:30:38 +0800
Message-ID: <46441B9E.7060508@tw.ibm.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com> <4644192A.8090809@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:39423 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173AbXEKHao (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 03:30:44 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4B7UiCs020749
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 03:30:44 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4B7UiPb175692
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:30:44 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4B7UhVX001215
	for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 01:30:44 -0600
In-Reply-To: <4644192A.8090809@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

patch 3/7:
 move ata_altstatus() out from ata_hsm_move() to the pio data xfer functions.
Functions like ata_pio_sectors() and atapi_pio_bytes() know better if the
flush is needed.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 02_flush_fix/drivers/ata/libata-core.c 03_smart_flush/drivers/ata/libata-core.c
--- 02_flush_fix/drivers/ata/libata-core.c	2007-05-11 11:14:04.000000000 +0800
+++ 03_smart_flush/drivers/ata/libata-core.c	2007-05-11 10:24:19.000000000 +0800
@@ -4031,7 +4031,7 @@ void ata_data_xfer_noirq(struct ata_devi
  *	Inherited from caller.
  */
 
-static void ata_pio_sector(struct ata_queued_cmd *qc)
+static void ata_pio_sector(struct ata_queued_cmd *qc, int last)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	struct scatterlist *sg = qc->__sg;
@@ -4069,6 +4069,9 @@ static void ata_pio_sector(struct ata_qu
 		ap->ops->data_xfer(qc->dev, buf + offset, ATA_SECT_SIZE, do_write);
 	}
 
+	if (last)
+		ata_altstatus(ap); /* flush */
+
 	qc->curbytes += ATA_SECT_SIZE;
 	qc->cursg_ofs += ATA_SECT_SIZE;
 
@@ -4100,9 +4103,9 @@ static void ata_pio_sectors(struct ata_q
 		nsect = min((qc->nbytes - qc->curbytes) / ATA_SECT_SIZE,
 			    qc->dev->multi_count);
 		while (nsect--)
-			ata_pio_sector(qc);
+			ata_pio_sector(qc, !nsect);
 	} else
-		ata_pio_sector(qc);
+		ata_pio_sector(qc, 1);
 }
 
 /**
@@ -4185,6 +4188,8 @@ next_sg:
 		for (i = 0; i < words; i++)
 			ap->ops->data_xfer(qc->dev, (unsigned char*)pad_buf, 2, do_write);
 
+		ata_altstatus(ap); /* flush */
+
 		ap->hsm_task_state = HSM_ST_LAST;
 		return;
 	}
@@ -4234,6 +4239,8 @@ next_sg:
 
 	if (bytes)
 		goto next_sg;
+
+	ata_altstatus(ap); /* flush */
 }
 
 /**
@@ -4452,7 +4459,6 @@ fsm_start:
 			 */
 			ap->hsm_task_state = HSM_ST;
 			ata_pio_sectors(qc);
-			ata_altstatus(ap); /* flush */
 		} else
 			/* send CDB */
 			atapi_send_cdb(ap, qc);
@@ -4533,7 +4539,6 @@ fsm_start:
 
 				if (!(qc->tf.flags & ATA_TFLAG_WRITE)) {
 					ata_pio_sectors(qc);
-					ata_altstatus(ap);
 					status = ata_wait_idle(ap);
 				}
 
@@ -4552,13 +4557,11 @@ fsm_start:
 
 			if (ap->hsm_task_state == HSM_ST_IDLE) {
 				/* all data read */
-				ata_altstatus(ap);
 				status = ata_wait_idle(ap);
 				goto fsm_start;
 			}
 		}
 
-		ata_altstatus(ap); /* flush */
 		poll_next = 1;
 		break;
 


