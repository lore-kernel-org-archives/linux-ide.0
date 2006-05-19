From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: Fix the HSM error_mask mapping (was: Re: libata-tj
 and SMART)
Date: Fri, 19 May 2006 11:43:04 +0800
Message-ID: <446D3EC8.5070109@tw.ibm.com>
References: <e4b02t$e9b$1@sea.gmane.org> <44690B0F.90200@gmail.com> <e4bvsb$s9m$1@sea.gmane.org> <4469893A.10901@gmail.com> <e4g3or$jbm$1@sea.gmane.org> <446BF147.4040904@gmail.com> <446C98CA.50008@garzik.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:11694 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932177AbWESDnL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 May 2006 23:43:11 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4J3h9nd015827
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 23:43:09 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4J3h9lD153672
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 21:43:09 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4J3h8Ac022893
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 21:43:09 -0600
In-Reply-To: <446C98CA.50008@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Nicolas STRANSKY <Nico@stransky.cx>, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> It seems that HSM_ST needs to handle !DRQ && ERR case before the first
>> iteration (or maybe it should be pushed into HSM_ST_FIRST?).  Does my
>> analysis make sense?
> 
> 
> Agreed, though we should check for ERR on ATAPI path first, too, IMO.
> 

Fix the HSM error_mask mapping.

Changes:
- Better mapping in ac_err_mask()
- In HSM_ST_FIRST ans HSM_ST state, check ATA_ERR|ATA_DF and map it to AC_ERR_DEV instead of AC_ERR_HSM.
- In HSM_ST_FIRST and HSM_ST state, map DRQ=1 ERR=1 to AC_ERR_HSM.
- For PIO data in and DRQ=1 ERR=1, add check after the junk data block is read.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
The device might stop the HSM by BSY=0 DRQ=1 ERR=1 when it finds something wrong.
Map this condition to AC_ERR_DEV for accuracy.
This should fix the problem of SMART reported by Nicolas.
(patch against upstream branch.)
For your review, thanks.

--- upstream0/include/linux/libata.h	2006-05-16 11:08:54.000000000 +0800
+++ 201_hsm_error/include/linux/libata.h	2006-05-19 11:33:01.000000000 +0800
@@ -1062,7 +1062,7 @@ static inline int ata_try_flush_cache(co
 
 static inline unsigned int ac_err_mask(u8 status)
 {
-	if (status & ATA_BUSY)
+	if (status & (ATA_BUSY | ATA_DRQ))
 		return AC_ERR_HSM;
 	if (status & (ATA_ERR | ATA_DF))
 		return AC_ERR_DEV;
--- upstream0/drivers/scsi/libata-core.c	2006-05-16 11:08:49.000000000 +0800
+++ 201_hsm_error/drivers/scsi/libata-core.c	2006-05-19 11:41:26.000000000 +0800
@@ -4006,9 +4006,15 @@ fsm_start:
 		poll_next = (qc->tf.flags & ATA_TFLAG_POLLING);
 
 		/* check device status */
-		if (unlikely((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ)) {
-			/* Wrong status. Let EH handle this */
-			qc->err_mask |= AC_ERR_HSM;
+		if (unlikely((status & ATA_DRQ) == 0)) {
+			/* handle BSY=0, DRQ=0 as error */
+			if (likely(status & (ATA_ERR | ATA_DF)))
+				/* device stops HSM for abort/error */
+				qc->err_mask |= AC_ERR_DEV;
+			else
+				/* HSM violation. Let EH handle this */
+				qc->err_mask |= AC_ERR_HSM;
+
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}
@@ -4022,7 +4028,7 @@ fsm_start:
 		if (unlikely(status & (ATA_ERR | ATA_DF))) {
 			printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
 			       ap->id, status);
-			qc->err_mask |= AC_ERR_DEV;
+			qc->err_mask |= AC_ERR_HSM;
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}
@@ -4064,7 +4070,9 @@ fsm_start:
 		if (qc->tf.protocol == ATA_PROT_ATAPI) {
 			/* ATAPI PIO protocol */
 			if ((status & ATA_DRQ) == 0) {
-				/* no more data to transfer */
+				/* No more data to transfer or device error.
+				 * Device error will be tagged in HSM_ST_LAST.
+				 */
 				ap->hsm_task_state = HSM_ST_LAST;
 				goto fsm_start;
 			}
@@ -4078,7 +4086,7 @@ fsm_start:
 			if (unlikely(status & (ATA_ERR | ATA_DF))) {
 				printk(KERN_WARNING "ata%d: DRQ=1 with device error, dev_stat 0x%X\n",
 				       ap->id, status);
-				qc->err_mask |= AC_ERR_DEV;
+				qc->err_mask |= AC_ERR_HSM;
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
 			}
@@ -4093,7 +4101,13 @@ fsm_start:
 			/* ATA PIO protocol */
 			if (unlikely((status & ATA_DRQ) == 0)) {
 				/* handle BSY=0, DRQ=0 as error */
-				qc->err_mask |= AC_ERR_HSM;
+				if (likely(status & (ATA_ERR | ATA_DF)))
+					/* device stops HSM for abort/error */
+					qc->err_mask |= AC_ERR_DEV;
+				else
+					/* HSM violation. Let EH handle this */
+					qc->err_mask |= AC_ERR_HSM;
+
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
 			}
@@ -4118,6 +4132,9 @@ fsm_start:
 					status = ata_wait_idle(ap);
 				}
 
+				if (status & (ATA_BUSY | ATA_DRQ))
+					qc->err_mask |= AC_ERR_HSM;
+
 				/* ata_pio_sectors() might change the
 				 * state to HSM_ST_LAST. so, the state
 				 * is changed after ata_pio_sectors().


