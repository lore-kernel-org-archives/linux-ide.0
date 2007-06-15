From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 5/9] libata: use freeze()/thaw() for polling
Date: Fri, 15 Jun 2007 11:24:43 +0800
Message-ID: <4672067B.5070609@tw.ibm.com>
References: <46720353.90209@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:33806 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbXFODYs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jun 2007 23:24:48 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5F3Olwc006778
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 23:24:47 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5F3OlC9243344
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:24:47 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5F3OliL006664
	for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 21:24:47 -0600
In-Reply-To: <46720353.90209@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>
Cc: Doug Maxey <dwm@enoyolf.org>, Tejun Heo <htejun@gmail.com>

Patch 5/9:

  This patch changes polling codes to use freeze()/thaw() for irq off/on.
ata_qc_set_polling() is also removed since now unused.

The reason for freeze()/thaw(): some ATAPI devices raises INTRQ even if nIEN = 1.
Using the host adapter irq mask mechanism, if available, is more reliable than using the device nIEN bit.

Considerations:
 1. the semantic of freeze()/thaw() maybe more than irq off/on?
 2. HSM, the new user of freeze()/thaw(), will call freeze()/thaw() more frequently than EH.
    Can current implemention of freeze()/thaw() handle it?

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 04_convert_freeze/drivers/ata/libata-core.c 05_convert_hsm_to_freeze/drivers/ata/libata-core.c
--- 04_convert_freeze/drivers/ata/libata-core.c	2007-06-11 17:37:24.000000000 +0800
+++ 05_convert_hsm_to_freeze/drivers/ata/libata-core.c	2007-06-12 13:33:03.000000000 +0800
@@ -4753,7 +4753,7 @@ static void ata_hsm_qc_complete(struct a
 			qc = ata_qc_from_tag(ap, qc->tag);
 			if (qc) {
 				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
-					ap->ops->irq_on(ap);
+					ap->ops->thaw(ap);
 					ata_qc_complete(qc);
 				} else
 					ata_port_freeze(ap);
@@ -4769,7 +4769,7 @@ static void ata_hsm_qc_complete(struct a
 	} else {
 		if (in_wq) {
 			spin_lock_irqsave(ap->lock, flags);
-			ap->ops->irq_on(ap);
+			ap->ops->thaw(ap);
 			ata_qc_complete(qc);
 			spin_unlock_irqrestore(ap->lock, flags);
 		} else
@@ -5421,7 +5421,7 @@ unsigned int ata_qc_issue_prot(struct at
 	switch (qc->tf.protocol) {
 	case ATA_PROT_NODATA:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_qc_set_polling(qc);
+			ap->ops->freeze(ap);
 
 		ata_tf_to_host(ap, &qc->tf);
 		ap->hsm_task_state = HSM_ST_LAST;
@@ -5442,7 +5442,7 @@ unsigned int ata_qc_issue_prot(struct at
 
 	case ATA_PROT_PIO:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_qc_set_polling(qc);
+			ap->ops->freeze(ap);
 
 		ata_tf_to_host(ap, &qc->tf);
 
@@ -5471,7 +5471,7 @@ unsigned int ata_qc_issue_prot(struct at
 	case ATA_PROT_ATAPI:
 	case ATA_PROT_ATAPI_NODATA:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_qc_set_polling(qc);
+			ap->ops->freeze(ap);
 
 		ata_tf_to_host(ap, &qc->tf);
 
diff -Nrup 04_convert_freeze/include/linux/libata.h 05_convert_hsm_to_freeze/include/linux/libata.h
--- 04_convert_freeze/include/linux/libata.h	2007-06-11 17:37:24.000000000 +0800
+++ 05_convert_hsm_to_freeze/include/linux/libata.h	2007-06-12 13:40:14.000000000 +0800
@@ -1100,11 +1100,6 @@ static inline u8 ata_wait_idle(struct at
 	return status;
 }
 
-static inline void ata_qc_set_polling(struct ata_queued_cmd *qc)
-{
-	qc->tf.ctl |= ATA_NIEN;
-}
-
 static inline struct ata_queued_cmd *__ata_qc_from_tag(struct ata_port *ap,
 						       unsigned int tag)
 {


